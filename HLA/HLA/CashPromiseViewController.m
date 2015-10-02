//
//  CashPromiseViewController.m
//  iMobile Planner
//
//  Created by infoconnect on 2/1/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CashPromiseViewController.h"
#import "DBController.h"
#import "DataTable.h"
#import "AppDelegate.h"
#import "RiderViewController.h"
//#import "RiderDetailData.h"

@interface CashPromiseViewController ()

@end
NSMutableArray *UpdateTradDetail, *gWaiverAnnual, *gWaiverSemiAnnual, *gWaiverQuarterly, *gWaiverMonthly, *UpdateTradDetailTerm;

@implementation CashPromiseViewController
@synthesize paymentOption;
@synthesize SINo, PolicyTerm, BasicSA,OtherRiderCode,OtherRiderDesc,OtherRiderTerm,sex;
@synthesize YearlyIncome, CashDividend,CustCode, Age;
@synthesize HealthLoading, OtherRiderSA, OtherRiderPlanOption,Name;
@synthesize strBasicAnnually, aStrOtherRiderAnnually, SummaryGuaranteedAddValue;
@synthesize SummaryGuaranteedDBValueA, SummaryGuaranteedDBValueB,SummaryGuaranteedSurrenderValue, OccpClass;
@synthesize SummaryGuaranteedTotalGYI, SummaryNonGuaranteedAccuCashDividendA,SummaryNonGuaranteedAccuCashDividendB;
@synthesize SummaryNonGuaranteedAccuYearlyIncomeA, SummaryNonGuaranteedAccuYearlyIncomeB;
@synthesize SummaryNonGuaranteedDBValueA, SummaryNonGuaranteedDBValueB, SummaryNonGuaranteedSurrenderValueA,SummaryNonGuaranteedSurrenderValueB;
@synthesize BasicMaturityValueA, BasicMaturityValueB, BasicTotalPremiumPaid, BasicTotalYearlyIncome, TotalPremiumBasicANDIncomeRider;
@synthesize EntireMaturityValueA,EntireMaturityValueB,EntireTotalPremiumPaid,EntireTotalYearlyIncome, OtherRiderDeductible;
@synthesize aStrOtherRiderMonthly, PartialAcc, PartialPayout, OtherRiderTempHL, OtherRiderTempHLTerm;
@synthesize aStrOtherRiderQuarterly,aStrOtherRiderSemiAnnually,strBasicMonthly,strBasicQuarterly,strBasicSemiAnnually, OccLoading;
@synthesize strOriBasicAnnually, strOriBasicMonthly,strOriBasicQuarterly,strOriBasicSemiAnnually;
@synthesize HealthLoadingTerm, TempHealthLoading, TempHealthLoadingTerm, aStrBasicSA, PayorAge, PDSorSI;
@synthesize dataTable = _dataTable;
@synthesize db = _db;
@synthesize OtherRiderHL100SA, OtherRiderHL100SATerm,OtherRiderHL1kSA,OtherRiderHL1kSATerm,OtherRiderHLPercentage,OtherRiderHLPercentageTerm;
@synthesize TotalCI, CIRiders, TotalCI2, CIRiders2;
@synthesize pPlanCode, coveragePeriod, lang, need2PagesUnderwriting;
@synthesize reportType;// isUnderwriting;

@synthesize gstValue;
//@synthesize la2RiderDataArray;
//@synthesize payorRiderDataArray;

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
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"BCA_Rates.sqlite"]];
    
    UpdateTradDetail = [[NSMutableArray alloc] init ];
	UpdateTradDetailTerm = [[NSMutableArray alloc] init ];
    gWaiverAnnual = [[NSMutableArray alloc] init ];
    gWaiverSemiAnnual = [[NSMutableArray alloc] init ];
    gWaiverQuarterly = [[NSMutableArray alloc] init ];
    gWaiverMonthly = [[NSMutableArray alloc] init ];
    
    aStrOtherRiderAnnually = [[NSMutableArray alloc] init ];
    aStrOtherRiderSemiAnnually = [[NSMutableArray alloc] init ];
    aStrOtherRiderQuarterly = [[NSMutableArray alloc] init ];
    aStrOtherRiderMonthly = [[NSMutableArray alloc] init ];
    aStrBasicSA = [[NSMutableArray alloc] init ];
    
    aStrWPGYIRiderAnnually = [[NSMutableArray alloc] init ];
    aStrWPGYIRiderSemiAnnually = [[NSMutableArray alloc] init ];
    aStrWPGYIRiderQuarterly = [[NSMutableArray alloc] init ];
    aStrWPGYIRiderMonthly = [[NSMutableArray alloc] init ];
    
    SummaryTotalPremiumPaid = [[NSMutableArray alloc] init ];
    SummaryTotalPayoutOption = [[NSMutableArray alloc] init ];
    SummaryTotalPayoutAndAccumulate = [[NSMutableArray alloc] init ];
    SummaryTotalAccumulateWithoutInterest = [[NSMutableArray alloc] init ];
    
    
    SummaryGuaranteedTotalGYI = [[NSMutableArray alloc] init ];
    SummaryGuaranteedAddValue = [[NSMutableArray alloc] init ];
    SummaryGuaranteedDBValueA = [[NSMutableArray alloc] init ];
    SummaryGuaranteedDBValueB = [[NSMutableArray alloc] init ];
    SummaryGuaranteedSurrenderValue = [[NSMutableArray alloc] init ];
    
	
    SummaryNonGuaranteedCurrentCashDividendA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedCurrentCashDividendB = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedAccuCashDividendA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedAccuCashDividendB = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedAccuYearlyIncomeA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedAccuYearlyIncomeB = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedDBValueA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedDBValueB = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedSurrenderValueA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedSurrenderValueB = [[NSMutableArray alloc] init ];
    
    SummaryNonGuaranteedTotalTDivA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedTotalTDivB = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedTotalSpeA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedTotalSpeB = [[NSMutableArray alloc] init ];
    
    CIRiders = [[NSMutableArray alloc] init ];
	CIRiders2 = [[NSMutableArray alloc] init ];
	
    OccLoading = [[NSMutableArray alloc] init ];
    
    BasicTotalYearlyIncome = 0.00;
    BasicMaturityValueA = 0.00;
    BasicMaturityValueB = 0.00;
    BasicTotalPremiumPaid = 0.00;
    
    EntireTotalYearlyIncome = 0.00;
    EntireMaturityValueA = 0.00;
    EntireMaturityValueB = 0.00;
    EntireTotalPremiumPaid = 0.00;
	TotalCI = 0.00;
	TotalCI2 = 0.00;
    
    gstValue = 0.06;
    
    pPlanName = [self getPlanNameFromCode];
	
	[self deleteTemp]; //clear all temp data
    
    [self getAllPreDetails]; // get all the details needed before proceed
    
    
    
    [self InsertToSI_Temp_Trad_LA]; // for the front summary page
	
    //[self InsertToSI_Temp_Trad_Details]; // for the front summary page figures
	
    if([PDSorSI isEqualToString:@"SI"])
    {
        if([pPlanCode isEqualToString:@"HLACP"])
        {
            [self InsertToSI_Temp_Trad_Basic];
        }
        else if([pPlanCode isEqualToString:@"HLAWP"])
        {
            [self InsertToSI_Temp_Trad_Basic_HLAWP];//you can cheat the whole world, but not yourself. be a grown man, be a responsible guy and stop giving empty promise
        }
        else if([pPlanCode isEqualToString:@"BCALH"])
        {
            [self InsertToSI_Temp_Trad_Basic_L100];
        }
        else if([pPlanCode isEqualToString:@"S100"])
        {
            [self InsertToSI_Temp_Trad_Basic_S100];
        }
        
    }
    else{
        if([pPlanCode isEqualToString:@"HLAWP"])
        {
            [self InsertToSI_Temp_Trad_Basic_HLAWP];
        }
    }
    /*
    [self InsertToSI_Temp_Trad_Rider];
    
    if([pPlanCode isEqualToString:@"HLAWP"])
    {
        if (wpGYIRidersCode.count > 0 ){
            [self InsertToSI_Temp_Trad_Rider_WP_GYI];
            [self InsertToSI_Temp_Trad_Summary_HLAWP ];
        }
    }
    
    if ([PDSorSI isEqualToString:@"SI"]) {
		[self InsertToSI_Temp_Trad];
		[self InsertToSI_Temp_Trad_Overall];
    }
	
    [self UpdateToSI_Temp_Trad_Details];
    
    if([pPlanCode isEqualToString:@"HLAWP"] || [pPlanCode isEqualToString:@"S100"]) {
        [self Insert_Into_SI_temp_Benefit];
    }
    */
	if ([PDSorSI isEqualToString:@"SI"]) {
		NSString *siNo = @"";
		NSString *databaseName = @"hladb.sqlite";
		
		self.db = [DBController sharedDatabaseController:databaseName];
		
		NSString *sqlStmt;

		
		
		
		
		int pageNum = 0;
		int riderCount = 0;
		int riderCountStart = 19; //rider html page number
		NSString *desc = @"Page";
		int DBID;
        
        NSString *tempLang;
        if( [lang isEqualToString:@"Malay"] ){
            tempLang = @"mly";
        }
        else{
            tempLang = @"eng";
        }
        
        sqlStmt = @"Delete from SI_Temp_Pages";
        DBID = [_db ExecuteINSERT:sqlStmt];
        		
        if([pPlanCode isEqualToString:@"HLAWP"])
        {
            [self buildSITempPagesHLAWP:&pageNum desc:desc sqlStmt:&sqlStmt DBID:&DBID lang:tempLang];
            
        } else if([pPlanCode isEqualToString:@"S100"]) {
            [self buildSITempPagesS100:&pageNum desc:desc sqlStmt:&sqlStmt DBID:&DBID];
            
        } else if([pPlanCode isEqualToString:@"L100"] || [pPlanCode isEqualToString:@"BCALH"]) {
            [self buildSITempPagesL100:&pageNum desc:desc sqlStmt:&sqlStmt DBID:&DBID];
            
        } else if ([pPlanCode isEqualToString:@"HLACP"]) {
            [self buildSITempPagesHLACP:&pageNum desc:desc sqlStmt:&sqlStmt DBID:&DBID];
        }
        /*
        for (row in _dataTable.rows)
        {
            if(![RiderViewController containsWealthGYIRiders:[row objectAtIndex:0]]){
                riderCount++;
                if (riderCount % 3 == 1){
                    riderCountStart++;
                    pageNum++;
                    sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@_%@',%d,'%@')",
                               tempLang, [desc stringByAppendingString:[NSString stringWithFormat:@"%d.html",riderCountStart]],pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                    DBID = [_db ExecuteINSERT:sqlStmt];
                    if (DBID <= 0){
                        NSLog(@"Error inserting data into database.");
                    }
                }
                
            }
        }
		
        if([pPlanCode isEqualToString:@"HLAWP"])
        {
            //description of basic plan, 2 pages
            pageNum++;
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@_HLAWP_Page30.html',%d,'%@')", tempLang, pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
        } else if([pPlanCode isEqualToString:@"S100"])
        {
            pageNum++;
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('S100_Page3.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
        } else if([pPlanCode isEqualToString:@"HLACP"])
        {
            //description of basic plan, 2 pages
            pageNum++;
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page30.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
        } else if([pPlanCode isEqualToString:@"L100"])
        {
            pageNum++;
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('L100_Page3.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
        }
        
		//rider benefits
		riderCount = 0; //reset rider count
		int descRiderCountStart; //start of rider description page
        
        if ([lang isEqualToString:@"Malay"]) {
            descRiderCountStart = 36; //start of rider description page
            [self buildSITempPagesRiderBenefit:&pageNum description:desc descRiderCountStart:descRiderCountStart endPage1:@"Page60" endPage2:@"Page61" endPage3:@"Page62"];
        } else {
            // english
            descRiderCountStart = 35;
            [self buildSITempPagesRiderBenefit:&pageNum description:desc descRiderCountStart:descRiderCountStart endPage1:@"Page40" endPage2:@"Page41" endPage3:@"Page42"];
        }
        */
        sqlStmt = Nil;
        dirPaths = Nil;
        docsDir = Nil;
        siNo = Nil;
        databaseName = Nil;
        desc = Nil;
        
    }
    
    [self clearLanguages];
    [self reArrangePages];
    
    //------- end ---------
}

- (void)buildSITempPagesHLAWP:(int *)pageNum desc:(NSString *)desc sqlStmt:(NSString **)sqlStmt DBID:(int *)DBID lang:(NSString *)tempLang
{
    NSString *pageDifferentiator;
    int numberOfItems;
    pageDifferentiator = [NSString stringWithFormat:@"%@_",pPlanCode];
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@Page1.html',%d,'%@')",pageDifferentiator,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    numberOfItems = _dataTable.rows.count + 1; //1 is for basic plan
    
    for (int i = 0; i <_dataTable.rows.count; i ++) {
        if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"CIWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"LCWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_PRE"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_STD"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"PR"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        }
    }
    if( numberOfItems > 13){
        (*pageNum)++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@Page1_2.html',%d,'%@')",pageDifferentiator,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('HLAWP_Page_Benefit1.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    //                numberOfItems = _dataTable.rows.count;
    numberOfItems = 1;
    for (int i = 0; i <_dataTable.rows.count; i ++) {
        if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"CIWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"LCWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_PRE"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_STD"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"PR"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"EDUWR"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"WB30R"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"WB50R"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"WBI6R30"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"WBD10R30"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"TPDYLA"] != NSNotFound) {
            numberOfItems = numberOfItems + 3;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"ICR"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"CCTR"] != NSNotFound ||
                   [[_dataTable.rows objectAtIndex:i] indexOfObject:@"HMM"] != NSNotFound ||
                   [[_dataTable.rows objectAtIndex:i] indexOfObject:@"CPA"] != NSNotFound ||
                   [[_dataTable.rows objectAtIndex:i] indexOfObject:@"WP30R"] != NSNotFound ||
                   [[_dataTable.rows objectAtIndex:i] indexOfObject:@"WP50R"] != NSNotFound ||
                   [[_dataTable.rows objectAtIndex:i] indexOfObject:@"WPTPD30R"] != NSNotFound ||
                   [[_dataTable.rows objectAtIndex:i] indexOfObject:@"WPTPD50R"] != NSNotFound) {
            numberOfItems = numberOfItems + 2;
        } else {
            numberOfItems++;
        }
    }
    
    if( numberOfItems >= 28){
        (*pageNum)++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('HLAWP_Page_Benefit2.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    if( numberOfItems >= 50){
        (*pageNum)++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('HLAWP_Page_Benefit3.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@Page2.html',%d,'%@')",pageDifferentiator,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@Page3.html',%d,'%@')",pageDifferentiator,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    
    NSString *riderTemp;
    NSArray* row;
    for (row in _dataTable.rows)
    {
        riderTemp = [row objectAtIndex:0];
        if([RiderViewController containsWealthGYIRiders:riderTemp]) //this one is only for HLAWP GYI Wealth Riders
        {
            for(int x=1; x<=2; x++)
            {
                pageNum++;
                *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc,riders) VALUES ('%@_HLAWP_PageWPRiders_%d_%@.html',%d,'Page%d','%@')", tempLang, x, riderTemp, *pageNum, *pageNum, riderTemp];
                
                *DBID = [_db ExecuteINSERT:*sqlStmt];
                if (*DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
            }
        }
    }
    
    if (wpGYIRidersCode.count > 0 ){ //HLA WP summary page
        pageNum++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@_HLAWP_Summary_Page1.html',%d,'%@')", tempLang, *pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
        
        pageNum++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@_HLAWP_Summary_Page2.html',%d,'%@')",tempLang, *pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
        
        pageNum++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@_HLAWP_Summary_Page3.html',%d,'%@')",tempLang, *pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
}

- (void)buildSITempPagesS100:(int *)pageNum desc:(NSString *)desc sqlStmt:(NSString **)sqlStmt DBID:(int *)DBID
{
    int numberOfItems;
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('S100_Page1.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    numberOfItems = _dataTable.rows.count + 1; //1 is for basic plan
        
    for (int i = 0; i <_dataTable.rows.count; i ++) {
        if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"CIWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"LCWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_PRE"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_STD"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"PR"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        }
    }
    
    if( numberOfItems > 13){
        (*pageNum)++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('S100_Page1_2.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    // adding Summary of Benefits for Basic Plan (and attached Riders)
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('HLAWP_Page_Benefit1.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    numberOfItems = 1;
    for (int i = 0; i <_dataTable.rows.count; i ++) {
        if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"CIWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"LCWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_PRE"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_STD"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"PR"] != NSNotFound) {
            numberOfItems = numberOfItems + 6;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"TPDYLA"] != NSNotFound) {
            numberOfItems = numberOfItems + 3;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"ICR"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"CCTR"] != NSNotFound ||
                   [[_dataTable.rows objectAtIndex:i] indexOfObject:@"HMM"] != NSNotFound ||
                   [[_dataTable.rows objectAtIndex:i] indexOfObject:@"CPA"] != NSNotFound) {
            numberOfItems = numberOfItems + 2;
        } else {
            numberOfItems++;
        }
    }
    
    if( numberOfItems >= 28){ //that mean one page ca
        (*pageNum)++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('HLAWP_Page_Benefit2.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('S100_Page2.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('S100_Page2_2.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
}


- (void)buildSITempPagesL100:(int *)pageNum desc:(NSString *)desc sqlStmt:(NSString **)sqlStmt DBID:(int *)DBID
{
    int numberOfItems;
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('BCALH_Page1.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    /*
    numberOfItems = _dataTable.rows.count + 1; //1 is for basic plan
    
    if( numberOfItems > 13){
        (*pageNum)++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('L100_Page1_2.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    numberOfItems = _dataTable.rows.count + 1;
    
    for (int i = 0; i <_dataTable.rows.count; i ++) {
        if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"CIWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"LCWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_PRE"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_STD"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"PR"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        }
    }
    */
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('eng_BCALH_Page2.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('eng_BCALH_Page3.html',%d,'%@')",*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
}
    
- (void)buildSITempPagesHLACP:(int *)pageNum desc:(NSString *)desc sqlStmt:(NSString **)sqlStmt DBID:(int *)DBID
{
    NSString *pageDifferentiator;
    int numberOfItems;
    pageDifferentiator = @"";
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@Page1.html',%d,'%@')",pageDifferentiator,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    numberOfItems = _dataTable.rows.count + 1; //1 is for basic plan
    
    for (int i = 0; i <_dataTable.rows.count; i ++) {
        if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"CIWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"LCWP"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_PRE"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"SP_STD"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        } else if ([[_dataTable.rows objectAtIndex:i] indexOfObject:@"PR"] != NSNotFound) {
            numberOfItems = numberOfItems + 4;
        }
    }
    
    if( numberOfItems > 13){
        (*pageNum)++;
        *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@Page1_2.html',%d,'%@')",pageDifferentiator,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        *DBID = [_db ExecuteINSERT:*sqlStmt];
        if (*DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@Page2.html',%d,'%@')",pageDifferentiator,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
    
    (*pageNum)++;
    *sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@Page3.html',%d,'%@')",pageDifferentiator,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
    *DBID = [_db ExecuteINSERT:*sqlStmt];
    if (*DBID <= 0){
        NSLog(@"Error inserting data into database.");
    }
}

- (void)buildSITempPagesRiderBenefit:(int *)pageNum description:(NSString *)desc descRiderCountStart:(int)descRiderCountStart endPage1:(NSString *)ePage1 endPage2:(NSString *)ePage2 endPage3:(NSString *)ePage3
{
    NSString *sqlStmt;
    NSArray *row;
    int DBID;
    int riderCount = 0;
    int riderInPageCount = 0; //number of rider in a page, maximum 3
    NSString *riderInPage = @""; //rider in a page, write to db
    NSString *curRider = @""; //current rider
    NSString *prevRider = @""; //previous rider
    NSString *headerTitle = @"tblHeader;";
    NSString *rc;
    for (row in _dataTable.rows) {
        riderCount++;
        curRider = [row objectAtIndex:0];
        if ([curRider isEqualToString:@"CCTR"] || [curRider isEqualToString:@"TPDYLA"] || [curRider isEqualToString:@"HB"] ||
            [curRider isEqualToString:@"HMM"] || [curRider isEqualToString:@"HSP_II"] || [curRider isEqualToString:@"MG_II"] ||
            [curRider isEqualToString:@"MG_IV"] || [curRider isEqualToString:@"PR"] ||
            [curRider isEqualToString:@"SP_STD"] || [curRider isEqualToString:@"PTR"] || [curRider isEqualToString:@"EDB"] ||
            [curRider isEqualToString:@"ETPDB"]  ){
            
            riderInPageCount++;
            prevRider = curRider;
            
            if(riderInPageCount == 1){
                riderInPage = [headerTitle stringByAppendingString:riderInPage];
            }
            
            riderInPage = [riderInPage stringByAppendingString:curRider];
            riderInPage = [riderInPage stringByAppendingString:@";"];
            if (riderInPageCount == 3){
                (*pageNum)++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
                prevRider = @"";
                
            } else if (riderInPageCount == 1 && riderCount == _dataTable.rows.count){
                (*pageNum)++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
                
            } if (riderInPageCount == 2 && riderCount == _dataTable.rows.count) {
                (*pageNum)++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
            }
        }
        else{
            if (riderInPageCount == 2){
                (*pageNum)++;
                if(riderInPageCount == 2)
                    riderInPage = [headerTitle stringByAppendingString:riderInPage];
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                prevRider= @"";
                riderInPageCount = 0;
                riderInPage = @"";
            }
            
            if ([prevRider isEqualToString:@"CCTR"] || [prevRider isEqualToString:@"TPDYLA"] || [prevRider isEqualToString:@"HB"] ||
                [prevRider isEqualToString:@"HMM"] || [prevRider isEqualToString:@"HSP_II"] || [prevRider isEqualToString:@"MG_II"] ||
                [prevRider isEqualToString:@"MG_IV"] || [prevRider isEqualToString:@"PR"] ||
                [prevRider isEqualToString:@"SP_STD"] || [prevRider isEqualToString:@"PTR"] || [prevRider isEqualToString:@"ETPDB"]
                || [prevRider isEqualToString:@"EDB"]){
                if (![curRider isEqualToString:@"ICR"] && ![curRider isEqualToString:@"LCPR"] && ![curRider isEqualToString:@"LCWP"] && ![curRider isEqualToString:@"CIWP"]
                    && ![curRider isEqualToString:@"PLCP"] && ![prevRider isEqualToString:@""] && ![curRider isEqualToString:@"CIR"] && ![curRider isEqualToString:@"SP_PRE"]
                    && ![curRider isEqualToString:@"PA"] && ![curRider isEqualToString:@"CPA"]  && ![curRider isEqualToString:@"WBI6R30"] && ![curRider isEqualToString:@"WBD10R30"]
                    && ![curRider isEqualToString:@"WB30R"] && ![curRider isEqualToString:@"WB50R"] ) {
                    
                    prevRider = [prevRider stringByAppendingString:@";"];
                    curRider = [prevRider stringByAppendingString:curRider];
                    riderInPageCount = 0;
                    riderInPage = @"";
                } else {
                    (*pageNum)++;
                    
                    if(riderInPageCount == 1) {
                        riderInPage = [headerTitle stringByAppendingString:riderInPage];
                    }
                    
                    sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
                               "('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
                    DBID = [_db ExecuteINSERT:sqlStmt];
                    if (DBID <= 0){
                        NSLog(@"Error inserting data into database.");
                    }
                    prevRider = @"";
                    riderInPage = @"";
                    riderInPageCount = 0;
                }
            }
            
            (*pageNum)++;
            if(riderInPageCount == 0) {
                curRider = [headerTitle stringByAppendingString:curRider];
            }
            
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",curRider,descRiderCountStart,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
            riderInPageCount = 0;
            if ([[row objectAtIndex:0] isEqualToString:@"C+"] || [[row objectAtIndex:0] isEqualToString:@"CPA"] || [[row objectAtIndex:0] isEqualToString:@"LCWP"] ||
                [[row objectAtIndex:0] isEqualToString:@"PLCP"] || [[row objectAtIndex:0] isEqualToString:@"ICR"] || [[row objectAtIndex:0] isEqualToString:@"WBI6R30"] ||
                [[row objectAtIndex:0] isEqualToString:@"LCPR"] || [[row objectAtIndex:0] isEqualToString:@"SP_PRE"] || [[row objectAtIndex:0] isEqualToString:@"PA"]) { // insert page 2 of rider desc
                
                (*pageNum)++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
                           "('%@','Page%d_2.html',%d,'%@')", curRider,descRiderCountStart,*pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
            }
        }
    }
    
    if([pPlanCode isEqualToString:@"HLAWP"] ||[pPlanCode isEqualToString:@"HLACP"]) {
        (*pageNum)++;
        sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@.html',%d,'%@')",ePage1, *pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        DBID = [_db ExecuteINSERT:sqlStmt];
        if (DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
        
        (*pageNum)++;
        sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@.html',%d,'%@')",ePage2, *pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
        DBID = [_db ExecuteINSERT:sqlStmt];
        if (DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    for (row in _dataTable.rows) {
        rc = [row objectAtIndex:0];
        if([rc isEqualToString:@"HMM" ] || [rc isEqualToString:@"HB" ] || [rc isEqualToString:@"MG_IV" ] || [rc isEqualToString:@"MG_II" ]
           || [rc isEqualToString:@"CIR" ] || [rc isEqualToString:@"CIWP" ] || [rc isEqualToString:@"HSP_II" ] || [rc isEqualToString:@"LCPR" ]
           || [rc isEqualToString:@"LCWP" ] || [rc isEqualToString:@"ICR"]  || [rc isEqualToString:@"SP_PRE" ] || [rc isEqualToString:@"PLCP" ] ){
            
            (*pageNum)++;
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@.html',%d,'%@')",ePage3, *pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",*pageNum]]];
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
            break;
        }
        rc = Nil;
    }
}

-(int)addRidersToSITempPagesWithPageNum:(int)page andSiNo:(NSString *)siNo {
    
    //rider benefits
    int descRiderCountStart = 35; //start of rider description page
    int riderInPageCount = 0; //number of rider in a page, maximum 3
    NSString *riderInPage = @""; //rider in a page, write to db
    //NSString *riderInPage1 = @"";
    NSString *curRider; //current rider
    NSString *prevRider; //previous rider
    NSString *headerTitle = @"tblHeader;";
    NSArray* row;
    NSString *desc = @"Page";
    int riderCount = 0;
    int DBID;
    int pageNum = page;
    NSString *sqlStmt = [NSString stringWithFormat:@"SELECT RiderCode FROM Trad_Rider_Details Where SINo = '%@' ORDER BY RiderCode ASC ",siNo];
    _dataTable = [_db  ExecuteQuery:sqlStmt];
    for (row in _dataTable.rows) {
        riderCount++;
        curRider = [row objectAtIndex:0];
        
        if ([curRider isEqualToString:@"CCTR"] || [curRider isEqualToString:@"TPDYLA"] || [curRider isEqualToString:@"HB"] ||
            [curRider isEqualToString:@"EDB"] || [curRider isEqualToString:@"ETPDB"]  ||
            [curRider isEqualToString:@"HMM"] || [curRider isEqualToString:@"HSP_II"] || [curRider isEqualToString:@"MG_II"] ||
            [curRider isEqualToString:@"MG_IV"] || [curRider isEqualToString:@"PR"] ||
            [curRider isEqualToString:@"SP_STD"] || [curRider isEqualToString:@"PTR"] ){
            riderInPageCount++;
            prevRider = curRider;
            
            if(riderInPageCount == 1){
                riderInPage = [headerTitle stringByAppendingString:riderInPage];
            }
            
            riderInPage = [riderInPage stringByAppendingString:curRider];
            riderInPage = [riderInPage stringByAppendingString:@";"];
            if (riderInPageCount == 3){
                pageNum++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                NSLog(@"curRider1a  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
                prevRider = @"";
                
            } else if (riderInPageCount == 1 && riderCount == _dataTable.rows.count){
                pageNum++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                NSLog(@"curRider1b  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
                
            } if (riderInPageCount == 2 && riderCount == _dataTable.rows.count) {
                pageNum++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                NSLog(@"curRider1c  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
            }
        }
        else{
            if (riderInPageCount == 2){
                pageNum++;
                if(riderInPageCount == 2)
                    riderInPage = [headerTitle stringByAppendingString:riderInPage];
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                NSLog(@"curRider2a  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                prevRider= @"";
                riderInPageCount = 0;
                riderInPage = @"";
            }
            
            if ([prevRider isEqualToString:@"CCTR"] || [prevRider isEqualToString:@"TPDYLA"] || [prevRider isEqualToString:@"HB"] ||
                [prevRider isEqualToString:@"HMM"] || [prevRider isEqualToString:@"HSP_II"] || [prevRider isEqualToString:@"MG_II"] ||
                [prevRider isEqualToString:@"MG_IV"] || [prevRider isEqualToString:@"PR"] ||
                [prevRider isEqualToString:@"SP_STD"] || [prevRider isEqualToString:@"PTR"] || [prevRider isEqualToString:@"ETPDB"]
                || [prevRider isEqualToString:@"EDB"]){
                if (![curRider isEqualToString:@"ICR"] && ![curRider isEqualToString:@"LCPR"] && ![curRider isEqualToString:@"LCWP"] && ![curRider isEqualToString:@"CIWP"]
                    && ![curRider isEqualToString:@"PLCP"] && ![prevRider isEqualToString:@""] && ![curRider isEqualToString:@"CIR"] && ![curRider isEqualToString:@"SP_PRE"]
                    && ![curRider isEqualToString:@"PA"] && ![curRider isEqualToString:@"CPA"] ) {
                    prevRider = [prevRider stringByAppendingString:@";"];
                    curRider = [prevRider stringByAppendingString:curRider];
                    riderInPageCount = 0;
                    riderInPage = @"";
                } else {
                    pageNum++;
                    
                    if(riderInPageCount == 1) {
                        riderInPage = [headerTitle stringByAppendingString:riderInPage];
                    }
                    
                    sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
                               "('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                    NSLog(@"curRider2b  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                    DBID = [_db ExecuteINSERT:sqlStmt];
                    if (DBID <= 0){
                        NSLog(@"Error inserting data into database.");
                    }
                    prevRider = @"";
                    riderInPage = @"";
                    riderInPageCount = 0;
                }
            }
            
            pageNum++;
            if(riderInPageCount == 0) {
                curRider = [headerTitle stringByAppendingString:curRider];
            }
            
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",curRider,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
            NSLog(@"curRider2c  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
            riderInPageCount = 0;
            
            if ([[row objectAtIndex:0] isEqualToString:@"C+"] || [[row objectAtIndex:0] isEqualToString:@"CPA"] || [[row objectAtIndex:0] isEqualToString:@"LCWP"] ||
                [[row objectAtIndex:0] isEqualToString:@"PLCP"] || [[row objectAtIndex:0] isEqualToString:@"ICR"] || [[row objectAtIndex:0] isEqualToString:@"WBI6R30"] ||
                [[row objectAtIndex:0] isEqualToString:@"LCPR"] || [[row objectAtIndex:0] isEqualToString:@"PA"]) { // insert page 2 of rider desc
                pageNum++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
                           "('%@','Page%d_2.html',%d,'%@')", curRider,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                DBID = [_db ExecuteINSERT:sqlStmt];
                NSLog(@"curRider2d  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
            }
        }
    }
    
    if([pPlanCode isEqualToString:@"HLACP"]||[pPlanCode isEqualToString:@"HLAWP"]) {
        pageNum++;
        sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page40.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
        NSLog(@"curRider3  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
        DBID = [_db ExecuteINSERT:sqlStmt];
        if (DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
        
        pageNum++;
        sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page41.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
        NSLog(@"curRider4  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
        DBID = [_db ExecuteINSERT:sqlStmt];
        if (DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    NSString *rc;
    for (row in _dataTable.rows) {
        rc = [row objectAtIndex:0];
        
        if([rc isEqualToString:@"HMM" ] || [rc isEqualToString:@"HB" ] || [rc isEqualToString:@"MG_IV" ] || [rc isEqualToString:@"MG_II" ]
           || [rc isEqualToString:@"CIR" ] || [rc isEqualToString:@"CIWP" ] || [rc isEqualToString:@"HSP_II" ] || [rc isEqualToString:@"LCPR" ]
           || [rc isEqualToString:@"LCWP" ] || [rc isEqualToString:@"ICR"]  || [rc isEqualToString:@"SP_PRE" ] || [rc isEqualToString:@"PLCP" ] ){
            
            pageNum++;
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page42.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
            NSLog(@"curRider5  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
            break;
        }
        rc = Nil;
    }
    
    riderCount = 0; //reset rider count
    descRiderCountStart = 36; //start of rider description page
    riderInPageCount = 0; //number of rider in a page, maximum 3
    riderInPage = @""; //rider in a page, write to db
    prevRider = @"";
    
    curRider = @""; //current rider         prevRider = @""; //previous rider
    headerTitle = @"tblHeader;";
    
    
    for (row in _dataTable.rows) {
        //income rider
        riderCount++;
        curRider = [row objectAtIndex:0];
        
        if ([curRider isEqualToString:@"CCTR"] || [curRider isEqualToString:@"TPDYLA"] || [curRider isEqualToString:@"HB"] ||
            [curRider isEqualToString:@"HMM"] || [curRider isEqualToString:@"HSP_II"] || [curRider isEqualToString:@"MG_II"] ||
            [curRider isEqualToString:@"MG_IV"] || [curRider isEqualToString:@"PR"] ||
            [curRider isEqualToString:@"SP_STD"] || [curRider isEqualToString:@"PTR"] || [curRider isEqualToString:@"EDB"] || [curRider isEqualToString:@"ETPDB"]){
            riderInPageCount++;
            prevRider = curRider;
            
            if(riderInPageCount == 1){
                riderInPage = [headerTitle stringByAppendingString:riderInPage];
            }
            riderInPage = [riderInPage stringByAppendingString:curRider];
            riderInPage = [riderInPage stringByAppendingString:@";"];
            if (riderInPageCount == 3){
                pageNum++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                NSLog(@"curRider6  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
                prevRider = @"";
            }
            
            if (riderInPageCount == 1 && riderCount == _dataTable.rows.count){
                pageNum++;
                
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                NSLog(@"curRider7  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
            }
            
            if (riderInPageCount == 2 && riderCount == _dataTable.rows.count) {
                pageNum++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                NSLog(@"curRider8  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                riderInPageCount = 0;
                riderInPage = @"";
            }
        } else {
            if (riderInPageCount == 2){
                pageNum++;
                if(riderInPageCount == 2) {
                    riderInPage = [headerTitle stringByAppendingString:riderInPage];
                }
                
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                NSLog(@"curRider9  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
                
                prevRider= @"";
                riderInPageCount = 0;
                riderInPage = @"";
            }
            
            if ([prevRider isEqualToString:@"CCTR"] || [prevRider isEqualToString:@"TPDYLA"] || [prevRider isEqualToString:@"HB"] ||
                [prevRider isEqualToString:@"HMM"] || [prevRider isEqualToString:@"HSP_II"] || [prevRider isEqualToString:@"MG_II"] ||
                [prevRider isEqualToString:@"MG_IV"] || [prevRider isEqualToString:@"PR"] ||
                [prevRider isEqualToString:@"SP_STD"] || [prevRider isEqualToString:@"PTR"] || [prevRider isEqualToString:@"ETPDB"]
                || [prevRider isEqualToString:@"EDB"]){
                if (![curRider isEqualToString:@"ICR"] && ![curRider isEqualToString:@"LCPR"] && ![curRider isEqualToString:@"LCWP"] && ![curRider isEqualToString:@"CIWP"] && ![curRider isEqualToString:@"CIR"]
                    && ![curRider isEqualToString:@"PLCP"] && ![prevRider isEqualToString:@""] && ![curRider isEqualToString:@"SP_PRE"] && ![curRider isEqualToString:@"C+"] && ![curRider isEqualToString:@"PA"]&& ![curRider isEqualToString:@"WB30R"] && ![curRider isEqualToString:@"WB50R"] && ![curRider isEqualToString:@"CPA"]) {
                    prevRider = [prevRider stringByAppendingString:@";"];
                    curRider = [prevRider stringByAppendingString:curRider];
                    riderInPageCount = 0;
                    riderInPage = @"";
                    
                } else {
                    pageNum++;
                    if(riderInPageCount == 0){
                        riderInPage = [headerTitle stringByAppendingString:riderInPage];
                    }
                    sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
                               "('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                    DBID = [_db ExecuteINSERT:sqlStmt];
//                    NSLog(@"curRider10  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                    if (DBID <= 0){
                        NSLog(@"Error inserting data into database.");
                    }
                    prevRider = @"";
                    riderInPage = @"";
                    riderInPageCount = 0;
                }
            }
            
            pageNum++;
            if(riderInPageCount == 0) {
                curRider = [headerTitle stringByAppendingString:curRider];
            }
            
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",curRider,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
            NSLog(@"curRider11  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
            
            if ([[row objectAtIndex:0] isEqualToString:@"C+"] || [[row objectAtIndex:0] isEqualToString:@"CPA"] ||  [[row objectAtIndex:0] isEqualToString:@"LCPR"] ||
                [[row objectAtIndex:0] isEqualToString:@"LCWP"] || [[row objectAtIndex:0] isEqualToString:@"SP_PRE"] ||
                [[row objectAtIndex:0] isEqualToString:@"ICR"] || [[row objectAtIndex:0] isEqualToString:@"PA"] ||
                [[row objectAtIndex:0] isEqualToString:@"WBI6R30"] || [[row objectAtIndex:0] isEqualToString:@"PLCP"]) { // insert page 2 of rider desc
                pageNum++;
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
                           "('%@','Page%d_2.html',%d,'%@')", curRider,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                DBID = [_db ExecuteINSERT:sqlStmt];
                NSLog(@"curRider12  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
            }
        }
    }
    
    if([pPlanCode isEqualToString:@"HLACP"]||[pPlanCode isEqualToString:@"HLAWP"]) {
        pageNum++;
        sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page60.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
        NSLog(@"curRider13  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
        DBID = [_db ExecuteINSERT:sqlStmt];
        if (DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
        
        pageNum++;
        sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page61.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
        NSLog(@"curRider14  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
        DBID = [_db ExecuteINSERT:sqlStmt];
        if (DBID <= 0){
            NSLog(@"Error inserting data into database.");
        }
    }
    
    for (row in _dataTable.rows) {
        rc = [row objectAtIndex:0];
        
        if([rc isEqualToString:@"HMM" ] || [rc isEqualToString:@"HB" ] || [rc isEqualToString:@"MG_IV" ] || [rc isEqualToString:@"MG_II" ]
           || [rc isEqualToString:@"CIR" ] || [rc isEqualToString:@"CIWP" ] || [rc isEqualToString:@"HSP_II" ]|| [rc isEqualToString:@"LCPR" ]
           || [rc isEqualToString:@"LCWP" ] || [rc isEqualToString:@"ICR"]   || [rc isEqualToString:@"SP_PRE" ] || [rc isEqualToString:@"PLCP" ] ){
            
            pageNum++;
            sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page62.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
            NSLog(@"curRider15  curRider: %@      sqlStmt:%@",riderInPage, sqlStmt);
            DBID = [_db ExecuteINSERT:sqlStmt];
            if (DBID <= 0){
                NSLog(@"Error inserting data into database.");
            }
            
            break;
        }
        rc = Nil;
    }
    
    NSLog(@"end:  %d",pageNum);
    sqlStmt = Nil;
    riderInPage = Nil;
    headerTitle = Nil;
    curRider = Nil;
    prevRider = Nil;
    return pageNum;
}

-(void)dealloc {
    _dataTable = Nil;
    _db = Nil;
    
    RatesDatabasePath = Nil;
    YearlyIncome = Nil;
    CashDividend = Nil;
    CustCode = Nil;
    Name = Nil;
    strBasicAnnually = Nil, strBasicSemiAnnually = Nil, strBasicQuarterly = Nil, strBasicMonthly = Nil;
    strOriBasicAnnually = Nil, strOriBasicSemiAnnually = Nil, strOriBasicQuarterly = Nil, strOriBasicMonthly = Nil;
    sex = Nil,
    OccpClass = Nil;
    OccLoading = Nil, aStrOtherRiderAnnually = Nil, aStrOtherRiderMonthly = Nil;
    aStrOtherRiderQuarterly =Nil, aStrOtherRiderSemiAnnually = nil;
    OtherRiderCode = Nil, OtherRiderDeductible = Nil, OtherRiderDesc= Nil, OtherRiderPlanOption = Nil, OtherRiderSA = Nil;
    OtherRiderTerm = Nil, SummaryGuaranteedAddValue = Nil, SummaryGuaranteedDBValueA = Nil;
    SummaryGuaranteedDBValueB = Nil, SummaryGuaranteedSurrenderValue = Nil, SummaryGuaranteedTotalGYI = Nil;
    SummaryNonGuaranteedAccuCashDividendA = Nil, SummaryNonGuaranteedAccuCashDividendB = Nil, SummaryNonGuaranteedAccuYearlyIncomeA = nil;
    SummaryNonGuaranteedAccuYearlyIncomeA = Nil, SummaryNonGuaranteedAccuYearlyIncomeB = Nil, SummaryNonGuaranteedDBValueA = Nil;
    SummaryNonGuaranteedDBValueB = Nil, SummaryNonGuaranteedSurrenderValueA = Nil, SummaryNonGuaranteedSurrenderValueB =Nil;
    _db = Nil, _dataTable = Nil;
    UpdateTradDetail = Nil, gWaiverAnnual = Nil, gWaiverSemiAnnual = Nil, gWaiverQuarterly = Nil, gWaiverMonthly = Nil;
    aStrBasicSA = Nil, HealthLoadingTerm = Nil, TempHealthLoading = Nil, TempHealthLoadingTerm = Nil;
    databasePath = Nil;
    contactDB = Nil;
    
    wpGYIRidersPremAnnual = nil;
    wpGYIRiderDeductible = nil;
    wpGYIRiderDesc = nil;
    wpGYIRiderHL100SA = nil;
    wpGYIRiderHL100SATerm = nil;
    wpGYIRiderHL1kSA = nil;
    wpGYIRiderHL1kSATerm = nil;
    wpGYIRiderHLPercentage = nil;
    wpGYIRiderHLPercentageTerm = nil;
    wpGYIRiderPlanOption = nil;
    wpGYIRidersCode = nil;
    wpGYIRidersPayingTerm = nil;
    wpGYIRidersPremAnnual = nil;
    wpGYIRidersPremAnnualWithoutHLoading = nil;
    wpGYIRidersPremMonth = nil;
    wpGYIRidersPremQuarter = nil;
    wpGYIRidersPremSemiAnnual = nil;
    wpGYIRidersSA = nil;
    wpGYIRidersTerm = nil;
    wpGYIRiderTempHL = nil;
    wpGYIRiderTempHLTerm = nil;
            
    aStrWPGYIRiderAnnually = nil;
    aStrWPGYIRiderSemiAnnually = nil;
    aStrWPGYIRiderQuarterly = nil;
    aStrWPGYIRiderMonthly = nil;
    
    SummaryTotalPremiumPaid =  nil;
    SummaryTotalPayoutOption = nil;
    SummaryTotalPayoutAndAccumulate = nil;
    SummaryTotalAccumulateWithoutInterest = nil;
	
    SummaryNonGuaranteedCurrentCashDividendA = nil;
    SummaryNonGuaranteedCurrentCashDividendB = nil;
    SummaryNonGuaranteedAccuCashDividendA = nil;
    SummaryNonGuaranteedAccuCashDividendB = nil;
    SummaryNonGuaranteedAccuYearlyIncomeA = nil;
    SummaryNonGuaranteedAccuYearlyIncomeB = nil;
    SummaryNonGuaranteedDBValueA = nil;
    SummaryNonGuaranteedDBValueB = nil;
    SummaryNonGuaranteedSurrenderValueA = nil;
    SummaryNonGuaranteedSurrenderValueB = nil;
    
    SummaryNonGuaranteedTotalTDivA = nil;
    SummaryNonGuaranteedTotalTDivB = nil;
    SummaryNonGuaranteedTotalSpeA = nil;
    SummaryNonGuaranteedTotalSpeB = nil;
    
    CIRiders = nil;
	CIRiders2 = nil;
	
    BasicTotalYearlyIncome = 0.00;
    BasicMaturityValueA = 0.00;
    BasicMaturityValueB = 0.00;
    BasicTotalPremiumPaid = 0.00;
    
    EntireTotalYearlyIncome = 0.00;
    EntireMaturityValueA = 0.00;
    EntireMaturityValueB = 0.00;
    EntireTotalPremiumPaid = 0.00;
	TotalCI = 0.00;
	TotalCI2 = 0.00;
    
    gstValue = 0.06;
    
    pPlanName = nil;
}

-(void)Insert_Into_SI_temp_Benefit
{
    NSString *databaseName = @"hladb.sqlite";
    NSString *WP1;
    NSString * WPRider = @"100%<br/>total<br/>Premium<br/>Paid For<br/>this Rider";
    NSString * MedicalRider = @"Medical Plan";
    
    if (PolicyTerm == 30) {
        WP1 = @"150%<br/>of total Basic premium Paid";
    } else {
        WP1 = @"250%<br/>of total Basic premium Paid";
    }
    
    NSString * sqlStmt = nil;
    self.db = [DBController sharedDatabaseController:databaseName];
    if ([pPlanCode isEqualToString:@"HLAWP"]) {
        sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('HLA Wealth Plan','-','-','%@','-','-','-','-','-','-','-','-','-','%@','Yes','Yes')",WP1,WP1];
    } else {
        sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('Secure 100','-','-','%@','-','-','-','-','-','-','-','-','-','%@','Yes','No')",WP1,WP1];
    }
    [_db ExecuteINSERT:sqlStmt];
    
    sqlStmt = [NSString stringWithFormat:@"SELECT A.riderCode, B.riderDesc, A.SumAssured, A.PlanOption FROM Trad_Rider_Details A left outer join trad_sys_rider_profile B on A.riderCode=B.riderCode Where SINo = '%@' ",SINo];
    _dataTable = [_db  ExecuteQuery:sqlStmt];
    NSString *tempRiderCode;
    NSString *riderName;
    NSString *RSA;
    NSString *PlanOption;
    for(int x = 0; x < [OtherRiderCode count]; x++)
    {
        tempRiderCode = [OtherRiderCode objectAtIndex:x];
        riderName = [OtherRiderDesc objectAtIndex:x];
        RSA = [OtherRiderSA objectAtIndex:x];
        PlanOption = [OtherRiderPlanOption objectAtIndex:x];
        
        if( [tempRiderCode isEqualToString:@"WP30R"] || [tempRiderCode isEqualToString:@"WP50R"] ) {
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','-','%@','-','-','-','-','-','-','-','-','-','Yes','No')",riderName,RSA];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if([tempRiderCode isEqualToString:@"WPTPD30R"] || [tempRiderCode isEqualToString:@"WPTPD50R"] ) {
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','-','-','-','%@','-','-','-','-','-','-','-','Yes','Yes')",riderName,RSA];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"ACIR"] || [tempRiderCode isEqualToString:@"CIR"]  ){
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','-','-','-','-','%@','-','-','-','-','-','-','No','No')",riderName,RSA];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"LCPR"] || [tempRiderCode isEqualToString:@"PCLP"] ){
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','%@','-','-','-','%@','-','-','-','-','-','-','Yes','No')",riderName,RSA,RSA];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"CCTR"] || [tempRiderCode isEqualToString:@"PTR"] ){
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','%@','-','-','-','-','-','-','-','-','-','-','Yes','No')",riderName,RSA];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"HMM"] || [tempRiderCode isEqualToString:@"MG_IV"] || [tempRiderCode isEqualToString:@"MG_II"]){
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','%@','-','-','-','-','-','-','-','-','%@','-','-','-','No','No')",riderName, PlanOption, MedicalRider];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"HSP_II"]) {
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','%@','-','-','-','-','-','-','-','-','%@','-','-','-','No','No')",riderName, [self ReturnRiderOption:PlanOption AndRiderCode:tempRiderCode], MedicalRider];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"HB"] ) {
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','-','-','-','-','-','-','-','%@','-','-','-','No','No')",riderName, @"Hospitalisation Income"];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"C+"]  ) {
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','%@','-','-','-','-','-','-','%@','-','-','-','-','-','Yes','No')",riderName, [self ReturnRiderOption:PlanOption AndRiderCode:tempRiderCode], RSA];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"PA"]  ) {
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','-','-','-','-','-','-','%@','-','-','-','-','No','No')",riderName, RSA];
            [_db ExecuteINSERT:sqlStmt];
            
        } else if ([tempRiderCode isEqualToString:@"ICR"]   ) {
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','-','-','-','-','-','-','-','-','%@','-','-','No','No')",riderName, RSA];
            [_db ExecuteINSERT:sqlStmt];
        }
    }
    
    for(int x = 0; x < [wpGYIRidersCode count]; x++) {
        tempRiderCode = [wpGYIRidersCode objectAtIndex:x];
        riderName = [wpGYIRiderDesc objectAtIndex:x];
        
        if([tempRiderCode isEqualToString:@"EDUWR"] || [tempRiderCode isEqualToString:@"WB30R"] || [tempRiderCode isEqualToString:@"WBI6R30"]
           || [tempRiderCode isEqualToString:@"WBD10R30"] || [tempRiderCode isEqualToString:@"WB50R"] ) {
            sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('%@','-','-','%@','-','-','-','-','-','-','-','-','100.00','-','Yes','Yes')",riderName,WPRider];
            [_db ExecuteINSERT:sqlStmt];
        }
    }
    
    if(gWaiverAnnual > 0){
        sqlStmt = [NSString stringWithFormat:@"insert into SI_Temp_Benefit values('Waiver of Premium Riders','','','','','','','','','','','','','','','')"];
        [_db ExecuteINSERT:sqlStmt];
    }
    
}

-(NSString *)ReturnRiderOption : (NSString *)aaOption AndRiderCode : (NSString *)aaRiderCode {
    if ([aaRiderCode isEqualToString:@"C+"]) {
        if ([aaOption isEqualToString:@"L"]) {
            return @"Option 1";
        } else if ([aaOption isEqualToString:@"I"]) {
            return @"Option 2";
        } else if ([aaOption isEqualToString:@"B"]) {
            return @"Option 3";
        } else {
            return @"Option 4";
        }
    } else {
        if ([aaOption isEqualToString:@"S"]) {
            return @"Standard";
        } else if ([aaOption isEqualToString:@"D"]) {
            return @"Deluxe";
        } else {
            return @"Premier";
        }
    }
}

-(void)copyReportFolderToDoc:(NSString *)dir{
    NSString *directory = dir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentSIFolderPath = [documentsDirectory stringByAppendingPathComponent:directory];
    NSString *resourceSIFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:directory];
    
    if (![fileManager fileExistsAtPath:documentSIFolderPath]) {
        [fileManager createDirectoryAtPath:documentSIFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    } else {
        [fileManager removeItemAtPath:documentSIFolderPath error:&error];
        [fileManager createDirectoryAtPath:documentSIFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:resourceSIFolderPath error:&error];
    NSString *newFilePath;
    NSString *oldFilePath;
    for (NSString *SIFiles in fileList) {
        newFilePath = [documentSIFolderPath stringByAppendingPathComponent:SIFiles];
        oldFilePath = [resourceSIFolderPath stringByAppendingPathComponent:SIFiles];
        [fileManager copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
    }
}


-(NSString *) getPlanNameFromCode
{
    NSString *temp = nil;
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK) {
        NSString *querySQL = [NSString stringWithFormat:@"select PlanName from Trad_Sys_Profile where PlanCode='%@'",pPlanCode];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                temp = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return temp;
}

-(NSMutableDictionary *) getRiderCodesForThisPlan:(NSString*)planCode
{
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath2 = [paths2 objectAtIndex:0];
    NSString *path2 = [docsPath2 stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path2];
    [database open];
    
    NSString *sql = [NSString stringWithFormat:@"select A.RiderCode as RiderCode, B.RiderDesc as RiderDesc from Trad_Sys_RiderComb A left outer join Trad_Sys_Rider_Profile B on A.RiderCode=B.RiderCode where A.PlanCode = '%@' Order by A.PTypeCode, A.Seq, A.RiderCode", planCode];
    
    FMResultSet *results = [database executeQuery:sql];
    
//    NSLog(@"rider code sql:%@",sql);
    
    NSMutableDictionary *riderDict = [NSMutableDictionary dictionary];
    
    NSString *obj = nil;
    NSString *key = nil;
    
    while([results next]) {
        obj = [NSString stringWithFormat:@"%@", [results stringForColumn:@"RiderCode"]];
        key = [NSString stringWithFormat:@"%@", [results stringForColumn:@"RiderDesc"]];
        [riderDict setObject:obj forKey:key];
    }
    
    return riderDict;
}

- (void)SetupRiderCode
{
    riderCode = [NSMutableDictionary dictionary];
    
    if([pPlanCode isEqualToString:@"HLAWP"]) {
        riderCode = [self getRiderCodesForThisPlan:@"HLAWP"];
        [riderCode setObject:@"HLAWP" forKey:@"HLA Wealth Plan"];
    } else if([pPlanCode isEqualToString:@"HLACP"]) {
        if([pPlanCode isEqualToString:@"HLACP"]) {
            [riderCode setObject:@"HLACP" forKey:@"HLA Cash Promise"];
        }
        
        [riderCode setObject:@"C+" forKey:@"C+ Secure"];
        [riderCode setObject:@"CCTR" forKey:@"Convertible Comprehensive Term Rider"];
        [riderCode setObject:@"CIR" forKey:@"Critical Illness Rider"];
        [riderCode setObject:@"CIWP" forKey:@"Critical Illness Waiver of Premium Rider"];
        [riderCode setObject:@"CPA" forKey:@"Comprehensive Personal Accident Rider"];
        [riderCode setObject:@"EDB" forKey:@"Enhanced Death Benefit Rider "];
        [riderCode setObject:@"TPDYLA" forKey:@"TPD Yearly Living Allowance Rider"];
        [riderCode setObject:@"ETPDB" forKey:@"Enhanced TPD Benefit Rider"];
        [riderCode setObject:@"HB" forKey:@"Hospitalisation Benefit Rider"];
        [riderCode setObject:@"HMM" forKey:@"HLA Major Medi"];
        [riderCode setObject:@"HSP_II" forKey:@"Hospital & Surgical Plus II"];
        [riderCode setObject:@"ICR" forKey:@"Income Care Rider"];
        [riderCode setObject:@"LCPR" forKey:@"Living Care Plus Rider"];
        [riderCode setObject:@"MG_II" forKey:@"MedGLOBAL II"];
        [riderCode setObject:@"MG_IV" forKey:@"MedGLOBAL IV Plus"];
        [riderCode setObject:@"PA" forKey:@"Personal Accident Rider"];
        [riderCode setObject:@"LCWP" forKey:@"Living Care Waiver Of Premium Payor Rider"];
        [riderCode setObject:@"PR" forKey:@"Waiver of Premium Payor Rider"];
        [riderCode setObject:@"SP_PRE" forKey:@"Waiver of Premium Spouse Rider (Premier)"];
        [riderCode setObject:@"SP_STD" forKey:@"Waiver of Premium Spouse Rider (Standard)"];
        [riderCode setObject:@"PLCP" forKey:@"Payor Living Care Plus Rider"];
        [riderCode setObject:@"PTR" forKey:@"Payor Term Rider"];
        
    } else if([pPlanCode isEqualToString:@"L100"]) {
        [riderCode setObject:@"L100" forKey:@"Life100"];
        
        [riderCode setObject:@"ACIR" forKey:@"Accelerated Critical Illness"];
        [riderCode setObject:@"C+" forKey:@"C+ Secure"];
        [riderCode setObject:@"CCTR" forKey:@"Convertible Comprehensive Term Rider"];
        [riderCode setObject:@"CIR" forKey:@"Critical Illness Rider"];
        [riderCode setObject:@"CIWP" forKey:@"Critical Illness Waiver of Premium Rider"];
        [riderCode setObject:@"CPA" forKey:@"Comprehensive Personal Accident Rider"];
        [riderCode setObject:@"TPDYLA" forKey:@"TPD Yearly Living Allowance Rider"];
        [riderCode setObject:@"HB" forKey:@"Hospitalisation Benefit Rider"];
        [riderCode setObject:@"HMM" forKey:@"HLA Major Medi"];
        [riderCode setObject:@"HSP_II" forKey:@"Hospital & Surgical Plus II"];
        [riderCode setObject:@"ICR" forKey:@"Income Care Rider"];
        [riderCode setObject:@"LCPR" forKey:@"Living Care Plus Rider"];
        [riderCode setObject:@"MG_II" forKey:@"MedGLOBAL II"];
        [riderCode setObject:@"MG_IV" forKey:@"MedGLOBAL IV Plus"];
        [riderCode setObject:@"PA" forKey:@"Personal Accident Rider"];
        [riderCode setObject:@"LCWP" forKey:@"Living Care Waiver Of Premium Payor Rider"];
        [riderCode setObject:@"PR" forKey:@"Waiver of Premium Payor Rider"];
        [riderCode setObject:@"SP_PRE" forKey:@"Waiver of Premium Spouse Rider (Premier)"];
        [riderCode setObject:@"SP_STD" forKey:@"Waiver of Premium Spouse Rider (Standard)"];
        [riderCode setObject:@"PLCP" forKey:@"Payor Living Care Plus Rider"];
        [riderCode setObject:@"PTR" forKey:@"Payor Term Rider"];
        
    } else if([pPlanCode isEqualToString:@"S100"]) {
        [riderCode setObject:@"S100" forKey:@"Secure 100"];
        
        [riderCode setObject:@"ACIR" forKey:@"Accelerated Critical Illness"];
        [riderCode setObject:@"C+" forKey:@"C+ Secure"];
        [riderCode setObject:@"CCTR" forKey:@"Convertible Comprehensive Term Rider"];
        [riderCode setObject:@"CIR" forKey:@"Critical Illness Rider"];
        [riderCode setObject:@"CIWP" forKey:@"Critical Illness Waiver of Premium Rider"];
        [riderCode setObject:@"CPA" forKey:@"Comprehensive Personal Accident Rider"];
        [riderCode setObject:@"TPDYLA" forKey:@"TPD Yearly Living Allowance Rider"];
        [riderCode setObject:@"HB" forKey:@"Hospitalisation Benefit Rider"];
        [riderCode setObject:@"HMM" forKey:@"HLA Major Medi"];
        [riderCode setObject:@"HSP_II" forKey:@"Hospital & Surgical Plus II"];
        [riderCode setObject:@"ICR" forKey:@"Income Care Rider"];
        [riderCode setObject:@"LCPR" forKey:@"Living Care Plus Rider"];
        [riderCode setObject:@"MG_II" forKey:@"MedGLOBAL II"];
        [riderCode setObject:@"MG_IV" forKey:@"MedGLOBAL IV Plus"];
        [riderCode setObject:@"PA" forKey:@"Personal Accident Rider"];
        [riderCode setObject:@"LCWP" forKey:@"Living Care Waiver Of Premium Payor Rider"];
        [riderCode setObject:@"PR" forKey:@"Waiver of Premium Payor Rider"];
        [riderCode setObject:@"SP_PRE" forKey:@"Waiver of Premium Spouse Rider (Premier)"];
        [riderCode setObject:@"SP_STD" forKey:@"Waiver of Premium Spouse Rider (Standard)"];
        [riderCode setObject:@"PLCP" forKey:@"Payor Living Care Plus Rider"];
        [riderCode setObject:@"PTR" forKey:@"Payor Term Rider"];
    }
}

-(void)copyRatesJSONFromPath:(NSString *)docsDir {
	
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *DBerror;
    
    NSString *CommDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Rates.json"]];
    
    BOOL success;
    if([fileManager fileExistsAtPath:CommDatabasePath] == FALSE ){
		NSString *RatesFromBundle = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Rates.json"];
		success = [fileManager copyItemAtPath:RatesFromBundle toPath:CommDatabasePath error:&DBerror];
		if (!success) {
			NSAssert1(0, @"Failed to create UL Rates file with message '%@'.", [DBerror localizedDescription]);
		}
        RatesFromBundle= Nil;
	}
}

-(void)generateJSON_HLCP:(BOOL)isPDS // to generate Json file for quotation
{
    NSString* temp;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //[self SetupRiderCode];
    
    NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath2 = [paths2 objectAtIndex:0];
    NSString *path2 = [docsPath2 stringByAppendingPathComponent:@"hladb.sqlite"];
    
    [self copyRatesJSONFromPath:docsPath2];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path2];
    [database open];
    FMResultSet *results;
    NSString *query;
    int totalRecords = 0;
    
    results = [database executeQuery:@"select AgentCode,AgentName from Agent_profile"];
    NSString *agentCode;
    NSString *agentName;
    while([results next]) {
        agentCode = [results stringForColumn:@"AgentCode"];
        agentName  = [results stringForColumn:@"AgentName"];
    }
    
    results = [database executeQuery:@"select SINo, PlanCode, PlanName from SI_Temp_Trad"];
    NSString *_SINo;
    NSString *PlanName;
    NSString *PlanCode;

        _SINo = SINo;
        PlanCode = @"BCALH";
        PlanName = @"";

    
    query = [NSString stringWithFormat:@"Select UpdatedAt,HL1KSA,TempHL1KSA from Trad_Details where SINo ='%@'",_SINo];
    results = [database executeQuery:query];
    NSString *UpdatedAt;
    int HL1KSA = 0.0;
    double TempHL1KSA = 0;
    if ([results next]) {
        UpdatedAt = [results stringForColumnIndex:0];
        HL1KSA = [results intForColumnIndex:1];
        TempHL1KSA = [results doubleForColumnIndex:2];
    }
    
    int TotalPages = 0;
    if ([PDSorSI isEqualToString:@"SI"]) {
        results = [database executeQuery:@"select count(*) as cnt from SI_Temp_Pages"];
    } else {
        results = [database executeQuery:@"select count(*) as cnt from SI_Temp_Pages_PDS"];
    }
    
    if ([results next]) {
        TotalPages = [results intForColumn:@"cnt"];
    }
    
    //make a file name to write the data to using the documents directory:
    NSString *jsonFile = [docsPath2 stringByAppendingPathComponent:@"SI.json"];
    
    NSMutableString *content = [[NSMutableString alloc] initWithString:@"{\n"];
    [content appendString:@"\"SI\": [\n"];
    [content appendString:@"{\n"];
    
    [self buildSITempPages:database withContent:&content];
    //SI_Temp_Pages end
    
    //SI_Temp_Benefit page starts
    if([pPlanCode isEqualToString:@"HLAWP"])
    {
        [self buildSITempBenefit:database withContent:&content];
    }
    //SI_Temp_Benefit Pages ends
    
    //SI Underwriting Pages starts
    if (reportType == REPORT_UNDERWRITING)
    {
        [self buildSIUnderwritingPages:database withContent:&content];
    }
    //SI Underwriting Pages ends
    

    
    //SI Main components for Quotation start
    if(!isPDS)
    {
        [content appendFormat:@"\"agentCode\":\"%@\",\n", agentCode];
        [content appendFormat:@"\"agentName\":\"%@\",\n", agentName];
        [content appendFormat:@"\"SINo\":\"%@\",\n", _SINo];
        [content appendFormat:@"\"PlanCode\":\"%@\",\n", PlanCode];
        [content appendFormat:@"\"PlanName\":\"%@\",\n", PlanName];
        NSDate *tempDate = [dateFormatter dateFromString:UpdatedAt];
        dateFormatter.dateFormat = @"dd/MM/yyyy hh:mm:ssa";
        
        [content appendFormat:@"\"DateModified\":\"%@\",\n", [dateFormatter stringFromDate:tempDate ]];
        [content appendFormat:@"\"HL1KSA\":\"%d\",\n", HL1KSA];
        [content appendFormat:@"\"TempHL1KSA\":\"%f\",\n", TempHL1KSA];
        [content appendFormat:@"\"OCCPClass\":\"%@\",\n", OccpClass];
        [content appendFormat:@"\"BasicSA\":\"%f\",\n", BasicSA ];
        
        [content appendFormat:@"\"TotalPages\":\"%d\",\n", TotalPages];
        [content appendFormat:@"\"QuotationLang\":\"%@\",\n", lang];
    }
    //SI Main components for Quotation ends
    
    //SI_Temp_Trad_LA start
    [self buildSITempTradLA:_SINo database:database withContent:&content];
    //SI_Temp_Trad_LA end
    

    
    //SI_Temp_Trad_Basic start
    temp = [self buildTempSITradBasicUsing:database];
    [content appendString:temp];
    
    
    
    if([pPlanCode isEqualToString:@"HLAWP"])
    {
        //SI_Temp_Trad_Riderillus start
        [self buildSITempTradRiderillus:database withContent:&content];
        //SI_Temp_Trad_Riderillus end
        
        //SI_Temp_Trad_Summary start
        [self buildSITempTradSummary:database withContent:&content];
        //SI_Temp_Trad_Summary end
    }
    

    
    //SI_Temp_Pages_PDS start
    totalRecords = [self buildSITempPagesPDS:database withContent:&content];
    //SI_Temp_Pages_PDS end
    
    //SI Main components for PDS start
    if(isPDS) //added to correctly show total pages for PDS
    {
        [content appendFormat:@"\"agentCode\":\"%@\",\n", agentCode];
        [content appendFormat:@"\"agentName\":\"%@\",\n", agentName];
        [content appendFormat:@"\"SINo\":\"%@\",\n", _SINo];
        [content appendFormat:@"\"PlanCode\":\"%@\",\n", PlanCode];
        [content appendFormat:@"\"PlanName\":\"%@\",\n", pPlanName];
        [content appendFormat:@"\"DateModified\":\"%@\",\n", UpdatedAt];
        [content appendFormat:@"\"HL1KSA\":\"%d\",\n", HL1KSA];
        [content appendFormat:@"\"TempHL1KSA\":\"%f\",\n", TempHL1KSA];
        [content appendFormat:@"\"TotalPages\":\"%d\",\n", totalRecords]; //changed from totalPages to totalRecords
        [content appendFormat:@"\"QuotationLang\":\"%@\",\n", lang];
        [content appendFormat:@"\"OCCPClass\":\"%@\",\n", OccpClass];
    }
    //SI Main components for PDS start
    
    [self buildSIStorePremium:database withContent:&content];
    //SI_Store_Premium end
    
    [content appendString:@"}\n"];
    [content appendString:@"]\n"];
    [content appendString:@"}"];
    [content writeToFile:jsonFile
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    
    [database close];
    database = nil;
    content = nil;
    
}

- (void)buildSITempBenefit:(FMDatabase *)database withContent:(NSMutableString **)content
{
    int totalRecords;
    int currentRecord;
    NSString *query;
    FMResultSet *results;
    totalRecords = 0;
    currentRecord = 0;
    
    query = [NSString stringWithFormat:@"Select count(*) as cnt from SI_Temp_Benefit"];
    results = [database executeQuery:query];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"Select * from SI_Temp_Benefit"];
    results = [database executeQuery:query];
    if (results != Nil){
        [*content appendString:@"\"SI_Temp_Benefit\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\",\n", [results stringForColumn:@"col12"]];
        [*content appendFormat:@"\"col13\":\"%@\",\n", [results stringForColumn:@"col13"]];
        [*content appendFormat:@"\"col14\":\"%@\",\n", [results stringForColumn:@"col14"]];
        [*content appendFormat:@"\"col15\":\"%@\",\n", [results stringForColumn:@"col15"]];
        [*content appendFormat:@"\"col16\":\"%@\"\n", [results stringForColumn:@"col16"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

- (void)buildSITempTradLA:(NSString *)_SINo database:(FMDatabase *)database withContent:(NSMutableString **)content
{
    int totalRecords;
    int currentRecord;
    NSString *query;
    FMResultSet *results;
    totalRecords = 0;
    currentRecord = 0;
    
    query = [NSString stringWithFormat:@"Select count(*) as cnt from SI_Temp_Trad_LA where SINo ='%@'",_SINo];
    results = [database executeQuery:query];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"Select LADesc,LADescM,Name,Age,Sex,Smoker,PTypeCode from SI_Temp_trad_LA where SINo ='%@'",_SINo];
    results = [database executeQuery:query];
    if (results != Nil){
        [*content appendString:@"\"SI_Temp_trad_LA\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"LADesc\":\"%@\",\n", [results stringForColumn:@"LADesc"]];
        [*content appendFormat:@"\"LADescM\":\"%@\",\n", [results stringForColumn:@"LADescM"]];
        [*content appendFormat:@"\"Name\":\"%@\",\n", [results stringForColumn:@"Name"]];
        [*content appendFormat:@"\"Age\":\"%@\",\n", [results stringForColumn:@"Age"]];
        [*content appendFormat:@"\"Sex\":\"%@\",\n", [results stringForColumn:@"Sex"]];
        [*content appendFormat:@"\"Smoker\":\"%@\",\n", [results stringForColumn:@"Smoker"]];
        [*content appendFormat:@"\"OccpDesc\":\"%@\",\n", OccpDesc];
        [*content appendFormat:@"\"MOP\":\"%d\",\n", premiumPaymentOption];
        [*content appendFormat:@"\"PTypeCode\":\"%@\"\n", [results stringForColumn:@"PTypeCode"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

-(NSString*)buildTempSITradDetailsUsing:(FMDatabase *)database {
    
    int currentRecord = 0;
    
    FMResultSet *results;
    NSString *query;
    NSMutableString *content = [[NSMutableString alloc] initWithString:@""];
    
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Details ORDER BY SeqNo"];
    results = [database executeQuery:query];
    
    if (results != Nil){
        [content appendString:@"\"SI_Temp_Trad_Details\":{\n"];
        [content appendString:@"\"data\":[\n"];
    }
    
    while([results next]) {
        if (currentRecord > 0) {
            [content appendString:@",\n"];
        }
        currentRecord++;
        [content appendString:@"{\n"];
        [content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        
        [content appendFormat:@"\"RiderCode\":\"%@\",\n", [results stringForColumn:@"RiderCode"]];
        
        [content appendFormat:@"\"col0_2\":\"%@\",\n", [RiderViewController getRiderDecFromValue:[results stringForColumn:@"col0_2"]]]; //uses this, since C+ & HSP_II changed to short denomination @ Edwin 27-03-2014
        [content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [content appendFormat:@"\"col11\":\"%@\"\n", [results stringForColumn:@"col11"]];        
        [content appendString:@"}"];
        
    }
    [content appendString:@"\n]\n"];
    [content appendString:@"},\n"];
    return content;
}

-(NSString*)buildTempSITradBasicUsing:(FMDatabase *)database {
    int totalRecords = 0;
    int currentRecord = 0;
    FMResultSet *results = [database executeQuery:@"select count(*) as cnt from SI_Temp_Trad_Basic where DataType = 'DATA'"];
    NSString *query;
    NSMutableString *content = [[NSMutableString alloc] initWithString: @""];
    
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT col0_1,col0_2,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,col22,col23 FROM SI_Temp_Trad_Basic where DataType = 'DATA'"];
    results = [database executeQuery:query];
    if (results != Nil){
        [content appendString:@"\"SI_Temp_Trad_Basic\":{\n"];
        [content appendString:@"\"data\":[\n"];
    }
    
    while([results next]) {
        currentRecord++;
        [content appendString:[self buildSITradDetailsElementString:results]];
        if (currentRecord == totalRecords){ //last record
            [content appendString:@"}\n"];
        }
        else{
            [content appendString:@"},\n"];
        }
    }
    
    [content appendString:@"]\n"];
    [content appendString:@"},\n"];
    
    return content;
}

-(NSString*)buildSITradDetailsElementString:(FMResultSet*)results {
    NSMutableString *content = [[NSMutableString alloc] initWithString:@""];
    [content appendString:@"{\n"];
    [content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
    [content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
    [content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
    [content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
    
    double val = [[results stringForColumn:@"col3"] doubleValue];
    [content appendFormat:@"\"col3\":\"%d\",\n", [self roundingDouble:val]];
    
    [content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
    [content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
    [content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
    [content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
    [content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
    [content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
    [content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
    [content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
    [content appendFormat:@"\"col12\":\"%@\",\n", [results stringForColumn:@"col12"]];
    [content appendFormat:@"\"col13\":\"%@\",\n", [results stringForColumn:@"col13"]];
    [content appendFormat:@"\"col14\":\"%@\",\n", [results stringForColumn:@"col14"]];
    [content appendFormat:@"\"col15\":\"%@\",\n", [results stringForColumn:@"col15"]];
    [content appendFormat:@"\"col16\":\"%@\",\n", [results stringForColumn:@"col16"]];
    [content appendFormat:@"\"col17\":\"%@\",\n", [results stringForColumn:@"col17"]];
    [content appendFormat:@"\"col18\":\"%@\",\n", [results stringForColumn:@"col18"]];
    [content appendFormat:@"\"col19\":\"%@\",\n", [results stringForColumn:@"col19"]];
    [content appendFormat:@"\"col20\":\"%@\",\n", [results stringForColumn:@"col20"]];
    [content appendFormat:@"\"col21\":\"%@\",\n", [results stringForColumn:@"col21"]];
    [content appendFormat:@"\"col22\":\"%@\",\n", [results stringForColumn:@"col22"]];
    [content appendFormat:@"\"col23\":\"%@\"\n", [results stringForColumn:@"col23"]];
    return content;
}

-(NSMutableArray*)reformatDataFromDatabase:(FMDatabase *)database {
    NSMutableArray* newDataArr = [[NSMutableArray alloc] init];
    
    FMResultSet *results;
    NSString *query;
    
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Details ORDER BY SeqNo"];
    results = [database executeQuery:query];
    
    NSMutableDictionary* tempDic;
    NSString* tempStr;
    NSString* key;
    while([results next]) {
        key = @"col0_1";
        tempStr = [results stringForColumn:key];
        if (![tempStr hasPrefix:@"-"]) {
            tempDic = [[NSMutableDictionary alloc] init];
            [tempDic setObject:tempStr forKey:key];
            
            key = @"RiderCode";
            tempStr = [results stringForColumn:key];
            [tempDic setObject:tempStr forKey:key];
            
            key = @"col5";
            tempStr = [results stringForColumn:key];
            [tempDic setObject:tempStr forKey:key];
            key = @"col6";
            tempStr = [results stringForColumn:key];
            [tempDic setObject:tempStr forKey:key];
            key = @"col7";
            tempStr = [results stringForColumn:key];
            [tempDic setObject:tempStr forKey:key];
            key = @"col8";
            tempStr = [results stringForColumn:key];
            [tempDic setObject:tempStr forKey:key];
            
            [newDataArr addObject:tempDic];
        } else {
            if ([tempStr hasPrefix:@"-Annually"]) {
                key = @"col5";
                tempStr = [results stringForColumn:key];
                [tempDic setObject:tempStr forKey:key];
            } else if ([tempStr hasPrefix:@"-Semi-annually"]) {
                key = @"col6";
                tempStr = [results stringForColumn:key];
                [tempDic setObject:tempStr forKey:key];
            } else if ([tempStr hasPrefix:@"-Quarterly"]) {
                key = @"col7";
                tempStr = [results stringForColumn:key];
                [tempDic setObject:tempStr forKey:key];
            } else if ([tempStr hasPrefix:@"-Monthly"]) {
                key = @"col8";
                tempStr = [results stringForColumn:key];
                [tempDic setObject:tempStr forKey:key];
                
            }
        }
    }
    tempDic = nil;
    
    return newDataArr;
}

- (void)buildSITempTrad:(FMDatabase *)database withContent:(NSMutableString **)content
{
    //SI_Temp_Trad start
    int totalRecords;
    int currentRecord;
    FMResultSet *results;
    NSString *query;
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from SI_Temp_Trad"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT TotPremPaid,SurrenderValueHigh,SurrenderValueLow,TotalYearlylncome,SINo,PlanName,PlanCode,LAName,CashPaymentD,MCashPaymentD FROM SI_Temp_Trad"];
    results = [database executeQuery:query];
    if (results != Nil){
        [*content appendString:@"\"SI_Temp_Trad\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"TotPremPaid\":\"%@\",\n", [results stringForColumn:@"TotPremPaid"]];
        [*content appendFormat:@"\"SurrenderValueHigh\":\"%@\",\n", [results stringForColumn:@"SurrenderValueHigh"]];
        [*content appendFormat:@"\"SurrenderValueLow\":\"%@\",\n", [results stringForColumn:@"SurrenderValueLow"]];
        [*content appendFormat:@"\"TotalYearlylncome\":\"%@\",\n", [results stringForColumn:@"TotalYearlylncome"]];
        [*content appendFormat:@"\"SINo\":\"%@\",\n", [results stringForColumn:@"SINo"]];
        [*content appendFormat:@"\"PlanName\":\"%@\",\n", [results stringForColumn:@"PlanName"]];
        [*content appendFormat:@"\"PlanCode\":\"%@\",\n", [results stringForColumn:@"PlanCode"]];
        [*content appendFormat:@"\"LAName\":\"%@\",\n", [results stringForColumn:@"LAName"]];
        [*content appendFormat:@"\"CashPaymentD\":\"%@\",\n", [results stringForColumn:@"CashPaymentD"]];
        [*content appendFormat:@"\"MCashPaymentD\":\"%@\"\n", [results stringForColumn:@"MCashPaymentD"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

- (void)buildSITradOverall:(FMDatabase *)database withContent:(NSMutableString **)content
{
    //SI_Temp_Trad_Overall start
    int totalRecords;
    int currentRecord;
    FMResultSet *results;
    NSString *query;
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from SI_Temp_Trad_Overall"];
    while ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT TotPremPaid1,SurrenderValueHigh1,SurrenderValueLow1,TotYearlyIncome1,TotPremPaid2,SurrenderValueHigh2,SurrenderValueLow2,TotYearlyIncome2 FROM SI_Temp_Trad_Overall"];
    results = [database executeQuery:query];
    [*content appendString:@"\"SI_Temp_Trad_Overall\":{\n"];
    [*content appendString:@"\"data\":[\n"];
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"TotPremPaid1\":\"%@\",\n", [results stringForColumn:@"TotPremPaid1"]];
        [*content appendFormat:@"\"SurrenderValueHigh1\":\"%@\",\n", [results stringForColumn:@"SurrenderValueHigh1"]];
        [*content appendFormat:@"\"SurrenderValueLow1\":\"%@\",\n", [results stringForColumn:@"SurrenderValueLow1"]];
        [*content appendFormat:@"\"TotYearlyIncome1\":\"%@\",\n", [results stringForColumn:@"TotYearlyIncome1"]];
        [*content appendFormat:@"\"TotPremPaid2\":\"%@\",\n", [results stringForColumn:@"TotPremPaid2"]];
        [*content appendFormat:@"\"SurrenderValueHigh2\":\"%@\",\n", [results stringForColumn:@"SurrenderValueHigh2"]];
        [*content appendFormat:@"\"SurrenderValueLow2\":\"%@\",\n", [results stringForColumn:@"SurrenderValueLow2"]];
        [*content appendFormat:@"\"TotYearlyIncome2\":\"%@\"\n", [results stringForColumn:@"TotYearlyIncome2"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

- (void)buildTradDetails:(NSString *)_SINo database:(FMDatabase *)database withContent:(NSMutableString **)content dateFormatter:(NSDateFormatter *)dateFormatter
{
    //Trad_Details start
    FMResultSet *results;
    NSString *query;
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM Trad_Details where SINo ='%@'",_SINo];
    results = [database executeQuery:query];
    if (results != Nil){
        [*content appendString:@"\"Trad_Details\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    while([results next]) {
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"BasicSA\":\"%@\",\n", [results stringForColumn:@"BasicSA"]];
        [*content appendFormat:@"\"AdvanceYearlyIncome\":\"%@\",\n", [results stringForColumn:@"AdvanceYearlyIncome"]];
        [*content appendFormat:@"\"DateModified\":\"%@\",\n", [dateFormatter dateFromString:[results stringForColumn:@"UpdatedAt"]]];
        [*content appendFormat:@"\"CashDividend\":\"%@\",\n", [results stringForColumn:@"CashDividend"]];
        [*content appendFormat:@"\"YearlyIncome\":\"%@\",\n", [results stringForColumn:@"YearlyIncome"]];
        [*content appendFormat:@"\"PartialAcc\":\"%@\",\n", [results stringForColumn:@"PartialAcc"]];
        [*content appendFormat:@"\"PolicyTerm\":\"%@\",\n", [results stringForColumn:@"PolicyTerm"]];
        if([pPlanCode isEqualToString:@"HLAWP"])
        {
            [*content appendFormat:@"\"PolicyPercentage\":\"%@\",\n", [self getPolicyPercentage:[results stringForColumn:@"PolicyTerm"]]];
            [*content appendFormat:@"\"PremiumPaymentOption\":\"%@\",\n", [results stringForColumn:@"PremiumPaymentOption"]];
            [*content appendFormat:@"\"PremiumPayableUntill\":\"%@\",\n", [self getPremiumPayableUntillAge:[results intForColumn:@"PremiumPaymentOption"]]];
            [*content appendFormat:@"\"GIRR\":\"%@\",\n", [results stringForColumn:@"GIRR"]];
            
        }
        [*content appendFormat:@"\"PartialPayout\":\"%@\"\n", [results stringForColumn:@"PartialPayout"]];
    }
    [*content appendString:@"}\n"];
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

- (void)buildSITempTradRider:(FMDatabase *)database withContent:(NSMutableString **)content
{
    //SI_Temp_Trad_Rider start
    
    int totalRecords;
    int currentRecord;
    FMResultSet *results;
    NSString *query;
    [*content appendString:@"\"SI_Temp_Trad_Rider\":{\n"];
    //page1 start
    [*content appendString:@"\"p1\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Rider where PageNo = '1' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Rider where PageNo = '1' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
    [*content appendString:@"],\n"];
    //page1 end
    
    //page2 start
    [*content appendString:@"\"p2\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Rider where PageNo = '2' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Rider where PageNo = '2' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
    [*content appendString:@"],\n"];
    //page2 end
    
    //page3 start
    [*content appendString:@"\"p3\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Rider where PageNo = '3' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Rider where PageNo = '3' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
    [*content appendString:@"],\n"];
    //page3 end
    
    //page4 start
    [*content appendString:@"\"p4\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Rider where PageNo = '4' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Rider where PageNo = '4' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
    [*content appendString:@"],\n"];
    //page4 end
    
    //page5 start
    [*content appendString:@"\"p5\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Rider where PageNo = '5' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Rider where PageNo = '5' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
    [*content appendString:@"],\n"];
    //page5 end
    
    //page6 start
    [*content appendString:@"\"p6\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Rider where PageNo = '6' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Rider where PageNo = '6' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
    [*content appendString:@"],\n"];
    //page6 end
    
    //page7 start
    [*content appendString:@"\"p7\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Rider where PageNo = '7' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Rider where PageNo = '7' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
    [*content appendString:@"],\n"];
    //page7 end
    
    //page8 start
    [*content appendString:@"\"p8\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Rider where PageNo = '8' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Rider where PageNo = '8' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
    [*content appendString:@"]\n"];
    //page8 end
    
    [*content appendString:@"},\n"];
}

- (void)buildSITempTradRiderillus:(FMDatabase *)database withContent:(NSMutableString **)content
{
    NSString *query;
    FMResultSet *results;
    int totalRecords = 0;
    int currentRecord = 0;
    int pageNo;
    int pageCnt = -1;
    NSMutableArray *pagesArr =  [[NSMutableArray alloc]init];
    
    [*content appendString:@"\"SI_Temp_Trad_Riderillus\":{\n"];
    //page1 start
    [*content appendString:@"\"riders\":[\n"];//rider array
    
    totalRecords = 0;
    currentRecord = 0;
    
    query = [NSString stringWithFormat:@"select count(distinct pageNo) as cnt from si_temp_trad_riderillus order by pageNo asc"];
    results = [database executeQuery:query];
    if ([results next]) {
        pageCnt = [results intForColumn:@"cnt"];
    }
    
    query = [NSString stringWithFormat:@"select distinct pageNo as pageNo from si_temp_trad_riderillus order by pageNo asc"];
    results = [database executeQuery:query];
    
    int resultCnt = 0;
    
    while([results next])
    {
        [pagesArr addObject:[results stringForColumn:@"pageNo"] ];
    }
    
    for (int i=0; i<pagesArr.count; i++) {
        
        pageNo = [[pagesArr objectAtIndex:i] intValue];
        resultCnt++;
        
        results = [database executeQuery:[NSString stringWithFormat:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Riderillus where PageNo = '%d' order by CAST(SeqNo AS INT) asc", i]];
        if ([results next]) {
            totalRecords = [results intForColumn:@"cnt"];
        }
        results = Nil;
        
        
        [*content appendString:@"{\n"]; //rider bracket
        [*content appendFormat:@"\"pageNo\":\"%d\"\n , \n", pageNo];
        [*content appendString:@"\"data\":[\n"]; //data array
        
        query = [NSString stringWithFormat:@"SELECT B.RiderDesc, A.* FROM SI_Temp_Trad_Riderillus A Left outer join Trad_Sys_Rider_Profile B on A.DataType=B.RiderCode where A.PageNo = '%d' order by CAST(A.SeqNo AS INT) asc",pageNo];
        results = [database executeQuery:query];
        currentRecord = 0;
        while([results next]) {
            currentRecord++;
            [*content appendString:@"{\n"];
            [*content appendFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
            [*content appendFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
            [*content appendFormat:@"\"RiderDesc\":\"%@\",\n", [results stringForColumn:@"RiderDesc"]];
            [*content appendFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
            [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
            [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
            [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
            [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
            [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
            [*content appendFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
            [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
            [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
            [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
            [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
            [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
            [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
            [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
            [*content appendFormat:@"\"col12\":\"%@\",\n", [results stringForColumn:@"col12"]];
            [*content appendFormat:@"\"col13\":\"%@\",\n", [results stringForColumn:@"col13"]];
            [*content appendFormat:@"\"col14\":\"%@\",\n", [results stringForColumn:@"col14"]];
            [*content appendFormat:@"\"col15\":\"%@\",\n", [results stringForColumn:@"col15"]];
            [*content appendFormat:@"\"col16\":\"%@\",\n", [results stringForColumn:@"col16"]];
            [*content appendFormat:@"\"col17\":\"%@\",\n", [results stringForColumn:@"col17"]];
            [*content appendFormat:@"\"col18\":\"%@\",\n", [results stringForColumn:@"col18"]];
            [*content appendFormat:@"\"col19\":\"%@\",\n", [results stringForColumn:@"col19"]];
            [*content appendFormat:@"\"col20\":\"%@\",\n", [results stringForColumn:@"col20"]];
            [*content appendFormat:@"\"col21\":\"%@\"\n", [results stringForColumn:@"col21"]];
            
            if (currentRecord == totalRecords){ //last record
                [*content appendString:@"}\n"];
            }
            else{
                [*content appendString:@"},\n"];
            }
        }
        [*content appendString:@"]\n"]; //data array
        
        if(resultCnt==pageCnt)
        {
            [*content appendString:@"}\n"]; //rider bracket
        }else
        {
            [*content appendString:@"},\n"]; //rider bracket
        }
        
    }
    
    [*content appendString:@"]\n"]; //rider array
    //page1 end
    
    [*content appendString:@"},\n"];
}

- (void)buildSITempTradSummary:(FMDatabase *)database withContent:(NSMutableString **)content
{
    //SI_Temp_Trad_Summary start
    FMResultSet *results;
    NSString *query;
    int totalRecords = 0;
    int currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from SI_Temp_Trad_Summary "];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT col0_1,col0_2,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21 FROM SI_Temp_Trad_Summary "];
    results = [database executeQuery:query];
    if (results != Nil){
        [*content appendString:@"\"SI_Temp_Trad_Summary\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        [*content appendFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        [*content appendFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        [*content appendFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        [*content appendFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        [*content appendFormat:@"\"col4\":\"%f\",\n", [results doubleForColumn:@"col4"]];
        [*content appendFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        [*content appendFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        [*content appendFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        [*content appendFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        [*content appendFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        [*content appendFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        [*content appendFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        [*content appendFormat:@"\"col12\":\"%@\",\n", [results stringForColumn:@"col12"]];
        [*content appendFormat:@"\"col13\":\"%@\",\n", [results stringForColumn:@"col13"]];
        [*content appendFormat:@"\"col14\":\"%@\",\n", [results stringForColumn:@"col14"]];
        [*content appendFormat:@"\"col15\":\"%@\",\n", [results stringForColumn:@"col15"]];
        [*content appendFormat:@"\"col16\":\"%@\",\n", [results stringForColumn:@"col16"]];
        [*content appendFormat:@"\"col17\":\"%@\",\n", [results stringForColumn:@"col17"]];
        [*content appendFormat:@"\"col18\":\"%@\",\n", [results stringForColumn:@"col18"]];
        [*content appendFormat:@"\"col19\":\"%@\",\n", [results stringForColumn:@"col19"]];
        [*content appendFormat:@"\"col20\":\"%@\",\n", [results stringForColumn:@"col20"]];
        [*content appendFormat:@"\"col21\":\"%@\"\n", [results stringForColumn:@"col21"]];
        
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

- (void)buildSIUnderwritingPages:(FMDatabase*)database withContent:(NSMutableString **)content
{
    NSString *amountOfPages = nil;
    int count = 1;
    int upperLimit1 = 12;
    int upperLimit2 = 20;
    if(need2PagesUnderwriting)
    {
        NSString *query = [NSString stringWithFormat:@"SELECT COUNT(RiderCode) cnt FROM Trad_Rider_Details WHERE SINO ='%@' AND PTypeCode='LA' AND Seq='1'", SINo];
        FMResultSet *results = [database executeQuery:query];
        if ([results next]) {
            count = [results  intForColumn:@"cnt"];
        }
        if (count > upperLimit2) {
            amountOfPages = @"3";
        } else if (count > upperLimit1) {
            amountOfPages = @"2";
        }
    } else {
        amountOfPages = @"1";
    }
    
    NSString *ulang;
    if([lang isEqualToString:@"Malay"]) {
        ulang = @"mly";
    } else {
        ulang = @"eng";
    }
    
    [*content appendString:@"\"SI_Underwriting_Pages\":{\n"];
    [*content appendFormat:@"\"amountOfPages\":\"%@\",\n", amountOfPages];
    [*content appendString:@"\"data\":[\n"];
    [*content appendString:@"{\n"];
    [*content appendFormat:@"\"PageDesc\":\"%@\",\n", @"Trad_Page1"];
    [*content appendFormat:@"\"htmlName\":\"Trad_%@_Page1.html\"\n", ulang];
    [*content appendString:@"}\n"];
    
    if(need2PagesUnderwriting)
    {
        if (count > upperLimit2) {
            [*content appendString:@",{\n"];
            [*content appendFormat:@"\"PageDesc\":\"%@\",\n", @"Trad_Page2"];
            [*content appendFormat:@"\"htmlName\":\"Trad_%@_Page2.html\"\n", ulang];
            [*content appendString:@"}\n"];
            [*content appendString:@",{\n"];
            [*content appendFormat:@"\"PageDesc\":\"%@\",\n", @"Trad_Page3"];
            [*content appendFormat:@"\"htmlName\":\"Trad_%@_Page3.html\"\n", ulang];
            [*content appendString:@"}\n"];
        } else if (count > upperLimit1) {
            [*content appendString:@",{\n"];
            [*content appendFormat:@"\"PageDesc\":\"%@\",\n", @"Trad_Page2"];
            [*content appendFormat:@"\"htmlName\":\"Trad_%@_Page2.html\"\n", ulang];
            [*content appendString:@"}\n"];
        }
    }
        
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

- (void)buildTradRiderDetails:(NSString *)_SINo database:(FMDatabase *)database withContent:(NSMutableString **)content
{
    //Trad_Rider_Details start
    
    int totalRecords;
    int currentRecord;
    NSString *query;
    FMResultSet *results;
    totalRecords = 0;
    currentRecord = 0;
    query = [NSString stringWithFormat:@"Select count(*) as cnt from Trad_Rider_Details where SINo ='%@'",_SINo];
    results = [database executeQuery:query];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"Select * from Trad_Rider_Details where SINo ='%@' ORDER BY Seq ASC, PTypeCode ASC, RiderCode ASC" ,_SINo];
    results = [database executeQuery:query];
    if (results != Nil){
        [*content appendString:@"\"Trad_Rider_Details\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"RiderCode\":\"%@\",\n", [results stringForColumn:@"RiderCode"]];
        [*content appendFormat:@"\"PTypeCode\":\"%@\",\n", [results stringForColumn:@"PTypeCode"]];
        [*content appendFormat:@"\"Seq\":\"%@\",\n", [results stringForColumn:@"Seq"]];
        [*content appendFormat:@"\"RiderTerm\":\"%@\",\n", [results stringForColumn:@"RiderTerm"]];
        [*content appendFormat:@"\"SumAssured\":\"%@\",\n", [results stringForColumn:@"SumAssured"]];
        [*content appendFormat:@"\"PlanOption\":\"%@\",\n", [RiderViewController getRiderDecFromValue:[results stringForColumn:@"PlanOption"]]]; //uses this, since C+ & HSP_II changed to short denomination @ Edwin 27-03-2014
        [*content appendFormat:@"\"Units\":\"%@\",\n", [results stringForColumn:@"Units"]];
        [*content appendFormat:@"\"Deductible\":\"%@\",\n", [results stringForColumn:@"Deductible"]];
        [*content appendFormat:@"\"PayingTerm\":\"%@\",\n", [results stringForColumn:@"PayingTerm"]];
        [*content appendFormat:@"\"HL1KSA\":\"%@\",\n", [results stringForColumn:@"HL1KSA"]];
        [*content appendFormat:@"\"HL1KSATerm\":\"%@\",\n", [results stringForColumn:@"HL1KSATerm"]];
        [*content appendFormat:@"\"HLPercentage\":\"%@\",\n", [results stringForColumn:@"HLPercentage"]];
        [*content appendFormat:@"\"HLPercentageTerm\":\"%@\",\n", [results stringForColumn:@"HLPercentageTerm"]];
        [*content appendFormat:@"\"TempHL1KSA\":\"%@\",\n", [results stringForColumn:@"TempHL1KSA"]];
        [*content appendFormat:@"\"TempHL1KSATerm\":\"%@\"\n", [results stringForColumn:@"TempHL1KSATerm"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

- (int)buildSITempPagesPDS:(FMDatabase *)database withContent:(NSMutableString **)content
{
    //SI_Temp_Pages_PDS start
    
    int currentRecord;
    FMResultSet *results;
    NSString *query;
    int totalRecords;
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from SI_Temp_Pages_PDS"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Pages_PDS ORDER BY PageNum"];
    results = [database executeQuery:query];
    
    if (results != Nil){
        [*content appendString:@"\"SI_Temp_Pages_PDS\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"htmlName\":\"%@\",\n", [results stringForColumn:@"htmlName"]];
        [*content appendFormat:@"\"PageNum\":\"%@\",\n", [results stringForColumn:@"PageNum"]];
        [*content appendFormat:@"\"PageDesc\":\"%@\",\n", [results stringForColumn:@"PageDesc"]];
        [*content appendFormat:@"\"riders\":\"%@\"\n", [results stringForColumn:@"riders"]];
        if (currentRecord == totalRecords){ //last record
            [*content appendString:@"}\n"];
        }
        else{
            [*content appendString:@"},\n"];
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
    return totalRecords;
}

- (void)buildSIStorePremium:(FMDatabase *)database withContent:(NSMutableString **)content
{
    //SI_Store_Premium start
    
    FMResultSet *pTypeResult;
    FMResultSet *results;
    NSString *query;
    
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Store_premium where Type= 'B' AND SIno = '%@' ", SINo];
    
    results = [database executeQuery:query];
    if (results != Nil){
        [*content appendString:@"\"SI_Store_Premium\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    // basic plan
    if([results next]) {
        [*content appendString:@"{\n"];
        [*content appendFormat:@"\"Type\":\"%@\",\n", [results stringForColumn:@"Type"]];
        [*content appendFormat:@"\"Annually\":\"%@\",\n", [results stringForColumn:@"Annually"]];
        [*content appendFormat:@"\"SemiAnnually\":\"%@\",\n", [results stringForColumn:@"SemiAnnually"]];
        [*content appendFormat:@"\"Quarterly\":\"%@\",\n", [results stringForColumn:@"Quarterly"]];
        [*content appendFormat:@"\"Monthly\":\"%@\",\n", [results stringForColumn:@"Monthly"]];
        [*content appendFormat:@"\"PremiumWithoutHLoading\":\"%@\",\n", [results stringForColumn:@"PremiumWithoutHLoading"]];
        [*content appendFormat:@"\"FromAge\":\"%@\",\n", [results stringForColumn:@"FromAge"]];
        [*content appendFormat:@"\"ToAge\":\"%@\"\n", [results stringForColumn:@"ToAge"]];
        [*content appendString:@"}"];
        }
    
    query = [NSString stringWithFormat:@"SELECT PTypeCode, Sequence FROM Trad_LAPayor WHERE SINo='%@' ORDER BY PTypeCode ASC, Sequence ASC", SINo];
    pTypeResult = [database executeQuery:query];
    
    while([pTypeResult next]) {
        query = [NSString stringWithFormat:@"SELECT a.* FROM SI_Store_premium a LEFT JOIN Trad_Sys_RiderComb b ON a.Type=b.RiderCode WHERE a.Type != 'BOriginal' "
                 "AND a.SIno = '%@' "
                 "AND b.PlanCode='%@' "
                 "AND b.PTypeCode='%@' "
                 "AND Seq='%@' "
                 "ORDER BY b.Seq ASC, b.RiderCode ASC ",
                 SINo, pPlanCode, [pTypeResult stringForColumn:@"PTypeCode"], [pTypeResult stringForColumn:@"Sequence"]];
        results = [database executeQuery:query];
        
        // riders
        while([results next]) {
            [*content appendString:@",\n"];
            [*content appendString:@"{\n"];
            [*content appendFormat:@"\"Type\":\"%@\",\n", [results stringForColumn:@"Type"]];
            [*content appendFormat:@"\"Annually\":\"%@\",\n", [results stringForColumn:@"Annually"]];
            [*content appendFormat:@"\"SemiAnnually\":\"%@\",\n", [results stringForColumn:@"SemiAnnually"]];
            [*content appendFormat:@"\"Quarterly\":\"%@\",\n", [results stringForColumn:@"Quarterly"]];
            [*content appendFormat:@"\"Monthly\":\"%@\",\n", [results stringForColumn:@"Monthly"]];
            [*content appendFormat:@"\"FromAge\":\"%@\",\n", [results stringForColumn:@"FromAge"]];
            [*content appendFormat:@"\"ToAge\":\"%@\"\n", [results stringForColumn:@"ToAge"]];
            [*content appendString:@"}"];
        }
    }
    [*content appendString:@"\n"];
    [*content appendString:@"]\n"];
    [*content appendString:@"}\n"];
}

- (void)buildSITempPages:(FMDatabase *)database withContent:(NSMutableString **)content
{
    //SI_Temp_Pages start
    
    int totalRecords;
    int currentRecord;
    FMResultSet *results;
    NSString *query;
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from SI_Temp_Pages"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Pages ORDER BY PageNum"];
    results = [database executeQuery:query];
    
    if (results != Nil){
        [*content appendString:@"\"SI_Temp_Pages\":{\n"];
        [*content appendString:@"\"data\":[\n"];
    }
    
    NSArray *malayDesc = @[@"Page50.html", @"Page36.html", @"Page36_2.html", @"Page60.html", @"Page61.html", @"Page62.html"]; //newly added for language switcher
    NSArray *engDesc = @[@"Page30.html", @"Page35.html", @"Page35_2.html", @"Page40.html", @"Page41.html", @"Page42.html" ]; //newly added for language switcher
    NSArray *pages;
    
    if([pPlanCode isEqualToString:@"HLACP"]) {
        pages = @[@"Page1.html", @"Page2.html", @"Page3.html", @"Page20.html", @"Page21.html", @"Page22.html", @"Page23.html", @"Page24.html", @"Page25.html", @"Page26.html", @"Page27.html"]; //newly added for language switcher
    } else if([pPlanCode isEqualToString:@"HLAWP"]) {
        pages = @[@"HLAWP_Page1.html", @"HLAWP_Page1_2.html", @"HLAWP_Page2.html", @"HLAWP_Page3.html", @"HLAWP_PageWPRiders_1_WBI6R30.html", @"HLAWP_PageWPRiders_2_WBI6R30.html", @"HLAWP_PageWPRiders_1_WB30R.html", @"HLAWP_PageWPRiders_2_WB30R.html", @"HLAWP_PageWPRiders_1_WB50R.html", @"HLAWP_PageWPRiders_2_WB50R.html", @"HLAWP_PageWPRiders_1_WBD10R30.html", @"HLAWP_PageWPRiders_2_WBD10R30.html", @"HLAWP_PageWPRiders_1_EDUWR.html", @"HLAWP_PageWPRiders_2_EDUWR.html",  @"HLAWP_Page20.html", @"HLAWP_Page21.html", @"HLAWP_Page22.html", @"HLAWP_Page23.html", @"HLAWP_Page24.html", @"HLAWP_Page25.html", @"HLAWP_Page26.html", @"HLAWP_Page27.html", @"HLAWP_Page_Benefit1.html", @"HLAWP_Page_Benefit2.html", @"HLAWP_Page_Benefit3.html", @"HLAWP_Summary_Page1.html", @"HLAWP_Summary_Page2.html", @"HLAWP_Summary_Page3.html"];
        
    } else if([pPlanCode isEqualToString:@"L100"]) {
        pages = @[@"L100_Page1.html",@"L100_Page1_2.html", @"L100_Page2.html",@"L100_Page2_2.html", @"L100_Page3.html", @"Page20.html", @"Page21.html", @"Page22.html", @"Page23.html", @"Page24.html", @"Page25.html", @"Page26.html", @"Page27.html"];
    } else if ([pPlanCode isEqualToString:@"S100"]) {
        
        pages = @[@"S100_Page1.html",@"S100_Page1_2.html", @"S100_Page2.html",@"S100_Page2_2.html", @"S100_Page3.html", @"Page20.html", @"Page21.html", @"Page22.html", @"Page23.html", @"Page24.html", @"Page25.html", @"Page26.html", @"Page27.html", @"HLAWP_Page_Benefit1.html", @"HLAWP_Page_Benefit2.html", @"HLAWP_Page_Benefit3.html", ];
    }
    
    NSString *htmlName;
    while([results next]) {
        htmlName = [results stringForColumn:@"htmlName"];
        
        if([lang isEqualToString:@"Malay"]) {
            if( [engDesc containsObject:htmlName] ) {
                totalRecords--;
                continue;
            } else {
                currentRecord++;
                
                if( [htmlName isEqualToString:@"Page62.html"] && ([pPlanCode isEqualToString:@"HLACP"] || [pPlanCode isEqualToString:@"HLAWP"] || [pPlanCode isEqualToString:@"L100"]  || [pPlanCode isEqualToString:@"S100"]) ) {
                    //skip this for 1.7 requirements
                    totalRecords--;
                } else {
                    if( currentRecord == 1 ) {
                        [*content appendString:@"{\n"];
                    } else {
                        [*content appendString:@",{\n"];
                    }
                    
                    if( [pages containsObject:[results stringForColumn:@"htmlName"]] ) {
                        htmlName = [NSString stringWithFormat:@"%@%@", @"mly_", [results stringForColumn:@"htmlName"] ];
                    } else {
                        htmlName = [results stringForColumn:@"htmlName"];
                    }
                    
                    [*content appendFormat:@"\"htmlName\":\"%@\",\n", htmlName];
                    [*content appendFormat:@"\"PageNum\":\"%@\",\n", [NSString stringWithFormat:@"%d",currentRecord]]; // get from the currentRecord instead of [results stringForColumn:@"PageNum"] @Edwin 6-9-2013
                    [*content appendFormat:@"\"PageDesc\":\"%@\",\n", [results stringForColumn:@"PageDesc"]];
                    [*content appendFormat:@"\"riders\":\"%@\"\n", [results stringForColumn:@"riders"]];
                    [*content appendString:@"}\n"];
                }
            }
            
        } else {
            //english
            if( [malayDesc containsObject:htmlName] ) {
                totalRecords--;
                continue;
            } else {
                currentRecord++;
                
                if( [htmlName isEqualToString:@"Page42.html"] && ([pPlanCode isEqualToString:@"HLACP"] || [pPlanCode isEqualToString:@"HLAWP"] || [pPlanCode isEqualToString:@"L100"]  || [pPlanCode isEqualToString:@"S100"]) ) {
                    //skip this for 1.7 requirements
                    totalRecords--;
                } else {
                    if( currentRecord == 1 ) {
                        [*content appendString:@"{\n"];
                    } else {
                        [*content appendString:@",{\n"];
                    }
                    
                    if( [pages containsObject:[results stringForColumn:@"htmlName"]] )
                    {
                        htmlName = [NSString stringWithFormat:@"%@%@", @"eng_", [results stringForColumn:@"htmlName"] ];
                    }else
                    {
                        htmlName = [results stringForColumn:@"htmlName"];
                    }
                    
                    [*content appendFormat:@"\"htmlName\":\"%@\",\n", htmlName];
                    [*content appendFormat:@"\"PageNum\":\"%@\",\n", [NSString stringWithFormat:@"%d",currentRecord]]; // get from the currentRecord instead of [results stringForColumn:@"PageNum"] @Edwin 6-9-2013
                    [*content appendFormat:@"\"PageDesc\":\"%@\",\n", [results stringForColumn:@"PageDesc"]];
                    [*content appendFormat:@"\"riders\":\"%@\"\n", [results stringForColumn:@"riders"]];
                    [*content appendString:@"}\n"];
                }
            }
        }
    }
    [*content appendString:@"]\n"];
    [*content appendString:@"},\n"];
}

-(NSString*)buildTempSITradGSTUsing:(FMDatabase *)database andArray:(NSMutableArray *)array  {
    
    int currentRecord = 0;
    NSMutableString *content = [[NSMutableString alloc] initWithString: @""];
    
    double annual = 0;
    double semi = 0;
    double quarter = 0;
    double month = 0;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formatter setMaximumFractionDigits:4];
    [formatter setMinimumFractionDigits:4];
    
    NSNumberFormatter *formattertwo = [[NSNumberFormatter alloc]init];
    [formattertwo setNumberStyle:NSNumberFormatterDecimalStyle];
    [formattertwo setRoundingMode:NSNumberFormatterRoundHalfUp];
    [formattertwo setMaximumFractionDigits:2];
    [formattertwo setMinimumFractionDigits:2];
    
    NSString *tempStr;
    double tempNum;
    double gstAnn = 0;
    double gstSemi = 0;
    double gstQtr = 0;
    double gstMon = 0;
    BOOL isGST = true;
    NSString *rider;
    NSDictionary *tempDict;
    double temp;
    for(currentRecord=0; currentRecord<array.count; currentRecord++) {
        tempDict = [array objectAtIndex:currentRecord];
        if (currentRecord > 0) {
            [content appendString:@",\n"];
        }
        
        rider = [tempDict objectForKey:@"RiderCode"];
        isGST = [self getRiderGSTFromDb:database withRiderCode:rider];
        [content appendString:[self buildGSTElementStringUsingDictionary:tempDict usingFormatter:formatter withGST:isGST]];
        
        tempStr = [tempDict objectForKey:@"col5"];
        tempNum = [[formatter numberFromString:tempStr] doubleValue];
        annual += tempNum;
        
        if (isGST) {
            temp = [[formatter stringFromNumber:@(tempNum * gstValue)] doubleValue];
            gstAnn += [[formattertwo stringFromNumber:@(temp)] doubleValue];
            //            NSLog(@"GST: %@  tempStr:%@   tempA:%f     %f    ", rider, tempStr, temp, [[formatter stringFromNumber:@(tempNum * gstValue)] doubleValue]);
        }
        
        tempStr = [tempDict objectForKey:@"col6"];
        tempNum = [[formatter numberFromString:tempStr] doubleValue];
        semi += tempNum;
        if (isGST) {
            temp = [[formatter stringFromNumber:@(tempNum * gstValue)] doubleValue];
            gstSemi += [[formattertwo stringFromNumber:@(temp)] doubleValue];;
        }
        
        tempStr = [tempDict objectForKey:@"col7"];
        tempNum = [[formatter numberFromString:tempStr] doubleValue];
        quarter += tempNum;
        if (isGST) {
            temp = [[formatter stringFromNumber:@(tempNum * gstValue)] doubleValue];
            gstQtr += [[formattertwo stringFromNumber:@(temp)] doubleValue];;
        }
        
        tempStr = [tempDict objectForKey:@"col8"];
        tempNum = [[formatter numberFromString:tempStr] doubleValue];
        month += tempNum;
        if (isGST) {
            temp = [[formatter stringFromNumber:@(tempNum * gstValue)] doubleValue];
            gstMon += [[formattertwo stringFromNumber:@(temp)] doubleValue];;
        }
        
        tempDict = nil;
    }
    
    NSMutableString *contentFinal = [[NSMutableString alloc] initWithString: @""];
    if (currentRecord > 0) {
        [contentFinal appendString:@"\"SI_Temp_Trad_GST\":{\n"];
        [contentFinal appendString:@"\"data\":[\n"];
        [contentFinal appendString:content];
        [contentFinal appendString:@"\n]\n"];
        [contentFinal appendString:@"},\n"];
        
        // open
        [contentFinal appendString:@"\"SI_Temp_Trad_GST_Total\":{\n"];
        [contentFinal appendString:@"\"data\":[\n"];
        [contentFinal appendString:@"{\n"];
        
        [contentFinal appendString:[self buildGSTTempSITradGSTTotalElementUsingFormatter:formatter withKey:@"Annual" withInitValue:annual withGSTValue:gstAnn withTotalValue:(annual + gstAnn)]];
        [contentFinal appendString:@",\n"];
        
        [contentFinal appendString:[self buildGSTTempSITradGSTTotalElementUsingFormatter:formatter withKey:@"Semi" withInitValue:semi withGSTValue:gstSemi withTotalValue:(semi + gstSemi)]];
        [contentFinal appendString:@",\n"];
        
        [contentFinal appendString:[self buildGSTTempSITradGSTTotalElementUsingFormatter:formatter withKey:@"Quarter" withInitValue:quarter withGSTValue:gstQtr withTotalValue:(quarter + gstQtr)]];
        [contentFinal appendString:@",\n"];
        
        [contentFinal appendString:[self buildGSTTempSITradGSTTotalElementUsingFormatter:formatter withKey:@"Month" withInitValue:month withGSTValue:gstMon withTotalValue:(month + gstMon)]];
        // close
        [contentFinal appendString:@"}\n"];
        [contentFinal appendString:@"]\n"];
        [contentFinal appendString:@"},\n"];
    }
    
    return contentFinal;
    
}

// Unused at the moment
-(NSString*)buildTempSITradGSTUsing:(FMDatabase *)database {
    int currentRecord = 0;
    NSMutableString *content = [[NSMutableString alloc] initWithString: @""];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM SI_Temp_Trad_Details ORDER BY SeqNo"];
    
    FMResultSet *results = [database executeQuery:query];
    
    double annual = 0;
    double semi = 0;
    double quarter = 0;
    double month = 0;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:4];
    [formatter setMinimumFractionDigits:4];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    NSString *tempStr;
    double tempNum;
    double gstAnn = 0;
    double gstSemi = 0;
    double gstQtr = 0;
    double gstMon = 0;
    BOOL isGST = true;
    NSString *rider;
    while ([results next]) {
        if (currentRecord > 0) {
            [content appendString:@",\n"];
        }
        currentRecord++;
        
        rider = [results stringForColumn:@"RiderCode"];
        isGST = [self getRiderGSTFromDb:database withRiderCode:rider];
        [content appendString:[self buildGSTElementString:results usingFormatter:formatter withGST:isGST]];
        
        tempStr = [results stringForColumn:@"col5"];
        tempNum = [[formatter numberFromString:tempStr] doubleValue];
        annual += tempNum;
        if (isGST) {
            gstAnn += tempNum;
        }
        
        tempStr = [results stringForColumn:@"col6"];
        tempNum = [[formatter numberFromString:tempStr] doubleValue];
        semi += tempNum;
        if (isGST) {
            gstSemi += tempNum;
        }
        
        tempStr = [results stringForColumn:@"col7"];
        tempNum = [[formatter numberFromString:tempStr] doubleValue];
        quarter += tempNum;
        if (isGST) {
            gstQtr += tempNum;
        }
        
        tempStr = [results stringForColumn:@"col8"];
        tempNum = [[formatter numberFromString:tempStr] doubleValue];
        month += tempNum;
        if (isGST) {
            gstMon += tempNum;
        }
    }
    
    NSMutableString *contentFinal = [[NSMutableString alloc] initWithString: @""];
    if (currentRecord > 0) {
        [contentFinal appendString:@"\"SI_Temp_Trad_GST\":{\n"];
        [contentFinal appendString:@"\"data\":[\n"];
        [contentFinal appendString:content];
        [contentFinal appendString:@"\n]\n"];
        [contentFinal appendString:@"},\n"];
        
        // open
        [contentFinal appendString:@"\"SI_Temp_Trad_GST_Total\":{\n"];
        [contentFinal appendString:@"\"data\":[\n"];
        [contentFinal appendString:@"{\n"];
        
        //        [contentFinal appendString:[self buildTempSITradGSTTotalUsingFormatter:formatter Annual:annual Semi:semi Quarter:quarter Month:month]];
        double gstTemp = 0;
        gstTemp = [[formatter stringFromNumber:[NSNumber numberWithDouble:gstAnn * gstValue]] doubleValue];
        
        [contentFinal appendString:[self buildGSTTempSITradGSTTotalElementUsingFormatter:formatter withKey:@"Annual" withInitValue:annual withGSTValue:gstTemp withTotalValue:(annual + gstTemp)]];
        [contentFinal appendString:@",\n"];
        
        gstTemp = [[formatter stringFromNumber:[NSNumber numberWithDouble:gstSemi * gstValue]] doubleValue];
        [contentFinal appendString:[self buildGSTTempSITradGSTTotalElementUsingFormatter:formatter withKey:@"Semi" withInitValue:semi withGSTValue:gstTemp withTotalValue:(semi + gstTemp)]];
        [contentFinal appendString:@",\n"];
        
        gstTemp = [[formatter stringFromNumber:[NSNumber numberWithDouble:gstQtr * gstValue]] doubleValue];
        [contentFinal appendString:[self buildGSTTempSITradGSTTotalElementUsingFormatter:formatter withKey:@"Quarter" withInitValue:quarter withGSTValue:gstTemp withTotalValue:(quarter + gstTemp)]];
        [contentFinal appendString:@",\n"];
        
        gstTemp = [[formatter stringFromNumber:[NSNumber numberWithDouble:gstMon * gstValue]] doubleValue];
        [contentFinal appendString:[self buildGSTTempSITradGSTTotalElementUsingFormatter:formatter withKey:@"Month" withInitValue:month withGSTValue:gstTemp withTotalValue:(month + gstTemp)]];
        // close
        [contentFinal appendString:@"}\n"];
        [contentFinal appendString:@"]\n"];
        [contentFinal appendString:@"},\n"];
    }
    
    return contentFinal;
}

-(NSString*)buildGSTTempSITradGSTTotalElementUsingFormatter:(NSNumberFormatter *)formatter withKey:(NSString *)keyStr withInitValue:(double)initVal withGSTValue:(double)igstValue withTotalValue:(double)totalValue {    
    NSMutableString *content = [[NSMutableString alloc] initWithString: @""];
    
    [content appendFormat:@"\"init%@\":\"%@\",\n", keyStr, [formatter stringFromNumber:@(initVal)]];
    [content appendFormat:@"\"gst%@\":\"%@\",\n", keyStr, [formatter stringFromNumber:@(igstValue)]];
    [content appendFormat:@"\"total%@\":\"%@\"", keyStr, [formatter stringFromNumber:@(totalValue)]];
    
    return content;
}

-(NSString*)buildGSTElementStringUsingDictionary:(NSDictionary *)dict usingFormatter:(NSNumberFormatter *)formatter withGST:(BOOL)isGST {
    
    NSMutableString *content = [[NSMutableString alloc] initWithString: @""];
    
    [content appendString:@"{\n"];
    [content appendFormat:@"\"col0_1\":\"%@\",\n", [dict objectForKey:@"col0_1"]];
    
    NSString *cAppend = @"";
    
    // annual
    cAppend = [self appendGSTReadingDBColumn:[dict objectForKey:@"col5"] toPremCol:@"col3" toGSTCol:@"col8" toTotalCol:@"col12" usingFormatter:formatter withGST:isGST];
    [content appendString:cAppend];
    
    // semi
    cAppend = [self appendGSTReadingDBColumn:[dict objectForKey:@"col6"] toPremCol:@"col4" toGSTCol:@"col9" toTotalCol:@"col13" usingFormatter:formatter withGST:isGST];
    [content appendString:cAppend];
    
    // quarterly
    cAppend = [self appendGSTReadingDBColumn:[dict objectForKey:@"col7"] toPremCol:@"col5" toGSTCol:@"col10" toTotalCol:@"col14" usingFormatter:formatter withGST:isGST];
    [content appendString:cAppend];
    
    // monthly
    cAppend = [self appendGSTReadingDBColumn:[dict objectForKey:@"col8"] toPremCol:@"col6" toGSTCol:@"col11" toTotalCol:@"col15" usingFormatter:formatter withGST:isGST];
    [content appendString:cAppend];
    NSString *gstVal = @"0";
    if (isGST) {
        gstVal = @"1";
    }
    [content appendFormat:@"\"col7\":\"%@\"\n", gstVal];    
    [content appendString:@"}"];
    
    return content;
}

// assumes you're reading directly from the database
-(NSString*)buildGSTElementString:(FMResultSet *)results usingFormatter:(NSNumberFormatter *)formatter withGST:(BOOL)isGST {
    
    NSMutableString *content = [[NSMutableString alloc] initWithString: @""];
    
    [content appendString:@"{\n"];
    [content appendFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
    
    NSString *cAppend = @"";
    
    // annual
    cAppend = [self appendGSTReadingDBColumn:[results stringForColumn:@"col5"] toPremCol:@"col3" toGSTCol:@"col8" toTotalCol:@"col12" usingFormatter:formatter withGST:isGST];
    [content appendString:cAppend];
    
    // semi
    cAppend = [self appendGSTReadingDBColumn:[results stringForColumn:@"col6"] toPremCol:@"col4" toGSTCol:@"col9" toTotalCol:@"col13" usingFormatter:formatter withGST:isGST];
    [content appendString:cAppend];
    
    // quarterly
    cAppend = [self appendGSTReadingDBColumn:[results stringForColumn:@"col7"] toPremCol:@"col5" toGSTCol:@"col10" toTotalCol:@"col14" usingFormatter:formatter withGST:isGST];
    [content appendString:cAppend];
    
    // monthly
    cAppend = [self appendGSTReadingDBColumn:[results stringForColumn:@"col8"] toPremCol:@"col6" toGSTCol:@"col11" toTotalCol:@"col15" usingFormatter:formatter withGST:isGST];
    [content appendString:cAppend];
    NSString *gstVal = @"0";
    if (isGST) {
        gstVal = @"1";
    }
    [content appendFormat:@"\"col7\":\"%@\"\n", gstVal];
    
    [content appendString:@"}"];
    
    return content;
}

-(NSString*)appendGSTReadingDBColumn:(NSString *)dbCol toPremCol:(NSString *)col1 toGSTCol:(NSString *)col2 toTotalCol:(NSString *)col3 usingFormatter:(NSNumberFormatter *) formatter withGST:(BOOL)gstVal{
    NSMutableString *content = [[NSMutableString alloc] initWithString: @""];
    double prem = 0;
    double prem_gst= 0;
    double total = 0;
    [content appendFormat:@"\"%@\":\"%@\",\n", col1, dbCol];
    if ([dbCol isEqualToString:@"-"]) {
        [content appendFormat:@"\"%@\":\"-\",\n", col2];
        [content appendFormat:@"\"%@\":\"-\",\n", col3];
        
    } else {
        prem = [[dbCol stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
        if (gstVal) {
            NSNumberFormatter *formattertwo = [[NSNumberFormatter alloc]init];
            [formattertwo setNumberStyle:NSNumberFormatterDecimalStyle];
            [formattertwo setRoundingMode:NSNumberFormatterRoundHalfUp];
            [formattertwo setMaximumFractionDigits:2];
            [formattertwo setMinimumFractionDigits:2];
            prem_gst = [[formatter stringFromNumber:@(prem * gstValue)] doubleValue];
            prem_gst = [[formattertwo stringFromNumber:@(prem_gst)] doubleValue];
        }
        
        [content appendFormat:@"\"%@\":\"%@\",\n", col2, [formatter stringFromNumber:@(prem_gst)]];
        
        total = prem + prem_gst;
        [content appendFormat:@"\"%@\":\"%@\",\n", col3, [formatter stringFromNumber:@(total)]];
    }
    return content;
}

-(BOOL)getRiderGSTFromDb:(FMDatabase*)database withRiderCode:(NSString*)rider {
    int gstVal = 0;
    NSString *query = [NSString stringWithFormat:@"SELECT GST FROM Trad_Sys_Rider_Mtn WHERE RiderCode=\"%@\"", rider];
    FMResultSet *result = [database executeQuery:query];
    
    while([result next]) {
        if ([result boolForColumnIndex:0]) {
            gstVal = 1;
        }
    }
    return gstVal == 1;
}

-(int)getRiderTotalPage:(int)pageNo {
    
    sqlite3_stmt *statement;
    int temp = -1;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        NSString * SelectSQL = [ NSString stringWithFormat:@"SELECT count(*) as cnt FROM SI_Temp_Trad_Riderillus where PageNo = '%d' order by CAST(SeqNo AS INT) asc",pageNo];
        int gg = sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL);
        if( gg == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                temp = sqlite3_column_int(statement, 0);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return temp;
}

-(NSString*) getPolicyPercentage:(NSString*)policyTerm {
    NSString* toRet = nil;
    
    if([policyTerm isEqualToString:@"30"])
    {
        toRet = @"150%";
    }else if([policyTerm isEqualToString:@"50"]) {
        toRet = @"250%";
    }
    
    return toRet;
}

-(NSString*) getPremiumPayableUntillAge:(int)payOption {
    return [NSString stringWithFormat:@"%d", Age+payOption];
}

//removed BM/Eng pages depend on the language choosen
-(void) clearLanguages {
    NSString *malayDesc = @"\"Page50.html\", \"Page36.html\",\"Page36_2.html\", \"Page60.html\", \"Page61.html\", \"Page62.html\", \"Page42.html\""; //page42 is included due to the need to be taken out for 7.1requirements
    NSString *engDesc = @"\"Page30.html\", \"Page35.html\", \"Page35_2.html\", \"Page40.html\", \"Page41.html\", \"Page42.html\", \"Page62.html\""; //same goes for page62
    NSString *pagesToDelete = nil;
    
    if( [lang isEqualToString:@"Malay"] ) {
        pagesToDelete = engDesc;
    }else {
        pagesToDelete = malayDesc;
    }
    
    
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        
        QuerySQL = [NSString stringWithFormat:@"Delete from si_temp_pages where htmlName in (%@)",pagesToDelete];
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    
    statement = Nil;
    QuerySQL = Nil;
    
}

-(void) reArrangePages
{
    NSMutableArray *pagesArr =  [[NSMutableArray alloc]init];
    NSMutableArray *ridersArr =  [[NSMutableArray alloc]init];
    NSString *temp = nil;
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        NSString *QuerySQL = @"Select * from si_temp_pages";
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char * str = (char*)sqlite3_column_text(statement, 3);
                if (str){
                    temp = [NSString stringWithUTF8String:str];
                }
                else{
                    temp = @"";
                }
                
                [pagesArr addObject:[ [NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,0)] ];
                [ridersArr addObject:temp];
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from si_temp_pages";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
            }
            sqlite3_finalize(statement);
        }
        
        NSString *intStr;
        for(int x=0; x<pagesArr.count; x++)
        {
            int y = x+1;
            intStr = [NSString stringWithFormat:@"%d", y];
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
            {
                NSString *querySQL = [NSString stringWithFormat:@"Insert into si_temp_pages ('htmlName','PageNum','PageDesc','riders') values ('%@','%@','Page%@','%@')", [pagesArr objectAtIndex:x], intStr, intStr, [ridersArr objectAtIndex:x]];
                
                //                NSLog(@"%@",querySQL);
                if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement) == SQLITE_DONE)
                    {
                    }
                }
            }
        }
        sqlite3_finalize(statement);
        
        
        sqlite3_close(contactDB);
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)deleteTemp{
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        QuerySQL = @"Delete from SI_Temp_Benefit";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from SI_Temp_Trad_Summary";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        
        QuerySQL = @"Delete from SI_temp_Rider";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from SI_temp_Trad";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from SI_temp_Trad_Basic";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from SI_temp_Trad_details";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete  from SI_temp_Trad_Overall";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from SI_temp_Trad_Rider";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from SI_temp_Trad_Riderillus";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete  from SI_temp_Trad_Summary";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = @"Delete from SI_temp_trad_LA";
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                
                
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    
    statement = Nil;
    QuerySQL = Nil;
    
}

-(NSString *)roundToTwoDecimals:(NSString *)value
{
    double temp = [value doubleValue];
    
    return [NSString stringWithFormat:@"%.2f", temp];
}

-(double)getLSDRate
{
    sqlite3_stmt *statement;
    double LSDRate = 0.00;
    
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
        NSString *querySQL;
        
        if([pPlanCode isEqualToString:@"HLAWP"])
        {
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate FROM Trad_Sys_Basic_LSD WHERE PlanCode=\"%@\" AND FromSA <=\"%f\" AND ToSA >= \"%f\" and PremPayOpt='%d'",pPlanCode, BasicSA, BasicSA , premiumPaymentOption];
            
        } else if([pPlanCode isEqualToString:@"L100"]){
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate FROM Trad_Sys_Basic_LSD WHERE PlanCode=\"%@\" AND FromSA <=\"%f\" AND ToSA >= \"%f\"", pPlanCode, BasicSA,BasicSA];
        } else if ([pPlanCode isEqualToString:@"S100"]) {
            int premPayOpt = 100;
            if (premiumPaymentOption != 100 - Age) {
                premPayOpt = premiumPaymentOption;
            }
            querySQL = [NSString stringWithFormat:
                        @"SELECT Rate, PlanCode FROM Trad_Sys_Basic_LSD WHERE PlanCode=\"%@\" AND FromSA <=\"%f\" AND ToSA >= \"%f\" AND and PremPayOpt=\"%d\"", pPlanCode, BasicSA,BasicSA, premPayOpt];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                LSDRate =  sqlite3_column_double(statement, 0);
                
//            } else {
//                NSLog(@"error access getLSDRate");
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    return LSDRate;
}

-(double)getBasicSIRate
{
    sqlite3_stmt *statement;
    double basicRate= 0.00;
    
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *querySQL;
        NSString *sexStr;
        
        if( [sex isEqualToString:@"FEMALE"] ) {
            sexStr = @"F";
        }else if( [sex isEqualToString:@"MALE"] ) {
            sexStr = @"M";
        } else {
            sexStr = sex;
        }
        
        if([pPlanCode isEqualToString:@"HLACP"]) {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\"",pPlanCode];
            
        } else if([pPlanCode isEqualToString:@"L100"]) {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\" AND Sex=\"%@\" AND FromAge=\"%d\" AND ToAge=\"%d\" ",pPlanCode,sexStr,Age,Age];
            
        } else if([pPlanCode isEqualToString:@"S100"]) {
            int premPayOpt = 100;
            if (premiumPaymentOption != 100 - Age) {
                premPayOpt = premiumPaymentOption;
            }
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\" AND Sex=\"%@\" AND FromAge=\"%d\" AND ToAge=\"%d\" AND premPayOpt=\"%d\" ",pPlanCode,sexStr,Age,Age, premPayOpt];
            
        } else if([pPlanCode isEqualToString:@"HLAWP"]) {
            querySQL = [NSString stringWithFormat: @"SELECT Rate FROM Trad_Sys_Basic_Prem_new WHERE PlanCode=\"%@\" AND FromAge<=\"%d\" AND ToAge>=\"%d\" and FromTerm <=\"%d\" AND ToTerm >= \"%d\" AND PremPayOpt=\"%d\" ", pPlanCode,Age,Age, PolicyTerm,PolicyTerm, premiumPaymentOption];
        }
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                basicRate =  sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    return basicRate;
}

-(void)InsertToSI_Temp_Trad_Details{
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    NSString *RiderSQL;
    NSString *SelectSQL = @"";
    NSString *firstLifeLoading = [OccLoading objectAtIndex:0];
    NSString *secondtLifeLoading = @"";
    double BasicRate= 0.00;
    double LSDRate= 0.00;
    
    NSString *strAnnually = @"";
    NSString *strSemiAnnually = @"";
    NSString *strQuarterly = @"";
    NSString *strMonthly = @"";
    NSString *HL1KSA = @"";
    NSString *TempHL1KSA = @"";
    NSString *strUnits = @"";
    NSString *strTemp = @"";
    NSString *seq = @"";
    NSString *OtherHLoading= @"";
    NSString*OtherTempHLoading= @"";
    
    NSString *RiderDesc = @"";
    NSString *SA = @"";
    
    if ([firstLifeLoading isEqualToString:@"0.0"]) { //<-- for penta
        firstLifeLoading = @"";
    } else {
        firstLifeLoading = [NSString stringWithFormat:@"%d", [firstLifeLoading intValue]];
    }
    
    if (OccLoading.count > 1) {
        secondtLifeLoading = [[OccLoading objectAtIndex:1] isEqualToString:@"0.0"] ? @"" : [OccLoading objectAtIndex:1] ;
    } else {
        secondtLifeLoading = @"";
    }
    
    if (![secondtLifeLoading isEqualToString:@""]) {
        secondtLifeLoading = [NSString stringWithFormat:@"%d", [secondtLifeLoading intValue]];
    }
    
    if ([pPlanCode isEqualToString:@"L100"] || [pPlanCode isEqualToString:@"S100"]) {
        BasicRate = [self getBasicSIRate];
    }
    
    LSDRate = [self getLSDRate];
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        strAnnually = @"";
        strSemiAnnually = @"";
        strQuarterly = @"";
        strMonthly = @"";
        HL1KSA = @"";
        TempHL1KSA = @"";
        
        SelectSQL = [NSString stringWithFormat:@"Select * from SI_Store_Premium where type = \"B\" AND SIno = '%@'", SINo ];
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                
                strAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                strSemiAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                strQuarterly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                strMonthly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                strBasicAnnually = strAnnually;
                strBasicSemiAnnually = strSemiAnnually;
                strBasicQuarterly = strQuarterly;
                strBasicMonthly = strMonthly;
            }
            sqlite3_finalize(statement);
        }
        
        SelectSQL = [NSString stringWithFormat:@"Select * from SI_Store_Premium where type = \"BOriginal\" AND SIno = '%@'", SINo ];
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                strOriBasicAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                strOriBasicSemiAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                strOriBasicQuarterly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                strOriBasicMonthly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
            }
            sqlite3_finalize(statement);
        }
        
        
        SelectSQL = [NSString stringWithFormat:@"Select case when HL1KSA is '' then '0' else HL1KSA end as HL1KSA, "
                     "case when TempHL1KSA is '' then '0' else TempHL1KSA end as TempHL1KSA, HL1kSATerm, TempHL1kSATerm  from Trad_Details where Sino = \"%@\" ", SINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                HL1KSA = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] isEqual:NULL] ? @"0" : [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] ;
                TempHL1KSA = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] isEqual:NULL] ? @"0" : [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] ;
                
            }
            sqlite3_finalize(statement);
        }
        
        float val = [HL1KSA floatValue ] + [TempHL1KSA floatValue];
        NSString *totalHLoading = [NSString stringWithFormat:@"%.2f", val];
        
        if (val != 0) {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setMaximumFractionDigits:2];
            [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
            
            double ActualPremium = 0.00;
            double tempValue = 0.00;
            double OccpLoad;
            double LSDAnnually;
            if ([pPlanCode isEqualToString:@"HLAWP"]) {
                for (int i = 1; i <= PolicyTerm;  i++) {
                    if (i <= premiumPaymentOption) {
                        if (![HL1KSA isEqualToString:@"0"]) {
                            if(i <= [HealthLoadingTerm intValue ]){
                                tempValue = [HL1KSA doubleValue] * BasicSA/1000;
                            }
                        }
                        
                        if (![TempHL1KSA isEqualToString:@"0"]) {
                            if (i <= [TempHealthLoadingTerm intValue ]) {
                                tempValue = tempValue + [TempHL1KSA doubleValue] * BasicSA/1000;
                            }
                        }
                        
                        OccpLoad = [[OccLoading objectAtIndex:0] doubleValue] * 30 * (BasicSA/1000.00);
                        LSDAnnually = LSDRate  * (BasicSA/1000.00);
                        
                        ActualPremium = BasicSA + [self dblRoundToTwoDecimal:tempValue] + [self dblRoundToTwoDecimal:OccpLoad] - [self dblRoundToTwoDecimal:LSDAnnually];
                    } else {
                        ActualPremium = 0.00;
                    }
                    [aStrBasicSA addObject: [NSString stringWithFormat:@"%.2f", ActualPremium]];
                }
            } else if ([pPlanCode isEqualToString:@"L100"]) {
                for (int i = 1; i <= PolicyTerm;  i++) {
                    if (![HL1KSA isEqualToString:@"0"]) {
                        if(i <= [HealthLoadingTerm intValue ]) {
                            tempValue = [HL1KSA doubleValue] * BasicSA/1000;
                        }
                    }
                    
                    if (![TempHL1KSA isEqualToString:@"0"]) {
                        if (i <= [TempHealthLoadingTerm intValue ]) {
                            tempValue = tempValue + [TempHL1KSA doubleValue] * BasicSA/1000;
                        }
                    }
                    
                    OccpLoad = [[OccLoading objectAtIndex:0] doubleValue] * 1 * (BasicSA/1000.00);
                    LSDAnnually = LSDRate  * (BasicSA/1000.00);
                    ActualPremium = BasicRate * (BasicSA/1000.00) + [self dblRoundToTwoDecimal:tempValue] + [self dblRoundToTwoDecimal:OccpLoad] - [self dblRoundToTwoDecimal:LSDAnnually];
                    [aStrBasicSA addObject: [NSString stringWithFormat:@"%.2f", ActualPremium]];
                }
            } else if ([pPlanCode isEqualToString:@"S100"]) {
                for (int i = 1; i <= PolicyTerm;  i++) {
                    if (i <= premiumPaymentOption) {
                        if (![HL1KSA isEqualToString:@"0"]) {
                            if(i <= [HealthLoadingTerm intValue ]){
                                tempValue = [HL1KSA doubleValue] * BasicSA/1000;
                            }
                        }
                        
                        if (![TempHL1KSA isEqualToString:@"0"]) {
                            if (i <= [TempHealthLoadingTerm intValue ]) {
                                tempValue = tempValue + [TempHL1KSA doubleValue] * BasicSA/1000;
                            }
                        }
                        
                        OccpLoad = [[OccLoading objectAtIndex:0] doubleValue] * 1 * (BasicSA/1000.00);
                        LSDAnnually = LSDRate  * (BasicSA/1000.00);
                        ActualPremium = BasicRate * (BasicSA/1000.00) + [self dblRoundToTwoDecimal:tempValue] + [self dblRoundToTwoDecimal:OccpLoad] - [self dblRoundToTwoDecimal:LSDAnnually];
                    } else {
                        ActualPremium = 0.00;
                    }
                    [aStrBasicSA addObject: [NSString stringWithFormat:@"%.2f", ActualPremium]];
                }
            }
        } else {
            totalHLoading = @"";
            for (int i = 1; i <= PolicyTerm;  i++) {
                [aStrBasicSA addObject:[strBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
            }
        }
        
        if([pPlanCode isEqualToString:@"HLAWP"]) {
            QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                        "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') "
                        " VALUES ( "
                        " \"%@\",\"1\",\"DATA\",\"%@\",\"\",\"0\",\"%.2f\",\"%d\",\"%d\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", '%@' "
                        ")", SINo, pPlanName, BasicSA,PolicyTerm, premiumPaymentOption,strAnnually, strSemiAnnually, strQuarterly, strMonthly, totalHLoading, firstLifeLoading, pPlanCode  ];
            
        } else if([pPlanCode isEqualToString:@"S100"]) {
            QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                        "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') "
                        " VALUES ( "
                        " \"%@\",\"1\",\"DATA\",\"%@\",\"\",\"0\",\"%.2f\","
                        "\"%i\",\"%i\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", '%@' "
                        ")", SINo, pPlanName, BasicSA,100 - Age,
                        coveragePeriod,strAnnually, strSemiAnnually, strQuarterly, strMonthly, totalHLoading, firstLifeLoading, pPlanCode  ];
        } else if([pPlanCode isEqualToString:@"HLACP"]) {
            QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                        "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') "
                        " VALUES ( "
                        " \"%@\",\"1\",\"DATA\",\"%@\",\"\",\"0\",\"%.2f\","
                        "\"%d\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", '%@' "
                        ")", SINo, pPlanName, BasicSA,
                        PolicyTerm,@"6",strAnnually, strSemiAnnually, strQuarterly, strMonthly, totalHLoading, firstLifeLoading, pPlanCode];
            
        } else if([pPlanCode isEqualToString:@"L100"]) {
            QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                        "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') "
                        " VALUES ( "
                        " \"%@\",\"1\",\"DATA\",\"%@\",\"\",\"0\",\"%.2f\",\"%i\",\"%i\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", '%@' "
                        ")", SINo, pPlanName, BasicSA,coveragePeriod,coveragePeriod,strAnnually, strSemiAnnually, strQuarterly, strMonthly, totalHLoading, firstLifeLoading, pPlanCode  ];
        }
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
                NSLog(@"insert to SI_Temp_Trad_Details -|- start");
                
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
        
        strAnnually = Nil;
        strSemiAnnually = Nil;
        strQuarterly = Nil;
        strMonthly = Nil;
        HL1KSA = Nil;
        TempHL1KSA = Nil;
        
    }
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        // wealth booster riders
        for (int a=0; a<wpGYIRidersCode.count; a++) {
            strAnnually = @"";
            strSemiAnnually = @"";
            strQuarterly = @"";
            strMonthly = @"";
            strUnits = @"";
            strTemp = @"";
            
            OtherHLoading= @"";
            OtherTempHLoading= @"";
            
            seq = @"3";
            
            SelectSQL = [ NSString stringWithFormat:@"Select \"Type\", \"Annually\",\"SemiAnnually\",\"Quarterly\",\"Monthly\", ifnull(\"PremiumWithoutHLoading\", '0')  "
                         " from SI_Store_Premium as A, trad_rider_details as B where A.Type = B.riderCode AND A.SINO=B.SINO AND \"type\" = \"%@\" "
                         " AND \"FromAge\" is NULL AND B.SINO = \"%@\" ", [wpGYIRidersCode objectAtIndex:a], SINo];
            
            if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    strAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    strSemiAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    strQuarterly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    strMonthly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                    strTemp = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                    
                    [aStrWPGYIRiderAnnually addObject:[strAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ]]; //with HL and occ loading
                    [aStrWPGYIRiderSemiAnnually addObject:[strSemiAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    [aStrWPGYIRiderQuarterly addObject:[strQuarterly stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    [aStrWPGYIRiderMonthly addObject:[strMonthly stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    
                    [wpGYIRidersPremAnnualWithoutHLoading addObject:[strTemp stringByReplacingOccurrencesOfString:@"," withString:@"" ]];//without HL and occloading,
                }
                sqlite3_finalize(statement);
            }
            
            SelectSQL = [NSString stringWithFormat:@"Select HL1KSA, TempHL1KSA from Trad_Rider_Details where Sino = \"%@\" AND Ridercode = \"%@\"  ", SINo, [wpGYIRidersCode objectAtIndex:a]];
            
            if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    OtherHLoading = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] isEqualToString:@"(null)"] ? @"" : [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] ;
                    OtherTempHLoading = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] isEqualToString:@"(null)"] ? @"" : [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] ;
                }
                sqlite3_finalize(statement);
            }
            
            if ([OtherHLoading isEqualToString:@"" ]) {
                OtherHLoading = @"";
            } else {
                OtherHLoading = [NSString stringWithFormat:@"%.2f", [OtherHLoading floatValue]];
            }
            
            if (![OtherTempHLoading isEqualToString:@"" ]) {
                OtherHLoading = [NSString stringWithFormat:@"%.2f",[OtherHLoading floatValue ] + [OtherTempHLoading floatValue]];
            }
            
            RiderDesc = [wpGYIRiderDesc objectAtIndex:a];
            SA = [wpGYIRidersSA objectAtIndex:a];
            
            RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                        "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') VALUES ( "
                        " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                        ")", SINo, seq, RiderDesc,@"", strUnits, SA,
                        [wpGYIRidersTerm objectAtIndex:a],
                        [wpGYIRidersPayingTerm objectAtIndex:a],
                        strAnnually,
                        strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, firstLifeLoading, [wpGYIRidersCode  objectAtIndex:a]];
            
            if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {
                    
                }
                sqlite3_finalize(statement);
            }
            
            SA = Nil;
            
            strAnnually = Nil;
            strSemiAnnually = Nil;
            strQuarterly = Nil;
            strMonthly = Nil;
            strUnits = Nil;
            seq = Nil, OtherHLoading= Nil;
        }
        
        sqlite3_close(contactDB);
    }
    
    
    NSString *planOption;
    NSString *coverOption = @"";
    NSString *ocr;
    for (int a=0; a<OtherRiderCode.count; a++) {
        strAnnually = @"";
        strSemiAnnually = @"";
        strQuarterly = @"";
        strMonthly = @"";
        strUnits = @"";
        seq = @"";
        OtherHLoading= @"";
        OtherTempHLoading= @"";
        ocr = [OtherRiderCode objectAtIndex:a];
        
        if ([ocr isEqualToString:@"LCWP"] || [ocr isEqualToString:@"PLCP"] || [ocr isEqualToString:@"PR"] || [ocr isEqualToString:@"PTR"]) {
            seq = @"5";
        } else if ([ocr isEqualToString:@"SP_STD"] || [ocr isEqualToString:@"SP_PRE"]) {
            seq = @"4";
        } else if ([ocr isEqualToString:@"WP30R"] || [ocr isEqualToString:@"WP50R"] || [ocr isEqualToString:@"WPTPD30R"] || [ocr isEqualToString:@"WPTPD50R"]) {
            seq = @"3";
        } else {
            seq = @"2";
        }
        //        if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"ICR" ]) {
        //            seq = @"4";
        //        } else if(([[OtherRiderCode objectAtIndex:a] characterAtIndex:0] > 64 && [[OtherRiderCode objectAtIndex:a] characterAtIndex:0] < 73) ||
        //                ([[OtherRiderCode objectAtIndex:a] characterAtIndex:0] > 96 && [[OtherRiderCode objectAtIndex:a] characterAtIndex:0] < 105)) {
        //            seq = @"2";
        //        } else {
        //            seq = @"6";
        //        }
        
        //for total CI
        if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"CIR" ] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"LCPR" ] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"ACIR_MPP" ]) {
            TotalCI = TotalCI + [[OtherRiderSA objectAtIndex:a] doubleValue];
            [CIRiders addObject:[OtherRiderCode objectAtIndex:a]];
        } else if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"ICR" ]) {
            TotalCI = TotalCI + ([[OtherRiderSA objectAtIndex:a] doubleValue] * 10);
            [CIRiders addObject:[OtherRiderCode objectAtIndex:a]];
        } else if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"PLCP" ]) {
            TotalCI2 = TotalCI2 + ([[OtherRiderSA objectAtIndex:a] doubleValue]);
            [CIRiders2 addObject:[OtherRiderCode objectAtIndex:a]];
        }
        //end
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK) {
            SelectSQL = [ NSString stringWithFormat:@"Select \"Type\", \"Annually\",\"SemiAnnually\",\"Quarterly\",\"Monthly\", \"Units\", ifnull(\"PremiumWithoutHLoading\", '0')  "
                         " from SI_Store_Premium as A, trad_rider_details as B where A.Type = B.riderCode AND A.SINO=B.SINO AND \"type\" = \"%@\" "
                         " AND \"FromAge\" is NULL AND B.SINO = \"%@\" ", [OtherRiderCode objectAtIndex:a], SINo];
            
            if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    strAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    strSemiAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    strQuarterly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    strMonthly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                    strUnits = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                    NSString *strTemp = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                    
                    //NSLog(@"%@ -- %@", strUnits, [OtherRiderCode objectAtIndex:a]);
                    [aStrOtherRiderAnnually addObject:[strAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ]]; //premium with HL and occ loading
                    [aStrOtherRiderSemiAnnually addObject:[strSemiAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    [aStrOtherRiderQuarterly addObject:[strQuarterly stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    [aStrOtherRiderMonthly addObject:[strMonthly stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    [OtherRiderPremWithoutHLoading addObject:[strTemp stringByReplacingOccurrencesOfString:@"," withString:@"" ]]; //premium without HL and occ loading
                } else {
                    [aStrOtherRiderAnnually addObject:@"0.00"];
                    [aStrOtherRiderSemiAnnually addObject:@"0.00"];
                    [aStrOtherRiderQuarterly addObject:@"0.00"];
                    [aStrOtherRiderMonthly addObject:@"0.00"];
                    [OtherRiderPremWithoutHLoading addObject:@"0.00"];
                }
                sqlite3_finalize(statement);
            }
            
            if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"ACIR_MPP"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"C+"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"CCTR"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"CIR"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"C+"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"CPA"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"TPDYLA"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"LCPR"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"C+"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PA"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PLCP"]
                || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"ICR"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PTR"]
                || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"EDB" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"ETPDB" ] ||
                [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"WP30R" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"WP50R" ] ||
                [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"WPTPD30R" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"WPTPD50R" ]) {
                
                SelectSQL = [NSString stringWithFormat:@"Select HL1KSA, TempHL1KSA from Trad_Rider_Details where Sino = \"%@\" AND Ridercode = \"%@\"  ", SINo, [OtherRiderCode objectAtIndex:a]];
                
            } else if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"CIWP"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"LCWP"] ||
                       [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PR"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"SP_PRE"] ||
                       [[OtherRiderCode objectAtIndex:a] isEqualToString:@"SP_STD"]){
                SelectSQL = [NSString stringWithFormat:@"Select HL100SA, TempHL1KSA from Trad_Rider_Details where Sino = \"%@\" AND Ridercode = \"%@\"  ", SINo, [OtherRiderCode objectAtIndex:a]];
                
            } else {
                SelectSQL = [NSString stringWithFormat:@"Select HLPercentage, TempHL1KSA from Trad_Rider_Details where Sino = \"%@\" AND Ridercode = \"%@\"  ", SINo, [OtherRiderCode objectAtIndex:a]];
                
            }
            
            if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    OtherHLoading = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] isEqualToString:@"(null)"] ? @"" : [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] ;
                    OtherTempHLoading = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] isEqualToString:@"(null)"] ? @"" : [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] ;
                }
                sqlite3_finalize(statement);
            }
            
            if ([OtherHLoading isEqualToString:@"" ]) {
                OtherHLoading = @"";
                
            } else {
                if ( [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HMM" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HSP_II" ]
                    || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_IV" ]
                    || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HB" ]){
                    OtherHLoading = [NSString stringWithFormat:@"%d", [OtherHLoading intValue]];
                }
                else{
                    OtherHLoading = [NSString stringWithFormat:@"%.2f", [OtherHLoading floatValue]];
                }
                
            }
            
            if (![OtherTempHLoading isEqualToString:@"" ]) {
                OtherHLoading = [NSString stringWithFormat:@"%.2f",[OtherHLoading floatValue ] + [OtherTempHLoading floatValue]];
            }
            
            // special case for LCWP, PR, SP_PRE, SP_STD --> second life assured riders
            if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"LCWP" ] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PR" ] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"SP_PRE" ] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"SP_STD" ]) {
                [UpdateTradDetail addObject:[OtherRiderCode objectAtIndex:a]];
                [UpdateTradDetailTerm addObject:[OtherRiderTerm objectAtIndex:a]];
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, [[OtherRiderDesc objectAtIndex:a] stringByAppendingString:[ NSString stringWithFormat:@" (%@%%)", [OtherRiderSA objectAtIndex:a]]],
                            [OtherRiderPlanOption objectAtIndex:a], @"-", [OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], @"-",
                            @"-", @"-", @"-", OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a] ];
                
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, @"-Annually",@"-", @"500.00", @"", @"", strAnnually, @"-", @"-", @"-",OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, @"-Semi-annually",@"-", @"400.00", @"", @"", @"-", strSemiAnnually, @"-", @"-",OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, @"-Quarterly",@"-", @"300.00", @"", @"", @"-", @"-", strQuarterly, @"-", OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, @"-Monthly",@"-", @"200.00", @"", @"", @"-", @"-", @"-", strMonthly,OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
            } else if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"CIWP"  ]) {
                //special case for ciwp only --> first life assured riders
                [UpdateTradDetail addObject:[OtherRiderCode objectAtIndex:a]];
                [UpdateTradDetailTerm addObject:[OtherRiderTerm objectAtIndex:a]];
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, [[OtherRiderDesc objectAtIndex:a] stringByAppendingString:[ NSString stringWithFormat:@" (%@%%)", [OtherRiderSA objectAtIndex:a]]],
                            [OtherRiderPlanOption objectAtIndex:a], @"-", [OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], @"-",
                            @"-", @"-", @"-",OtherHLoading, @"", [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a] ];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, @"-Annually",@"-", @"500.00", @"", @"", strAnnually, @"-", @"-", @"-",OtherHLoading, @"", [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a]];
                
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, @"-Semi-annually",@"-", @"400.00", @"", @"", @"-", strSemiAnnually, @"-", @"-",OtherHLoading, @"", [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, @"-Quarterly",@"-", @"300.00", @"", @"", @"-", @"-", strQuarterly, @"-", OtherHLoading, @"", [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\", 'RiderCode') VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                            ")", SINo, seq, @"-Monthly",@"-", @"200.00", @"", @"", @"-", @"-", @"-", strMonthly, OtherHLoading, @"", [OtherRiderCode objectAtIndex:a], [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
            }
            else {
                RiderDesc = @"";
                SA = @"";
                planOption = [OtherRiderPlanOption objectAtIndex:a];
                coverOption = @"";
                if ([planOption isEqualToString:@"L"]) {
                    planOption = @"Option 1";
                    coverOption = @"Level Cover";
                } else if ([planOption isEqualToString:@"I"]) {
                    planOption = @"Option 2";
                    coverOption = @"Increasing Cover";
                } else if ([planOption isEqualToString:@"B"]) {
                    planOption = @"Option 3";
                    coverOption = @"Level Cover with NCB";
                } else if ([planOption isEqualToString:@"N"]) {
                    planOption = @"Option 4";
                    coverOption = @"Increasing Cover with NCB";
                }
                
                if (![[OtherRiderDeductible objectAtIndex:a] isEqualToString:@"(null)" ]) {
                    RiderDesc= [NSString stringWithFormat:@"%@ (Class %@) (Deductible %@)", [OtherRiderDesc objectAtIndex:a],
                                OccpClass ,[OtherRiderDeductible objectAtIndex:a] ];
                } else if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HMM" ]) {
                    if ([[OtherRiderPlanOption objectAtIndex:a] isEqual:@"HMM_1000"]) {
                        RiderDesc = [NSString stringWithFormat:@"%@ Plus (Class %@)", [OtherRiderDesc objectAtIndex:a], OccpClass ];
                    } else {
                        RiderDesc = [NSString stringWithFormat:@"%@ (Class %@)", [OtherRiderDesc objectAtIndex:a], OccpClass ];
                    }
                } else if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"CPA" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"PA" ]
                           || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HSP_II" ]
                           || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_IV" ]){
                    RiderDesc = [NSString stringWithFormat:@"%@ (Class %@)", [OtherRiderDesc objectAtIndex:a], OccpClass ];
                } else if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"C+"]) {
                    
                    RiderDesc = [NSString stringWithFormat:@"%@ (%@)", [OtherRiderDesc objectAtIndex:a], coverOption ];
                } else {
                    RiderDesc = [OtherRiderDesc objectAtIndex:a];
                }
                
                if ( [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HMM" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HSP_II" ]
                    || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_IV" ]
                    || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HB" ]){
                    
                    SA = @"-";
                    if (![OtherHLoading isEqualToString:@""]) {
                        OtherHLoading = [OtherHLoading stringByAppendingFormat:@"%%" ];
                    }
                    
                } else {
                    SA = [OtherRiderSA objectAtIndex:a];
                }
                
                if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"CCTR" ]) {
                    RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') VALUES ( "
                                " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                                ")", SINo, seq, RiderDesc,planOption, strUnits, [OtherRiderSA objectAtIndex:a],
                                [OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], strAnnually,
                                strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, firstLifeLoading, [OtherRiderCode objectAtIndex:a]];
                } else {
                    
                    if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"EDB" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"ETPDB" ] ) {
                        RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                    "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') VALUES ( "
                                    " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                                    ")", SINo, seq, RiderDesc,planOption, strUnits, SA,
                                    [OtherRiderTerm objectAtIndex:a], @"6", strAnnually,
                                    strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, firstLifeLoading, [OtherRiderCode objectAtIndex:a]];
                        
                    } else if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"PLCP"] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"PTR"]){ // add in occ loading
                        RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                    "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') VALUES ( "
                                    " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\" "
                                    ")", SINo, seq, RiderDesc,planOption, strUnits, SA,
                                    [OtherRiderTerm objectAtIndex:a],
                                    [OtherRiderPayingTerm objectAtIndex:a], strAnnually,
                                    strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a]];
                    } else if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"LCPR"]
                               || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"TPDYLA"] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"ICR"]){ // add in occ loading
                        RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                    "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') VALUES ( "
                                    " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                                    ")", SINo, seq, RiderDesc,planOption, strUnits, SA,
                                    [OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], strAnnually,
                                    strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, firstLifeLoading, [OtherRiderCode objectAtIndex:a]];
                    } else if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"WP30R" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"WP50R" ] ||
                               [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"WPTPD30R" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"WPTPD50R"]){ // diff payment term
                        RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                    "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') VALUES ( "
                                    " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                                    ")", SINo, seq, RiderDesc,planOption, strUnits, SA,
                                    [OtherRiderTerm objectAtIndex:a], [OtherRiderPayingTerm objectAtIndex:a], strAnnually,
                                    strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, firstLifeLoading, [OtherRiderCode objectAtIndex:a]];
                    }
                    else{
                        //Edwin 23-07-2014, added getRiderTerm for paymentOption HLAWP col4
                        // without occ loading in quotation
                        RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                    "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\", 'RiderCode') VALUES ( "
                                    " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"\", \"%@\" "
                                    ")", SINo, seq, RiderDesc,planOption, strUnits, SA,
                                    [OtherRiderTerm objectAtIndex:a],
                                    [OtherRiderPayingTerm objectAtIndex:a], strAnnually,
                                    strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, [OtherRiderCode objectAtIndex:a]];
                    }
                }
                
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                planOption = Nil;
                SA = Nil;
            }
            
            sqlite3_close(contactDB);
        }
        
        strAnnually = Nil;
        strSemiAnnually = Nil;
        strQuarterly = Nil;
        strMonthly = Nil;
        strUnits = Nil;
        seq = Nil, OtherHLoading= Nil;
    }
    
    NSLog(@"insert to SI_Temp_Trad_Details -|- End");
    statement = Nil;
    QuerySQL = Nil;
    RiderSQL = Nil;
    SelectSQL =  Nil;
    firstLifeLoading = Nil;
    secondtLifeLoading = Nil;
}

//only special for HLAWP riders
-(NSString *) getRiderCoveragePeriod:(NSString*) riderTerm riderCode:(NSString*) aariderCode
{
    if([pPlanCode isEqualToString:@"HLAWP"])
    {
        if([aariderCode isEqualToString:@"EDUWR"]) {
            int termInt = [riderTerm intValue];
            return [NSString stringWithFormat:@"%d",termInt];
        } else {
            return [NSString stringWithFormat:@"%d",premiumPaymentOption];
        }
    } else {
        return riderTerm;
    }
}

//only special for HLAWP riders
-(NSString *) getRiderTerm:(NSString*) riderTerm
{
    if([pPlanCode isEqualToString:@"HLAWP"]) {
        return [NSString stringWithFormat:@"%d", premiumPaymentOption ];
    } else {
        return riderTerm;
    }
}

-(void)InsertToSI_Temp_Trad_LA{
    sqlite3_stmt *statement;
    sqlite3_stmt *statement2;
    sqlite3_stmt *statement3;
    NSString *getCustomerCodeSQL;
    NSString *getFromCltProfileSQL;
    NSString *smoker;
    NSString *QuerySQL;
    
    NSLog(@"insert to SI Temp Trad LA --- start");
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        getCustomerCodeSQL = [ NSString stringWithFormat:@"select CustCode from Trad_LaPayor where sino = \"%@\" AND sequence = %d ", SINo, 1];
        
        if(sqlite3_prepare_v2(contactDB, [getCustomerCodeSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                CustCode  = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                getFromCltProfileSQL = [NSString stringWithFormat:@"Select a.Name, a.Smoker, a.sex, a.ALB, b.OtherIDType from clt_profile a LEFT JOIN prospect_profile b ON a.indexNo=b.IndexNo where a.custcode =\"%@\"", CustCode];
                if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement2) == SQLITE_ROW) {
                        NSString *oidType = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)];
                        
                        Name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                        Age = sqlite3_column_int(statement2, 3);
                        if ([oidType isEqualToString:@"EDD"]) {
                            smoker = @"";
                            sex = @"";
                        } else {
                            smoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
                            sex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
                        }
                        QuerySQL  = [ NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_LA (\"SINo\", \"LADesc\", "
                                     "\"PtypeCode\", \"Seq\", \"Name\", \"Age\", \"Sex\", \"Smoker\", \"LADescM\") "
                                     " VALUES (\"%@\",\"Life Assured\",\"LA\",\"%d\",\"%@\",\"%d\", \"%@\", \"%@\", "
                                     " \"Hayat Diinsuranskan\")", SINo, 1, Name, Age, sex, smoker ];
                        
                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement3, NULL) == SQLITE_OK) {
                            if (sqlite3_step(statement3) == SQLITE_DONE) {
                            }
                            sqlite3_finalize(statement3);
                        }
                        
                        smoker = Nil;
                    }
                    sqlite3_finalize(statement2);
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    // check for 2nd life assured
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        getCustomerCodeSQL = [ NSString stringWithFormat:@"select CustCode from Trad_LaPayor where sino = \"%@\" AND sequence = %d ", SINo, 2];
        
        if(sqlite3_prepare_v2(contactDB, [getCustomerCodeSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                CustCode  = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                getFromCltProfileSQL  = [NSString stringWithFormat:@"Select Name, Smoker, sex, ALB from clt_profile where custcode  = \"%@\"",  CustCode];
                
                if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
                    
                    if (sqlite3_step(statement2) == SQLITE_ROW) {
                        NSString *SecName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                        NSString *Secsmoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
                        NSString *Secsex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
                        int SecAge = sqlite3_column_int(statement2, 3);
                        
                        QuerySQL  = [ NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_LA (\"SINo\", \"LADesc\", "
                                     "\"PtypeCode\", \"Seq\", \"Name\", \"Age\", \"Sex\", \"Smoker\", \"LADescM\") "
                                     " VALUES (\"%@\",\"2nd Life Assured\",\"LA\",\"%d\",\"%@\",\"%d\", \"%@\", \"%@\", "
                                     " \"Hayat Diinsuranskan ke-2\")", SINo, 2, SecName, SecAge, Secsex, Secsmoker ];
                        
                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement3, NULL) == SQLITE_OK) {
                            if (sqlite3_step(statement3) == SQLITE_DONE) {
                                //NSLog(@"done insert to temp_trad_LA");
                            }
                            sqlite3_finalize(statement3);
                        }
                        
                        SecName = Nil;
                        Secsmoker = Nil;
                        Secsex = Nil;
                    }
                    sqlite3_finalize(statement2);
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    //check for payor
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        getCustomerCodeSQL = [ NSString stringWithFormat:@"select CustCode from Trad_LaPayor where sino = \"%@\" AND PtypeCode = 'PY' ", SINo];
        
        if(sqlite3_prepare_v2(contactDB, [getCustomerCodeSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                CustCode  = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                getFromCltProfileSQL  = [NSString stringWithFormat:@"Select Name, Smoker, sex, ALB from clt_profile where custcode  = \"%@\"",  CustCode];
                
                if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
                    
                    if (sqlite3_step(statement2) == SQLITE_ROW) {
                        NSString *PYName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                        NSString *PYsmoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
                        NSString *PYsex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
                        int PYAge = sqlite3_column_int(statement2, 3);
                        
                        QuerySQL  = [ NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_LA (\"SINo\", \"LADesc\", "
                                     "\"PtypeCode\", \"Seq\", \"Name\", \"Age\", \"Sex\", \"Smoker\", \"LADescM\") "
                                     " VALUES (\"%@\",\"Policy Owner\",\"PY\",\"%d\",\"%@\",\"%d\", \"%@\", \"%@\", "
                                     " \"Pemunya Polisi\")", SINo, 1, PYName, PYAge, PYsex, PYsmoker ];
                        
                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement3, NULL) == SQLITE_OK) {
                            if (sqlite3_step(statement3) == SQLITE_DONE) {
                                
                            }
                            sqlite3_finalize(statement3);
                        }
                        
                        PYName = Nil;
                        PYsmoker = Nil;
                        PYsex = Nil;
                    }
                    sqlite3_finalize(statement2);
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    NSLog(@"insert to SI_Temp_Trad_LA --- End");
    statement = Nil;
    statement2 = Nil;
    statement3 = Nil;
    getCustomerCodeSQL = Nil;
    getFromCltProfileSQL = Nil;
    smoker = Nil;
    QuerySQL = Nil;
    
}


-(void)InsertToSI_Temp_Trad_Basic_L100
{
    NSString *QuerySQL;
    sqlite3_stmt *statement;
    NSMutableArray *SurValueSingle = [[NSMutableArray alloc] init ];
    NSMutableArray *SurValue5Pay = [[NSMutableArray alloc] init ];
    
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        for (int i = 1; i < 100 - Age; i++) {
            QuerySQL = [NSString stringWithFormat: @"Select rates from cash_SurValue_Single where "
                        " age = \"%d\" and gender='%@' ", Age + i - 1, [sex substringToIndex:1]];
            
            if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                
                if(sqlite3_step(statement) == SQLITE_ROW) {
                    
                    [SurValueSingle addObject:[NSString stringWithFormat:@"%f", sqlite3_column_double(statement, 0) ]];
                    
                }
                sqlite3_finalize(statement);
            }
            
            if (premiumPaymentOption == 5) {
                QuerySQL = [NSString stringWithFormat: @"Select rates from cash_SurValue_5Pay where "
                            " age = \"%d\" and gender='%@' AND year = '%d' ", Age, [sex substringToIndex:1], i];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    
                    if(sqlite3_step(statement) == SQLITE_ROW) {
                        [SurValue5Pay addObject:[NSString stringWithFormat:@"%f", sqlite3_column_double(statement, 0) ]];
                    }
                    else{
                        [SurValue5Pay addObject:@"0.00"];
                    }
                    sqlite3_finalize(statement);
                }
            }
            
            
        }
        
        sqlite3_close(contactDB);
    }
    
    //----do the insertion of si_temp_trad_basic here---------------//

    int skipCount=1;
    int lifeAsAt=0;
    int seqNo=1;
    double totPremPaid = 0;


    
    double PenanggunganTambahanAcc = 0.00;
    double PrevPenanggunganTambahanAcc = 0.00;
    double PenanggunganTambahan = 0.00;
    double NilaiTunaiTerjamin = 0.00;
    double NilaiTunaiPerTanggunganTambahan = 0.00;
    double TotalNilaiTunai = 0.00;
    double TotalManfaat = 0.00;
    double RB_Rate = 0.015;
    double interest_Rate = 0.0225;
    int RB_Factor = 0;
    double tempBasicSA = BasicSA/1000;
    
    for (int polYear=1; polYear< 100 - Age; polYear++) {
        lifeAsAt = polYear + Age;
        //juv = [self getJuvenileRate:lifeAsAt];

        if (premiumPaymentOption == 1) {
            RB_Factor = polYear == 1 ? 0 : 1;
        }
        else{
            RB_Factor = polYear < 3 ? 0 : 1;
        }
        
        PenanggunganTambahan = RB_Factor * (tempBasicSA * RB_Rate) + (PrevPenanggunganTambahanAcc * interest_Rate);
        PenanggunganTambahanAcc = PenanggunganTambahanAcc + PenanggunganTambahan;
        PrevPenanggunganTambahanAcc = PenanggunganTambahanAcc;
        TotalManfaat = tempBasicSA + PenanggunganTambahanAcc;
        
        if (premiumPaymentOption == 1) {
                NilaiTunaiTerjamin = [[SurValueSingle objectAtIndex:polYear -1] doubleValue] * tempBasicSA/1000.00;
        }
        else{
               NilaiTunaiTerjamin = [[SurValue5Pay objectAtIndex:polYear -1] doubleValue] * tempBasicSA/1000.00;
        }
        
        NilaiTunaiPerTanggunganTambahan = [[SurValueSingle objectAtIndex:polYear - 1] doubleValue] * PenanggunganTambahanAcc/1000.00;
        
        TotalNilaiTunai = NilaiTunaiTerjamin + NilaiTunaiPerTanggunganTambahan;
        
        if(lifeAsAt<100) {
            if(polYear>20 && skipCount<5   ) {
                if (lifeAsAt != 100 - 1) {
                    skipCount++;
                    continue;
                }
            }
        }
        skipCount = 1;
        
        QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Basic "
                    "(\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\", "
                    "\"col1\",\"col2\", \"col3\",\"col4\",\"col5\", \"col6\",\"col7\" ) "
                    "VALUES ( "
                    " \"%@\",\"%d\",\"DATA\",\"%d\",\"%d\", "
                    "\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\" )",
                    SINo, seqNo, polYear, lifeAsAt,
                    tempBasicSA,  PenanggunganTambahan, PenanggunganTambahanAcc, TotalManfaat, NilaiTunaiTerjamin, NilaiTunaiPerTanggunganTambahan, TotalNilaiTunai];
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {
                    
                }
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
        
        seqNo++;
        totPremPaidL100 = totPremPaid;
    }
}

-(double)getJuvenileRate:(int)age {
    double juv = 1.0;
    
    if (age < 2) {
        juv = 0.2;
    } else if (age == 2) {
        juv = 0.4;
    } else if (age == 3) {
        juv = 0.6;
    } else if (age == 4) {
        juv = 0.8;
    }
    
    return juv;
}

-(void)InsertToSI_Temp_Trad_Basic_S100
{
    NSString *QuerySQL;
    sqlite3_stmt *statement;
    NSMutableArray *SurrenderRatesS100 = [[NSMutableArray alloc] init ];
    int maxPolYear = -1;
    int ppo = 100;
    
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        // check for the correct premium payment mode
        if (premiumPaymentOption != 100 - Age) {
            ppo = premiumPaymentOption;
        }
        QuerySQL = [NSString stringWithFormat: @"SELECT Rate, PolYear from Trad_Sys_Basic_CSV WHERE "
                    " Age = \"%d\" AND PlanCode='%@' AND PremPayOpt='%d' ORDER BY PolYear", Age, pPlanCode, ppo];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            NSNumber *num;
            while (sqlite3_step(statement) == SQLITE_ROW) {
                num = [NSNumber numberWithFloat:sqlite3_column_double(statement, 0)];
                [SurrenderRatesS100 addObject:num];
                maxPolYear = sqlite3_column_int(statement, 1);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
    //----do the insertion of si_temp_trad_basic here---------------//
    int skipCount=1;
    int lifeAsAt=0;
    int seqNo=1;
    double totPremPaid = 0;
    NSString *basicAnnualSA;
    NSString *surrValue;
    double deathBenefit;
    double rpu;
    double deathBenefitRPU;
    
    double juv = 1.0;
    double tempTotal;
    
    for (int polYear=1; polYear<=maxPolYear; polYear++)
    {
        lifeAsAt = polYear + Age;
        juv = [self getJuvenileRate:lifeAsAt];
        
        if (polYear <= premiumPaymentOption) {
            basicAnnualSA = [aStrBasicSA objectAtIndex:(polYear-1)];
        } else {
            basicAnnualSA = 0;
        }
        
        surrValue = [NSString stringWithFormat:@"%d", [self roundingDouble:[[SurrenderRatesS100 objectAtIndex:polYear-1] floatValue] * BasicSA/1000]];
        tempTotal = [self getL100TotalAnnualPremium:polYear basicAnnualSA:basicAnnualSA];
        
        deathBenefit = BasicSA * juv;
        totPremPaid = totPremPaid + tempTotal;
        
        rpu = [self getRPUForPolYear:polYear Age:Age PayOpt:ppo UsingStatement:statement];
        deathBenefitRPU = BasicSA * rpu * juv / 1000;
        
        if(lifeAsAt<100) {
            if(polYear>20 && skipCount<5) {
                skipCount++;
                continue;
            }
        }
        skipCount = 1;
        
        QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Basic "
                    "(\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\", "
                    "\"col1\",\"col2\", \"col3\",\"col4\",\"col5\" ) "
                    "VALUES ( "
                    " \"%@\",\"%d\",\"DATA\",\"%d\",\"%d\", "
                    "\"%@\",\"%@\",\"%f\",\"%f\",\"%.2f\" )",
                    SINo, seqNo, polYear, lifeAsAt,
                    basicAnnualSA, surrValue, deathBenefit, deathBenefitRPU, tempTotal];
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE) {
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
        
        seqNo++;
        totPremPaidL100 = totPremPaid;
    }
}

-(double)getRPUForPolYear:(int)polyear Age:(int)age PayOpt:(int)ppo UsingStatement:(sqlite3_stmt*)statement{
    double val = 0;
    
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK) {
        NSString *QuerySQL = [NSString stringWithFormat:@"SELECT Rates FROM Trad_Sys_Basic_RPU WHERE "
                              "PlanCode='%@' AND PolYear='%d' AND Age='%d' AND PremPayOpt='%d'",pPlanCode, polyear, age, ppo];
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                val = sqlite3_column_double(statement, 0);
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    return val;
}

//includes both basic and riders
-(double) getL100TotalAnnualPremium:(int)polYear basicAnnualSA:(NSString*)basicAnnualSA
{
    //---------------- total premium paid ----------
    NSString *QuerySQL;
    sqlite3_stmt *statement;
    double sumBasic = 0.0;
    float sumOtherRider = 0.0;
    
    sumBasic = [basicAnnualSA doubleValue];
    
    for (int j =0; j<OtherRiderCode.count; j++) {
        if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HMM" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_IV" ]
            || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HSP_II" ] ) {
            
            if ( polYear <= [[OtherRiderTerm objectAtIndex:j] intValue ]   ) {
                double tempHMMRates = 0.00;
                
                if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                    QuerySQL = [NSString stringWithFormat:@"Select Annually from SI_Store_premium Where Type = \"%@\" AND "
                                "FromAge <= \"%d\" AND ToAge >= \"%d\" AND SIno = '%@' ", [OtherRiderCode objectAtIndex:j ], Age + polYear - 1, Age + polYear - 1, SINo];
                    
                    if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                        if (sqlite3_step(statement) == SQLITE_ROW) {
                            tempHMMRates = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] doubleValue ];
                        }
                        sqlite3_finalize(statement);
                    }
                    sqlite3_close(contactDB);
                }
                
                NSString *tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:j];
                NSString *tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:j];
                NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                
                double actualPremium = 0.0;
                double baseValue = tempHMMRates/([tempHLPercentage doubleValue]/100 + 1);
                
                if([tempHLPercentage isEqualToString:@"(null)"]) {
                    actualPremium = baseValue;
                } else {
                    if ([tempTempHL isEqualToString:@"(null)"]) {
                        actualPremium = baseValue;
                    } else {
                        if(polYear <= [tempHLPercentageTerm intValue ] && polYear <= [tempTempHLTerm intValue ]    ) {
                            actualPremium = baseValue * ([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100  + 1.00);
                        } else if(polYear <= [tempHLPercentageTerm intValue ] && polYear > [tempTempHLTerm intValue ]    ) {
                            actualPremium = baseValue * ([tempHLPercentage doubleValue]/100  + 1.00);
                            
                        } else if(polYear > [tempHLPercentageTerm intValue ] && polYear  <= [tempTempHLTerm intValue ]    ) {
                            actualPremium = baseValue * ([tempTempHL doubleValue]/100  + 1.00);
                            
                        } else if(polYear  > [tempHLPercentageTerm intValue ] && polYear > [tempTempHLTerm intValue ]    ) {
                            actualPremium = baseValue;
                        }
                        
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        [formatter setMaximumFractionDigits:2];
                        [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
                        
                        actualPremium = [[formatter stringFromNumber:[NSNumber numberWithDouble:actualPremium]] doubleValue];
                    }
                    
                }
                sumOtherRider = sumOtherRider + actualPremium;
                tempHLPercentage = Nil;
                tempHLPercentageTerm = Nil;
            }
        }
        else{ //non medical rider
            if ( polYear <= [[OtherRiderTerm objectAtIndex:j] intValue ]   ) {
                
                if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"CIWP" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"LCWP" ] ||
                    [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"PR" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"SP_PRE" ] ||
                    [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"SP_STD" ] ) {
                    
                    double waiverRiderSA = [[strOriBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                    
                    NSString *tempRiderCode = [OtherRiderCode objectAtIndex:j ];
                    NSString *tempHL100SA = [OtherRiderHL100SA objectAtIndex:j ];
                    NSString *tempHL100SATerm = [OtherRiderHL100SATerm objectAtIndex:j];
                    NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:j ];
                    NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j ];
                    double tempRiderSA = [[OtherRiderSA objectAtIndex:j ] doubleValue];
                    int tempRiderTerm = [[OtherRiderTerm objectAtIndex:j ] doubleValue];
                    NSString *tempPremWithoutHLoading = [OtherRiderPremWithoutHLoading objectAtIndex:j ];
                    
                    if ([tempRiderCode isEqualToString:@"CIWP"]) {
                        
                        for (int q=0; q < OtherRiderCode.count; q++) {
                            if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCPR"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIR"]  ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ICR"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_TW"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_TWP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_EXC"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_MPP"])) {
                                waiverRiderSA = waiverRiderSA + [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                
                            }
                            else if ([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_MPP"]) {
                                waiverRiderSA = waiverRiderSA -
                                (( ([[OtherRiderSA objectAtIndex:q] doubleValue]/ BasicSA) * [[strOriBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]));
                                
                            }
                        }
                    } else if ([tempRiderCode isEqualToString:@"SP_STD"])  {
                        for (int q=0; q < OtherRiderCode.count; q++) {
                            if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PLCP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PTR"] )) {
                                waiverRiderSA = waiverRiderSA +
                                [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                            }
                        }
                    } else {
                        for (int q=0; q < OtherRiderCode.count; q++) {
                            if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PLCP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                  [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PTR"])) {
                                waiverRiderSA = waiverRiderSA +
                                [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                
                            }
                        }
                    }
                    
                    double actualPremium = 0.0;
                    double tempHLValue = 0.0;
                    
                    if (![tempHL100SA isEqualToString:@"(null)"]) {
                        if(polYear <= [tempHL100SATerm intValue ]){
                            tempHLValue = [tempHL100SA doubleValue];
                        }
                    }
                    
                    if (![tempTempHL isEqualToString:@"(null)"]) {
                        if (polYear <= [tempTempHLTerm intValue ]) {
                            tempHLValue = tempHLValue + [tempTempHL doubleValue];
                        }
                    }
                    
                    double waiverRiderRoundedUp = [self dblRoundToTwoDecimal:waiverRiderSA * tempRiderSA/100];
                    
                    if ([tempRiderCode isEqualToString:@"CIWP"]) {
                        actualPremium = [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * ([tempPremWithoutHLoading doubleValue]/100.00)]  +
                        [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * (tempRiderTerm/1000.00 * 0.00 + tempHLValue/100)];
                    } else if ([tempRiderCode isEqualToString:@"SP_PRE"]) {
                        actualPremium = [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * ([tempPremWithoutHLoading doubleValue]/100.00)]  +
                        [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * (tempRiderTerm/1000.00 * [[OccLoading objectAtIndex:1] doubleValue] + tempHLValue/100)];
                    }
                    else {
                        actualPremium = [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * ([tempPremWithoutHLoading doubleValue]/100.00)]  +
                        [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * (tempRiderTerm/1000.00 * [[OccLoading objectAtIndex:1] doubleValue] + tempHLValue/100)];
                    }
                    sumOtherRider = sumOtherRider + actualPremium;
                    
                    tempHL100SA = Nil;
                    tempHL100SATerm = Nil;
                } else if([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HB" ] ){
                    NSString *tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:j];
                    NSString *tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:j];
                    NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                    NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                    
                    double actualPremium = 0.0;
                    double baseValue = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                    /([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100 + 1.00);
                    
                    if([tempHLPercentage isEqualToString:@"(null)"]) {
                        actualPremium = baseValue;
                    } else {
                        if ([tempTempHL isEqualToString:@"(null)"]) {
                            actualPremium = baseValue;
                        } else {
                            if(polYear  <= [tempHLPercentageTerm intValue ] && polYear  <= [tempTempHLTerm intValue ]    ) {
                                actualPremium = baseValue * ([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100  + 1.00);
                            } else if(polYear  <= [tempHLPercentageTerm intValue ] && polYear  > [tempTempHLTerm intValue ]    ) {
                                actualPremium = baseValue * ([tempHLPercentage doubleValue]/100  + 1.00);
                            } else if(polYear  > [tempHLPercentageTerm intValue ] && polYear <= [tempTempHLTerm intValue ]    ) {
                                actualPremium = baseValue * ([tempTempHL doubleValue]/100  + 1.00);
                            } else if(polYear > [tempHLPercentageTerm intValue ] && polYear  > [tempTempHLTerm intValue ]    ) {
                                actualPremium = baseValue;
                            }
                        }
                    }
                    
                    sumOtherRider = sumOtherRider + actualPremium;
                }
                else{ //rider is not CIWP, PR, LCWP, SP_PRE, SP_STD, HB
                    NSString *tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
                    NSString *tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
                    NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                    NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                    
                    float actualPremium = 0.0;
                    if([tempHL1KSA isEqualToString:@"(null)"]) {
                        actualPremium = [ [self roundingTwoDecimal:[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ]] floatValue ];
                    } else {
                        if(polYear <= [tempHL1KSATerm intValue ] ){
                            actualPremium = [ [self roundingTwoDecimal:[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ]] floatValue ];
                        } else {
                            actualPremium = [ [self roundingTwoDecimal:[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ]] floatValue ]
                            - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000)  * [tempHL1KSA floatValue];
                        }
                    }
                    
                    if (![tempTempHL isEqualToString:@"(null)"] ) {
                        if (polYear > [tempTempHLTerm intValue]) {
                            actualPremium = actualPremium - ([[OtherRiderSA objectAtIndex:j] floatValue ]/1000) * [tempTempHL floatValue];
                        }
                    }
                    sumOtherRider = sumOtherRider + actualPremium;
                    
                    tempHL1KSA = nil;
                    tempHL1KSATerm = Nil;
                }
                
            }
        }
        
    }
    double TotalBasicAndRider = sumBasic + [self roundingTwoDecimalFloat:sumOtherRider];
    
    return TotalBasicAndRider;
    //----------------- total premium paid end ---------- //
}

-(int)roundingDouble:(double) val
{
    float value = val;
    int intValue = (int)value;
    
    float fractional = fmodf(value, (float)intValue);
    if(fractional > .5f)
        intValue++;
    
    return intValue;
}

-(void)getRiderWPGYIPrem:(NSString*)wpRidercode
{
    sqlite3_stmt *statement;
    
    NSString * strAnnually;
    NSString * strSemiAnnually;
    NSString * strQuarterly;
    NSString * strMonthly;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        NSString * SelectSQL = [ NSString stringWithFormat:@"Select * from SI_Store_Premium where \"type\" = \"%@\" and siNo='%@' ", wpRidercode, SINo];
        
        if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                strAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                strSemiAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                strQuarterly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                strMonthly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
                [wpGYIRidersPremAnnual addObject:strAnnually];
                [wpGYIRidersPremSemiAnnual addObject:strSemiAnnually];
                [wpGYIRidersPremQuarter addObject:strQuarterly];
                [wpGYIRidersPremMonth addObject:strMonthly];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(double)dblRoundToTwoDecimal:(double)value
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];
    
    NSString *temp = [formatter stringFromNumber:[NSNumber numberWithDouble:value]];
    return [temp doubleValue];
}

-(void)InsertToSI_Temp_Trad_Rider_WP_GYI{
    
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    double tempValueGYI;
    double tempValueGYIPayout;
    double tempValueGYITotal;
    double tempValueGYIWithoutInterest;
    double tempSurrenderValue;
    double tempGuaranteeDBValue;
    
    double tempCurrentCashDividendA;
    double tempCurrentCashDividendB;
    double tempCashDividendA;
    double tempCashDividendB;
    double tempYearlyIncomeA;
    double tempYearlyincomeB;
    double tempTotalNonGuaranteedSurrenderA;
    double tempTotalNonGuaranteedSurrenderB;
    double tempTotalNonGuaranteedTDivA;
    double tempTotalNonGuaranteedTDivB;
    double tempTotalNonGuaranteedSpeA;
    double tempTotalNonGuaranteedSpeB;
    double tempTotalDbA;
    double tempTotalDbB;
    double tempTotalPremiumPaid;
    
    
    NSLog(@"insert to SI_Temp_Trad_RideriLLus for WP Riders --- start");
    
    
    if (wpGYIRidersCode.count > 0 ) {
        
        NSMutableArray *AnnualPremium = [[NSMutableArray alloc] init ];
        NSMutableArray *GuaranteeYearlyIncomeAccumulate = [[NSMutableArray alloc] init ];
        NSMutableArray *GuaranteeYearlyIncomePayout = [[NSMutableArray alloc] init ];
        NSMutableArray *GuaranteeYearlyIncomeTotal  = [[NSMutableArray alloc] init ];
        NSMutableArray *GuaranteeYearlyIncomeTotal2  = [[NSMutableArray alloc] init ];
        NSMutableArray *SurrenderRates = [[NSMutableArray alloc] init ];
        NSMutableArray *SurrenderValue = [[NSMutableArray alloc] init ];
        NSMutableArray *DBRates = [[NSMutableArray alloc] init ];
        NSMutableArray *DBValue = [[NSMutableArray alloc] init ];
        NSMutableArray *aValue = [[NSMutableArray alloc] init ];
        NSMutableArray *aValueEnd = [[NSMutableArray alloc] init ];
        NSMutableArray *CurrentCashDividendRatesA = [[NSMutableArray alloc] init ];
        NSMutableArray *CurrentCashDividendValueA = [[NSMutableArray alloc] init ];
        NSMutableArray *CurrentCashDividendRatesB = [[NSMutableArray alloc] init ];
        NSMutableArray *CurrentCashDividendValueB = [[NSMutableArray alloc] init ];
        NSMutableArray *AccuCashDividendValueA = [[NSMutableArray alloc] init ];
        NSMutableArray *AccuCashDividendValueB = [[NSMutableArray alloc] init ];
        NSMutableArray *AccuYearlyIncomeValueA = [[NSMutableArray alloc] init ];
        NSMutableArray *AccuYearlyIncomeValueB = [[NSMutableArray alloc] init ];
        NSMutableArray *tDividendRatesA = [[NSMutableArray alloc] init ];
        NSMutableArray *tDividendValueA = [[NSMutableArray alloc] init ];
        NSMutableArray *tDividendRatesB = [[NSMutableArray alloc] init ];
        NSMutableArray *tDividendValueB = [[NSMutableArray alloc] init ];
        NSMutableArray *speRatesA = [[NSMutableArray alloc] init ];
        NSMutableArray *speValueA = [[NSMutableArray alloc] init ];
        NSMutableArray *speRatesB = [[NSMutableArray alloc] init ];
        NSMutableArray *speValueB = [[NSMutableArray alloc] init ];
        NSMutableArray *TotalNonGuaranteedSurrenderValueA = [[NSMutableArray alloc] init ];
        NSMutableArray *TotalNonGuaranteedSurrenderValueB = [[NSMutableArray alloc] init ];
        NSMutableArray *TotalDBValueA = [[NSMutableArray alloc] init ];
        NSMutableArray *TotalDBValueB = [[NSMutableArray alloc] init ];
        NSString *wpRiderCode;
        
        double dRiderSA;
        int iTerm;
        int inputAge = 0;
        
        double dGuaranteeYearlyIncomeTotal2 = 0.00;
        double actualPremium = 0.00;
        
        double tempRiderSA;
        NSString *tempHL1KSA;
        NSString *tempHL1KSATerm;
        NSString *tempTempHL;
        NSString *tempTempHLTerm;
        NSString *tempPrem;
        NSString *tempPremWithoutHLoading;
        double tempHLValue = 0.00;
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        
        double dTotalSurrenderValueA = 0.00;
        double dTotalSurrenderValueB = 0.00;
        double dDBValueA = 0.00;
        double dDbValueB = 0.00;
        
        NSString *strAccuCDA = @"";
        NSString *strAccuCDB = @"";
        NSString *strAccuYIA = @"";
        NSString *strAccuYIB = @"";
        
        int col0_1;
        int col0_2;
        NSString * col1;
        double col2;
        double col3;
        double col4;
        double col5;
        double col6;
        double col7;
        double col8;
        double col9;
        double col10;
        double col11;
        double col12;
        double col13;
        NSString * col14;
        NSString * col15;
        NSString * col16;
        NSString * col17;
        double col18;
        double col19;
        double col20;
        double col21;
        for (int i=0; i<wpGYIRidersCode.count; i++) {
            
            AnnualPremium = [[NSMutableArray alloc] init ];
            GuaranteeYearlyIncomeAccumulate = [[NSMutableArray alloc] init ];
            GuaranteeYearlyIncomePayout = [[NSMutableArray alloc] init ];
            GuaranteeYearlyIncomeTotal  = [[NSMutableArray alloc] init ];
            GuaranteeYearlyIncomeTotal2  = [[NSMutableArray alloc] init ];
            SurrenderRates = [[NSMutableArray alloc] init ];
            SurrenderValue = [[NSMutableArray alloc] init ];
            DBRates = [[NSMutableArray alloc] init ];
            DBValue = [[NSMutableArray alloc] init ];
            aValue = [[NSMutableArray alloc] init ];
            aValueEnd = [[NSMutableArray alloc] init ];
            CurrentCashDividendRatesA = [[NSMutableArray alloc] init ];
            CurrentCashDividendValueA = [[NSMutableArray alloc] init ];
            CurrentCashDividendRatesB = [[NSMutableArray alloc] init ];
            CurrentCashDividendValueB = [[NSMutableArray alloc] init ];
            AccuCashDividendValueA = [[NSMutableArray alloc] init ];
            AccuCashDividendValueB = [[NSMutableArray alloc] init ];
            AccuYearlyIncomeValueA = [[NSMutableArray alloc] init ];
            AccuYearlyIncomeValueB = [[NSMutableArray alloc] init ];
            tDividendRatesA = [[NSMutableArray alloc] init ];
            tDividendValueA = [[NSMutableArray alloc] init ];
            tDividendRatesB = [[NSMutableArray alloc] init ];
            tDividendValueB = [[NSMutableArray alloc] init ];
            speRatesA = [[NSMutableArray alloc] init ];
            speValueA = [[NSMutableArray alloc] init ];
            speRatesB = [[NSMutableArray alloc] init ];
            speValueB = [[NSMutableArray alloc] init ];
            TotalNonGuaranteedSurrenderValueA = [[NSMutableArray alloc] init ];
            TotalNonGuaranteedSurrenderValueB = [[NSMutableArray alloc] init ];
            TotalDBValueA = [[NSMutableArray alloc] init ];
            TotalDBValueB = [[NSMutableArray alloc] init ];
            
            wpRiderCode = [wpGYIRidersCode objectAtIndex:i];
            dRiderSA = [[wpGYIRidersSA objectAtIndex:i] doubleValue ];
            iTerm = [[wpGYIRidersTerm objectAtIndex:i] intValue ];
            
            inputAge = 0;
            
            if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                //------- surrender value
                QuerySQL = [NSString stringWithFormat: @"Select \"rate\" from SI_Trad_Rider_HLAWP_CSV where  "
                            "\"planoption\" = \"%@\" AND \"PremPayOpt\" = \"%d\" AND \"Age\" = \"%d\" ORDER by \"polyear\" asc ", wpRiderCode, premiumPaymentOption, Age];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [SurrenderRates addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    }
                    sqlite3_finalize(statement);
                }
                else {
                    NSLog(@"!!! SQL ERROR Under InsertToSI_Temp_Trad_Rider_WP_GYI");
                }
                
                
                
                //-------  cash dividend high
                QuerySQL = [NSString stringWithFormat: @"Select rate from SI_Trad_Rider_HLAWP_CD where  "
                            "planoption = \"%@\" AND PremPayOpt = \"%d\" AND Type = \"H\" AND Term = '%d' ORDER by polyear asc ", wpRiderCode, premiumPaymentOption, iTerm];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [CurrentCashDividendRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    }
                    sqlite3_finalize(statement);
                }else {
                    NSLog(@"!!! SQL ERROR Under InsertToSI_Temp_Trad_Rider_WP_GYI");
                }
                
                //-------  cash dividend low
                QuerySQL = [NSString stringWithFormat: @"Select rate from SI_Trad_Rider_HLAWP_CD where  "
                            "planoption = \"%@\" AND PremPayOpt = \"%d\" AND Type = \"L\" AND Term = '%d' ORDER by polyear asc ", wpRiderCode, premiumPaymentOption, iTerm];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [CurrentCashDividendRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    }
                    sqlite3_finalize(statement);
                }else {
                    NSLog(@"!!! SQL ERROR Under InsertToSI_Temp_Trad_Rider_WP_GYI");
                }
                
                //------TD high
                QuerySQL = [NSString stringWithFormat: @"Select rate from SI_Trad_Rider_HLAWP_TD where  "
                            "planoption = \"%@\" AND PremPayOpt = \"%d\" AND Age = \"%d\" AND Term = '%d' AND Type = \"H\" ORDER by polyear asc ", wpRiderCode, premiumPaymentOption, Age, iTerm];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [tDividendRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    }
                    sqlite3_finalize(statement);
                }else {
                    NSLog(@"!!! SQL ERROR Under InsertToSI_Temp_Trad_Rider_WP_GYI");
                }
                
                //------TD low
                QuerySQL = [NSString stringWithFormat: @"Select rate from SI_Trad_Rider_HLAWP_TD where  "
                            "planoption = \"%@\" AND PremPayOpt = \"%d\" AND Age = \"%d\" AND Term = '%d' AND Type = \"L\" ORDER by polyear asc ", wpRiderCode, premiumPaymentOption, Age, iTerm];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [tDividendRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    }
                    sqlite3_finalize(statement);
                }else {
                    NSLog(@"!!! SQL ERROR Under InsertToSI_Temp_Trad_Rider_WP_GYI");
                }
                
                //------spe high
                QuerySQL = [NSString stringWithFormat: @"Select rate from SI_Trad_Rider_HLAWP_SpeTD where  "
                            "planoption = \"%@\" AND PremPayOpt = \"%d\" AND Age = \"%d\" AND Term = '%d' AND Type = \"H\" ORDER by polyear asc ", wpRiderCode, premiumPaymentOption, Age, iTerm];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [speRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    }
                    sqlite3_finalize(statement);
                }else {
                    NSLog(@"!!! SQL ERROR Under InsertToSI_Temp_Trad_Rider_WP_GYI");
                }
                
                //------spe low
                QuerySQL = [NSString stringWithFormat: @"Select rate from SI_Trad_Rider_HLAWP_SpeTD where  "
                            "planoption = \"%@\" AND PremPayOpt = \"%d\" AND Age = \"%d\" AND Term = '%d' AND Type = \"L\" ORDER by polyear asc ", wpRiderCode, premiumPaymentOption, Age, iTerm];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [speRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    }
                    sqlite3_finalize(statement);
                }else {
                    NSLog(@"!!! SQL ERROR Under InsertToSI_Temp_Trad_Rider_WP_GYI");
                }
                sqlite3_close(contactDB);
                
            }
            
            NSLog(@"getting rates for csv done");
            
            if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                //------- DB
                QuerySQL = [NSString stringWithFormat: @"Select rate from SI_Trad_Rider_HLAWP_DB where  "
                            "planoption = \"%@\" AND PremPayOpt = \"%d\" AND Age = \"%d\" AND Term = '%d' ORDER by polyear asc ", wpRiderCode, premiumPaymentOption, Age, iTerm];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    while (sqlite3_step(statement) == SQLITE_ROW) {
                        [DBRates addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    }
                    
                    sqlite3_finalize(statement);
                }else {
                    NSLog(@"!!! SQL ERROR Under InsertToSI_Temp_Trad_Rider_WP_GYI");
                }
                
                sqlite3_close(contactDB);
            }
            
            dGuaranteeYearlyIncomeTotal2 = 0.00;
            actualPremium = 0.00;
            
            tempHLValue = 0.00;
            
            dTotalSurrenderValueA = 0.00;
            dTotalSurrenderValueB = 0.00;
            dDBValueA = 0.00;
            dDbValueB = 0.00;
            for (int j =1; j <=iTerm; j++) {
                tempRiderSA = [[wpGYIRidersSA objectAtIndex:i] doubleValue];
                tempHL1KSA = [wpGYIRiderHL1kSA objectAtIndex:i];
                tempHL1KSATerm = [wpGYIRiderHL1kSATerm objectAtIndex:i];
                tempTempHL = [wpGYIRiderTempHL objectAtIndex:i];
                tempTempHLTerm = [wpGYIRiderTempHLTerm objectAtIndex:i];
                tempPrem = [[wpGYIRidersPremAnnual objectAtIndex:i ] stringByReplacingOccurrencesOfString:@"," withString:@""];
                tempPremWithoutHLoading = [[wpGYIRidersPremAnnualWithoutHLoading objectAtIndex:i ] stringByReplacingOccurrencesOfString:@"," withString:@""];
                
                if (j <= premiumPaymentOption ) {
                    tempHLValue = 0.00;
                    
                    if (![tempHL1KSA isEqualToString:@"(null)"]) {
                        if(j <= [tempHL1KSATerm intValue ]){
                            tempHLValue = [tempHL1KSA doubleValue] * tempRiderSA/1000;
                        }
                    }
                    
                    if (![tempTempHL isEqualToString:@"(null)"]) {
                        if (j <= [tempTempHLTerm intValue ]) {
                            tempHLValue = tempHLValue + [tempTempHL doubleValue] * tempRiderSA/1000;
                        }
                    }
                    
                    if ([[OccLoading objectAtIndex:0] doubleValue] != 0) {
                        tempHLValue = tempHLValue + [[OccLoading objectAtIndex:0] doubleValue] * 20 * (tempRiderSA/1000.00);
                    }
                    
                    if ([tempTempHLTerm intValue] == 0 && [tempHL1KSATerm intValue] == 0) {
                        actualPremium = [tempPrem doubleValue];
                    }
                    else{
                        actualPremium = [tempPremWithoutHLoading doubleValue] + [[formatter stringFromNumber:[NSNumber numberWithDouble:tempHLValue]] doubleValue];
                    }
                    
                    
                    [AnnualPremium addObject:[NSString stringWithFormat:@"%.2f", actualPremium ]];
                }
                else {
                    [AnnualPremium addObject:@"0.00"];
                }
                
                EntireTotalPremiumPaid = EntireTotalPremiumPaid +
                [[[AnnualPremium objectAtIndex:j-1 ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                
                TotalPremiumBasicANDIncomeRider = TotalPremiumBasicANDIncomeRider +
                [[[AnnualPremium objectAtIndex:j-1 ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                
                
                if ([wpRiderCode isEqualToString:@"WB30R"] || [wpRiderCode isEqualToString:@"WB50R"]) {
                    [GuaranteeYearlyIncomeAccumulate addObject:[NSString stringWithFormat:@"%.5f", PartialAcc/100.00 * dRiderSA ]];
                    [GuaranteeYearlyIncomePayout addObject:[NSString stringWithFormat:@"%.5f", PartialPayout/100.00 * dRiderSA ]];
                    [GuaranteeYearlyIncomeTotal addObject:[NSString stringWithFormat:@"%.5f", 100/100 * dRiderSA ]];
                }
                else if([wpRiderCode isEqualToString:@"WBI6R30"]){
                    if (j > 6 ) {
                        [GuaranteeYearlyIncomeAccumulate addObject:[NSString stringWithFormat:@"%.5f", PartialAcc/100.00 * (dRiderSA * 6)]];
                        [GuaranteeYearlyIncomePayout addObject:[NSString stringWithFormat:@"%.5f", PartialPayout/100.00 * (dRiderSA * 6)]];
                        [GuaranteeYearlyIncomeTotal addObject:[NSString stringWithFormat:@"%.5f", 100/100 * (dRiderSA * 6) ]];
                    }
                    else{
                        [GuaranteeYearlyIncomeAccumulate addObject:[NSString stringWithFormat:@"%.5f", PartialAcc/100.00 * (dRiderSA * j)]];
                        [GuaranteeYearlyIncomePayout addObject:[NSString stringWithFormat:@"%.5f", PartialPayout/100.00 * (dRiderSA * j)]];
                        [GuaranteeYearlyIncomeTotal addObject:[NSString stringWithFormat:@"%.5f", 100/100 * (dRiderSA * j) ]];
                    }
                }
                else if([wpRiderCode isEqualToString:@"WBD10R30"]){
                    if (j > 10 ) {
                        [GuaranteeYearlyIncomeAccumulate addObject:[NSString stringWithFormat:@"%.5f", PartialAcc/100.00 * dRiderSA ]];
                        [GuaranteeYearlyIncomePayout addObject:[NSString stringWithFormat:@"%.5f", PartialPayout/100.00 * dRiderSA ]];
                        [GuaranteeYearlyIncomeTotal addObject:[NSString stringWithFormat:@"%.5f", 100/100 * dRiderSA ]];
                    }
                    else{
                        [GuaranteeYearlyIncomeAccumulate addObject:[NSString stringWithFormat:@"0.00"]];
                        [GuaranteeYearlyIncomePayout addObject:[NSString stringWithFormat:@"0.00" ]];
                        [GuaranteeYearlyIncomeTotal addObject:[NSString stringWithFormat:@"0.00"]];
                    }
                    
                }
                else if([wpRiderCode isEqualToString:@"EDUWR"]){
                    if (j + Age >= 18 ) {
                        [GuaranteeYearlyIncomeAccumulate addObject:[NSString stringWithFormat:@"%.5f", PartialAcc/100.00 * dRiderSA ]];
                        [GuaranteeYearlyIncomePayout addObject:[NSString stringWithFormat:@"%.5f", PartialPayout/100.00 * dRiderSA ]];
                        [GuaranteeYearlyIncomeTotal addObject:[NSString stringWithFormat:@"%.5f", 100/100 * dRiderSA ]];
                    }
                    else{
                        [GuaranteeYearlyIncomeAccumulate addObject:[NSString stringWithFormat:@"0.00"]];
                        [GuaranteeYearlyIncomePayout addObject:[NSString stringWithFormat:@"0.00" ]];
                        [GuaranteeYearlyIncomeTotal addObject:[NSString stringWithFormat:@"0.00"]];
                    }
                    
                }
                
                dGuaranteeYearlyIncomeTotal2 = dGuaranteeYearlyIncomeTotal2 + [[GuaranteeYearlyIncomeAccumulate objectAtIndex:j-1 ] doubleValue ];
                [GuaranteeYearlyIncomeTotal2 addObject:[NSString stringWithFormat:@"%.5f", dGuaranteeYearlyIncomeTotal2 ]];
                
                EntireTotalYearlyIncome = EntireTotalYearlyIncome + [[GuaranteeYearlyIncomeTotal objectAtIndex:j-1 ] doubleValue ];
                
                //-----Surrender Value -------
                if (j > iTerm) {
                    [SurrenderValue addObject: [NSString stringWithFormat:@"0.00"]];
                }
                else{
                    [SurrenderValue addObject: [NSString stringWithFormat:@"%.9f",
                                                [[SurrenderRates objectAtIndex:j-1] doubleValue ] * dRiderSA/1000.00 ]];
                }
                
                
                //----- DB    ----------------
                if (j > iTerm) {
                    [DBValue addObject:@"0.00"];
                }
                else{
                    [DBValue addObject:[NSString stringWithFormat:@"%.3f", [[DBRates objectAtIndex:j-1] doubleValue]/100.00 * dRiderSA ]];
                }
                
                //------ current year dividend
                [CurrentCashDividendValueA addObject:[NSString stringWithFormat:@"%.8f",
                                                      [[CurrentCashDividendRatesA objectAtIndex:j-1] doubleValue ]/100.00 * dRiderSA ]];
                [CurrentCashDividendValueB addObject:[NSString stringWithFormat:@"%.9f",
                                                      [[CurrentCashDividendRatesB objectAtIndex:j-1] doubleValue ]/100.00 * dRiderSA ]];
                // --- accu cash dividend
                if ([CashDividend isEqualToString:@"ACC"]) {
                    if (j == 1) {
                        [AccuCashDividendValueA addObject:[CurrentCashDividendValueA objectAtIndex:j-1]];
                        [AccuCashDividendValueB addObject:[CurrentCashDividendValueB objectAtIndex:j-1]];
                    }
                    else {
                        [AccuCashDividendValueA addObject: [NSString stringWithFormat:@"%.8f",
                                                            [[CurrentCashDividendValueA objectAtIndex:j-1] doubleValue ] +
                                                            [[AccuCashDividendValueA objectAtIndex:j - 2] doubleValue ] * (1 + 0.0525) ]];
                        [AccuCashDividendValueB addObject: [NSString stringWithFormat:@"%.9f",
                                                            [[CurrentCashDividendValueB objectAtIndex:j-1] doubleValue ] +
                                                            [[AccuCashDividendValueB objectAtIndex:j - 2] doubleValue ] * (1 + 0.0325) ]];
                    }
                }
                else {
                    [AccuCashDividendValueA addObject:@"-" ];
                    [AccuCashDividendValueB addObject:@"-" ];
                }
                
                
                // --- accu yearly income
                if ([YearlyIncome isEqualToString:@"ACC"]) {
                    
                    
                    if (j == 1) {
                        [AccuYearlyIncomeValueA addObject:[GuaranteeYearlyIncomeAccumulate objectAtIndex:j-1]];
                        [AccuYearlyIncomeValueB addObject:[GuaranteeYearlyIncomeAccumulate objectAtIndex:j-1]];
                    }
                    else {
                        [AccuYearlyIncomeValueA addObject: [NSString stringWithFormat:@"%.8f",
                                                            [[GuaranteeYearlyIncomeAccumulate objectAtIndex:j-1] doubleValue ] +
                                                            [[AccuYearlyIncomeValueA objectAtIndex:j - 2] doubleValue ] * (1 + 0.0525) ]];
                        [AccuYearlyIncomeValueB addObject: [NSString stringWithFormat:@"%.9f",
                                                            [[GuaranteeYearlyIncomeAccumulate objectAtIndex:j-1] doubleValue ] +
                                                            [[AccuYearlyIncomeValueB objectAtIndex:j - 2] doubleValue ] * (1 + 0.0325) ]];
                    }
                    
                }
                else {
                    [AccuYearlyIncomeValueA addObject:@"-" ];
                    [AccuYearlyIncomeValueB addObject:@"-" ];
                }
                
                // ---- TD
                if (j >  iTerm) {
                    [tDividendValueA addObject:@"0.00"];
                    [tDividendValueB addObject:@"0.00"];
                }
                else{
                    [tDividendValueA addObject:[NSString stringWithFormat:@"%.8f", [[tDividendRatesA objectAtIndex:j-1] doubleValue ] * dRiderSA/100.00 ]];
                    [tDividendValueB addObject:[NSString stringWithFormat:@"%.9f", [[tDividendRatesB objectAtIndex:j-1] doubleValue ] * dRiderSA/100.00 ]];
                }
                
                
                // --- spe
                
                [speValueA addObject:[NSString stringWithFormat:@"%.3f", [[speRatesA objectAtIndex:j-1] doubleValue ] * dRiderSA/100.00 ]];
                [speValueB addObject:[NSString stringWithFormat:@"%.3f", [[speRatesB objectAtIndex:j-1] doubleValue ] * dRiderSA/100.00 ]];
                
                // --- Total non guaranteed Surrender value
                dTotalSurrenderValueA = 0.00;
                dTotalSurrenderValueB = 0.00;
                
                if (j > iTerm) {
                    
                    if ([wpRiderCode isEqualToString:@"ID20R"] || [wpRiderCode isEqualToString:@"ID30R"] || [wpRiderCode isEqualToString:@"ID40R"] ) {
                        if (j == 1) {
                            dTotalSurrenderValueA = 0.00;
                            dTotalSurrenderValueB = 0.00;
                        }
                    }
                    else {
                        if ([CashDividend isEqualToString:@"ACC"] ) {
                            dTotalSurrenderValueA = 0.00 + [[AccuYearlyIncomeValueA objectAtIndex:j-1] doubleValue ] + [[AccuCashDividendValueA objectAtIndex:j-1] doubleValue ] + 0.00;
                            
                            dTotalSurrenderValueB = 0.00 + [[AccuYearlyIncomeValueB objectAtIndex:j-1] doubleValue ] + [[AccuCashDividendValueB objectAtIndex:j-1] doubleValue ] + 0.00;
                        }
                        else if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) {
                            dTotalSurrenderValueA = [[AccuYearlyIncomeValueA objectAtIndex:j-1] doubleValue ];
                            dTotalSurrenderValueB = [[AccuYearlyIncomeValueB objectAtIndex:j-1] doubleValue ];
                        }
                        else if (![CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"] ) {
                            dTotalSurrenderValueA =  [[SurrenderValue objectAtIndex:j-1] doubleValue ] +
                            [[tDividendValueA objectAtIndex:j-1] doubleValue ];
                            dTotalSurrenderValueB =  [[SurrenderValue objectAtIndex:j-1] doubleValue ] +
                            [[tDividendValueB objectAtIndex:j-1] doubleValue ];
                            
                        }
                    }
                    
                }
                else {
                    if ([CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) { //CD : ACC, GYI : ACC
                        dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:j-1]doubleValue ] +
                        [[AccuYearlyIncomeValueA objectAtIndex:j-1] doubleValue ] +
                        [[AccuCashDividendValueA objectAtIndex:j-1] doubleValue ] +
                        [[tDividendValueA objectAtIndex:j-1] doubleValue ];
                        
                        dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:j-1]doubleValue ] +
                        [[AccuYearlyIncomeValueB objectAtIndex:j-1] doubleValue ] +
                        [[AccuCashDividendValueB objectAtIndex:j-1] doubleValue ] +
                        [[tDividendValueB objectAtIndex:j-1] doubleValue ];
                    }
                    else if ([CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) { //CD : ACC, GYI : payout
                        dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:j-1]doubleValue ] +
                        [[AccuCashDividendValueA objectAtIndex:j-1] doubleValue ] +
                        [[tDividendValueA objectAtIndex:j-1] doubleValue ];
                        
                        dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:j-1]doubleValue ] +
                        [[AccuCashDividendValueB objectAtIndex:j-1] doubleValue ] +
                        [[tDividendValueB objectAtIndex:j-1] doubleValue ];
                    }
                    else if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) { //CD : Payout, GYI : ACC
                        dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:j-1]doubleValue ] +
                        [[AccuYearlyIncomeValueA objectAtIndex:j-1] doubleValue ] +
                        [[tDividendValueA objectAtIndex:j-1] doubleValue ];
                        
                        dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:j-1]doubleValue ] +
                        [[AccuYearlyIncomeValueB objectAtIndex:j-1] doubleValue ] +
                        [[tDividendValueB objectAtIndex:j-1] doubleValue ];
                    }
                    else { //CD : payout, GYI : payout
                        dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:j-1]doubleValue ] +
                        [[tDividendValueA objectAtIndex:j-1] doubleValue ];
                        
                        dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:j-1]doubleValue ] +
                        [[tDividendValueB objectAtIndex:j-1] doubleValue ];
                    }
                }
                [TotalNonGuaranteedSurrenderValueA addObject: [NSString stringWithFormat: @"%.8f", dTotalSurrenderValueA ] ];
                [TotalNonGuaranteedSurrenderValueB addObject: [NSString stringWithFormat: @"%.9f", dTotalSurrenderValueB ] ];
                
                // --- Total non guarantee Db value
                dDBValueA = 0.00;
                dDbValueB = 0.00;
                
                if (j > iTerm) {
                    
                    if ([wpRiderCode isEqualToString:@"I20R"] || [wpRiderCode isEqualToString:@"I30R"] || [wpRiderCode isEqualToString:@"I40R"]
                        || [wpRiderCode isEqualToString:@"IE20R"] || [wpRiderCode isEqualToString:@"IE30R"]  ) {
                        
                        if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) {
                            dDBValueA = [[AccuYearlyIncomeValueA objectAtIndex:j-1] doubleValue ];
                            dDbValueB = [[AccuYearlyIncomeValueB objectAtIndex:j-1] doubleValue ];
                            
                        }
                    }
                    else {
                        dDBValueA = [[TotalNonGuaranteedSurrenderValueA objectAtIndex:j-1] doubleValue ];
                        dDbValueB = [[TotalNonGuaranteedSurrenderValueB objectAtIndex:j-1] doubleValue ];
                        
                    }
                    
                    
                }
                else {
                    if ([CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) { //CD : ACC, GYI : ACC
                        dDBValueA = [[DBValue objectAtIndex:j-1] doubleValue ] +
                        [[AccuCashDividendValueA objectAtIndex:j-1] doubleValue ] +
                        [[AccuYearlyIncomeValueA objectAtIndex:j-1] doubleValue ] +
                        [[speValueA objectAtIndex:j-1] doubleValue ];
                        
                        dDbValueB = [[DBValue objectAtIndex:j-1] doubleValue ] +
                        [[AccuCashDividendValueB objectAtIndex:j-1] doubleValue ] +
                        [[AccuYearlyIncomeValueB objectAtIndex:j-1] doubleValue ] +
                        [[speValueB objectAtIndex:j-1] doubleValue ];
                    }
                    else if ([CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) {//CD : ACC, GYI : payout
                        dDBValueA = [[DBValue objectAtIndex:j-1] doubleValue ] +
                        [[AccuCashDividendValueA objectAtIndex:j-1] doubleValue ] +
                        [[speValueA objectAtIndex:j-1] doubleValue ];
                        
                        dDbValueB = [[DBValue objectAtIndex:j-1] doubleValue ] +
                        [[AccuCashDividendValueB objectAtIndex:j-1] doubleValue ] +
                        [[speValueB objectAtIndex:j-1] doubleValue ];
                    }
                    else if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) { //CD : payout, GYI : ACC
                        dDBValueA = [[DBValue objectAtIndex:j-1] doubleValue ] +
                        [[AccuYearlyIncomeValueA objectAtIndex:j-1] doubleValue ] +
                        [[speValueA objectAtIndex:j-1] doubleValue ];
                        
                        dDbValueB = [[DBValue objectAtIndex:j-1] doubleValue ] +
                        [[AccuYearlyIncomeValueB objectAtIndex:j-1] doubleValue ] +
                        [[speValueB objectAtIndex:j-1] doubleValue ];
                    }
                    else { //CD : payout, GYI : payout
                        dDBValueA = [[DBValue objectAtIndex:j-1] doubleValue ] +
                        [[speValueA objectAtIndex:j-1] doubleValue ];
                        
                        dDbValueB = [[DBValue objectAtIndex:j-1] doubleValue ] +
                        [[speValueB objectAtIndex:j-1] doubleValue ];
                    }
                }
                
                [TotalDBValueA addObject:[NSString stringWithFormat:@"%.3f", dDBValueA]];
                [TotalDBValueB addObject:[NSString stringWithFormat:@"%.3f", dDbValueB]];
            }
            
            NSLog(@"WP rider table done");
            
            for (int k=0; k < PolicyTerm; k++) { //policyterm = basic policy term
                
                if (k < iTerm) { //iTerm refers to Riders term
                    tempTotalPremiumPaid = [[SummaryTotalPremiumPaid objectAtIndex:k] doubleValue ];
                    tempTotalPremiumPaid = tempTotalPremiumPaid + [[AnnualPremium objectAtIndex:k] doubleValue ];
                    
                    tempValueGYI = [[SummaryGuaranteedTotalGYI objectAtIndex:k] doubleValue ];
                    tempValueGYI = tempValueGYI + [[GuaranteeYearlyIncomeAccumulate objectAtIndex:k] doubleValue ];
                    
                    tempValueGYIPayout = [[SummaryTotalPayoutOption objectAtIndex:k] doubleValue ];
                    tempValueGYIPayout = tempValueGYIPayout + [[GuaranteeYearlyIncomePayout objectAtIndex:k] doubleValue ];
                    
                    tempValueGYITotal = [[SummaryTotalPayoutAndAccumulate objectAtIndex:k] doubleValue ];
                    tempValueGYITotal = tempValueGYITotal + [[GuaranteeYearlyIncomeTotal objectAtIndex:k] doubleValue ];
                    
                    tempValueGYIWithoutInterest = [[SummaryTotalAccumulateWithoutInterest objectAtIndex:k] doubleValue ];
                    tempValueGYIWithoutInterest = tempValueGYIWithoutInterest + [[GuaranteeYearlyIncomeTotal2 objectAtIndex:k] doubleValue ];
                    
                    tempSurrenderValue = [[SummaryGuaranteedSurrenderValue objectAtIndex:k] doubleValue ];
                    tempSurrenderValue = tempSurrenderValue + [[SurrenderValue objectAtIndex:k] doubleValue ];
                    
                    tempGuaranteeDBValue = [[SummaryGuaranteedDBValueA objectAtIndex:k] doubleValue ];
                    tempGuaranteeDBValue = tempGuaranteeDBValue + [[DBValue objectAtIndex:k] doubleValue ];
                    
                    tempCurrentCashDividendA = [[SummaryNonGuaranteedCurrentCashDividendA objectAtIndex:k] doubleValue ];
                    tempCurrentCashDividendA = tempCurrentCashDividendA + [[CurrentCashDividendValueA objectAtIndex:k] doubleValue ];
                    
                    tempCurrentCashDividendB = [[SummaryNonGuaranteedCurrentCashDividendB objectAtIndex:k] doubleValue ];
                    tempCurrentCashDividendB = tempCurrentCashDividendB + [[CurrentCashDividendValueB objectAtIndex:k] doubleValue ];
                    
                    if ([CashDividend isEqualToString:@"ACC" ]) {
                        tempCashDividendA = [[SummaryNonGuaranteedAccuCashDividendA objectAtIndex:k] doubleValue ];
                        tempCashDividendA = tempCashDividendA + [[AccuCashDividendValueA objectAtIndex:k] doubleValue ];
                        
                        tempCashDividendB = [[SummaryNonGuaranteedAccuCashDividendB objectAtIndex:k] doubleValue ];
                        tempCashDividendB = tempCashDividendB + [[AccuCashDividendValueB objectAtIndex:k] doubleValue ];
                    }
                    
                    if ([YearlyIncome isEqualToString:@"ACC" ]) {
                        tempYearlyIncomeA = [[SummaryNonGuaranteedAccuYearlyIncomeA objectAtIndex:k] doubleValue ];
                        tempYearlyIncomeA = tempYearlyIncomeA + [[AccuYearlyIncomeValueA objectAtIndex:k] doubleValue ];
                        
                        tempYearlyincomeB = [[SummaryNonGuaranteedAccuYearlyIncomeB objectAtIndex:k] doubleValue ];
                        tempYearlyincomeB = tempYearlyincomeB + [[AccuYearlyIncomeValueB objectAtIndex:k] doubleValue ];
                    }
                    
                    tempTotalNonGuaranteedSurrenderA = [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedSurrenderA = tempTotalNonGuaranteedSurrenderA + [[TotalNonGuaranteedSurrenderValueA objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedSurrenderB = [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedSurrenderB = tempTotalNonGuaranteedSurrenderB + [[TotalNonGuaranteedSurrenderValueB objectAtIndex:k] doubleValue ];
                    
                    tempTotalDbA = [[SummaryNonGuaranteedDBValueA objectAtIndex:k] doubleValue ];
                    tempTotalDbA = tempTotalDbA + [[TotalDBValueA objectAtIndex:k] doubleValue ];
                    
                    tempTotalDbB = [[SummaryNonGuaranteedDBValueB objectAtIndex:k] doubleValue ];
                    tempTotalDbB = tempTotalDbB + [[TotalDBValueB objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedTDivA = [[SummaryNonGuaranteedTotalTDivA objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedTDivA = tempTotalNonGuaranteedTDivA + [[tDividendValueA objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedTDivB = [[SummaryNonGuaranteedTotalTDivB objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedTDivB = tempTotalNonGuaranteedTDivB + [[tDividendValueB objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedSpeA = [[SummaryNonGuaranteedTotalSpeA objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedSpeA = tempTotalNonGuaranteedSpeA + [[speValueA objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedSpeB = [[SummaryNonGuaranteedTotalSpeB objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedSpeB = tempTotalNonGuaranteedSpeB + [[speValueB objectAtIndex:k] doubleValue ];
                }
                else { //basic term policy year is more than rider policy year
                    
                    [GuaranteeYearlyIncomeAccumulate addObject:[NSString stringWithFormat:@"0.00" ]];
                    [GuaranteeYearlyIncomeTotal addObject:[NSString stringWithFormat:@"0.00"]];
                    [GuaranteeYearlyIncomePayout addObject:[NSString stringWithFormat:@"0.00"]];
                    
                    dGuaranteeYearlyIncomeTotal2 = dGuaranteeYearlyIncomeTotal2 + [[GuaranteeYearlyIncomeAccumulate objectAtIndex:k ] doubleValue ];
                    [GuaranteeYearlyIncomeTotal2 addObject:[NSString stringWithFormat:@"%.2f", dGuaranteeYearlyIncomeTotal2 ]];
                    
                    //
                    tempValueGYIPayout = [[SummaryTotalPayoutOption objectAtIndex:k] doubleValue ];
                    tempValueGYIPayout = tempValueGYIPayout + [[GuaranteeYearlyIncomePayout objectAtIndex:k] doubleValue ];
                    
                    tempValueGYI = [[SummaryGuaranteedTotalGYI objectAtIndex:k] doubleValue ];
                    tempValueGYI = tempValueGYI + [[GuaranteeYearlyIncomeAccumulate objectAtIndex:k] doubleValue ];
                    
                    tempValueGYITotal = [[SummaryTotalPayoutAndAccumulate objectAtIndex:k] doubleValue ];
                    tempValueGYITotal = tempValueGYITotal + [[GuaranteeYearlyIncomeTotal objectAtIndex:k] doubleValue ];
                    
                    tempValueGYIWithoutInterest = [[SummaryTotalAccumulateWithoutInterest objectAtIndex:k] doubleValue ];
                    tempValueGYIWithoutInterest = tempValueGYIWithoutInterest + [[GuaranteeYearlyIncomeTotal2 objectAtIndex:k] doubleValue ];
                    
                    
                    // --- surrender value -----
                    [SurrenderValue addObject: @"0.00"];
                    [CurrentCashDividendValueA addObject:@"0.00"];
                    [CurrentCashDividendValueB addObject:@"0.00"];
                    
                    tempSurrenderValue = [[SummaryGuaranteedSurrenderValue objectAtIndex:k] doubleValue ];
                    tempSurrenderValue = tempSurrenderValue + [[SurrenderValue objectAtIndex:k] doubleValue ];
                    //----- end --------
                    
                    tempGuaranteeDBValue = [[SummaryGuaranteedDBValueA objectAtIndex:k] doubleValue ];
                    tempGuaranteeDBValue =  tempGuaranteeDBValue + 0.00;
                    
                    tempCurrentCashDividendA = [[SummaryNonGuaranteedCurrentCashDividendA objectAtIndex:k] doubleValue ];
                    tempCurrentCashDividendA = tempCurrentCashDividendA + [[CurrentCashDividendValueA objectAtIndex:k] doubleValue ];
                    
                    tempCurrentCashDividendB = [[SummaryNonGuaranteedCurrentCashDividendB objectAtIndex:k] doubleValue ];
                    tempCurrentCashDividendB = tempCurrentCashDividendB + [[CurrentCashDividendValueB objectAtIndex:k] doubleValue ];
                    
                    if ([CashDividend isEqualToString:@"ACC" ]) {
                        
                        [AccuCashDividendValueA addObject: [NSString stringWithFormat:@"%.8f",
                                                            [[AccuCashDividendValueA objectAtIndex:k - 1] doubleValue ] * (1 + 0.0525) ]];
                        [AccuCashDividendValueB addObject: [NSString stringWithFormat:@"%.9f",
                                                            [[AccuCashDividendValueB objectAtIndex:k - 1] doubleValue ] * (1 + 0.0325) ]];
                        
                        tempCashDividendA = [[SummaryNonGuaranteedAccuCashDividendA objectAtIndex:k] doubleValue ];
                        tempCashDividendA = tempCashDividendA + [[AccuCashDividendValueA objectAtIndex:k] doubleValue ];
                        
                        tempCashDividendB = [[SummaryNonGuaranteedAccuCashDividendB objectAtIndex:k] doubleValue ];
                        tempCashDividendB = tempCashDividendB + [[AccuCashDividendValueB objectAtIndex:k] doubleValue ];
                    }
                    
                    
                    if ([YearlyIncome isEqualToString:@"ACC" ]) {
                        
                        [AccuYearlyIncomeValueA addObject: [NSString stringWithFormat:@"%.8f",
                                                            [[GuaranteeYearlyIncomeAccumulate objectAtIndex:k] doubleValue ] +
                                                            [[AccuYearlyIncomeValueA objectAtIndex:k - 1] doubleValue ] * (1 + 0.0525) ]];
                        [AccuYearlyIncomeValueB addObject: [NSString stringWithFormat:@"%.9f",
                                                            [[GuaranteeYearlyIncomeAccumulate objectAtIndex:k] doubleValue ] +
                                                            [[AccuYearlyIncomeValueB objectAtIndex:k - 1] doubleValue ] * (1 + 0.0325) ]];
                        
                        tempYearlyIncomeA = [[SummaryNonGuaranteedAccuYearlyIncomeA objectAtIndex:k] doubleValue ];
                        tempYearlyIncomeA = tempYearlyIncomeA + [[AccuYearlyIncomeValueA objectAtIndex:k] doubleValue ];
                        
                        tempYearlyincomeB = [[SummaryNonGuaranteedAccuYearlyIncomeB objectAtIndex:k] doubleValue ];
                        tempYearlyincomeB = tempYearlyincomeB + [[AccuYearlyIncomeValueB objectAtIndex:k] doubleValue ];
                    }
                    else{
                        [AccuYearlyIncomeValueA addObject: [NSString stringWithFormat:@"0.00"]];
                        [AccuYearlyIncomeValueB addObject: [NSString stringWithFormat:@"0.00"]];
                    }
                    
                    
                    // -------- continue to add remaining total surrender value after policy year > rider's term
                    dTotalSurrenderValueA = 0.0;
                    dTotalSurrenderValueB = 0.0;
                    
                    [tDividendValueA addObject:[NSString stringWithFormat:@"0.00"]];
                    [tDividendValueB addObject:[NSString stringWithFormat:@"0.00"]];
                    
                    [speValueA addObject:[NSString stringWithFormat:@"0.00"]];
                    [speValueB addObject:[NSString stringWithFormat:@"0.00"]];
                    
                    tempTotalNonGuaranteedTDivA = [[SummaryNonGuaranteedTotalTDivA objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedTDivA = tempTotalNonGuaranteedTDivA + [[tDividendValueA objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedTDivB = [[SummaryNonGuaranteedTotalTDivB objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedTDivB = tempTotalNonGuaranteedTDivB + [[tDividendValueB objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedSpeA = [[SummaryNonGuaranteedTotalSpeA objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedSpeA = tempTotalNonGuaranteedSpeA + [[speValueA objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedSpeB = [[SummaryNonGuaranteedTotalSpeB objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedSpeB = tempTotalNonGuaranteedSpeB + [[speValueB objectAtIndex:k] doubleValue ];
                    
                    if ([wpRiderCode isEqualToString:@"ID20R"] || [wpRiderCode isEqualToString:@"ID30R"] || [wpRiderCode isEqualToString:@"ID40R"] ) {
                        if (k == 0) {
                            dTotalSurrenderValueA = 0.00;
                            dTotalSurrenderValueB = 0.00;
                        }
                        else {
                            dTotalSurrenderValueA = [[TotalNonGuaranteedSurrenderValueA objectAtIndex:k-1] doubleValue ] * (1 + 0.055);
                            dTotalSurrenderValueB = [[TotalNonGuaranteedSurrenderValueB objectAtIndex:k-1] doubleValue ] * (1 + 0.035);
                            
                            
                            
                        }
                    }
                    else {
                        if ([CashDividend isEqualToString:@"ACC"] ) {
                            if (k == 0) {
                                dTotalSurrenderValueA = 0.00;
                                dTotalSurrenderValueB = 0.00;
                            }
                            else {
                                dTotalSurrenderValueA = 0.00 + [[AccuYearlyIncomeValueA objectAtIndex:k] doubleValue] + [[AccuCashDividendValueA  objectAtIndex:k] doubleValue] + 0.00;
                                dTotalSurrenderValueB = 0.00 + [[AccuYearlyIncomeValueB objectAtIndex:k] doubleValue] + [[AccuCashDividendValueB objectAtIndex:k] doubleValue]  + 0.00;
                            }
                        }
                        else if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) {
                            dTotalSurrenderValueA = 0.00 + [[AccuYearlyIncomeValueA objectAtIndex:k] doubleValue] + 0.00;
                            dTotalSurrenderValueB = 0.00 + [[AccuYearlyIncomeValueB objectAtIndex:k] doubleValue] + 0.00;
                            
                        }
                        else if (![CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"] ) {
                            dTotalSurrenderValueA =  [[SurrenderValue objectAtIndex:k] doubleValue ] +
                            [[tDividendValueA objectAtIndex:k] doubleValue ]; // both are 0.00 and 0.00
                            dTotalSurrenderValueB =  [[SurrenderValue objectAtIndex:k] doubleValue ] +
                            [[tDividendValueB objectAtIndex:k] doubleValue ]; // both are 0.00 and 0.00
                            
                        }
                        
                    }
                    [TotalNonGuaranteedSurrenderValueA addObject: [NSString stringWithFormat: @"%.8f", dTotalSurrenderValueA ] ];
                    [TotalNonGuaranteedSurrenderValueB addObject: [NSString stringWithFormat: @"%.9f", dTotalSurrenderValueB ] ];
                    
                    
                    tempTotalNonGuaranteedSurrenderA = [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedSurrenderA = tempTotalNonGuaranteedSurrenderA + [[TotalNonGuaranteedSurrenderValueA objectAtIndex:k] doubleValue ];
                    
                    tempTotalNonGuaranteedSurrenderB = [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:k] doubleValue ];
                    tempTotalNonGuaranteedSurrenderB = tempTotalNonGuaranteedSurrenderB  + [[TotalNonGuaranteedSurrenderValueB objectAtIndex:k] doubleValue ];
                    
                    //----- end ----
                    dDBValueA = 0.00;
                    dDbValueB = 0.00;
                    
                    if ([wpRiderCode isEqualToString:@"I20R"] || [wpRiderCode isEqualToString:@"I30R"] || [wpRiderCode isEqualToString:@"I40R"]
                        || [wpRiderCode isEqualToString:@"IE20R"] || [wpRiderCode isEqualToString:@"IE30R"]  ) {
                        
                        if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) {
                            dDBValueA = [[AccuYearlyIncomeValueA objectAtIndex:k] doubleValue ];
                            dDbValueB = [[AccuYearlyIncomeValueB objectAtIndex:k] doubleValue ];
                            
                        }
                        else {
                            dDBValueA = [[TotalNonGuaranteedSurrenderValueA objectAtIndex:k] doubleValue ];
                            dDbValueB = [[TotalNonGuaranteedSurrenderValueB objectAtIndex:k] doubleValue ];
                        }
                    }
                    else {
                        if ([CashDividend isEqualToString:@"ACC"] ) {
                            
                            dDBValueA = 0.00 + [[AccuYearlyIncomeValueA objectAtIndex:k] doubleValue] + [[AccuCashDividendValueA  objectAtIndex:k] doubleValue] + 0.00;
                            dDbValueB = 0.00 + [[AccuYearlyIncomeValueB objectAtIndex:k] doubleValue] + [[AccuCashDividendValueB objectAtIndex:k] doubleValue]  + 0.00;
                            
                        }
                        else if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) {
                            
                            dDBValueA = 0.00 + [[AccuYearlyIncomeValueA objectAtIndex:k] doubleValue] + 0.00;
                            dDbValueB = 0.00 + [[AccuYearlyIncomeValueB objectAtIndex:k] doubleValue] + 0.00;
                            
                        }
                        else if (![CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"] ) {
                            dDBValueA =  0.00;
                            dDbValueB =  0.00;
                            
                        }
                        
                    }
                    
                    [TotalDBValueA addObject:[NSString stringWithFormat:@"%.3f", dDBValueA]];
                    [TotalDBValueB addObject:[NSString stringWithFormat:@"%.3f", dDbValueB]];
                    
                    tempTotalDbA = [[SummaryNonGuaranteedDBValueA objectAtIndex:k] doubleValue ];
                    tempTotalDbA = tempTotalDbA + [[TotalDBValueA objectAtIndex:k] doubleValue ];
                    
                    tempTotalDbB = [[SummaryNonGuaranteedDBValueB objectAtIndex:k] doubleValue ];
                    tempTotalDbB = tempTotalDbB + [[TotalDBValueB objectAtIndex:k] doubleValue ];
                    
                }
                
                [SummaryTotalPremiumPaid replaceObjectAtIndex:k withObject: [NSString stringWithFormat:@"%.9f", tempTotalPremiumPaid]];
                
                [SummaryGuaranteedTotalGYI replaceObjectAtIndex:k withObject: [NSString stringWithFormat:@"%.9f", tempValueGYI]];
                [SummaryTotalPayoutOption replaceObjectAtIndex:k withObject: [NSString stringWithFormat:@"%.9f", tempValueGYIPayout]];
                [SummaryTotalPayoutAndAccumulate replaceObjectAtIndex:k withObject: [NSString stringWithFormat:@"%.9f", tempValueGYITotal]];
                [SummaryTotalAccumulateWithoutInterest replaceObjectAtIndex:k withObject: [NSString stringWithFormat:@"%.9f", tempValueGYIWithoutInterest]];
                
                [SummaryGuaranteedSurrenderValue replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.9f", tempSurrenderValue ]];
                [SummaryGuaranteedDBValueA replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.3f", tempGuaranteeDBValue ]];
                
                [SummaryNonGuaranteedCurrentCashDividendA replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.8f", tempCurrentCashDividendA ]];
                [SummaryNonGuaranteedCurrentCashDividendB replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.9f", tempCurrentCashDividendB ]];
                
                if ([CashDividend isEqualToString:@"ACC" ]) {
                    [SummaryNonGuaranteedAccuCashDividendA replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.8f", tempCashDividendA ]];
                    [SummaryNonGuaranteedAccuCashDividendB replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.9f", tempCashDividendB ]];
                    
                }
                
                if ([YearlyIncome isEqualToString:@"ACC" ]) {
                    [SummaryNonGuaranteedAccuYearlyIncomeA replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.8f", tempYearlyIncomeA ]];
                    [SummaryNonGuaranteedAccuYearlyIncomeB replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.9f", tempYearlyincomeB ]];
                    
                }
                
                [SummaryNonGuaranteedSurrenderValueA replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.8f", tempTotalNonGuaranteedSurrenderA ]];
                [SummaryNonGuaranteedSurrenderValueB replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.9f", tempTotalNonGuaranteedSurrenderB ]];
                [SummaryNonGuaranteedDBValueA replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.3f", tempTotalDbA ]];
                [SummaryNonGuaranteedDBValueB replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.3f", tempTotalDbB ]];
                
                [SummaryNonGuaranteedTotalTDivA replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.8f", tempTotalNonGuaranteedTDivA]];
                [SummaryNonGuaranteedTotalTDivB replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.9f", tempTotalNonGuaranteedTDivB ]];
                [SummaryNonGuaranteedTotalSpeA replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.3f", tempTotalNonGuaranteedSpeA ]];
                [SummaryNonGuaranteedTotalSpeB replaceObjectAtIndex:k withObject:[NSString stringWithFormat:@"%.3f", tempTotalNonGuaranteedSpeB ]];
                
                if (k == PolicyTerm - 1) {
                    //EntireTotalYearlyIncome = [[SummaryGuaranteedTotalGYI objectAtIndex:k ] doubleValue ];
                    EntireMaturityValueA = [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:k ] doubleValue ];
                    EntireMaturityValueB = [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:k ] doubleValue ];
                }
            }
            NSLog(@"WP GYI for summary calculation done");
            
            
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                strAccuCDA = @"";
                strAccuCDB = @"";
                strAccuYIA = @"";
                strAccuYIB = @"";
                
                for (int a= 1; a<=[[wpGYIRidersTerm objectAtIndex:i] intValue]; a++) {
                    
                    if (a <= 20 || (a > 20 && a % 5  == 0) || (a == [[wpGYIRidersTerm objectAtIndex:i] intValue] && a%5 != 0) ) {
                        
                        if (Age >= 0){
                            
                            inputAge = Age + a;
                            
                            strAccuCDA = @"";
                            strAccuCDB = @"";
                            strAccuYIA = @"";
                            strAccuYIB = @"";
                            
                            if ([CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"]) {
                                strAccuCDA = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueA objectAtIndex:a-1] doubleValue ])];
                                strAccuCDB = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueB objectAtIndex:a-1] doubleValue ])];
                                strAccuYIA = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueA objectAtIndex:a-1] doubleValue ])];
                                strAccuYIB = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueB objectAtIndex:a-1] doubleValue ])];
                            }
                            else if ([CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) {
                                strAccuCDA = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueA objectAtIndex:a-1] doubleValue ])];
                                strAccuCDB = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueB objectAtIndex:a-1] doubleValue ])];
                                strAccuYIA = [NSString stringWithFormat:@"-"];
                                strAccuYIB = [NSString stringWithFormat:@"-"];
                            }
                            else if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"]) {
                                strAccuCDA = [NSString stringWithFormat:@"-"];
                                strAccuCDB = [NSString stringWithFormat:@"-"];
                                strAccuYIA = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueA objectAtIndex:a-1] doubleValue ])];
                                strAccuYIB = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueB objectAtIndex:a-1] doubleValue ])];
                            }
                            else if (![CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) {
                                strAccuCDA = [NSString stringWithFormat:@"-"];
                                strAccuCDB = [NSString stringWithFormat:@"-"];
                                strAccuYIA = [NSString stringWithFormat:@"-"];
                                strAccuYIB = [NSString stringWithFormat:@"-"];
                            }
                            
                            col0_1 = a;
                            col0_2 = inputAge;
                            col1 = [AnnualPremium objectAtIndex:a - 1];
                            col2 = [self dblRoundToTwoDecimal:[[GuaranteeYearlyIncomePayout objectAtIndex:a-1] doubleValue]];
                            col3 = [self dblRoundToTwoDecimal:[[GuaranteeYearlyIncomeAccumulate objectAtIndex:a-1] doubleValue]];
                            col4 = [self dblRoundToTwoDecimal:[[GuaranteeYearlyIncomeTotal objectAtIndex:a-1] doubleValue]];
                            col5 = [self dblRoundToTwoDecimal:[[GuaranteeYearlyIncomeTotal2 objectAtIndex:a-1] doubleValue]];
                            col6 = round( [[SurrenderValue objectAtIndex:a-1] doubleValue ]);
                            col7 = round( [[DBValue objectAtIndex:a-1] doubleValue ]);
                            col8 = round([[TotalNonGuaranteedSurrenderValueA objectAtIndex:a-1] doubleValue ]);
                            col9 = round([[TotalNonGuaranteedSurrenderValueB objectAtIndex:a-1] doubleValue ]);
                            col10 = round([[TotalDBValueA objectAtIndex:a-1] doubleValue ]);
                            col11 = round([[TotalDBValueB objectAtIndex:a-1] doubleValue ]);
                            col12 = round([[CurrentCashDividendValueA objectAtIndex:a-1] doubleValue ]);
                            col13 = round([[CurrentCashDividendValueB objectAtIndex:a-1] doubleValue ]);
                            col14 = strAccuCDA;
                            col15 = strAccuCDB;
                            col16 = strAccuYIA;
                            col17 = strAccuYIB;
                            col18 = round([[tDividendValueA objectAtIndex:a-1] doubleValue ]);
                            col19 = round([[tDividendValueB objectAtIndex:a-1] doubleValue ]);
                            col20 = round([[speValueA objectAtIndex:a-1] doubleValue ]);
                            col21 = round([[speValueB objectAtIndex:a-1] doubleValue ]);
                            
                            QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_RideriLLus ( "
                                        "\"SINO\", \"SeqNo\",\"DataType\",\"DataType2\", \"PageNo\", "
                                        
                                        "\"col0_1\",\"col0_2\",\"col1\",\"col2\", \"col3\", "
                                        
                                        "\"col4\",\"col5\",\"col6\",\"col7\",\"col8\", "
                                        
                                        
                                        "\"col9\",\"col10\",\"col11\",\"col12\",\"col13\", "
                                        
                                        "\"col14\",\"col15\",\"col16\",\"col17\",\"col18\", "
                                        
                                        "\"col19\",\"col20\",\"col21\") "
                                        "VALUES ( "
                                        " \"%@\",\"%d\",\"%@\",\"%@\",\"%d\", "
                                        
                                        "\"%d\",\"%d\",\"%@\",\"%f\",\"%f\", "
                                        
                                        "\"%f\",\"%f\",\"%.0f\",\"%.0f\",\"%.0f\", "
                                        
                                        
                                        "\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", "
                                        "\"%@\",\"%@\",\"%@\",\"%@\",\"%.0f\", "
                                        "\"%.0f\",\"%.0f\",\"%.0f\")",
                                        SINo, a, [wpGYIRidersCode objectAtIndex:i], @"DATA", i,
                                        
                                        col0_1, col0_2, col1, col2,col3 ,
                                        
                                        col4,col5,col6,col7,col8,
                                        
                                        
                                        col9, col10, col11, col12, col13,
                                        
                                        col14, col15, col16, col17, col18,
                                        
                                        col19, col20, col21
                                        ];
                            
                            if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                if (sqlite3_step(statement) == SQLITE_DONE) {
                                    
                                }
                                sqlite3_finalize(statement);
                            }
                            
                            strAccuCDA = Nil;
                            strAccuCDB = Nil;
                            strAccuYIA = Nil;
                            strAccuYIB = Nil;
                            
                        }
                    }
                }
                sqlite3_close(contactDB);
            }
            
            
            AnnualPremium = Nil;
            GuaranteeYearlyIncomeAccumulate= Nil;
            SurrenderRates = Nil;
            SurrenderValue = Nil;
            DBRates = Nil;
            DBValue = Nil;
            aValue = Nil;
            aValueEnd = Nil;
            CurrentCashDividendRatesA = Nil;
            CurrentCashDividendValueA = Nil;
            CurrentCashDividendRatesB = Nil;
            CurrentCashDividendValueB = Nil;
            AccuCashDividendValueA = Nil;
            AccuCashDividendValueB = Nil;
            AccuYearlyIncomeValueA = Nil;
            AccuYearlyIncomeValueB = Nil;
            tDividendRatesA = Nil;
            tDividendValueA = Nil;
            tDividendRatesB = Nil;
            tDividendValueB = Nil;
            speRatesA = Nil;
            speValueA = Nil;
            speRatesB = Nil;
            speValueB = Nil;
            TotalNonGuaranteedSurrenderValueA = Nil;
            TotalNonGuaranteedSurrenderValueB = Nil;
            TotalDBValueA = Nil;
            TotalDBValueB = Nil;
            QuerySQL = Nil;
            wpRiderCode = Nil;
        }
        
    }
    
    NSLog(@"insert to SI_Temp_Trad_RideriLLus --- End");
    
}

-(void)InsertToSI_Temp_Trad_Summary_HLAWP{
    
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    
    NSLog(@"cashpromise insert to SI_Temp_Trad_Summary --- start");
    
    int inputAge;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        BOOL showYear21 = FALSE;
        if ([wpGYIRidersCode indexOfObject:@"EDUWR"] != NSNotFound && Age == 0) {
            showYear21 = TRUE;
        }
        for (int a= 1; a<=PolicyTerm; a++) {
            if (a <= 20 || (a > 20 && a % 5  == 0) || (a == PolicyTerm && a%5 != 0) || (showYear21 == TRUE && a == 21)) {
                inputAge = Age + a;
                
                if ([CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"] ) { //CD : ACC, //GYI :ACC
                    QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Summary (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\", "
                                "\"col14\",\"col15\",\"col16\",\"col17\", \"col18\",\"col19\",\"col20\",\"col21\") VALUES ( "
                                " \"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"%.2f\",\"%.2f\",\"%.2f\",\"%.2f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", "
                                "\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\")", SINo, a, @"DATA2", a, inputAge,
                                [[SummaryTotalPremiumPaid objectAtIndex: a - 1] doubleValue],
                                [self dblRoundToTwoDecimal:[[SummaryTotalPayoutOption objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryGuaranteedTotalGYI objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryTotalPayoutAndAccumulate objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryTotalAccumulateWithoutInterest objectAtIndex: a - 1] doubleValue]],
                                round([[SummaryGuaranteedSurrenderValue objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryGuaranteedDBValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedSurrenderValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedSurrenderValueB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedDBValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedDBValueB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedCurrentCashDividendA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedCurrentCashDividendB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedAccuCashDividendA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedAccuCashDividendB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedAccuYearlyIncomeA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedAccuYearlyIncomeB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalTDivA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalTDivB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalSpeA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalSpeB objectAtIndex: a - 1] doubleValue])];
                    
                } else if([CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) { //CD : ACC, //GYI :POF
                    QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Summary (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\", "
                                "\"col14\",\"col15\",\"col16\",\"col17\", \"col18\",\"col19\",\"col20\",\"col21\") VALUES ( "
                                " \"%@\",\"%d\",\"DATA2\",\"%d\",\"%d\",\"%@\",\"%.2f\",\"%.2f\",\"%.2f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", "
                                "\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%@\",\"%@\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\")", SINo, a, a, inputAge,
                                [SummaryTotalPremiumPaid objectAtIndex: a - 1],
                                [self dblRoundToTwoDecimal:[[SummaryTotalPayoutOption objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryGuaranteedTotalGYI objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryTotalPayoutAndAccumulate objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryTotalAccumulateWithoutInterest objectAtIndex: a - 1] doubleValue]],
                                round([[SummaryGuaranteedSurrenderValue objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryGuaranteedDBValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedSurrenderValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedSurrenderValueB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedDBValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedDBValueB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedCurrentCashDividendA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedCurrentCashDividendB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedAccuCashDividendA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedAccuCashDividendB objectAtIndex: a - 1] doubleValue]),
                                @"-",
                                @"-",
                                round([[SummaryNonGuaranteedTotalTDivA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalTDivB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalSpeA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalSpeB objectAtIndex: a - 1] doubleValue])];
                } else if(![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"]) { //CD : POF, //GYI :ACC
                    QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Summary (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\", "
                                "\"col14\",\"col15\",\"col16\",\"col17\", \"col18\",\"col19\",\"col20\",\"col21\") VALUES ( "
                                " \"%@\",\"%d\",\"DATA2\",\"%d\",\"%d\",\"%@\",\"%.2f\",\"%.2f\",\"%.2f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", "
                                "\"%.0f\",\"%.0f\",\"%.0f\",\"%@\",\"%@\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\")", SINo, a, a, inputAge,
                                [SummaryTotalPremiumPaid objectAtIndex: a - 1],
                                [self dblRoundToTwoDecimal:[[SummaryTotalPayoutOption objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryGuaranteedTotalGYI objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryTotalPayoutAndAccumulate objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryTotalAccumulateWithoutInterest objectAtIndex: a - 1] doubleValue]],
                                round([[SummaryGuaranteedSurrenderValue objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryGuaranteedDBValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedSurrenderValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedSurrenderValueB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedDBValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedDBValueB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedCurrentCashDividendA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedCurrentCashDividendB objectAtIndex: a - 1] doubleValue]),
                                @"-",
                                @"-",
                                round([[SummaryNonGuaranteedAccuYearlyIncomeA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedAccuYearlyIncomeB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalTDivA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalTDivB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalSpeA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalSpeB objectAtIndex: a - 1] doubleValue])];
                } else { //CD : POF, //GYI :POF
                    QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Summary (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\", "
                                "\"col14\",\"col15\",\"col16\",\"col17\", \"col18\",\"col19\",\"col20\",\"col21\") VALUES ( "
                                " \"%@\",\"%d\",\"DATA2\",\"%d\",\"%d\",\"%@\",\"%.2f\",\"%.2f\",\"%.2f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", "
                                "\"%.0f\",\"%.0f\",\"%.0f\",\"%@\",\"%@\",\"%@\",\"%@\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\")", SINo, a, a, inputAge,
                                [SummaryTotalPremiumPaid objectAtIndex: a - 1],
                                [self dblRoundToTwoDecimal:[[SummaryTotalPayoutOption objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryGuaranteedTotalGYI objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryTotalPayoutAndAccumulate objectAtIndex: a - 1] doubleValue]],
                                [self dblRoundToTwoDecimal:[[SummaryTotalAccumulateWithoutInterest objectAtIndex: a - 1] doubleValue]],
                                round([[SummaryGuaranteedSurrenderValue objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryGuaranteedDBValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedSurrenderValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedSurrenderValueB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedDBValueA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedDBValueB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedCurrentCashDividendA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedCurrentCashDividendB objectAtIndex: a - 1] doubleValue]),
                                @"-",
                                @"-",
                                @"-",
                                @"-",
                                round([[SummaryNonGuaranteedTotalTDivA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalTDivB objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalSpeA objectAtIndex: a - 1] doubleValue]),
                                round([[SummaryNonGuaranteedTotalSpeB objectAtIndex: a - 1] doubleValue]) ];
                }
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
            }
        }
        
        sqlite3_close(contactDB);
    }
    
    NSLog(@"insert to SI_Temp_Trad_Summary --- End");
    QuerySQL = Nil;
    
}


-(void)InsertToSI_Temp_Trad_Basic{
    
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    int inputAge;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    NSMutableArray *rates = [[NSMutableArray alloc] init ];
    NSMutableArray *SurrenderRates = [[NSMutableArray alloc] init ];
    NSMutableArray *SurrenderValue = [[NSMutableArray alloc] init ];
    NSMutableArray *DBRates = [[NSMutableArray alloc] init ];
    NSMutableArray *DBValue = [[NSMutableArray alloc] init ];
    NSMutableArray *DBRatesEnd = [[NSMutableArray alloc] init ];
    NSMutableArray *DBValueEnd = [[NSMutableArray alloc] init ];
    NSMutableArray *aValue = [[NSMutableArray alloc] init ];
    NSMutableArray *AnnualPremium = [[NSMutableArray alloc] init ];
    NSMutableArray *arrayYearlyIncome = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalAllPremium = [[NSMutableArray alloc] init ];
    NSMutableArray *CurrentCashDividendRatesA = [[NSMutableArray alloc] init ];
    NSMutableArray *CurrentCashDividendValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *CurrentCashDividendRatesB = [[NSMutableArray alloc] init ];
    NSMutableArray *CurrentCashDividendValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *AccuCashDividendValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *AccuCashDividendValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *AccuYearlyIncomeValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *AccuYearlyIncomeValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *tDividendRatesA = [[NSMutableArray alloc] init ];
    NSMutableArray *tDividendValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *tDividendRatesB = [[NSMutableArray alloc] init ];
    NSMutableArray *tDividendValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *speRatesA = [[NSMutableArray alloc] init ];
    NSMutableArray *speValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *speRatesB = [[NSMutableArray alloc] init ];
    NSMutableArray *speValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalSurrenderValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalSurrenderValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalDBValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalDBValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalPartialYearlyIncome = [[NSMutableArray alloc] init ];
    NSMutableArray *YearlyIncomePayout = [[NSMutableArray alloc] init ];
    
    NSLog(@"insert to SI_Temp_Trad_Basic ---- start");
    
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        //------------------- GYI / BasicSA
        
        for (int a = 0; a< PolicyTerm; a++) {
            [rates addObject:[NSString stringWithFormat:@"%.2f", BasicSA]];
        }
        
        //---------------- surrender value
        //for testing purpose only, uncomment the above one and comment this below in release version
        QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_CSV where PlanCode = '%@'  "
                    " AND age = \"%d\" ", @"HLACP", Age];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [SurrenderRates addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        //------------------------------------- cash dividend high
        QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_CD where PlanCode = 'HLACP' AND fromAge = \"%d\" AND Type = \"H\" ", Age];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [CurrentCashDividendRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        //--------------------------------  cash dividend low
        
        QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_CD where PlanCode = 'HLACP' "
                    " AND fromAge = \"%d\" AND Type = \"L\" ",  Age];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [CurrentCashDividendRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (CurrentCashDividendRatesB.count == 0) {
            NSLog(@" CurrentCashDividendRatesA rates = 0");
        }
        
        //--------------------------------  t Dividen payable on surrender high
        
        QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_TD where PlanCode = 'HLACP' "
                    " AND Age = \"%d\" AND Type = \"H\" ", Age];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [tDividendRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (tDividendRatesA.count == 0) {
            NSLog(@" tDividendRatesA rates = 0");
        }
        
        //--------------------------------  t Dividen payable on surrender low
        
        QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_TD where PlanCode = 'HLACP' "
                    " AND Age = \"%d\" AND Type = \"L\" ", Age];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [tDividendRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (tDividendRatesB.count == 0) {
            NSLog(@" tDividendRatesB rates = 0");
        }
        
        //--------------------------------  high
        
        QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_speTD where PlanCode = 'HLACP' "
                    " AND Age = \"%d\" AND Type = \"H\" ", Age];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [speRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (speRatesA.count == 0) {
            NSLog(@" speRatesA rates = 0");
        }
        
        //--------------------------------  low
        
        QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_speTD where PlanCode = 'HLACP' "
                    " AND Age = \"%d\" AND Type = \"L\" ", Age];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [speRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (speRatesB.count == 0) {
            NSLog(@" speRatesB rates = 0");
        }
        
        sqlite3_close(contactDB);
    }
    
    double TotalAD;
    if (([pPlanCode isEqualToString:@"HLACP"]||[pPlanCode isEqualToString:@"HLAWP"]) && PolicyTerm > 25) {
        PolicyTerm = 25;
    }
    
    double sumBasic = 0.0;
    double sumOtherRider = 0.0;
    double tempHMMRates = 0.00;
    
    NSString *tempHLPercentage;
    NSString *tempHLPercentageTerm;
    NSString *tempTempHL;
    NSString *tempTempHLTerm;
    NSString *tempHL1KSA;
    NSString *tempHL1KSATerm;
    NSString *tempHL100SA;
    NSString *tempHL100SATerm;
    
    double actualPremium = 0.0;
    double baseValue;
    double waiverRiderSA;
    double dTotalSurrenderValueA = 0.00;
    double dTotalSurrenderValueB = 0.00;
    for (int i =1; i <= PolicyTerm; i++) {
        
        if ([pPlanCode isEqualToString:@"HLACP"]||[pPlanCode isEqualToString:@"HLAWP"]) {
            if (i <= 6) {
                [AnnualPremium addObject:[aStrBasicSA objectAtIndex:i-1]];
            } else {
                [AnnualPremium addObject:@"0.00"];
            }
            
            BasicTotalPremiumPaid = BasicTotalPremiumPaid +
            [[[AnnualPremium objectAtIndex:i-1 ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
            
            EntireTotalPremiumPaid = EntireTotalPremiumPaid +
            [[[AnnualPremium objectAtIndex:i-1 ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
            
            TotalPremiumBasicANDIncomeRider = TotalPremiumBasicANDIncomeRider +
            [[[AnnualPremium objectAtIndex:i-1 ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
            
            // --------------------------
            //[arrayYearlyIncome addObject:[NSString stringWithFormat:@"%d.00",  BasicSA]];
            [arrayYearlyIncome addObject:[NSString stringWithFormat:@"%.2f",  PartialAcc/100.00 * BasicSA]];
            
            [YearlyIncomePayout addObject:[NSString stringWithFormat:@"%.2f", PartialPayout/100.00 * BasicSA ]];
            [TotalPartialYearlyIncome addObject:[NSString stringWithFormat:@"%.2f", BasicSA ]];
            
            // ---------------------------------
            
            BasicTotalYearlyIncome = BasicTotalYearlyIncome + [[TotalPartialYearlyIncome objectAtIndex:i -1] doubleValue ];
            EntireTotalYearlyIncome = EntireTotalYearlyIncome + [[TotalPartialYearlyIncome objectAtIndex: i-1] doubleValue ];
            
            [SummaryGuaranteedTotalGYI addObject:[[arrayYearlyIncome objectAtIndex:i-1] stringByReplacingOccurrencesOfString:@"#" withString:@"" ]];
            [SurrenderValue addObject:[NSString stringWithFormat:@"%.9f", [[SurrenderRates objectAtIndex:i-1] doubleValue ] * BasicSA/1000 ]];
            [SummaryGuaranteedSurrenderValue addObject:[SurrenderValue objectAtIndex:i-1]];
            
            // --------------------
            if (Age <= 40) {
                [DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 12.5 * BasicSA ]];
            } else if (Age > 40 && Age <= 50){
                if ((26 - i) * BasicSA + 6.25 * BasicSA >= 12.5 * BasicSA) {
                    [DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 6.25 * BasicSA ]];
                } else {
                    [DBValue addObject:[NSString stringWithFormat:@"%.3f", 12.5 * BasicSA]];
                }
            } else if (Age > 50 && Age <= 60) {
                if ((26 - i) * BasicSA + 5.5 * BasicSA >= 11 * BasicSA) {
                    [DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 5.5 * BasicSA ]];
                } else {
                    [DBValue addObject:[NSString stringWithFormat:@"%.3f", 11.0 * BasicSA]];
                }
            } else if (Age > 60 && Age <= 63) {
                if ((26 - i) * BasicSA + 5.0 * BasicSA >= 10 * BasicSA) {
                    [DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 5.0 * BasicSA ]];
                } else {
                    [DBValue addObject:[NSString stringWithFormat:@"%.3f", 10.0 * BasicSA]];
                }
            }
            
            //-------------------
            
            if (Age <= 40) {
                if (i == 25) {
                    [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f",  BasicSA + 12.5 * BasicSA ]];
                } else {
                    [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 12.5 * BasicSA ]];
                }
            } else if (Age > 40 && Age <= 50){
                if ((25 - i) * BasicSA + 6.25 * BasicSA >= 12.5 * BasicSA) {
                    [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 6.25 * BasicSA ]];
                } else{
                    [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 12.5 * BasicSA]];
                }
            } else if (Age > 50 && Age <= 60){
                if ((25 - i) * BasicSA + 5.5 * BasicSA >= 11 * BasicSA) {
                    [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 5.5 * BasicSA ]];
                } else{
                    [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 11.0 * BasicSA]];
                }
            } else if (Age > 60 && Age <= 63){
                if ((25 - i) * BasicSA + 5.0 * BasicSA >= 10 * BasicSA) {
                    [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 5.0 * BasicSA ]];
                } else {
                    [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 10.0 * BasicSA]];
                }
            }
            
            [SummaryGuaranteedDBValueA addObject:[DBValue objectAtIndex:i-1]];
            [SummaryGuaranteedDBValueB addObject:[DBValueEnd objectAtIndex:i-1]];
            
            //------------------------
            
            if (i <= 6) {
                if (i+ Age <= 64) {
                    if (i == 1) {
                        TotalAD = [[AnnualPremium objectAtIndex:i -1]doubleValue ];
                    } else {
                        TotalAD = TotalAD + [[AnnualPremium objectAtIndex:i -1]doubleValue ];
                    }
                } else {
                    TotalAD = 0.00;
                }
            } else {
                TotalAD = 0.00;
            }
            
            
            [aValue addObject: [NSString stringWithFormat:@"%.3f", TotalAD] ];
            [SummaryGuaranteedAddValue addObject:[aValue objectAtIndex:i-1]];
            //-----------------------------------
            
            
            //---------------- total premium paid ----------
            
            sumOtherRider = 0.0;
            sumBasic = [[AnnualPremium objectAtIndex:i -1] doubleValue ];
            
            for (int j =0; j<OtherRiderCode.count; j++) {
                if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HMM" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_IV" ]
                    || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HSP_II" ] ) {
                    
                    if ( i <= [[OtherRiderTerm objectAtIndex:j] intValue ]   ) {
                        tempHMMRates = 0.00;
                        
                        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                            QuerySQL = [NSString stringWithFormat:@"Select Annually from SI_Store_premium Where Type = \"%@\" AND "
                                        "FromAge <= \"%d\" AND ToAge >= \"%d\" AND SIno = '%@' ", [OtherRiderCode objectAtIndex:j ], Age + i - 1, Age + i - 1, SINo];
                            
                            
                            if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                if (sqlite3_step(statement) == SQLITE_ROW) {
                                    tempHMMRates = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] doubleValue ];
                                    
                                }
                                sqlite3_finalize(statement);
                            }
                            sqlite3_close(contactDB);
                        }
                        
                        tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:j];
                        tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:j];
                        tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                        tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                        
                        actualPremium = 0.0;
                        baseValue = tempHMMRates/([tempHLPercentage doubleValue]/100 + 1);
                        
                        if([tempHLPercentage isEqualToString:@"(null)"]) {
                            actualPremium = baseValue;
                        } else {
                            if ([tempTempHL isEqualToString:@"(null)"]) {
                                actualPremium = baseValue;
                            } else {
                                if(i <= [tempHLPercentageTerm intValue ] && i <= [tempTempHLTerm intValue ]    ){
                                    actualPremium = baseValue * ([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100  + 1.00);
                                } else if(i <= [tempHLPercentageTerm intValue ] && i > [tempTempHLTerm intValue ]    ){
                                    actualPremium = baseValue * ([tempHLPercentage doubleValue]/100  + 1.00);
                                    
                                } else if(i > [tempHLPercentageTerm intValue ] && i  <= [tempTempHLTerm intValue ]    ){
                                    actualPremium = baseValue * ([tempTempHL doubleValue]/100  + 1.00);
                                    
                                } else if(i  > [tempHLPercentageTerm intValue ] && i  > [tempTempHLTerm intValue ]    ){
                                    actualPremium = baseValue;
                                }
                            }
                        }
                        
                        sumOtherRider = sumOtherRider + actualPremium;
                        
                        tempHLPercentage = Nil;
                        tempHLPercentageTerm = Nil;
                        
                    }
                }
                else{ //non medical rider
                    if ( i <= [[OtherRiderTerm objectAtIndex:j] intValue ]   ) {
                        
                        if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"EDB" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"ETPDB" ]) {
                            
                            tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
                            tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
                            tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                            tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                            
                            if (i <= 6) {
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                } else {
                                    if(i <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                    } else {
                                        actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                                        - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000)  * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000) * [tempTempHL doubleValue];
                                    }
                                }
                                sumOtherRider = sumOtherRider + actualPremium;
                            } else {
                                sumOtherRider = sumOtherRider + 0.00;
                            }
                            
                            tempHL1KSA = nil, tempHL1KSATerm = Nil;
                            
                        } else {
                            
                            if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"CIWP" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"LCWP" ] ||
                                [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"PR" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"SP_PRE" ] ||
                                [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"SP_STD" ] ) {
                                
                                waiverRiderSA = [[strOriBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                
                                if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"CIWP" ]) {
                                    
                                    for (int q=0; q < OtherRiderCode.count; q++) {
                                        if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCPR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIR"]  ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ICR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_TW"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_TWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_EXC"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_MPP"])) {
                                            waiverRiderSA = waiverRiderSA +
                                            [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                        }
                                    }
                                } else {
                                    for (int q=0; q < OtherRiderCode.count; q++) {
                                        if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PLCP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PTR"])) {
                                            waiverRiderSA = waiverRiderSA +
                                            [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            
                                        }
                                    }
                                }
                                
                                tempHL100SA = [OtherRiderHL100SA objectAtIndex:j];
                                tempHL100SATerm = [OtherRiderHL100SATerm objectAtIndex:j];
                                tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                                tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                                
                                actualPremium = 0.0;
                                if([tempHL100SA isEqualToString:@"(null)"]) {
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                } else {
                                    if(i  <= [tempHL100SATerm intValue ] ) {
                                        actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                    } else{
                                        actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                                        - (waiverRiderSA/100) * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/100) * [tempHL100SA doubleValue ] ;
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i  > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium -
                                        (waiverRiderSA/100) * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/100) * [tempTempHL doubleValue ] ;
                                    }
                                }
                                
                                sumOtherRider = sumOtherRider + actualPremium;
                                
                                tempHL100SA = Nil;
                                tempHL100SATerm = Nil;
                                
                            } else if([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HB" ] ){
                                tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:j];
                                tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:j];
                                tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                                tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                                
                                actualPremium = 0.0;
                                baseValue = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                                /([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100 + 1.00);
                                
                                if([tempHLPercentage isEqualToString:@"(null)"]) {
                                    actualPremium = baseValue;
                                }
                                else{
                                    if ([tempTempHL isEqualToString:@"(null)"]) {
                                        actualPremium = baseValue;
                                    }
                                    else{
                                        if(i  <= [tempHLPercentageTerm intValue ] && i  <= [tempTempHLTerm intValue ]    ){
                                            actualPremium = baseValue * ([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100  + 1.00);
                                        }
                                        else if(i  <= [tempHLPercentageTerm intValue ] && i  > [tempTempHLTerm intValue ]    ){
                                            actualPremium = baseValue * ([tempHLPercentage doubleValue]/100  + 1.00);
                                        }
                                        else if(i  > [tempHLPercentageTerm intValue ] && i  <= [tempTempHLTerm intValue ]    ){
                                            actualPremium = baseValue * ([tempTempHL doubleValue]/100  + 1.00);
                                        }
                                        else if(i  > [tempHLPercentageTerm intValue ] && i  > [tempTempHLTerm intValue ]    ){
                                            actualPremium = baseValue;
                                        }
                                    }
                                    
                                }
                                sumOtherRider = sumOtherRider + actualPremium;
                                
                            } else { //rider is not CIWP, PR, LCWP, SP_PRE, SP_STD, HB
                                tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
                                tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
                                tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                                tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                                
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                } else {
                                    if(i <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                    } else {
                                        actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                                        - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000)  * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000) * [tempTempHL doubleValue];
                                    }
                                }
                                sumOtherRider = sumOtherRider + actualPremium;
                                
                                tempHL1KSA = nil;
                                tempHL1KSATerm = Nil;
                            }
                        }
                    }
                }
            }
            [TotalAllPremium addObject: [NSString stringWithFormat:@"%.2f", (sumBasic + sumOtherRider)]];
            
            
            //----------------- total premium paid end ----------
        }
        
        //------------- current cash dividend
        [CurrentCashDividendValueA addObject: [NSString stringWithFormat: @"%.8f",
                                               BasicSA * [[CurrentCashDividendRatesA objectAtIndex: i - 1] doubleValue ] / 100 ]];
        [CurrentCashDividendValueB addObject: [NSString stringWithFormat: @"%.9f",
                                               BasicSA * [[CurrentCashDividendRatesB objectAtIndex: i - 1] doubleValue ] / 100 ]];
        
        //----------- current cash dividend end ----------
        
        
        //------ accu cash dividend
        if ([CashDividend isEqualToString:@"ACC"]) {
            double CDInterestRateHigh = 0.0525;
            double CDInterestRateLow = 0.0325;
            
            if (i == 1) {
                [AccuCashDividendValueA addObject:[CurrentCashDividendValueA objectAtIndex:i -1 ]];
                [AccuCashDividendValueB addObject:[CurrentCashDividendValueB objectAtIndex:i-1]];
            } else {
                [AccuCashDividendValueA addObject: [NSString stringWithFormat: @"%.8f",
                                                    [[AccuCashDividendValueA objectAtIndex:i-2] doubleValue ] * (1.00 + CDInterestRateHigh) +
                                                    [[CurrentCashDividendValueA objectAtIndex:i-1] doubleValue ] ] ];
                [AccuCashDividendValueB addObject: [NSString stringWithFormat: @"%.9f",
                                                    [[AccuCashDividendValueB objectAtIndex:i-2] doubleValue ] * (1.00 + CDInterestRateLow) +
                                                    [[CurrentCashDividendValueB objectAtIndex:i-1] doubleValue ] ] ];
            }
        } else {
            [AccuCashDividendValueA addObject:@"-"];
            [AccuCashDividendValueB addObject:@"-"];
        }
        
        [SummaryNonGuaranteedAccuCashDividendA addObject:[AccuCashDividendValueA objectAtIndex:i-1]];
        [SummaryNonGuaranteedAccuCashDividendB addObject:[AccuCashDividendValueB objectAtIndex:i-1]];
        
        //------- accucash dividend end --------
        
        //------ accu yearly income ------
        if ([YearlyIncome isEqualToString:@"ACC"]) {
            double CDInterestRateHigh = 0.0525;
            double CDInterestRateLow = 0.0325;
            
            if (i == 1) {
                [AccuYearlyIncomeValueA addObject:[arrayYearlyIncome objectAtIndex:i -1]];
                [AccuYearlyIncomeValueB addObject:[arrayYearlyIncome objectAtIndex:i -1]];
            } else {
                [AccuYearlyIncomeValueA addObject:[NSString stringWithFormat:@"%.8f",
                                                   [[AccuYearlyIncomeValueA objectAtIndex:i-2] doubleValue] * (1.00 + CDInterestRateHigh)
                                                   + [[arrayYearlyIncome objectAtIndex:i -1] doubleValue ] ] ];
                [AccuYearlyIncomeValueB addObject:[NSString stringWithFormat:@"%.9f",
                                                   [[AccuYearlyIncomeValueB objectAtIndex:i-2] doubleValue] * (1.00 + CDInterestRateLow)
                                                   + [[arrayYearlyIncome objectAtIndex:i -1] doubleValue ] ] ];
            }
        } else {
            [AccuYearlyIncomeValueA addObject:@"-"];
            [AccuYearlyIncomeValueB addObject:@"-"];
        }
        
        [SummaryNonGuaranteedAccuYearlyIncomeA addObject:[AccuYearlyIncomeValueA objectAtIndex:i-1]];
        [SummaryNonGuaranteedAccuYearlyIncomeB addObject:[AccuYearlyIncomeValueB objectAtIndex:i-1]];
        
        //------ accu yearly income end ------
        
        //------------- t dividend payable on surrender
        [tDividendValueA addObject: [NSString stringWithFormat: @"%.8f",
                                     BasicSA * [[tDividendRatesA objectAtIndex: i - 1] doubleValue ] / 100.00 ]];
        [tDividendValueB addObject: [NSString stringWithFormat: @"%.9f",
                                     BasicSA * [[tDividendRatesB objectAtIndex: i - 1] doubleValue ] / 100.00 ]];
        
        //----------- t dividend payable on surrender end ----------
        
        //-------------  spe TD
        [speValueA addObject: [NSString stringWithFormat: @"%.2f",
                               BasicSA * [[speRatesA objectAtIndex: i - 1] doubleValue ] / 100 ]];
        [speValueB addObject: [NSString stringWithFormat: @"%.2f",
                               BasicSA * [[speRatesB objectAtIndex: i - 1] doubleValue ] / 100 ]];
        
        //----------- spe TD end ----------
        
        //----------- total surrender value ----------
        dTotalSurrenderValueA = 0.00;
        dTotalSurrenderValueB = 0.00;
        
        if ([YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"] ) {
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueA objectAtIndex:i - 1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueB objectAtIndex:i - 1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        } else if ([YearlyIncome isEqualToString:@"ACC"] && ![CashDividend isEqualToString:@"ACC"]) {
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueA objectAtIndex:i - 1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueB objectAtIndex:i - 1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        } else if (![YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"]) {
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        } else {
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        }
        
        [TotalSurrenderValueA addObject: [NSString stringWithFormat:@"%.8f", dTotalSurrenderValueA ]];
        [TotalSurrenderValueB addObject: [NSString stringWithFormat:@"%.9f", dTotalSurrenderValueB ]];
        
        [SummaryNonGuaranteedSurrenderValueA addObject:[TotalSurrenderValueA objectAtIndex:i-1]];
        [SummaryNonGuaranteedSurrenderValueB addObject:[TotalSurrenderValueB objectAtIndex:i-1]];
        
        
        if (i == PolicyTerm) {
            BasicMaturityValueA = [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:PolicyTerm - 1] doubleValue ];
            BasicMaturityValueB = [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:PolicyTerm - 1] doubleValue ];
            
            
            EntireMaturityValueA = BasicMaturityValueA;
            EntireMaturityValueB = BasicMaturityValueB;
            
        }
        
        //------------ total surrender value end ------
        
        //----------- total DB value ----------
        double dTotalDBValueA = 0;
        double dTotalDBValueB = 0;
        
        if ([YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"] ) {
            dTotalDBValueA = [[DBValueEnd objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueA objectAtIndex:i - 1] doubleValue ] +
            [[speValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalDBValueB = [[DBValueEnd objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueB objectAtIndex:i - 1] doubleValue ] +
            [[speValueB objectAtIndex:i - 1 ] doubleValue ];
            
        } else if ([YearlyIncome isEqualToString:@"ACC"] && ![CashDividend isEqualToString:@"ACC"]) {
            dTotalDBValueA = [[DBValueEnd objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueA objectAtIndex:i - 1] doubleValue ] +
            [[speValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalDBValueB = [[DBValueEnd objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueB objectAtIndex:i - 1] doubleValue ] +
            [[speValueB objectAtIndex:i - 1 ] doubleValue ];
            
        }
        else if (![YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"]) {
            dTotalDBValueA = [[DBValueEnd objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[speValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalDBValueB = [[DBValueEnd objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[speValueB objectAtIndex:i - 1 ] doubleValue ];
            
        }
        else {
            dTotalDBValueA = [[DBValueEnd objectAtIndex:i-1] doubleValue ] +
            [[speValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalDBValueB = [[DBValueEnd objectAtIndex:i-1] doubleValue ] +
            [[speValueB objectAtIndex:i - 1 ] doubleValue ];
            
        }
        
        [TotalDBValueA addObject: [NSString stringWithFormat:@"%.3f", dTotalDBValueA ]];
        [TotalDBValueB addObject: [NSString stringWithFormat:@"%.3f", dTotalDBValueB ]];
        
        [SummaryNonGuaranteedDBValueA addObject:[TotalDBValueA objectAtIndex:i-1]];
        [SummaryNonGuaranteedDBValueB addObject:[TotalDBValueB objectAtIndex:i-1]];
        
        //------------ total DB value end ------
        
    }
    
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        NSString *strAccuCDA = @"";
        NSString *strAccuCDB = @"";
        NSString *strAccuYIA = @"";
        NSString *strAccuYIB = @"";
        NSString *DBYearlyIncome = @"";
        for (int a= 1; a<=PolicyTerm; a++) {
            if (a <= 25) {
                
                if (Age >= 0){
                    
                    inputAge = Age + a;
                    
                    strAccuCDA = @"";
                    strAccuCDB = @"";
                    strAccuYIA = @"";
                    strAccuYIB = @"";
                    
                    if ([CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"]) {
                        strAccuCDA = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueA objectAtIndex:a-1] doubleValue ])];
                        strAccuCDB = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueB objectAtIndex:a-1] doubleValue ])];
                        strAccuYIA = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueA objectAtIndex:a-1] doubleValue ])];
                        strAccuYIB = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueB objectAtIndex:a-1] doubleValue ])];
                    }
                    else if ([CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) {
                        strAccuCDA = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueA objectAtIndex:a-1] doubleValue ])];
                        strAccuCDB = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueB objectAtIndex:a-1] doubleValue ])];
                        strAccuYIA = [NSString stringWithFormat:@"-"];
                        strAccuYIB = [NSString stringWithFormat:@"-"];
                    }
                    else if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"]) {
                        strAccuCDA = [NSString stringWithFormat:@"-"];
                        strAccuCDB = [NSString stringWithFormat:@"-"];
                        strAccuYIA = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueA objectAtIndex:a-1] doubleValue ])];
                        strAccuYIB = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueB objectAtIndex:a-1] doubleValue ])];
                    }
                    else if (![CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) {
                        strAccuCDA = [NSString stringWithFormat:@"-"];
                        strAccuCDB = [NSString stringWithFormat:@"-"];
                        strAccuYIA = [NSString stringWithFormat:@"-"];
                        strAccuYIB = [NSString stringWithFormat:@"-"];
                    }
                    
                    DBYearlyIncome = @"";
                    
                    DBYearlyIncome =  [arrayYearlyIncome objectAtIndex:a-1];
                    
                    
                    QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Basic (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\", "
                                "\"col14\",\"col15\",\"col16\",\"col17\",\"col18\",\"col19\",\"col20\",\"col21\",\"col22\",\"col23\" ) VALUES ( "
                                " \"%@\",\"%d\",\"DATA\",\"%d\",\"%d\",\"%@\",\"%@\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", "
                                "\"%.0f\",\"%@\",\"%.0f\",\"%.0f\",\"%@\",\"%@\",\"%@\",\"%@\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", \"%.2f\", \"%.2f\")",
                                SINo, a, a, inputAge, [AnnualPremium objectAtIndex:a -1],DBYearlyIncome, round([[SurrenderValue objectAtIndex:a-1] doubleValue ]),
                                round( [[DBValue objectAtIndex:a-1] doubleValue ] ), round([[DBValueEnd objectAtIndex:a-1] doubleValue ]),
                                round( [[aValue objectAtIndex:a-1 ]  doubleValue]),
                                round([[TotalSurrenderValueA objectAtIndex:a-1 ] doubleValue ]), round([[TotalSurrenderValueB objectAtIndex:a-1] doubleValue ]),
                                round( [[TotalDBValueA objectAtIndex:a-1 ] doubleValue ]), round( [[TotalDBValueB objectAtIndex:a-1 ] doubleValue ]),
                                [TotalAllPremium objectAtIndex:a-1],
                                round( [[CurrentCashDividendValueA objectAtIndex:a-1] doubleValue ]), round( [[CurrentCashDividendValueB objectAtIndex:a-1] doubleValue ]),
                                strAccuCDA, strAccuCDB,
                                strAccuYIA, strAccuYIB,
                                round([[tDividendValueA objectAtIndex:a-1] doubleValue ]), round([[tDividendValueB objectAtIndex:a-1 ] doubleValue ]),
                                round([[speValueA objectAtIndex:a-1] doubleValue ]), round( [[speValueB objectAtIndex:a-1] doubleValue]),
                                [[YearlyIncomePayout objectAtIndex:a-1] doubleValue],  [[TotalPartialYearlyIncome objectAtIndex:a-1] doubleValue]];
                    
                    
                    if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                        if (sqlite3_step(statement) == SQLITE_DONE) {
                            
                        }
                        sqlite3_finalize(statement);
                    }
                    
                    strAccuCDA = Nil;
                    strAccuCDB = Nil;
                    strAccuYIA = Nil;
                    strAccuYIB = Nil;
                    DBYearlyIncome = Nil;
                }
                
            }
            
        }
        
        sqlite3_close(contactDB);
    }
    
    
    rates = Nil;
    SurrenderRates = Nil;
    SurrenderValue = Nil;
    DBRates = Nil;
    DBValue = Nil;
    DBRatesEnd = Nil;
    DBValueEnd = Nil;
    aValue = Nil;
    AnnualPremium = Nil;
    arrayYearlyIncome = Nil;
    TotalAllPremium = Nil;
    CurrentCashDividendRatesA = Nil;
    CurrentCashDividendValueA = Nil;
    CurrentCashDividendRatesB = Nil;
    CurrentCashDividendValueB = Nil;
    AccuCashDividendValueA = Nil;
    AccuCashDividendValueB = Nil;
    AccuYearlyIncomeValueA = Nil;
    AccuYearlyIncomeValueB = Nil;
    tDividendRatesA = Nil;
    tDividendValueA = Nil;
    tDividendRatesB = Nil;
    tDividendValueB = Nil;
    speRatesA = Nil;
    speValueA = Nil;
    speRatesB = Nil;
    speValueB = Nil;
    TotalSurrenderValueA = Nil;
    TotalSurrenderValueB = Nil;
    TotalDBValueA = Nil;
    TotalDBValueB = Nil;
    QuerySQL = Nil;
    TotalPartialYearlyIncome = nil;
    YearlyIncomePayout = nil;
    
    NSLog(@"insert to SI_Temp_Trad_Basic --- End");
    
}

-(void)InsertToSI_Temp_Trad_Basic_HLAWP{ //stop copying and giving stupid excuses
    
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    int inputAge;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
    
    NSMutableArray *rates = [[NSMutableArray alloc] init ];
    NSMutableArray *SurrenderRates = [[NSMutableArray alloc] init ];
    NSMutableArray *SurrenderValue = [[NSMutableArray alloc] init ];
    NSMutableArray *DBIncRates = [[NSMutableArray alloc] init ];
    NSMutableArray *DBIncValue = [[NSMutableArray alloc] init ];
    
    NSMutableArray *DBRates = [[NSMutableArray alloc] init ];
    NSMutableArray *DBValue = [[NSMutableArray alloc] init ];
    NSMutableArray *DBRatesEnd = [[NSMutableArray alloc] init ];
    NSMutableArray *DBValueEnd = [[NSMutableArray alloc] init ];
    NSMutableArray *aValue = [[NSMutableArray alloc] init ];
    NSMutableArray *AnnualPremium = [[NSMutableArray alloc] init ];
    NSMutableArray *arrayYearlyIncome = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalAllPremium = [[NSMutableArray alloc] init ];
    NSMutableArray *CurrentCashDividendRatesA = [[NSMutableArray alloc] init ];
    NSMutableArray *CurrentCashDividendValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *CurrentCashDividendRatesB = [[NSMutableArray alloc] init ];
    NSMutableArray *CurrentCashDividendValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *AccuCashDividendValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *AccuCashDividendValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *AccuYearlyIncomeValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *AccuYearlyIncomeValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *tDividendRatesA = [[NSMutableArray alloc] init ];
    NSMutableArray *tDividendValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *tDividendRatesB = [[NSMutableArray alloc] init ];
    NSMutableArray *tDividendValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *speRatesA = [[NSMutableArray alloc] init ];
    NSMutableArray *speValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *speRatesB = [[NSMutableArray alloc] init ];
    NSMutableArray *speValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalSurrenderValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalSurrenderValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalDBValueA = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalDBValueB = [[NSMutableArray alloc] init ];
    NSMutableArray *TotalPartialYearlyIncome = [[NSMutableArray alloc] init ];
    NSMutableArray *YearlyIncomePayout = [[NSMutableArray alloc] init ];
    
    NSString* tempAnnualPremium;
    NSLog(@"insert to SI_Temp_Trad_Basic ---- start");
    int maxPolYear= PolicyTerm;
    
    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
        
        //---------------- surrender value
        
        //        QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_CSV where PlanCode = '%@'  "
        //                    " AND age = \"%d\" ", pPlanCode, Age];
        
        
        //for testing purpose only, uncomment the above one and comment this below in release version
        QuerySQL = [NSString stringWithFormat: @"Select rate, polyear from SI_TRAD_CSV_HLAWP where age = \"%d\" and PremPayOpt='%d' and term='%d' order by polyear", Age,premiumPaymentOption,PolicyTerm];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [SurrenderRates addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                maxPolYear = sqlite3_column_int(statement, 1);
            }
            sqlite3_finalize(statement);
        }
        
        
        //------------------- GYI / BasicSA
        
        for (int a = 0; a< maxPolYear; a++) {
            [rates addObject:[NSString stringWithFormat:@"%.2f", BasicSA]];
        }
        
        
        for (int i =1; i <= maxPolYear; i++) {
            //------------------------------------- DB Rates
            
            QuerySQL = [NSString stringWithFormat: @"Select rate from SI_TRAD_SaInc_HLAWP where premPayOpt='%d' and term='%d' and polYear='%d' AND Age = \"%d\" ",  premiumPaymentOption, PolicyTerm, i, Age];
            if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    [DBIncRates addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                }
                sqlite3_finalize(statement);
            }
            
            
            //------------------------------------- cash dividend high
            QuerySQL = [NSString stringWithFormat: @"Select CDrate from SI_TRAD_CD_HLAWP where premPayOpt='%d' and term='%d' and polYear='%d' AND Type = \"H\" ",  premiumPaymentOption, PolicyTerm, i];
            if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    [CurrentCashDividendRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                }
                sqlite3_finalize(statement);
            }
            
            //--------------------------------  cash dividend low
            QuerySQL = [NSString stringWithFormat: @"Select CDrate from SI_TRAD_CD_HLAWP where premPayOpt='%d' and term='%d' and polYear='%d' AND Type = \"L\" ", premiumPaymentOption, PolicyTerm, i];
            if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    [CurrentCashDividendRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                }
                sqlite3_finalize(statement);
            }
        }
        
        if (CurrentCashDividendRatesB.count == 0) {
            NSLog(@" CurrentCashDividendRatesA rates = 0");
        }
        
        //--------------------------------  t Dividen payable on surrender high
        QuerySQL = [NSString stringWithFormat: @"Select rate from SI_TRAD_TD_HLAWP where Age = \"%d\" and term='%d' and premPayOpt='%d' AND Type = \"H\" ", Age, PolicyTerm,premiumPaymentOption];
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [tDividendRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (tDividendRatesA.count == 0) {
            NSLog(@" tDividendRatesA rates = 0");
        }
        
        //--------------------------------  t Dividen payable on surrender low
        QuerySQL = [NSString stringWithFormat: @"Select rate from SI_TRAD_TD_HLAWP where Age = \"%d\" and term='%d' and premPayOpt='%d' AND Type = \"L\" ORDER by PolYear ASC ", Age, PolicyTerm,premiumPaymentOption];
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [tDividendRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (tDividendRatesB.count == 0) {
            NSLog(@" tDividendRatesB rates = 0");
        }
        
        //--------------------------------  high
        QuerySQL = [NSString stringWithFormat: @"Select rate from SI_TRAD_SpeTD_HLAWP where Age = \"%d\" AND Type = \"H\" and term='%d' and premPayOpt='%d'", Age,PolicyTerm,premiumPaymentOption];
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [speRatesA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (speRatesA.count == 0) {
            NSLog(@" speRatesA rates = 0");
        }
        
        //--------------------------------  low
        QuerySQL = [NSString stringWithFormat: @"Select rate from SI_TRAD_SpeTD_HLAWP where Age = \"%d\" AND Type = \"L\" and term='%d' and premPayOpt='%d' ORDER by PolYear ASC", Age,PolicyTerm,premiumPaymentOption];
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [speRatesB addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        if (speRatesB.count == 0) {
            NSLog(@" speRatesB rates = 0");
        }
        
        sqlite3_close(contactDB);
    }
    
    double TotalAD;
    
    for (int i =1; i <= maxPolYear; i++) {
        if (i <= premiumPaymentOption) {
            tempAnnualPremium = [aStrBasicSA objectAtIndex:i-1];
        } else {
            tempAnnualPremium = @"0.00";
        }
        
        BasicTotalPremiumPaid = BasicTotalPremiumPaid + [[tempAnnualPremium stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
        EntireTotalPremiumPaid = EntireTotalPremiumPaid + [[tempAnnualPremium stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
        TotalPremiumBasicANDIncomeRider = TotalPremiumBasicANDIncomeRider + [[tempAnnualPremium stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
        [SummaryTotalPremiumPaid addObject:[tempAnnualPremium stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
        
        // --------------------------
        [arrayYearlyIncome addObject:[NSString stringWithFormat:@"%.2f",  PartialAcc/100.00 * BasicSA]];
        [YearlyIncomePayout addObject:[NSString stringWithFormat:@"%.2f", PartialPayout/100.00 * BasicSA ]];
        [TotalPartialYearlyIncome addObject:[NSString stringWithFormat:@"%.2f", BasicSA ]];
        // ---------------------------------
        
        BasicTotalYearlyIncome = BasicTotalYearlyIncome + [[TotalPartialYearlyIncome objectAtIndex:i -1] doubleValue ];
        
        [SummaryGuaranteedTotalGYI addObject:@"0.00"];
        [SummaryTotalPayoutOption addObject:@"0.00"];
        [SummaryTotalPayoutAndAccumulate addObject:@"0.00"];
        [SummaryTotalAccumulateWithoutInterest addObject:@"0.00"];
        
        [SurrenderValue addObject:[NSString stringWithFormat:@"%.9f", [[SurrenderRates objectAtIndex:i-1] doubleValue ] * BasicSA/1000 ]];
        [DBIncValue addObject:[NSString stringWithFormat:@"%.9f", [[DBIncRates objectAtIndex:i-1] doubleValue ] * BasicSA/100 ]];
        
        [SummaryGuaranteedSurrenderValue addObject:[SurrenderValue objectAtIndex:i-1]];
        [SummaryGuaranteedDBValueA addObject:[DBIncValue objectAtIndex:i-1]];
        
        // --------------------
        if (Age <= 40) {
            [DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 12.5 * BasicSA ]];
        } else if (Age > 40 && Age <= 50) {
            if ((26 - i) * BasicSA + 6.25 * BasicSA >= 12.5 * BasicSA) {
                [DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 6.25 * BasicSA ]];
            } else {
                [DBValue addObject:[NSString stringWithFormat:@"%.3f", 12.5 * BasicSA]];
            }
        } else if (Age > 50 && Age <= 60) {
            if ((26 - i) * BasicSA + 5.5 * BasicSA >= 11 * BasicSA) {
                [DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 5.5 * BasicSA ]];
            } else {
                [DBValue addObject:[NSString stringWithFormat:@"%.3f", 11.0 * BasicSA]];
            }
        } else if (Age > 60 && Age <= 63) {
            if ((26 - i) * BasicSA + 5.0 * BasicSA >= 10 * BasicSA) {
                [DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 5.0 * BasicSA ]];
            } else {
                [DBValue addObject:[NSString stringWithFormat:@"%.3f", 10.0 * BasicSA]];
            }
        }
        
        //-------------------
        
        if (Age <= 40) {
            if (i == 25) {
                [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f",  BasicSA + 12.5 * BasicSA ]];
            } else {
                [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 12.5 * BasicSA ]];
            }
        } else if (Age > 40 && Age <= 50) {
            if ((25 - i) * BasicSA + 6.25 * BasicSA >= 12.5 * BasicSA) {
                [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 6.25 * BasicSA ]];
            } else {
                [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 12.5 * BasicSA]];
            }
        } else if (Age > 50 && Age <= 60){
            if ((25 - i) * BasicSA + 5.5 * BasicSA >= 11 * BasicSA) {
                [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 5.5 * BasicSA ]];
            } else{
                [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 11.0 * BasicSA]];
            }
        } else if (Age > 60 && Age <= 63){
            if ((25 - i) * BasicSA + 5.0 * BasicSA >= 10 * BasicSA) {
                [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 5.0 * BasicSA ]];
            } else {
                [DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 10.0 * BasicSA]];
            }
        }
        
        //------------------------
        
        if (i <= premiumPaymentOption) {
            if (i+ Age <= 64) {
                if (i == 1) {
                    TotalAD = [tempAnnualPremium doubleValue];
                } else {
                    TotalAD = TotalAD + [tempAnnualPremium doubleValue];
                }
            } else {
                TotalAD = 0.00;
            }
        } else {
            TotalAD = 0.00;
        }
        
        [aValue addObject: [NSString stringWithFormat:@"%.3f", TotalAD] ];
        [SummaryGuaranteedAddValue addObject:[aValue objectAtIndex:i-1]];
        //-----------------------------------
        
        //---------------- total premium paid ----------
        
        double sumOtherRider = 0.0;
        double tempRates = 0.00;
        double sumBasic = [tempAnnualPremium doubleValue ];
        
        NSString *tempHLPercentage;
        NSString *tempHLPercentageTerm;
        NSString *tempTempHL;
        NSString *tempTempHLTerm;
        NSString *tempHL1KSA;
        NSString *tempHL1KSATerm;
        NSString *tempHL100SA;
        NSString *tempHL100SATerm;
        
        double actualPremium = 0.0;
        double tempHLValue;
        double HL = 0.00;
        double baseValue = tempRates;
        double waiverRiderSA;
        for (int j =0; j<OtherRiderCode.count; j++) {
            if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HMM" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_IV" ]
                || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HSP_II" ] ) {
                
                if ( i <= [[OtherRiderTerm objectAtIndex:j] intValue ]   ) {
                    tempRates = 0.00;
                    
                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                        
                        if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HMM" ] ) {
                            if([OccpClass isEqualToString:@"2"]) {
                                QuerySQL = [NSString stringWithFormat:
                                            @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND "
                                            "occpClass = \"%@\" AND PlanOption=\"%@\" AND deductible = '%@' ",
                                            [OtherRiderCode objectAtIndex:j ],Age + i - 1, Age + i - 1,[sex substringToIndex:1], @"1", [[OtherRiderPlanOption objectAtIndex:j] stringByReplacingOccurrencesOfString:@"_" withString:@""], [OtherRiderDeductible objectAtIndex:j]];
                            } else {
                                QuerySQL = [NSString stringWithFormat:
                                            @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND "
                                            "occpClass = \"%@\" AND PlanOption=\"%@\" AND deductible = '%@' ",
                                            [OtherRiderCode objectAtIndex:j ],Age + i - 1, Age + i - 1,[sex substringToIndex:1], OccpClass, [[OtherRiderPlanOption objectAtIndex:j] stringByReplacingOccurrencesOfString:@"_" withString:@""], [OtherRiderDeductible objectAtIndex:j]];
                            }
                        } else if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_IV" ] ) {
                            QuerySQL = [NSString stringWithFormat:
                                        @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND "
                                        "occpClass = \"%@\" AND PlanOption=\"%@\" ",
                                        [OtherRiderCode objectAtIndex:j ],Age + i - 1, Age + i - 1,[sex substringToIndex:1], OccpClass, [[OtherRiderPlanOption objectAtIndex:j] stringByReplacingOccurrencesOfString:@"IVP_" withString:@""]];
                        } else if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HSP_II" ] ) {
                            
                            QuerySQL = [NSString stringWithFormat:
                                        @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND "
                                        "occpClass = \"%@\" AND RiderOpt=\"%@\" ",
                                        [OtherRiderCode objectAtIndex:j ],Age + i - 1, Age + i - 1, OccpClass, [OtherRiderPlanOption objectAtIndex:j]];
                        } else if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_II" ] ) {
                            QuerySQL = [NSString stringWithFormat:
                                        @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND "
                                        "occpClass = \"%@\" AND PlanOption=\"%@\" ",
                                        [OtherRiderCode objectAtIndex:j ],Age + i - 1, Age + i - 1,[sex substringToIndex:1], OccpClass, [OtherRiderPlanOption objectAtIndex:j]];
                        }
                        
                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                            if (sqlite3_step(statement) == SQLITE_ROW) {
                                tempRates = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] doubleValue ];
                                
                            }
                            sqlite3_finalize(statement);
                        } else{
                            
                            NSLog(@"%@",[[NSString alloc] initWithUTF8String:sqlite3_errmsg(contactDB)]) ;
                        }
                        
                        sqlite3_close(contactDB);
                    }
                    
                    tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:j];
                    tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:j];
                    tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                    tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                    
                    actualPremium = 0.0;
                    HL = 0.00;
                    baseValue = tempRates;
                    
                    if(![tempHLPercentage isEqualToString:@"(null)"]) {
                        if (i <= [tempHLPercentageTerm intValue ]) {
                            HL = [tempHLPercentage doubleValue];
                        }
                    }
                    
                    if(![tempHLPercentage isEqualToString:@"(null)"]) {
                        if (i <= [tempTempHLTerm intValue ]) {
                            HL = HL + [tempTempHL doubleValue];
                        }
                    }
                    
                    actualPremium = [self dblRoundToTwoDecimal:(baseValue)] +  [self dblRoundToTwoDecimal:(baseValue* HL)/100.00 ];
                    
                    sumOtherRider = sumOtherRider + actualPremium;
                    
                    tempHLPercentage = Nil;
                    tempHLPercentageTerm = Nil;
                    
                }
            } else{ //non medical rider, i is basic term policy year
                if ( i <= [[OtherRiderTerm objectAtIndex:j] intValue ]   ) {
                    
                    if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"EDB" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"ETPDB" ]) {
                        tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
                        tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
                        tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                        tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                        
                        if (i <= premiumPaymentOption) {
                            actualPremium = 0.0;
                            if([tempHL1KSA isEqualToString:@"(null)"]) {
                                actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                            } else {
                                if(i <= [tempHL1KSATerm intValue ] ){
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                } else {
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                                    - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000)  * [tempHL1KSA doubleValue];
                                }
                            }
                            
                            if (![tempTempHL isEqualToString:@"(null)"] ) {
                                if (i > [tempTempHLTerm intValue]) {
                                    actualPremium = actualPremium - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000) * [tempTempHL doubleValue];
                                }
                            }
                            sumOtherRider = sumOtherRider + actualPremium;
                        } else {
                            sumOtherRider = sumOtherRider + 0.00;
                        }
                        
                        tempHL1KSA = nil, tempHL1KSATerm = Nil;
                        
                    } else if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"WP30R" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"WP50R" ] ||
                               [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"WPTPD30R" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"WPTPD50R" ]) {
                        
                        tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
                        tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
                        tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                        tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                        
                        if (i <= [[OtherRiderPayingTerm objectAtIndex:j] integerValue]) {
                            tempHLValue = 0.00;
                            actualPremium = 0.00;
                            
                            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                            [formatter setMaximumFractionDigits:2];
                            [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
                            
                            if (![tempHL1KSA isEqualToString:@"(null)"]) {
                                if(i <= [tempHL1KSATerm intValue ]){
                                    tempHLValue = [tempHL1KSA doubleValue] * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000);
                                }
                            }
                            
                            if (![tempTempHL isEqualToString:@"(null)"]) {
                                if (i <= [tempTempHLTerm intValue ]) {
                                    tempHLValue = tempHLValue + [tempTempHL doubleValue] * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000);
                                }
                            }
                            
                            if ([[OccLoading objectAtIndex:0] doubleValue] != 0) {
                                tempHLValue = tempHLValue + [[OccLoading objectAtIndex:0] doubleValue] * 3 * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000.00);
                            }
                            
                            if([tempHL1KSATerm intValue ] == 0 && [tempTempHLTerm intValue ] == 0 ){
                                actualPremium = [[aStrOtherRiderAnnually objectAtIndex:j] doubleValue];
                            } else {
                                actualPremium = [[OtherRiderPremWithoutHLoading objectAtIndex:j] doubleValue] + [[formatter stringFromNumber:[NSNumber numberWithDouble:tempHLValue]] doubleValue];
                            }
                            
                            
                            sumOtherRider = sumOtherRider + actualPremium;
                        } else {
                            sumOtherRider = sumOtherRider + 0.00;
                        }
                        
                        tempHL1KSA = nil, tempHL1KSATerm = Nil;
                        
                    } else {
                        if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"CIWP" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"LCWP" ] ||
                            [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"PR" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"SP_PRE" ] ||
                            [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"SP_STD" ] ) {
                            
                            waiverRiderSA = [[strOriBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                            
                            if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"CIWP" ]) {
                                for (int q=0; q < OtherRiderCode.count; q++) {
                                    if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCPR"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIR"]  ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ICR"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_TW"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_TWP"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_EXC"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_MPP"])) {
                                        waiverRiderSA = waiverRiderSA +
                                        [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                    }
                                }
                            } else {
                                for (int q=0; q < OtherRiderCode.count; q++) {
                                    if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PLCP"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                          [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PTR"])) {
                                        waiverRiderSA = waiverRiderSA +
                                        [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                        
                                    }
                                }
                            }
                            
                            if (wpGYIRidersCode.count > 0) {
                                for (int q=0; q < wpGYIRidersCode.count; q++) {
                                    
                                    waiverRiderSA = waiverRiderSA + [[[wpGYIRidersPremAnnual objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                    
                                }
                            }
                            
                            tempHL100SA = [OtherRiderHL100SA objectAtIndex:j];
                            tempHL100SATerm = [OtherRiderHL100SATerm objectAtIndex:j];
                            tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                            tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                            
                            actualPremium = 0.0;
                            if([tempHL100SA isEqualToString:@"(null)"]) {
                                actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                            } else {
                                if(i  <= [tempHL100SATerm intValue ] ){
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                } else {
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                                    - (waiverRiderSA/100) * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/100) * [tempHL100SA doubleValue ] ;
                                }
                            }
                            
                            if (![tempTempHL isEqualToString:@"(null)"] ) {
                                if (i  > [tempTempHLTerm intValue]) {
                                    actualPremium = actualPremium -
                                    //((waiverRiderSA *  tempRiderSA/100)/100) * [tempTempHL doubleValue];
                                    (waiverRiderSA/100) * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/100) * [tempTempHL doubleValue ] ;
                                }
                            }
                            
                            sumOtherRider = sumOtherRider + actualPremium;
                            
                            tempHL100SA = Nil;
                            tempHL100SATerm = Nil;
                            
                        } else if([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HB" ] ){
                            tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:j];
                            tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:j];
                            tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                            tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                            
                            actualPremium = 0.0;
                            baseValue = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                            /([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100 + 1.00);
                            
                            if([tempHLPercentage isEqualToString:@"(null)"]) {
                                actualPremium = baseValue;
                            } else {
                                if ([tempTempHL isEqualToString:@"(null)"]) {
                                    actualPremium = baseValue;
                                } else {
                                    if(i  <= [tempHLPercentageTerm intValue ] && i  <= [tempTempHLTerm intValue ]    ){
                                        actualPremium = baseValue * ([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100  + 1.00);
                                    } else if(i  <= [tempHLPercentageTerm intValue ] && i  > [tempTempHLTerm intValue ]    ){
                                        actualPremium = baseValue * ([tempHLPercentage doubleValue]/100  + 1.00);
                                    } else if(i  > [tempHLPercentageTerm intValue ] && i  <= [tempTempHLTerm intValue ]    ){
                                        actualPremium = baseValue * ([tempTempHL doubleValue]/100  + 1.00);
                                    } else if(i  > [tempHLPercentageTerm intValue ] && i  > [tempTempHLTerm intValue ]    ){
                                        actualPremium = baseValue;
                                    }
                                }
                                
                            }
                            
                            sumOtherRider = sumOtherRider + actualPremium;
                            
                        }
                        else{ //rider is not CIWP, PR, LCWP, SP_PRE, SP_STD, HB, HLAWP Rider
                            tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
                            tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
                            tempTempHL = [OtherRiderTempHL objectAtIndex:j];
                            tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
                            
                            actualPremium = 0.0;
                            if([tempHL1KSA isEqualToString:@"(null)"]) {
                                actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                            } else {
                                if(i <= [tempHL1KSATerm intValue ] ){
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                } else {
                                    actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
                                    - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000)  * [tempHL1KSA doubleValue];
                                }
                            }
                            
                            if (![tempTempHL isEqualToString:@"(null)"] ) {
                                if (i > [tempTempHLTerm intValue]) {
                                    actualPremium = actualPremium - ([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000) * [tempTempHL doubleValue];
                                }
                            }
                            sumOtherRider = sumOtherRider + actualPremium;
                            
                            tempHL1KSA = nil;
                            tempHL1KSATerm = Nil;
                        }
                    }
                }
            }
        }
        
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMaximumFractionDigits:2];
        [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
        
        for (int j =0; j<wpGYIRidersCode.count; j++) {
            if ( i <= [[wpGYIRidersPayingTerm objectAtIndex:j] intValue ]   ) {
                
                tempHL1KSA = [wpGYIRiderHL1kSA objectAtIndex:j];
                tempHL1KSATerm = [wpGYIRiderHL1kSATerm objectAtIndex:j];
                tempTempHL = [wpGYIRiderTempHL objectAtIndex:j];
                tempTempHLTerm = [wpGYIRiderTempHLTerm objectAtIndex:j];
                tempHLValue = 0.00;
                actualPremium = 0.0;
                
                if (![tempHL1KSA isEqualToString:@"(null)"]) {
                    if(i <= [tempHL1KSATerm intValue ]){
                        tempHLValue = [tempHL1KSA doubleValue] * ([[wpGYIRidersSA objectAtIndex:j] doubleValue ]/1000.00);
                    }
                }
                
                if (![tempTempHL isEqualToString:@"(null)"]) {
                    if (i <= [tempTempHLTerm intValue ]) {
                        tempHLValue = tempHLValue + [tempTempHL doubleValue] * ([[wpGYIRidersSA objectAtIndex:j] doubleValue ]/1000.00);
                    }
                }
                
                if ([[OccLoading objectAtIndex:0] doubleValue] != 0) {
                    tempHLValue = tempHLValue + [[OccLoading objectAtIndex:0] doubleValue] * 20 * ([[wpGYIRidersSA objectAtIndex:j] doubleValue ]/1000.00);
                }
                
                tempHLValue = [[formatter stringFromNumber:[NSNumber numberWithDouble:tempHLValue]] doubleValue];
                
                if ([tempHL1KSATerm intValue ] == 0 && [tempTempHLTerm intValue ] == 0 ) {
                    actualPremium = [[aStrWPGYIRiderAnnually objectAtIndex:j] doubleValue];
                } else {
                    actualPremium = [[wpGYIRidersPremAnnualWithoutHLoading objectAtIndex:j] doubleValue] + tempHLValue;
                }
                
                sumOtherRider = sumOtherRider + actualPremium;
                
                tempHL1KSA = nil;
                tempHL1KSATerm = Nil;
            }
        }
        
        [TotalAllPremium addObject: [NSString stringWithFormat:@"%.2f", (sumBasic + sumOtherRider) ]];
        
        //----------------- total premium paid end ----------
        
        //------------- current cash dividend
        [CurrentCashDividendValueA addObject: [NSString stringWithFormat: @"%.8f",
                                               BasicSA * [[CurrentCashDividendRatesA objectAtIndex: i - 1] doubleValue ] / 100 ]];
        [CurrentCashDividendValueB addObject: [NSString stringWithFormat: @"%.9f",
                                               BasicSA * [[CurrentCashDividendRatesB objectAtIndex: i - 1] doubleValue ] / 100 ]];
        
        [SummaryNonGuaranteedCurrentCashDividendA addObject:[CurrentCashDividendValueA objectAtIndex:i - 1]];
        [SummaryNonGuaranteedCurrentCashDividendB addObject:[CurrentCashDividendValueB objectAtIndex:i - 1]];
        
        
        //----------- current cash dividend end ----------
        
        
        //------ accu cash dividend
        double CDInterestRateHigh = 0.0525;
        double CDInterestRateLow = 0.0325;
        if ([CashDividend isEqualToString:@"ACC"]) {
            
            if (i == 1) {
                [AccuCashDividendValueA addObject:[CurrentCashDividendValueA objectAtIndex:i -1 ]];
                [AccuCashDividendValueB addObject:[CurrentCashDividendValueB objectAtIndex:i-1]];
            } else {
                [AccuCashDividendValueA addObject: [NSString stringWithFormat: @"%.8f",
                                                    [[AccuCashDividendValueA objectAtIndex:i-2] doubleValue ] * (1.00 + CDInterestRateHigh) +
                                                    [[CurrentCashDividendValueA objectAtIndex:i-1] doubleValue ] ] ];
                [AccuCashDividendValueB addObject: [NSString stringWithFormat: @"%.9f",
                                                    [[AccuCashDividendValueB objectAtIndex:i-2] doubleValue ] * (1.00 + CDInterestRateLow) +
                                                    [[CurrentCashDividendValueB objectAtIndex:i-1] doubleValue ] ] ];
                
            }
        } else {
            [AccuCashDividendValueA addObject:@"-"];
            [AccuCashDividendValueB addObject:@"-"];
        }
        
        [SummaryNonGuaranteedAccuCashDividendA addObject:[AccuCashDividendValueA objectAtIndex:i-1]];
        [SummaryNonGuaranteedAccuCashDividendB addObject:[AccuCashDividendValueB objectAtIndex:i-1]];
        
        //------- accucash dividend end --------
        
        //------ accu yearly income ------
        if ([YearlyIncome isEqualToString:@"ACC"]) {
            if (i == 1) {
                [AccuYearlyIncomeValueA addObject:[arrayYearlyIncome objectAtIndex:i -1]];
                [AccuYearlyIncomeValueB addObject:[arrayYearlyIncome objectAtIndex:i -1]];
            } else {
                [AccuYearlyIncomeValueA addObject:[NSString stringWithFormat:@"%.8f",
                                                   [[AccuYearlyIncomeValueA objectAtIndex:i-2] doubleValue] * (1.00 + CDInterestRateHigh)
                                                   + [[arrayYearlyIncome objectAtIndex:i -1] doubleValue ] ] ];
                [AccuYearlyIncomeValueB addObject:[NSString stringWithFormat:@"%.9f",
                                                   [[AccuYearlyIncomeValueB objectAtIndex:i-2] doubleValue] * (1.00 + CDInterestRateLow)
                                                   + [[arrayYearlyIncome objectAtIndex:i -1] doubleValue ] ] ];
            }
        } else {
            [AccuYearlyIncomeValueA addObject:@"-"];
            [AccuYearlyIncomeValueB addObject:@"-"];
        }
        
        [SummaryNonGuaranteedAccuYearlyIncomeA addObject:@"0.00"]; //HLAWP basic dont have GYI
        [SummaryNonGuaranteedAccuYearlyIncomeB addObject:@"0.00"]; //HLAWP basic dont have GYI
        
        //------ accu yearly income end ------
        
        //------------- t dividend payable on surrender
        [tDividendValueA addObject: [NSString stringWithFormat: @"%.8f",
                                     BasicSA * [[tDividendRatesA objectAtIndex: i - 1] doubleValue ] / 100.00 ]];
        [tDividendValueB addObject: [NSString stringWithFormat: @"%.9f",
                                     BasicSA * [[tDividendRatesB objectAtIndex: i - 1] doubleValue ] / 100.00 ]];
        
        [SummaryNonGuaranteedTotalTDivA addObject:[tDividendValueA objectAtIndex:i - 1]] ;
        [SummaryNonGuaranteedTotalTDivB addObject:[tDividendValueB objectAtIndex:i - 1]] ;
        
        //----------- t dividend payable on surrender end ----------
        
        //-------------  spe TD
        [speValueA addObject: [NSString stringWithFormat: @"%.2f",
                               BasicSA * [[speRatesA objectAtIndex: i - 1] doubleValue ] / 100 ]];
        [speValueB addObject: [NSString stringWithFormat: @"%.2f",
                               BasicSA * [[speRatesB objectAtIndex: i - 1] doubleValue ] / 100 ]];
        
        [SummaryNonGuaranteedTotalSpeA addObject:[speValueA objectAtIndex:i - 1]] ;
        [SummaryNonGuaranteedTotalSpeB addObject:[speValueB objectAtIndex:i - 1]] ;
        
        //----------- spe TD end ----------
        
        //----------- total no guaranteed surrender value ----------
        double dTotalSurrenderValueA = 0.00;
        double dTotalSurrenderValueB = 0.00;
        
        if ([YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"] ) { // GYI ACC, CD ACC
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        } else if ([YearlyIncome isEqualToString:@"ACC"] && ![CashDividend isEqualToString:@"ACC"]) { // GYI ACC, CD payout
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        } else if (![YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"]) { // GYI Payout, CD ACC
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        } else { // GYI payout, CD payout
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        }
        
        [TotalSurrenderValueA addObject: [NSString stringWithFormat:@"%.8f", dTotalSurrenderValueA ]];
        [TotalSurrenderValueB addObject: [NSString stringWithFormat:@"%.9f", dTotalSurrenderValueB ]];
        
        [SummaryNonGuaranteedSurrenderValueA addObject:[TotalSurrenderValueA objectAtIndex:i-1]];
        [SummaryNonGuaranteedSurrenderValueB addObject:[TotalSurrenderValueB objectAtIndex:i-1]];
        
        if (i == maxPolYear) {
            BasicMaturityValueA = [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:maxPolYear - 1] doubleValue ];
            BasicMaturityValueB = [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:maxPolYear - 1] doubleValue ];
            
            EntireMaturityValueA = BasicMaturityValueA;
            EntireMaturityValueB = BasicMaturityValueB;
        }
        
        //------------ total surrender value end ------
        
        //----------- total non guarantee DB value ----------
        double dTotalDBValueA = 0;
        double dTotalDBValueB = 0;
        
        if ([YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"] ) {
            dTotalDBValueA = [[DBIncValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[speValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalDBValueB = [[DBIncValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[speValueB objectAtIndex:i - 1 ] doubleValue ];
            
        } else if ([YearlyIncome isEqualToString:@"ACC"] && ![CashDividend isEqualToString:@"ACC"]) {
            dTotalDBValueA = [[DBIncValue objectAtIndex:i-1] doubleValue ] +
            [[speValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalDBValueB = [[DBIncValue objectAtIndex:i-1] doubleValue ] +
            [[speValueB objectAtIndex:i - 1 ] doubleValue ];
            
        } else if (![YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"]) {
            dTotalDBValueA = [[DBIncValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[speValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalDBValueB = [[DBIncValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[speValueB objectAtIndex:i - 1 ] doubleValue ];
            
        } else {
            dTotalDBValueA = [[DBIncValue objectAtIndex:i-1] doubleValue ] +
            [[speValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalDBValueB = [[DBIncValue objectAtIndex:i-1] doubleValue ] +
            [[speValueB objectAtIndex:i - 1 ] doubleValue ];
            
        }
        
        [TotalDBValueA addObject: [NSString stringWithFormat:@"%.3f", dTotalDBValueA ]];
        [TotalDBValueB addObject: [NSString stringWithFormat:@"%.3f", dTotalDBValueB ]];
        
        [SummaryNonGuaranteedDBValueA addObject:[TotalDBValueA objectAtIndex:i-1]];
        [SummaryNonGuaranteedDBValueB addObject:[TotalDBValueB objectAtIndex:i-1]];
        
        //------------ total DB value end ------
        
        [AnnualPremium addObject:tempAnnualPremium];
    }
    
    int skipCount=1;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        NSString *strAccuCDA = @"";
        NSString *strAccuCDB = @"";
        NSString *strAccuYIA = @"";
        NSString *strAccuYIB = @"";
        NSString *DBYearlyIncome = @"";
        
        id col1;
        NSString* col2;
        double col22 = 0.00;
        double col23 = 0.00;
        double col3 = 0.00;
        double col4 = 0.00;
        double col5 = 0.00;
        double col6a = 0.00;
        double col7a = 0.00;
        id col7;
        
        double col12 = 0.00;
        double col13 = 0.00;
        NSString* col16 = @"";
        NSString* col17 = @"";
        double col18 = 0.00;
        double col19 = 0.00;
        double col20 = 0.00;
        double col21 = 0.00;
        
        NSString* col14 = @"";
        NSString* col15 = @"";
        for (int a= 1; a<=maxPolYear; a++) {
            if (Age >= 0){
                inputAge = Age + a;
                
                strAccuCDA = @"";
                strAccuCDB = @"";
                strAccuYIA = @"";
                strAccuYIB = @"";
                
                if ([CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"]) {
                    strAccuCDA = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueA objectAtIndex:a-1] doubleValue ])];
                    strAccuCDB = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueB objectAtIndex:a-1] doubleValue ])];
                    strAccuYIA = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueA objectAtIndex:a-1] doubleValue ])];
                    strAccuYIB = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueB objectAtIndex:a-1] doubleValue ])];
                } else if ([CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) {
                    strAccuCDA = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueA objectAtIndex:a-1] doubleValue ])];
                    strAccuCDB = [NSString stringWithFormat:@"%.0f", round( [[AccuCashDividendValueB objectAtIndex:a-1] doubleValue ])];
                    strAccuYIA = [NSString stringWithFormat:@"-"];
                    strAccuYIB = [NSString stringWithFormat:@"-"];
                } else if (![CashDividend isEqualToString:@"ACC"] && [YearlyIncome isEqualToString:@"ACC"]) {
                    strAccuCDA = [NSString stringWithFormat:@"-"];
                    strAccuCDB = [NSString stringWithFormat:@"-"];
                    strAccuYIA = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueA objectAtIndex:a-1] doubleValue ])];
                    strAccuYIB = [NSString stringWithFormat:@"%.0f", round( [[AccuYearlyIncomeValueB objectAtIndex:a-1] doubleValue ])];
                } else if (![CashDividend isEqualToString:@"ACC"] && ![YearlyIncome isEqualToString:@"ACC"]) {
                    strAccuCDA = [NSString stringWithFormat:@"-"];
                    strAccuCDB = [NSString stringWithFormat:@"-"];
                    strAccuYIA = [NSString stringWithFormat:@"-"];
                    strAccuYIB = [NSString stringWithFormat:@"-"];
                }
                
                DBYearlyIncome = @"";
                DBYearlyIncome =  [arrayYearlyIncome objectAtIndex:a-1];
                
                if(a>20 && skipCount<5) {
                    skipCount++;
                    continue;
                }
                skipCount = 1;
                
                col1 = [AnnualPremium objectAtIndex:a -1];
                col2 = [NSString stringWithFormat:@"%f",round([[SurrenderValue objectAtIndex:a-1] doubleValue ])]; //DBYearlyIncome;
                col22 = [[YearlyIncomePayout objectAtIndex:a-1] doubleValue];
                
                col3 = round([[DBIncValue objectAtIndex:a-1] doubleValue ]);
                col7 = [TotalAllPremium objectAtIndex:a-1];
                
                col12 = round( [[CurrentCashDividendValueA objectAtIndex:a-1] doubleValue ]);
                col13 = round( [[CurrentCashDividendValueB objectAtIndex:a-1] doubleValue ]);
                col16 = strAccuYIA;
                col17 = strAccuYIB;
                col18 = round([[tDividendValueA objectAtIndex:a-1] doubleValue ]);
                col19 = round([[tDividendValueB objectAtIndex:a-1 ] doubleValue ]);
                col20 = round([[speValueA objectAtIndex:a-1] doubleValue ]);
                col21 = round( [[speValueB objectAtIndex:a-1] doubleValue]);
                
                col14 = strAccuCDA;
                col15 = strAccuCDB;
                
                col23 = [col2 doubleValue] + [col16 doubleValue] + col18;
                //                    col3 = [col2 doubleValue] + [col17 doubleValue] + col19;
                col4 = [col2 doubleValue] + [col14 doubleValue] + col18; //total non guaranteed surrender value A
                col5 = [col2 doubleValue] + [col15 doubleValue] + col19; //total non guaranteed surrender value B
                
                col6a = col3 + [col14 doubleValue] + col20; //total non guaranteed DB A
                col7a = col3 + [col15 doubleValue] + col21; //total non guaranteed DB B
                
                QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Basic (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\", "
                            "\"col1\",\"col2\",\"col3\",\"col4\", "
                            "\"col5\",\"col6\",\"col7\", "
                            "\"col8\",\"col9\",\"col10\",\"col11\", "
                            "\"col12\",\"col13\", \"col14\",\"col15\", "
                            "\"col16\", \"col17\",\"col18\",\"col19\", "
                            "\"col20\",\"col21\", "
                            "\"col22\",\"col23\" ) VALUES ( "
                            " \"%@\",\"%d\",\"DATA\",\"%d\",\"%d\",\"%@\",\"%@\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", "
                            "\"%.0f\",\"%@\",\"%.0f\",\"%.0f\",\"%@\",\"%@\",\"%@\",\"%@\",\"%.0f\",\"%.0f\",\"%.0f\",\"%.0f\", \"%.2f\", \"%.2f\")",
                            SINo, a, a, inputAge,
                            col1, col2, col3, col4,
                            round( [[TotalSurrenderValueB objectAtIndex:a-1 ] doubleValue ]),
                            round( [[TotalDBValueA objectAtIndex:a-1 ] doubleValue ]),
                            col7a,
                            round([[TotalSurrenderValueB objectAtIndex:a-1] doubleValue ]),
                            round( [[TotalDBValueA objectAtIndex:a-1 ] doubleValue ]), col5,
                            col7,
                            col12, col13,
                            col14, col15,
                            col16,col17,
                            col18, col19,
                            col20, col21,
                            col22, col23];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                
                strAccuCDA = Nil;
                strAccuCDB = Nil;
                strAccuYIA = Nil;
                strAccuYIB = Nil;
                DBYearlyIncome = Nil;
            }
        }
        sqlite3_close(contactDB);
    }
    
    rates = Nil;
    SurrenderRates = Nil;
    SurrenderValue = Nil;
    DBRates = Nil;
    DBValue = Nil;
    DBRatesEnd = Nil;
    DBValueEnd = Nil;
    aValue = Nil;
    AnnualPremium = Nil;
    arrayYearlyIncome = Nil;
    TotalAllPremium = Nil;
    CurrentCashDividendRatesA = Nil;
    CurrentCashDividendValueA = Nil;
    CurrentCashDividendRatesB = Nil;
    CurrentCashDividendValueB = Nil;
    AccuCashDividendValueA = Nil;
    AccuCashDividendValueB = Nil;
    AccuYearlyIncomeValueA = Nil;
    AccuYearlyIncomeValueB = Nil;
    tDividendRatesA = Nil;
    tDividendValueA = Nil;
    tDividendRatesB = Nil;
    tDividendValueB = Nil;
    speRatesA = Nil;
    speValueA = Nil;
    speRatesB = Nil;
    speValueB = Nil;
    TotalSurrenderValueA = Nil;
    TotalSurrenderValueB = Nil;
    TotalDBValueA = Nil;
    TotalDBValueB = Nil;
    QuerySQL = Nil;
    TotalPartialYearlyIncome = nil;
    YearlyIncomePayout = nil;
    
    NSLog(@"insert to SI_Temp_Trad_Basic --- End");
    
}

-(void)InsertToSI_Temp_Trad_Rider{
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    NSMutableArray *TotalRiderSurrenderValue = [[NSMutableArray alloc] init ];
    
    NSLog(@"insert to SI_Temp_Trad_Rider --- start");
    if (OtherRiderCode.count > 0) {
        for (int x = 0; x < PolicyTerm; x++) {
            [TotalRiderSurrenderValue addObject:@"0.00"];
        }
        double actualPremium = 0.0;
        double tempHLValue;
        double waiverRiderRoundedUp;
        
        NSMutableArray *RiderCol1;
        NSMutableArray *RiderCol2;
        NSMutableArray *RiderCol3;
        NSMutableArray *RiderCol4;
        NSMutableArray *RiderCol5;
        NSMutableArray *RiderCol6;
        NSMutableArray *RiderCol7;
        NSMutableArray *RiderCol8;
        NSMutableArray *RiderCol9;
        NSMutableArray *RiderCol10;
        NSMutableArray *RiderCol11;
        NSMutableArray *RiderCol12;
        
        NSString *tempRiderCode;
        NSString *tempRiderDesc;
        NSRange temprange;
        NSString *tempRiderPlanOption;
        NSString *tempRiderDeduc;
        double tempRiderSA;
        int tempRiderTerm;
        double tempPremium;
        NSMutableArray *tempCol1, *tempCol2, *tempCol3, *tempCol4;
        NSString *tempHL1KSA;
        NSString *tempHL1KSATerm;
        NSString *tempHL100SA;
        NSString *tempHL100SATerm;
        NSString *tempHLPercentage;
        NSString *tempHLPercentageTerm;
        NSString *tempTempHL;
        NSString *tempTempHLTerm;
        NSString *tempPremWithoutHLoading;
        
        int item;
        int NoOfPages = ceil(OtherRiderCode.count/3.00);
        
        double waiverRiderSA;
        double waiverRiderSASemiAnnual;
        double waiverRiderSAQuarterly;
        double waiverRiderSAMonthly;
        
        double CPlusSA = 0.00;
        double tempTotalRiderSurrenderValue = 0.00;
        NSMutableArray *Rate;
        int rowsToAdd;
        double CI = 0.0;
        double juv;
        
        for (int page =1; page <=NoOfPages; page++) {
            RiderCol1 = [[NSMutableArray alloc] init ];
            RiderCol2 = [[NSMutableArray alloc] init ];
            RiderCol3 = [[NSMutableArray alloc] init ];
            RiderCol4 = [[NSMutableArray alloc] init ];
            RiderCol5 = [[NSMutableArray alloc] init ];
            RiderCol6 = [[NSMutableArray alloc] init ];
            RiderCol7 = [[NSMutableArray alloc] init ];
            RiderCol8 = [[NSMutableArray alloc] init ];
            RiderCol9 = [[NSMutableArray alloc] init ];
            RiderCol10 = [[NSMutableArray alloc] init ];
            RiderCol11 = [[NSMutableArray alloc] init ];
            RiderCol12 = [[NSMutableArray alloc] init ];
            
            for (int Rider =0; Rider < 3; Rider++) {
                item = 3 * (page - 1) + Rider;
                if (item < OtherRiderCode.count) {
                    
                    tempRiderCode = [OtherRiderCode objectAtIndex:item];
                    tempRiderDesc = [OtherRiderDesc objectAtIndex:item];
                    temprange = [tempRiderDesc rangeOfString:@"("]; // to hide (30 years term)
                    tempRiderPlanOption = [OtherRiderPlanOption objectAtIndex:item];
                    tempRiderDeduc = [OtherRiderDeductible objectAtIndex:item];
                    
//                    if (temprange.location != NSNotFound &&
//                        ([tempRiderCode isEqualToString:@"WB30R"] || [tempRiderCode isEqualToString:@"WB50R"] || [tempRiderCode isEqualToString:@"WBI6R30"] ||
//                         [tempRiderCode isEqualToString:@"WBD10R30"] || [tempRiderCode isEqualToString:@"WP30R"] || [tempRiderCode isEqualToString:@"WP50R"] ||
//                         [tempRiderCode isEqualToString:@"EDUWR"] || [tempRiderCode isEqualToString:@"WPTPD30R"] || [tempRiderCode isEqualToString:@"WPTPD50R"] )) {
//                            tempRiderDesc = [tempRiderDesc substringToIndex:temprange.location];                            
//                    } else
                    if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"SP_PRE"] || [tempRiderCode isEqualToString:@"SP_STD"] ||
                               [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
                        tempRiderDesc =  [NSString stringWithFormat:@"%@ (%@%%)", tempRiderDesc, [OtherRiderSA objectAtIndex:item]];
                    } else if ([tempRiderCode isEqualToString:@"HMM"] || [tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"MG_II"] ||
                               [tempRiderCode isEqualToString:@"MG_IV"] || [tempRiderCode isEqualToString:@"PA"]) {
                        tempRiderDesc = [NSString stringWithFormat:@"%@ (Class %@)", tempRiderDesc, OccpClass];
                        if ([tempRiderCode isEqualToString:@"HMM"]) {
                            tempRiderDesc = [NSString stringWithFormat:@"%@ (Deductible %@)", tempRiderDesc, tempRiderDeduc];
                        }
                    } else if ([tempRiderCode isEqualToString:@"C+"]) {
                        NSString *coverOption = @"";
                        if ([tempRiderPlanOption isEqualToString:@"L"]) {
                            coverOption = @"Level Cover";
                        }
                        else if ([tempRiderPlanOption isEqualToString:@"I"]) {
                            coverOption = @"Increasing Cover";
                        }
                        else if ([tempRiderPlanOption isEqualToString:@"B"]) {
                            coverOption = @"Level Cover with NCB";
                        }
                        else if ([tempRiderPlanOption isEqualToString:@"N"]) {
                            coverOption = @"Increasing Cover with NCB";
                        }
                        tempRiderDesc = [NSString stringWithFormat:@"%@ (%@)", tempRiderDesc, coverOption];
                    }
                    tempRiderSA = [[OtherRiderSA objectAtIndex:item] doubleValue ];
                    tempRiderTerm = [[OtherRiderTerm objectAtIndex:item] intValue ];
                    tempPremium = [[aStrOtherRiderAnnually objectAtIndex:item] doubleValue ];
                    //double tempPremiumWithoutLoading = [[aStrOtherRiderAnnually objectAtIndex:item] doubleValue ];
                    
                    tempCol1 = [[NSMutableArray alloc] init ];
                    tempCol2 = [[NSMutableArray alloc] init ];
                    tempCol3 = [[NSMutableArray alloc] init ];
                    tempCol4 = [[NSMutableArray alloc] init ];
                    tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:item];
                    tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:item];
                    tempHL100SA = [OtherRiderHL100SA objectAtIndex:item];
                    tempHL100SATerm = [OtherRiderHL100SATerm objectAtIndex:item];
                    tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:item];
                    tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:item];
                    tempTempHL = [OtherRiderTempHL objectAtIndex:item];
                    tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:item];
                    tempPremWithoutHLoading = [OtherRiderPremWithoutHLoading objectAtIndex:item]; //this is the premium without the addition of health loading and/or occloading
                    
                    for (int row = 0; row < 3; row++) {
                        
                        if (row == 0) {
                            [tempCol1 addObject:tempRiderDesc ];
                            [tempCol2 addObject:@"" ];
                            [tempCol3 addObject:@"" ];
                            [tempCol4 addObject:@"" ];
                            
                        } else if (row == 1) {
                            if ([tempRiderCode isEqualToString:@"CCTR"]) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Surrender<br/> Value" ];
                                [tempCol3 addObject:@"Death/TPD<br/> Benefit" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"SP_PRE"] || [tempRiderCode isEqualToString:@"SP_STD"] ||
                                     [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Sum<br/>Assured" ];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"PTR"]) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Surrender<br/>Value" ];
                                [tempCol3 addObject:@"Death/TPD<br/>Benefit" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"LPPR"]) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Surrender<br/>Value" ];
                                [tempCol3 addObject:@"Death/TPD<br/>Benefit" ];
                                [tempCol4 addObject:@"Guaranteed<br/>Cash Payment" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"PA"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Accidental Death/TPD Benefit" ];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"CIR"] || [tempRiderCode isEqualToString:@"ACIR"] || [tempRiderCode isEqualToString:@"ACIR_WL"] ||
                                     [tempRiderCode isEqualToString:@"ACIR_MPP"] || [tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"] ||
                                     [tempRiderCode isEqualToString:@"ACIR_EXC"]) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Critical Illness Benefit" ];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"LCPR"] || [tempRiderCode isEqualToString:@"PLCP"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Surrender<br/>Value" ];
                                [tempCol3 addObject:@"Death/TPD<br/>Benefit" ];
                                [tempCol4 addObject:@"Critical Illness Benefit" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"C+"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Sum<br/>Assured" ];
                                [tempCol3 addObject:@"Guaranteed Surrender Value(if no claim admitted)" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"HPP"] || [tempRiderCode isEqualToString:@"HPPP"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Sum<br/>Assured" ];
                                [tempCol3 addObject:@"Guaranteed Surrender Value" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"EDB"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Death<br/>Benefit" ];
                                [tempCol3 addObject:@"Cash Surrender Value" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"ETPDB"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"TPD<br/>Benefit" ];
                                [tempCol3 addObject:@"OAD<br/>Benefit" ];
                                [tempCol4 addObject:@"Cash Surrender Value" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"WP30R"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Death<br/>Benefit" ];
                                [tempCol3 addObject:@"Cash Surrender Value" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"WP50R"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"Death<br/>Benefit" ];
                                [tempCol3 addObject:@"Cash Surrender Value" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"WPTPD30R"] || [tempRiderCode isEqualToString:@"WPTPD50R"] ) {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"TPD<br/>Benefit" ];
                                [tempCol3 addObject:@"OAD<br/>Benefit" ];
                                [tempCol4 addObject:@"Cash Surrender Value" ];
                            }
                            else {
                                [tempCol1 addObject:@"Annual Premium<br/>(Beg. of Year)" ];
                                [tempCol2 addObject:@"-" ];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                        } else if (row == 2) {
                            if ([tempRiderCode isEqualToString:@"CCTR"]) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Nilai Penyerahan" ];
                                [tempCol3 addObject:@"Faedah Kematian/TPD" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"SP_PRE"] || [tempRiderCode isEqualToString:@"SP_STD"] ||
                                     [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Jumlah Diinsuranskan" ];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"PTR"]) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Nilai Penyerahan" ];
                                [tempCol3 addObject:@"Faedah Kematian/TPD" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"LPPR"]) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Nilai Penyerahan" ];
                                [tempCol3 addObject:@"Faedah Kematian/TPD" ];
                                [tempCol4 addObject:@"Cash Payment Terjamin" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"PA"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Faedah Kematian Kemalangan/TPD " ];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"CIR"] || [tempRiderCode isEqualToString:@"ACIR"] || [tempRiderCode isEqualToString:@"ACIR_WL"] ||
                                     [tempRiderCode isEqualToString:@"ACIR_MPP"] || [tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"] ||
                                     [tempRiderCode isEqualToString:@"ACIR_EXC"]) {
                                
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Faedah Penyakit Kritikal" ];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"LCPR"] || [tempRiderCode isEqualToString:@"PLCP"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Nilai Penyerahan" ];
                                [tempCol3 addObject:@"Faedah Kematian/TPD" ];
                                [tempCol4 addObject:@"Faedah Penyakit Kritikal" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"C+"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Jumlah Diinsuranskan" ];
                                [tempCol3 addObject:@"Nilai Penyerahan Terjamin(jika tiada tuntutan)" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"HPP"] || [tempRiderCode isEqualToString:@"HPPP"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Jumlah Diinsuranskan" ];
                                [tempCol3 addObject:@"Nilai Penyerahan Terjamin" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"EDB"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Kematian TPD" ];
                                [tempCol3 addObject:@"Nilai Penyerahan Tunai" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"ETPDB"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Faedah TPD" ];
                                [tempCol3 addObject:@"Faedah OAD" ];
                                [tempCol4 addObject:@"Nilai Penyerahan Tunai" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"WP30R"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Faedah Kematian" ];
                                [tempCol3 addObject:@"Nilai Penyerahan Tunai" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"WP50R"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Faedah Kematian" ];
                                [tempCol3 addObject:@"Nilai Penyerahan Tunai" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            else if ([tempRiderCode isEqualToString:@"WPTPD30R"] || [tempRiderCode isEqualToString:@"WPTPD50R"] ) {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"Faedah TPD" ];
                                [tempCol3 addObject:@"Faedah OAD" ];
                                [tempCol4 addObject:@"Nilai Penyerahan Tunai" ];
                            }
                            else {
                                [tempCol1 addObject:@"Premium Tahunan<br>(Permulaan Tahun)" ];
                                [tempCol2 addObject:@"-" ];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                        }
                    }
                    
                    CPlusSA = 0.00;
                    tempTotalRiderSurrenderValue = 0.00;
                    Rate = [[NSMutableArray alloc] init ];
                    
                    for (int i = 0; i < PolicyTerm; i++) {
                        if (i < tempRiderTerm) {
                            if ([tempRiderCode isEqualToString:@"CCTR"]) {
                                
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" AND Term = \"%d\""
                                                    , tempRiderCode, Age, tempRiderTerm ];
                                        
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                                
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {
                                        rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = tempPremium;
                                }
                                else{
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = tempPremium;
                                    }
                                    else{
                                        actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"%.0f", tempRiderSA]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                
                                tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
                                tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol2 objectAtIndex:i] doubleValue ];
                                [TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
                                
                            }
                            else if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"SP_PRE"] || [tempRiderCode isEqualToString:@"SP_STD"] ||
                                     [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
                                
                                //waiver SA
                                waiverRiderSA = [[strOriBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                waiverRiderSASemiAnnual = [[strOriBasicSemiAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                waiverRiderSAQuarterly = [[strOriBasicQuarterly stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                waiverRiderSAMonthly = [[strOriBasicMonthly stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                
                                
                                if ([tempRiderCode isEqualToString:@"CIWP"]) {
                                    
                                    for (int q=0; q < OtherRiderCode.count; q++) {
                                        if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCPR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIR"]  ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ICR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_TW"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_TWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_EXC"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_MPP"])) {
                                            waiverRiderSA = waiverRiderSA + [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSASemiAnnual = waiverRiderSASemiAnnual +[[[aStrOtherRiderSemiAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSAQuarterly = waiverRiderSAQuarterly +[[[aStrOtherRiderQuarterly objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSAMonthly = waiverRiderSAMonthly +[[[aStrOtherRiderMonthly objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            
                                        }
                                        else if ([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"ACIR_MPP"]) {
                                            
                                            waiverRiderSA = waiverRiderSA -
                                            (( ([[OtherRiderSA objectAtIndex:q] doubleValue]/ BasicSA) * [[strOriBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]));
                                            
                                            waiverRiderSASemiAnnual = waiverRiderSASemiAnnual -
                                            (( ([[OtherRiderSA objectAtIndex:q] doubleValue]/ BasicSA)* [[strOriBasicSemiAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]) );
                                            
                                            
                                            waiverRiderSAQuarterly = waiverRiderSAQuarterly -
                                            (( ([[OtherRiderSA objectAtIndex:q] doubleValue]/ BasicSA)* [[strOriBasicQuarterly stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]) );
                                            
                                            
                                            waiverRiderSAMonthly = waiverRiderSAMonthly -
                                            (( ([[OtherRiderSA objectAtIndex:q] doubleValue]/ BasicSA)* [[strOriBasicMonthly stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]) );
                                            
                                        }
                                    }
                                }
                                else if ([tempRiderCode isEqualToString:@"SP_STD"])  {
                                    for (int q=0; q < OtherRiderCode.count; q++) {
                                        if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PLCP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PTR"] )) {
                                            waiverRiderSA = waiverRiderSA +
                                            [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSASemiAnnual = waiverRiderSASemiAnnual +
                                            [[[aStrOtherRiderSemiAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSAQuarterly = waiverRiderSAQuarterly +
                                            [[[aStrOtherRiderQuarterly objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSAMonthly = waiverRiderSAMonthly +
                                            [[[aStrOtherRiderMonthly objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            
                                        }
                                    }
                                }
                                else {
                                    for (int q=0; q < OtherRiderCode.count; q++) {
                                        if (!([[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PLCP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PR"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"LCWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_STD"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"SP_PRE"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"CIWP"] ||
                                              [[OtherRiderCode objectAtIndex:q ] isEqualToString:@"PTR"])) {
                                            waiverRiderSA = waiverRiderSA +
                                            [[[aStrOtherRiderAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSASemiAnnual = waiverRiderSASemiAnnual +
                                            [[[aStrOtherRiderSemiAnnually objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSAQuarterly = waiverRiderSAQuarterly +
                                            [[[aStrOtherRiderQuarterly objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            waiverRiderSAMonthly = waiverRiderSAMonthly +
                                            [[[aStrOtherRiderMonthly objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                            
                                        }
                                    }
                                }
                                
                                if (wpGYIRidersCode.count > 0) {
                                    for (int q=0; q < wpGYIRidersCode.count; q++) {
                                        
                                        waiverRiderSA = waiverRiderSA + [[[wpGYIRidersPremAnnual objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                        waiverRiderSASemiAnnual =waiverRiderSASemiAnnual+[[[wpGYIRidersPremSemiAnnual objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                        waiverRiderSAQuarterly = waiverRiderSAQuarterly + [[[wpGYIRidersPremQuarter objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                        waiverRiderSAMonthly = waiverRiderSAMonthly + [[[wpGYIRidersPremMonth objectAtIndex:q] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
                                    }
                                }
                                
                                actualPremium = 0.0;
                                tempHLValue = 0.0;
                                
                                if (![tempHL100SA isEqualToString:@"(null)"]) {
                                    if(i < [tempHL100SATerm intValue ]){
                                        //tempHLValue = ((waiverRiderSA *  tempRiderSA/100)/100) * [tempHL100SA doubleValue];
                                        tempHLValue = [tempHL100SA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"]) {
                                    if (i < [tempTempHLTerm intValue ]) {
                                        //tempHLValue = tempHLValue + ((waiverRiderSA *  tempRiderSA/100)/100) * [tempTempHL doubleValue];
                                        tempHLValue = tempHLValue + [tempTempHL doubleValue];
                                    }
                                }
                                
                                waiverRiderRoundedUp = [self dblRoundToTwoDecimal:waiverRiderSA * tempRiderSA/100];
                                
                                if ([tempRiderCode isEqualToString:@"CIWP"]) {
                                    actualPremium = [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * ([tempPremWithoutHLoading doubleValue]/100.00)]  +
                                    [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * (tempRiderTerm/1000.00 * 0.00 + tempHLValue/100)];
                                }
                                else if ([tempRiderCode isEqualToString:@"SP_PRE"]) {
                                    actualPremium = [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * ([tempPremWithoutHLoading doubleValue]/100.00)]  +
                                    [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * (tempRiderTerm/1000.00 * [[OccLoading objectAtIndex:1] doubleValue] + tempHLValue/100)];
                                }
                                else{
                                    actualPremium = [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * ([tempPremWithoutHLoading doubleValue]/100.00)]  +
                                    [self dblRoundToTwoDecimal:1 * waiverRiderRoundedUp * (tempRiderTerm/1000.00 * [[OccLoading objectAtIndex:1] doubleValue] + tempHLValue/100)];
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", waiverRiderSA *  tempRiderSA/100]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                
                                if (i == 1) {
                                    [gWaiverAnnual addObject:[NSString stringWithFormat:@"%.9f", waiverRiderSA *  tempRiderSA/100.00] ];
                                    [gWaiverSemiAnnual addObject:[NSString stringWithFormat:@"%.9f", waiverRiderSASemiAnnual *  tempRiderSA/100.00] ];
                                    [gWaiverQuarterly addObject:[NSString stringWithFormat:@"%.9f", waiverRiderSAQuarterly *  tempRiderSA/100.00] ];
                                    [gWaiverMonthly addObject:[NSString stringWithFormat:@"%.9f", waiverRiderSAMonthly *  tempRiderSA/100.00] ];
                                    
                                }
                            }
                            else if ([tempRiderCode isEqualToString:@"PTR"]) { //for payor only
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" AND Term = \"%d\""
                                                    , tempRiderCode, PayorAge, tempRiderTerm ];
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                                
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {
                                        rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = tempPremium;
                                } else {
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = tempPremium;
                                    } else {
                                        actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"%.0f", tempRiderSA]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                
                                tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
                                tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol2 objectAtIndex:i] doubleValue ];
                                [TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
                                
                            }
                            else if ([tempRiderCode isEqualToString:@"LPPR"]) {
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" AND Term = \"%d\""
                                                    , tempRiderCode, Age, tempRiderTerm ];
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {
                                        rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = tempPremium;
                                } else {
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = tempPremium;
                                    } else {
                                        actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"%.0f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"%.0f", tempRiderSA]];
                                
                                tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
                                tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol2 objectAtIndex:i] doubleValue ];
                                [TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
                            }
                            else if ([tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"PA"]) {
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = tempPremium;
                                } else {
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = tempPremium;
                                    } else {
                                        actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%0ff", tempRiderSA]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            else if ([tempRiderCode isEqualToString:@"CIR"] || [tempRiderCode isEqualToString:@"ACIR"] || [tempRiderCode isEqualToString:@"ACIR_WL"] ||
                                     [tempRiderCode isEqualToString:@"ACIR_MPP"] || [tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"] ||
                                     [tempRiderCode isEqualToString:@"ACIR_EXC"]) {
                                
                                CI = 0.0;
                                juv = [self getJuvenileRate:(Age + i + 1)];
                                
                                if ([tempRiderCode isEqualToString:@"CIR"] ||
                                    [tempRiderCode isEqualToString:@"ACIR"]) {
                                    CI = tempRiderSA;
                                } else if ([tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"]) {
                                    if (i > 20 && Age + i > 55) {
                                        CI = tempRiderSA * 0.5;
                                    }
                                    else {
                                        CI = tempRiderSA;
                                    }
                                }
                                else if ([tempRiderCode isEqualToString:@"ACIR_EXC"]) {
                                    if (Age <= 40 && Age + i <=60) {
                                        CI = tempRiderSA * juv;
                                    }
                                    else if (Age <= 40 && Age + i > 60) {
                                        CI = 2/3 * tempRiderSA * juv;
                                    }
                                    else if (Age > 40 && i <= 20) {
                                        CI = tempRiderSA * juv;
                                    }
                                    else if (Age > 40 && i > 20) {
                                        CI = 2/3 * tempRiderSA * juv;
                                    }
                                }
                                else if ([tempRiderCode isEqualToString:@"ACIR_MPP"]) {
                                    CI = tempRiderSA * juv;
                                    
                                }
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = tempPremium;
                                } else {
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = tempPremium;
                                    } else {
                                        actualPremium = tempPremium - (CI/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (CI/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%.2f", CI]];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            } else if ([tempRiderCode isEqualToString:@"LCPR"] || [tempRiderCode isEqualToString:@"PLCP"] ) {
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        if ([tempRiderCode isEqualToString:@"LCPR"]) {
                                            QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" AND Term = \"%d\""
                                                        , tempRiderCode, Age, tempRiderTerm ];
                                        } else { //for payor only
                                            QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" AND Term = \"%d\""
                                                        , tempRiderCode, PayorAge, tempRiderTerm ];
                                            
                                        }
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                                
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {
                                        rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = tempPremium;
                                } else {
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = tempPremium;
                                    } else {
                                        actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"%.2f", tempRiderSA] ];
                                [tempCol4 addObject:[NSString stringWithFormat:@"%.2f", tempRiderSA]];
                                
                                tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
                                tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol2 objectAtIndex:i] doubleValue ];
                                [TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
                            }
                            else if ([tempRiderCode isEqualToString:@"C+"] ) {
                                
                                if (i == 0) { //execute only one time to get the rates and put in array
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        QuerySQL = [NSString stringWithFormat:@"Select Rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND "
                                                    " Age = \"%d\" AND Term = \"%d\" AND Sex = \"%@\" AND planOption = \"%@\""
                                                    , tempRiderCode, Age, tempRiderTerm, [sex substringToIndex:1], tempRiderPlanOption ];
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while  (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                                
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {										
                                        rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                    
                                }
                                
                                if ([tempRiderPlanOption isEqualToString:@"I"] || [tempRiderPlanOption isEqualToString:@"N"]  ) {
                                    
                                    if (i < 20) {
                                        if (i == 0) {
                                            CPlusSA = tempRiderSA;
                                        }
                                        else if (i%2 == 1) {
                                            CPlusSA = CPlusSA + (tempRiderSA * 0.1);
                                        }
                                        else {
                                            CPlusSA = CPlusSA;
                                        }
                                    }
                                    else {
                                        // CPlusSA = 0.00;
                                        CPlusSA = CPlusSA;
                                    }
                                }
                                else {
                                    if ([tempRiderPlanOption isEqualToString:@"L"] || [tempRiderPlanOption isEqualToString:@"B"]  ) {
                                        CPlusSA = tempRiderSA;
                                    }
                                }
                                
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = tempPremium;
                                } else {
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = tempPremium;
                                    } else {
                                        actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%.2f", CPlusSA] ];
                                [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            else if ([tempRiderCode isEqualToString:@"HPP"] || [tempRiderCode isEqualToString:@"HPPP"] ) {								
                                
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" AND Term = \"%d\""
                                                    , tempRiderCode, Age, tempRiderTerm ];
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];												
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {										
                                        rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    actualPremium = tempPremium;
                                } else {
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        actualPremium = tempPremium;
                                    } else{
                                        //[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue] ]];
                                        actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"%.2f", tempRiderSA] ];
                                [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                
                                tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
                                tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol3 objectAtIndex:i] doubleValue ];
                                [TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
                                
                            } else if ([tempRiderCode isEqualToString:@"EDB"]) {
                                
                                double DBenefit = 0.00;
                                
                                if (Age + i + 1 == 1) {
                                    DBenefit = tempRiderSA * 0.2;
                                }
                                else if (Age + i + 1 == 2){
                                    DBenefit = tempRiderSA * 0.4;
                                }
                                else if (Age + i + 1 == 3){
                                    DBenefit = tempRiderSA * 0.6;
                                }
                                else if (Age + i + 1 == 4){
                                    DBenefit = tempRiderSA * 0.8;
                                }
                                else{
                                    DBenefit = tempRiderSA;
                                }
                                
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" "
                                                    " AND Term = \"%d\" AND Sex = \"%@\""
                                                    , tempRiderCode, Age, tempRiderTerm, sex];
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                                
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {
                                        
                                        int rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                if (i + 1 <= 6) {
                                    actualPremium = 0.0;
                                    if([tempHL1KSA isEqualToString:@"(null)"]) {
                                        actualPremium = tempPremium;
                                    }
                                    else{
                                        if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                            actualPremium = tempPremium;
                                        }
                                        else{
                                            actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                        }
                                    }
                                    
                                    if (![tempTempHL isEqualToString:@"(null)"] ) {
                                        if (i + 1 > [tempTempHLTerm intValue]) {
                                            actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                        }										
                                    }
                                    
                                    [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                    [tempCol2 addObject:[NSString stringWithFormat:@"%.2f", DBenefit] ];
                                    [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                    [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                }
                                else{
                                    [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                    [tempCol2 addObject:[NSString stringWithFormat:@"%.2f", DBenefit] ];
                                    [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                    [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                }
                                
                                
                                
                            }
                            else if ([tempRiderCode isEqualToString:@"WPTPD30R"] || [tempRiderCode isEqualToString:@"WPTPD50R"] ) {                                
                                double TPDBenefit = 0.00;
                                double OADBenefit = 0.00;
                                
                                if (Age + i + 1 <= 64 ) {
                                    if (Age + i + 1 == 1) {
                                        TPDBenefit = tempRiderSA * 0.2;
                                    }
                                    else if (Age + i + 1 == 2){
                                        TPDBenefit = tempRiderSA * 0.4;
                                    }
                                    else if (Age + i + 1 == 3){
                                        TPDBenefit = tempRiderSA * 0.6;
                                    }
                                    else if (Age + i + 1 == 4){
                                        TPDBenefit = tempRiderSA * 0.8;
                                    }
                                    else{
                                        TPDBenefit = tempRiderSA;
                                    }
                                }
                                else{
                                    TPDBenefit = 0.00;
                                }
                                
                                if (Age + i + 1 < 7 && TPDBenefit > 100000) {
                                    TPDBenefit = 100000;
                                }
                                else if (Age + i + 1 >= 7 && Age + i + 1 < 15 && TPDBenefit > 500000){
                                    TPDBenefit = 500000;
                                }
                                else if (Age + i + 1 >= 15 && TPDBenefit > 3500000){
                                    TPDBenefit = 3500000;
                                }
                                //---------end --------------
                                
                                if (Age + i + 1 > 64) {
                                    OADBenefit  = tempRiderSA;
                                }
                                else {
                                    OADBenefit  = 0;
                                }
                                
                                if (OADBenefit > 1000000) {
                                    OADBenefit = 1000000;
                                }
                                
                                // -------- end ---------------
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        
                                        QuerySQL = [NSString stringWithFormat:@"Select rate from SI_Trad_Rider_WPR_CSV Where plancode = \"%@\" AND entryAge = \"%d\" AND policyTerm = \"%d\" AND premterm = \"%d\" AND sex = '%@' " , tempRiderCode, Age, tempRiderTerm, premiumPaymentOption, [sex substringToIndex:1] ];
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                                
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {
                                        
                                        int rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                if (i + 1 <= premiumPaymentOption) {
                                    
                                    actualPremium = 0.0;
                                    tempHLValue = 0.0;
                                    
                                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                                    [formatter setMaximumFractionDigits:2];
                                    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
                                    
                                    if (![tempHL1KSA isEqualToString:@"(null)"]) {
                                        if(i < [tempHL1KSATerm intValue ]){
                                            tempHLValue = [tempHL1KSA doubleValue] * tempRiderSA/1000;
                                        }
                                    }
                                    
                                    if (![tempTempHL isEqualToString:@"(null)"]) {
                                        if (i < [tempTempHLTerm intValue ]) {
                                            tempHLValue = tempHLValue + [tempTempHL doubleValue] * tempRiderSA/1000;
                                        }
                                    }
                                    
                                    if ([tempTempHLTerm intValue ] == 0 && [tempHL1KSATerm intValue ] == 0 ) {
                                        actualPremium = tempPremium;
                                    }
                                    else{
                                        actualPremium = [tempPremWithoutHLoading doubleValue] + [[formatter stringFromNumber:[NSNumber numberWithDouble:tempHLValue]] doubleValue];
                                    }
                                    
                                    
                                    [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                    [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", TPDBenefit]];
                                    [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", OADBenefit]];
                                    [tempCol4 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00 ]];
                                    
                                }
                                else{
                                    [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                    [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", TPDBenefit]];
                                    [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", OADBenefit]];
                                    [tempCol4 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00 ]];
                                }
                                
                                
                            }
                            else if ([tempRiderCode isEqualToString:@"WP30R"] ||  [tempRiderCode isEqualToString:@"WP50R"] ) {
                                
                                double DBenefit = 0.00;
                                
                                if (Age + i + 1 == 1) {
                                    DBenefit = tempRiderSA * 0.2;
                                }
                                else if (Age + i + 1 == 2){
                                    DBenefit = tempRiderSA * 0.4;
                                }
                                else if (Age + i + 1 == 3){
                                    DBenefit = tempRiderSA * 0.6;
                                }
                                else if (Age + i + 1 == 4){
                                    DBenefit = tempRiderSA * 0.8;
                                }
                                else{
                                    DBenefit = tempRiderSA;
                                }
                                
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        
                                        
                                        
                                        QuerySQL = [NSString stringWithFormat:@"Select rate from SI_Trad_Rider_WPR_CSV Where plancode = \"%@\" AND entryAge = \"%d\" "
                                                    " AND PolicyTerm = \"%d\" AND premterm = \"%d\" AND sex = '%@' " , tempRiderCode, Age, tempRiderTerm, premiumPaymentOption, [sex substringToIndex:1]];
                                        
                                        
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                                
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {
                                        
                                        int rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                if (i + 1 <= premiumPaymentOption) {
                                    
                                    double actualPremium = 0.0;
                                    double tempHLValue = 0.0;
                                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                                    [formatter setMaximumFractionDigits:2];
                                    [formatter setRoundingMode:NSNumberFormatterRoundHalfUp];
                                    
                                    if (![tempHL1KSA isEqualToString:@"(null)"]) {
                                        if(i < [tempHL1KSATerm intValue ]){
                                            tempHLValue = [tempHL1KSA doubleValue] * tempRiderSA/1000;
                                        }
                                    }
                                    
                                    if (![tempTempHL isEqualToString:@"(null)"]) {
                                        if (i < [tempTempHLTerm intValue ]) {
                                            tempHLValue = tempHLValue + [tempTempHL doubleValue] * tempRiderSA/1000;
                                        }
                                    }
                                    
                                    if ([[OccLoading objectAtIndex:0] doubleValue] != 0) {
                                        tempHLValue = tempHLValue + [[OccLoading objectAtIndex:0] doubleValue] * 3 * (tempRiderSA/1000.00);
                                    }
                                    
                                    if ([tempTempHLTerm intValue ] == 0 && [tempHL1KSATerm intValue ] == 0 ) {
                                        actualPremium = tempPremium;
                                    }
                                    else{
                                        actualPremium = [tempPremWithoutHLoading doubleValue] + [[formatter stringFromNumber:[NSNumber numberWithDouble:tempHLValue]] doubleValue];
                                    }
                                    
                                    [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                    [tempCol2 addObject:[NSString stringWithFormat:@"%.2f", DBenefit] ];
                                    [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                    [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                }
                                else{
                                    [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                    [tempCol2 addObject:[NSString stringWithFormat:@"%.2f", DBenefit] ];
                                    [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
                                    [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                }
                                
                                
                                
                            }
                            else if ([tempRiderCode isEqualToString:@"ETPDB"]) {								
                                double TPDBenefit = 0.00;
                                double OADBenefit = 0.00;
                                
                                if (Age + i + 1 <= 64 ) {
                                    if (Age + i + 1 == 1) {
                                        TPDBenefit = tempRiderSA * 0.2;
                                    }
                                    else if (Age + i + 1 == 2){
                                        TPDBenefit = tempRiderSA * 0.4;
                                    }
                                    else if (Age + i + 1 == 3){
                                        TPDBenefit = tempRiderSA * 0.6;
                                    }
                                    else if (Age + i + 1 == 4){
                                        TPDBenefit = tempRiderSA * 0.8;
                                    }
                                    else{
                                        TPDBenefit = tempRiderSA;
                                    }
                                }
                                else{
                                    TPDBenefit = 0.00;
                                }
                                
                                if (Age + i + 1 < 7 && TPDBenefit > 100000) {
                                    TPDBenefit = 100000;
                                }
                                else if (Age + i + 1 >= 7 && Age + i + 1 < 15 && TPDBenefit > 500000){
                                    TPDBenefit = 500000;
                                }
                                else if (Age + i + 1 >= 15 && TPDBenefit > 3500000){
                                    TPDBenefit = 3500000;
                                }
                                //---------end --------------
                                
                                if (Age + i + 1 > 64) {
                                    OADBenefit  = tempRiderSA;
                                }
                                else {
                                    OADBenefit  = 0;
                                }
                                
                                if (OADBenefit > 1000000) {
                                    OADBenefit = 1000000;
                                }
                                
                                // -------- end ---------------
                                if (i == 0) {
                                    if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                        QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" AND Term = \"%d\" AND Sex = \"%@\" "
                                                    , tempRiderCode, Age, tempRiderTerm, sex ];
                                        
                                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                            while (sqlite3_step(statement) == SQLITE_ROW) {
                                                [Rate addObject: [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                                                
                                            }
                                            sqlite3_finalize(statement);
                                        }
                                        sqlite3_close(contactDB);
                                    }
                                    
                                    if (Rate.count < PolicyTerm) {
                                        
                                        int rowsToAdd = PolicyTerm - Rate.count;
                                        for (int u =0; u<rowsToAdd; u++) {
                                            [Rate addObject:@"0.00"];
                                        }
                                    }
                                }
                                
                                if (i + 1 <= 6) {
                                    actualPremium = 0.0;
                                    if([tempHL1KSA isEqualToString:@"(null)"]) {
                                        actualPremium = tempPremium;
                                    }
                                    else{
                                        if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                            actualPremium = tempPremium;
                                        }
                                        else{
                                            actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                        }
                                    }
                                    
                                    if (![tempTempHL isEqualToString:@"(null)"] ) {
                                        if (i + 1 > [tempTempHLTerm intValue]) {
                                            actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                        }										
                                    }
                                    
                                    [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                    [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", TPDBenefit]];
                                    [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", OADBenefit]];
                                    [tempCol4 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00 ]];
                                    
                                }
                                else{
                                    [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                    [tempCol2 addObject:[NSString stringWithFormat:@"%.3f", TPDBenefit]];
                                    [tempCol3 addObject:[NSString stringWithFormat:@"%.3f", OADBenefit]];
                                    [tempCol4 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00 ]];
                                }	
                            }
                            else if ([tempRiderCode isEqualToString:@"HMM"] || [tempRiderCode isEqualToString:@"MG_II"] || [tempRiderCode isEqualToString:@"MG_IV"]  || [tempRiderCode isEqualToString:@"HSP_II"] ) {
                                double tempRates = 0.00;
                                double actualPremium = 0.00;
                                if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
                                    
                                    if ([ tempRiderCode isEqualToString:@"HMM" ] ) {
                                        if ([OccpClass isEqualToString:@"2"]) {
                                            QuerySQL = [NSString stringWithFormat:
                                                        @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND "
                                                        "occpClass = \"%@\" AND PlanOption=\"%@\" AND deductible = '%@' ",
                                                        tempRiderCode,Age + i , Age + i ,[sex substringToIndex:1], @"1", [tempRiderPlanOption stringByReplacingOccurrencesOfString:@"_" withString:@""], tempRiderDeduc];
                                        }
                                        else{
                                            QuerySQL = [NSString stringWithFormat:
                                                        @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND "
                                                        "occpClass = \"%@\" AND PlanOption=\"%@\" AND deductible = '%@' ",
                                                        tempRiderCode,Age + i , Age + i ,[sex substringToIndex:1], OccpClass, [tempRiderPlanOption stringByReplacingOccurrencesOfString:@"_" withString:@""], tempRiderDeduc];
                                        }
                                        
                                        
                                        
                                    }
                                    else if ([tempRiderCode isEqualToString:@"MG_IV" ] ) {
                                        
                                        QuerySQL = [NSString stringWithFormat:
                                                    @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND "
                                                    "occpClass = \"%@\" AND PlanOption=\"%@\" ",
                                                    tempRiderCode,Age + i , Age + i ,[sex substringToIndex:1], OccpClass, [tempRiderPlanOption stringByReplacingOccurrencesOfString:@"IVP_" withString:@""]];
                                    }
                                    else if ([tempRiderCode isEqualToString:@"HSP_II" ] ) {
                                        
                                        QuerySQL = [NSString stringWithFormat:
                                                    @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND "
                                                    "occpClass = \"%@\" AND RiderOpt=\"%@\" ",
                                                    tempRiderCode,Age + i, Age + i, OccpClass, tempRiderPlanOption];
                                    }
                                    else if ([tempRiderCode isEqualToString:@"MG_II" ] || [tempRiderCode isEqualToString:@"HSP_II" ] ) {
                                        QuerySQL = [NSString stringWithFormat:
                                                    @"SELECT Rate, FromAge, ToAge FROM Trad_Sys_Rider_Prem_New WHERE RiderCode=\"%@\" AND FromAge<=\"%d\" AND ToAge >=\"%d\" AND Sex=\"%@\" AND "
                                                    "occpClass = \"%@\" AND PlanOption=\"%@\" ",
                                                    tempRiderCode,Age + i , Age + i ,[sex substringToIndex:1], OccpClass, tempRiderPlanOption];
                                    }                                    
                                    
                                    if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                                        if (sqlite3_step(statement) == SQLITE_ROW) {
                                            tempRates = [[[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue ];
                                        }
                                        sqlite3_finalize(statement);
                                    }
                                    
                                    sqlite3_close(contactDB);
                                }                               
                                
                                double HL = 0.00;
                                double baseValue = tempRates;
                                
                                if(![tempHLPercentage isEqualToString:@"(null)"]) {
                                    if (i < [tempHLPercentageTerm intValue ]) {
                                        HL = [tempHLPercentage doubleValue];
                                    }
                                }
                                
                                if(![tempTempHL isEqualToString:@"(null)"]) {
                                    if (i < [tempTempHLTerm intValue ]) {
                                        HL = HL + [tempTempHL doubleValue];
                                    }
                                }
                                
                                actualPremium = [self dblRoundToTwoDecimal:(baseValue)] +  [self dblRoundToTwoDecimal:(baseValue* HL)/100.00 ];
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            else if([tempRiderCode isEqualToString:@"HB"]){								
                                double actualPremium = 0.0;
                                double baseValue = tempPremium/([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100 + 1.00);
                                
                                if([tempHLPercentage isEqualToString:@"(null)"]) {
                                    actualPremium = baseValue;
                                }
                                else{
                                    if ([tempTempHL isEqualToString:@"(null)"]) {
                                        actualPremium = baseValue;
                                    }
                                    else{
                                        if(i + 1 <= [tempHLPercentageTerm intValue ] && i + 1 <= [tempTempHLTerm intValue ]    ){
                                            actualPremium = baseValue * ([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100  + 1.00);
                                        }
                                        else if(i + 1 <= [tempHLPercentageTerm intValue ] && i + 1 > [tempTempHLTerm intValue ]    ){
                                            actualPremium = baseValue * ([tempHLPercentage doubleValue]/100  + 1.00);
                                        }
                                        else if(i + 1 > [tempHLPercentageTerm intValue ] && i + 1 <= [tempTempHLTerm intValue ]    ){
                                            actualPremium = baseValue * ([tempTempHL doubleValue]/100  + 1.00);
                                        }
                                        else if(i + 1 > [tempHLPercentageTerm intValue ] && i + 1 > [tempTempHLTerm intValue ]    ){
                                            actualPremium = baseValue;
                                        }
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                                
                            }
                            else {
                                
                                //[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
                                double actualPremium = 0.0;
                                if([tempHL1KSA isEqualToString:@"(null)"]) {
                                    //[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
                                    actualPremium = tempPremium;
                                }
                                else{
                                    if(i + 1 <= [tempHL1KSATerm intValue ] ){
                                        //[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
                                        actualPremium = tempPremium;
                                    }
                                    else{
                                        //[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue] ]];
                                        actualPremium = tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue];
                                    }
                                }
                                
                                if (![tempTempHL isEqualToString:@"(null)"] ) {
                                    if (i + 1 > [tempTempHLTerm intValue]) {
                                        actualPremium = actualPremium - (tempRiderSA/1000) * [tempTempHL doubleValue];
                                    }
                                    
                                }
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                        }
                        else {
                            if ([tempRiderCode isEqualToString:@"CCTR"]) {
                                
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"SP_PRE"] || [tempRiderCode isEqualToString:@"SP_STD"] ||
                                     [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
                                
                                //[tempCol1 addObject:[NSString stringWithFormat:@"0.00", tempPremium]];
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"PTR"]) {
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"] ];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"LPPR"]) {
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"0"]];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"PA"]) {
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"CIR"] || [tempRiderCode isEqualToString:@"ACIR"] || [tempRiderCode isEqualToString:@"ACIR_WL"] ||
                                     [tempRiderCode isEqualToString:@"ACIR_MPP"] || [tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"] ||
                                     [tempRiderCode isEqualToString:@"ACIR_EXC"]) {
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol3 addObject:@"-" ];
                                [tempCol4 addObject:@"-" ];
                            }
                            
                            else if ([tempRiderCode isEqualToString:@"LCPR"] || [tempRiderCode isEqualToString:@"PLCP"] ) {
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"0"]];
                            }
                            else if ([tempRiderCode isEqualToString:@"C+"] ) {
                                
                                
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            else if ([tempRiderCode isEqualToString:@"HPP"] || [tempRiderCode isEqualToString:@"HPPP"] ) {
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            else if ([tempRiderCode isEqualToString:@"EDB"]) {
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            else if ([tempRiderCode isEqualToString:@"ETPDB"]) {
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"0"]];
                            }
                            else if ([tempRiderCode isEqualToString:@"WP30R"] || [tempRiderCode isEqualToString:@"WP50R'"]) {
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }
                            else if ([tempRiderCode isEqualToString:@"WPTPD30R"] || [tempRiderCode isEqualToString:@"WPTPD50R"]  ) {
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"0"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"0"]];
                            }
                            else {
                                [tempCol1 addObject:[NSString stringWithFormat:@"0.00"]];
                                [tempCol2 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol3 addObject:[NSString stringWithFormat:@"-"]];
                                [tempCol4 addObject:[NSString stringWithFormat:@"-"]];
                            }							
                        }						
                        EntireTotalPremiumPaid = EntireTotalPremiumPaid + [[tempCol1 objectAtIndex:i + 3] doubleValue ]; //i +3 to skip the first 3 items
                    }                    
                    
                    if (Rider == 0){
                        for (int p =0; p < tempCol1.count; p++) {
                            [RiderCol1 addObject:[tempCol1 objectAtIndex:p]];
                            [RiderCol2 addObject:[tempCol2 objectAtIndex:p]];
                            [RiderCol3 addObject:[tempCol3 objectAtIndex:p]];
                            [RiderCol4 addObject:[tempCol4 objectAtIndex:p]];
                        }
                    }
                    else if (Rider == 1){
                        for (int p =0; p < tempCol1.count; p++) {
                            [RiderCol5 addObject:[tempCol1 objectAtIndex:p]];
                            [RiderCol6 addObject:[tempCol2 objectAtIndex:p]];
                            [RiderCol7 addObject:[tempCol3 objectAtIndex:p]];
                            [RiderCol8 addObject:[tempCol4 objectAtIndex:p]];
                        }
                    }
                    else if (Rider == 2){
                        for (int p =0; p < tempCol1.count; p++) {
                            [RiderCol9 addObject:[tempCol1 objectAtIndex:p]];
                            [RiderCol10 addObject:[tempCol2 objectAtIndex:p]];
                            [RiderCol11 addObject:[tempCol3 objectAtIndex:p]];
                            [RiderCol12 addObject:[tempCol4 objectAtIndex:p]];
                        }
                    }
                    Rate = Nil;
                    tempRiderCode = Nil;
                    tempRiderDesc = Nil;
                    tempRiderPlanOption = Nil;
                    tempCol1 = Nil;
                    tempCol2 = Nil;
                    tempCol3 = Nil;
                    tempCol4 = Nil;
                    
                }
                else {
                    if (Rider == 1) {
                        for (int row = 0; row < PolicyTerm + 3; row++){
                            [RiderCol5 addObject:@"-"];
                            [RiderCol6 addObject:@"-"];
                            [RiderCol7 addObject:@"-"];
                            [RiderCol8 addObject:@"-"];
                        }
                    }
                    if (Rider == 2) {
                        for (int row = 0; row < PolicyTerm + 3; row++){
                            [RiderCol9 addObject:@"-"];
                            [RiderCol10 addObject:@"-"];
                            [RiderCol11 addObject:@"-"];
                            [RiderCol12 addObject:@"-"];
                        }
                    }
                }                
            }
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                QuerySQL = [NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_Rider(\"SINO\", \"SeqNo\", \"DataType\", \"PageNo\",\"col0_1\",\"col0_2\", "
                            " \"col1\",\"col2\",\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\" ) VALUES ("
                            " \"%@\", \"%d\", \"TITLE\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" "
                            " , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" )", SINo, -2, page, @"", @"", [RiderCol1 objectAtIndex:0],[RiderCol2 objectAtIndex:0],
                            [RiderCol3 objectAtIndex:0],[RiderCol4 objectAtIndex:0],[RiderCol5 objectAtIndex:0],[RiderCol6 objectAtIndex:0],
                            [RiderCol7 objectAtIndex:0],[RiderCol8 objectAtIndex:0],[RiderCol9 objectAtIndex:0],[RiderCol10 objectAtIndex:0],
                            [RiderCol11 objectAtIndex:0],[RiderCol12 objectAtIndex:0]];
                
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                QuerySQL = [NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_Rider(\"SINO\", \"SeqNo\", \"DataType\", \"PageNo\",\"col0_1\",\"col0_2\", "
                            " \"col1\",\"col2\",\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\" ) VALUES ("
                            " \"%@\", \"%d\", \"HEADER\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" "
                            " , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" )", SINo, -1, page, @"Policy Year", @"Life Assured's Age at the End of Year",
                            [RiderCol1 objectAtIndex:1],[RiderCol2 objectAtIndex:1],
                            [RiderCol3 objectAtIndex:1],[RiderCol4 objectAtIndex:1],[RiderCol5 objectAtIndex:1],[RiderCol6 objectAtIndex:1],
                            [RiderCol7 objectAtIndex:1],[RiderCol8 objectAtIndex:1],[RiderCol9 objectAtIndex:1],[RiderCol10 objectAtIndex:1],
                            [RiderCol11 objectAtIndex:1],[RiderCol12 objectAtIndex:1]];
                
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                QuerySQL = [NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_Rider(\"SINO\", \"SeqNo\", \"DataType\", \"PageNo\",\"col0_1\",\"col0_2\", "
                            " \"col1\",\"col2\",\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\" ) VALUES ("
                            " \"%@\", \"%d\", \"HEADER\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" "
                            " , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" )", SINo, 0, page, @"Tahun Polisi", @"Umur Hayat Diinsuranskan pada Akhir Tahun",
                            [RiderCol1 objectAtIndex:2],[RiderCol2 objectAtIndex:2],
                            [RiderCol3 objectAtIndex:2],[RiderCol4 objectAtIndex:2],[RiderCol5 objectAtIndex:2],[RiderCol6 objectAtIndex:2],
                            [RiderCol7 objectAtIndex:2],[RiderCol8 objectAtIndex:2],[RiderCol9 objectAtIndex:2],[RiderCol10 objectAtIndex:2],
                            [RiderCol11 objectAtIndex:2],[RiderCol12 objectAtIndex:2]];
                
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                sqlite3_close(contactDB);
            }
            
            int lifeAsAt=-1;
            int termShow=-1;
            int skipCount=-1;
            
            if([pPlanCode isEqualToString:@"HLACP"])
            {
                termShow = 25;
            }
            else if([pPlanCode isEqualToString:@"L100"] || [pPlanCode isEqualToString:@"S100"])
            {
                termShow = PolicyTerm;
            }
            else if([pPlanCode isEqualToString:@"HLAWP"])
            {
                termShow = PolicyTerm;
            }
            
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                NSString *value1;
                NSString *value2;
                NSString *value3;
                NSString *value4;
                NSString *value5;
                NSString *value6;
                NSString *value7;
                NSString *value8;
                NSString *value9;
                NSString *value10;
                NSString *value11;
                NSString *value12;
                
                int currentAge;
                NSString *strSeqNo;
                for (int j=1; j <= PolicyTerm; j++) {
                    if (j <= termShow) {
                        currentAge = Age + j;
                        strSeqNo = @"";
                        if (j < 10) {
                            strSeqNo = [NSString stringWithFormat:@"0%d", j];
                        } else {
                            strSeqNo = [NSString stringWithFormat:@"%d", j];
                        }
                        
                        value1 = [[RiderCol1 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol1 objectAtIndex:j + 2] doubleValue ]];
                        value2 = [[RiderCol2 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol2 objectAtIndex:j + 2] doubleValue ])];
                        value3 = [[RiderCol3 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol3 objectAtIndex:j + 2] doubleValue ])];
                        value4 = [[RiderCol4 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol4 objectAtIndex:j + 2] doubleValue ])];
                        value5 = [[RiderCol5 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol5 objectAtIndex:j + 2] doubleValue ]];
                        value6 = [[RiderCol6 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol6 objectAtIndex:j + 2] doubleValue ])];
                        value7 = [[RiderCol7 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol7 objectAtIndex:j + 2] doubleValue ])];
                        value8 = [[RiderCol8 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol8 objectAtIndex:j + 2] doubleValue ])];
                        value9 = [[RiderCol9 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol9 objectAtIndex:j + 2] doubleValue ]];
                        value10 = [[RiderCol10 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol10 objectAtIndex:j + 2] doubleValue ])];
                        value11 = [[RiderCol11 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol11 objectAtIndex:j + 2] doubleValue ])];
                        value12 = [[RiderCol12 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol12 objectAtIndex:j + 2] doubleValue ])];
                        
                        QuerySQL = [NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_Rider(\"SINO\", \"SeqNo\", \"DataType\", \"PageNo\",\"col0_1\",\"col0_2\", "
                                    " \"col1\",\"col2\",\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\" ) VALUES ("
                                    " \"%@\", \"%@\", \"DATA\", \"%d\", \"%d\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" "
                                    " , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" )", SINo, strSeqNo , page, j, currentAge, value1,value2,
                                    value3,value4,value5,value6,value7, value8, value9, value10, value11, value12];
                        
                        lifeAsAt = j + Age;
                        
                        if(lifeAsAt<100) {
                            if(j>20 && skipCount<5) {
                                skipCount++;
                                continue;
                            }
                        }
                        skipCount = 1;
                        
                        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                            if (sqlite3_step(statement) == SQLITE_DONE) {
                                
                            }
                            sqlite3_finalize(statement);
                        }
                        
                        value1 = Nil;
                        value2 = Nil;
                        value3 = Nil;
                        value4 = Nil;
                        value5 = Nil;
                        value6 = Nil;
                        value7 = Nil;
                        value8 = Nil;
                        value9 = Nil;
                        value10 = Nil;
                        value11 = Nil;
                        value12 = Nil;
                        
                        
                        strSeqNo = Nil;
                    }
                }                
                sqlite3_close(contactDB);
            }
            
            RiderCol1 = Nil;
            RiderCol2 = Nil;
            RiderCol3 = Nil;
            RiderCol4 = Nil;
            RiderCol5 = Nil;
            RiderCol6 = Nil;
            RiderCol7 = Nil;
            RiderCol8 = Nil;
            RiderCol9 = Nil;
            RiderCol10 = Nil;
            RiderCol11 = Nil;
            RiderCol12 = Nil;
            
        }
        
        if([pPlanCode isEqualToString:@"HLACP"]) {
            if ([PDSorSI isEqualToString:@"SI"]) {
                double tempA;
                double tempB;
                for (int v= 0; v < PolicyTerm; v ++) {
                    tempA = [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:v] doubleValue ];
                    tempA = tempA + [[TotalRiderSurrenderValue objectAtIndex:v] doubleValue ];
                    [SummaryNonGuaranteedSurrenderValueA replaceObjectAtIndex:v withObject: [NSString stringWithFormat:@"%.3f", tempA]];
                    
                    tempB = [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:v] doubleValue ];
                    tempB = tempB + [[TotalRiderSurrenderValue objectAtIndex:v] doubleValue ];
                    [SummaryNonGuaranteedSurrenderValueB replaceObjectAtIndex:v withObject: [NSString stringWithFormat:@"%.3f", tempB]];
                }
            }
        }
    }
    
    NSLog(@"insert to SI_Temp_Trad_Rider --- End");
    statement = Nil;
    QuerySQL = Nil;
    TotalRiderSurrenderValue = Nil;
    
}

-(void)InsertToSI_Temp_Trad{
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        NSString *strEngYearlyIncome = @"";
        NSString *strBMYearlyIncome = @"";
        
        if ([pPlanCode isEqualToString:@"HLAWP"]) {
            if (wpGYIRidersCode.count > 0) {
                if ([wpGYIRidersCode indexOfObject:@"EDUWR"] != NSNotFound && wpGYIRidersCode.count > 1) { // EDUWR + other GYI rider
                    strEngYearlyIncome = [NSString stringWithFormat: @"(Yearly Cash Coupons & Cash Payments %d%% Accumulate & %d%% Payout)", PartialAcc, PartialPayout];
                    strBMYearlyIncome = [NSString stringWithFormat: @"(Kupon Tunai Tahunan & Bayaran Tunai %d%% Terkumpul & %d%% Dibayar)", PartialAcc, PartialPayout];
                }
                else if ([wpGYIRidersCode indexOfObject:@"EDUWR"] != NSNotFound && wpGYIRidersCode.count == 1) { // EDUWR  rider only
                    strEngYearlyIncome = [NSString stringWithFormat: @"(Cash Payments %d%% Accumulate & %d%% Payout)", PartialAcc, PartialPayout];
                    strBMYearlyIncome = [NSString stringWithFormat: @"(Bayaran Tunai %d%% Terkumpul & %d%% Dibayar)", PartialAcc, PartialPayout];
                }
                else{ // no EDUWR rider
                    strEngYearlyIncome = [NSString stringWithFormat: @"(Yearly Cash Coupons %d%% Accumulate & %d%% Payout)", PartialAcc, PartialPayout];
                    strBMYearlyIncome = [NSString stringWithFormat: @"(Kupon Tunai Tahunan  %d%% Terkumpul & %d%% Dibayar)", PartialAcc, PartialPayout];
                }
                
            }
            else{
                strEngYearlyIncome = [NSString stringWithFormat: @""];
                strBMYearlyIncome = [NSString stringWithFormat: @""];
                
            }
        }
        else{
            strEngYearlyIncome = [NSString stringWithFormat: @"(Yearly Income %d%% Accumulate & %d%% Payout)", PartialAcc, PartialPayout];
            strBMYearlyIncome = [NSString stringWithFormat: @"(Pendapatan Tahunan  %d%% Terkumpul & %d%% Dibayar)", PartialAcc, PartialPayout];
            
        }
        
        QuerySQL = [NSString stringWithFormat:@"INSERT INTO SI_Temp_trad(\"SINo\",\"LAName\",\"PlanCode\",\"PlanName\",\"PlanDesc\", "
                    " \"MPlanDesc\",\"CashPaymentT\",\"CashPaymentD\",\"MCashPaymentT\",\"MCashPaymentD\",\"HLoadingT\",\"MHLoadingT\", "
                    " \"OccLoadingT\",\"MOccLoadingT\",\"PolTerm\",\"TotPremPaid\",\"SurrenderValueHigh\",\"SurrenderValueLow\",\"CashPayment\", "
                    " \"SurrenderValuePaidUpHigh\",\"SurrenderValuePaidUpLow\",\"GlncPaid\",\"SumTotPremPaid\",\"SurrenderValuePaidUpHigh2\", "
                    " \"SurrenderValuePaidUpLow2\",\"SumTotPremPaid2\",\"TotalYearlylncome\",\"SumTotalYearlyIncome\",\"SumTotalYearlyIncome2\", "
                    " \"TotalPremPaid2\",\"SurrenderValueHigh2\",\"SurrenderValueLow2\",\"TotalYearlyIncome2\") VALUES "
                    " (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\",\"%.3f\",\"%.8f\", "
                    " \"%.9f\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%.3f\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\") ",
                    SINo, Name, pPlanCode, pPlanName, @"Participating Whole Life Plan with Guaranteed Yearly Income and",
                    @"Pelan Penyertaan Sepanjang Hayat dengan Pendapatan Tahunan Terjamin dan ", @"", strEngYearlyIncome, @"", strBMYearlyIncome,
                    @"", @"", @"Occ Loading (per 1k SA)", @"Caj Tambahan Perkerjaan (1k JAD)",
                    PolicyTerm, BasicTotalPremiumPaid,
                    BasicMaturityValueA, BasicMaturityValueB, 0, 0, 0, 0, arc4random()%10000 + 100, 0, 0, 0, BasicTotalYearlyIncome,
                    arc4random()%10000 + 100,0,0,0,0,0 ];
        
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)InsertToSI_Temp_Trad_Overall{    
    NSLog(@"insert to SI_Temp_Trad_Overall --- start");    
    sqlite3_stmt *statement;
    NSString *QuerySQL;    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        if([pPlanCode isEqualToString:@"HLACP"]||[pPlanCode isEqualToString:@"HLAWP"]) {
            QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Overall (\"SINO\", \"SurrenderValueHigh1\", "
                        " \"SurrenderValueLow1\",\"TotPremPaid1\",\"TotYearlyIncome1\", "
                        " \"SurrenderValuehigh2\",\"SurrenderValueLow2\",\"TotPremPaid2\",\"TotYearlyIncome2\") VALUES ( "
                        " \"%@\",\"%.8f\",\"%.9f\",\"%.2f\",\"%.2f\",\"%.8f\",\"%.9f\",\"%.2f\",\"%.2f\")",
                        SINo, EntireMaturityValueA,
                        EntireMaturityValueB, EntireTotalPremiumPaid, EntireTotalYearlyIncome,
                        EntireMaturityValueA,EntireMaturityValueB,TotalPremiumBasicANDIncomeRider,EntireTotalYearlyIncome];
            
        } else if([pPlanCode isEqualToString:@"L100"]) {
            QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Overall (\"SINO\", \"SurrenderValueHigh1\", "
                        " \"SurrenderValueLow1\",\"TotPremPaid1\",\"TotYearlyIncome1\", "
                        " \"SurrenderValuehigh2\",\"SurrenderValueLow2\",\"TotPremPaid2\",\"TotYearlyIncome2\") VALUES ( "
                        " \"%@\",\"%.8f\",\"%.9f\",\"%.2f\",\"%.2f\",\"%.8f\",\"%.9f\",\"%.2f\",\"%.2f\")",
                        SINo, 0.00, 0.00, totPremPaidL100,
                        0.00,0.00,0.00,0.00,0.00];
            
        } else if ([pPlanCode isEqualToString:@"S100"]) {
            QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Overall (\"SINO\", \"SurrenderValueHigh1\", "
                        " \"SurrenderValueLow1\",\"TotPremPaid1\",\"TotYearlyIncome1\", "
                        " \"SurrenderValuehigh2\",\"SurrenderValueLow2\",\"TotPremPaid2\",\"TotYearlyIncome2\") VALUES ( "
                        " \"%@\",\"%.8f\",\"%.9f\",\"%.2f\",\"%.2f\",\"%.8f\",\"%.9f\",\"%.2f\",\"%.2f\")",
                        SINo, 0.00, 0.00, totPremPaidL100 - EntireTotalPremiumPaid,
                        0.00,0.00,0.00,totPremPaidL100,0.00];
            
        }
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE) {
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
    NSLog(@"insert to SI_Temp_Trad_Overall --- End");
    statement = Nil;
    QuerySQL = Nil;
    
}

-(void)UpdateToSI_Temp_Trad_Details{
    
    if (UpdateTradDetail.count > 0) {
        NSLog(@"Update Trad Detail start");
        sqlite3_stmt *statement;
        NSString *QuerySQL = @"";
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setMaximumFractionDigits:2];
            [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];
            NSString *SAAnnual;
            NSString *SASemiAnnual;
            NSString *SAQuaterly;
            NSString *SAMonthly;
            for (int i = 0; i< UpdateTradDetail.count; i++) {
                SAAnnual = [formatter stringFromNumber:[NSDecimalNumber numberWithDouble:[[gWaiverAnnual objectAtIndex:i] doubleValue ]]];
                SASemiAnnual = [formatter stringFromNumber:[NSNumber numberWithDouble:[[gWaiverSemiAnnual objectAtIndex:i] doubleValue ]]];
                SAQuaterly = [formatter stringFromNumber:[NSNumber numberWithDouble:[[gWaiverQuarterly objectAtIndex:i] doubleValue ]]];
                SAMonthly = [formatter stringFromNumber:[NSNumber numberWithDouble:[[gWaiverMonthly objectAtIndex:i] doubleValue ]]];
                
                if ([[UpdateTradDetail objectAtIndex:i ] isEqualToString:@"CIWP" ]) {
                    if([[UpdateTradDetailTerm objectAtIndex:i] integerValue ] > 10){
                        TotalCI = TotalCI + ([[gWaiverAnnual objectAtIndex:i] doubleValue ] * 8);
                        [CIRiders addObject:[UpdateTradDetail objectAtIndex:i ]];
                    }
                    else{
                        TotalCI = TotalCI + ([[gWaiverAnnual objectAtIndex:i] doubleValue ] * 4);
                        [CIRiders addObject:[UpdateTradDetail objectAtIndex:i ]];
                    }
                    
                }
                else if([[UpdateTradDetail objectAtIndex:i ] isEqualToString:@"LCWP" ] ||
                        [[UpdateTradDetail objectAtIndex:i ] isEqualToString:@"SP_PRE" ]){
                    
                    if([[UpdateTradDetailTerm objectAtIndex:i] integerValue ] > 10){
                        TotalCI2 = TotalCI2 + ([[gWaiverAnnual objectAtIndex:i] doubleValue ] * 8);
                        [CIRiders2 addObject:[UpdateTradDetail objectAtIndex:i ]];
                    }
                    else{
                        TotalCI2 = TotalCI2 + ([[gWaiverAnnual objectAtIndex:i] doubleValue ] * 4);
                        [CIRiders2 addObject:[UpdateTradDetail objectAtIndex:i ]];
                    }
                }
                
                QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%@\" where col0_1 = \"-Annually\" AND col11 = \"%@\" ",
                            SAAnnual , [UpdateTradDetail objectAtIndex:i ]]; //edwin here                
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                
                QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%@\" where col0_1 = \"-Semi-annually\" AND col11 = \"%@\" ",
                            SASemiAnnual , [UpdateTradDetail objectAtIndex:i ]];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                
                QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%@\" where col0_1 = \"-Quarterly\" AND col11 = \"%@\" ",
                            SAQuaterly, [UpdateTradDetail objectAtIndex:i ]];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                
                QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%@\" where col0_1 = \"-Monthly\" AND col11 = \"%@\" ",
                            SAMonthly, [UpdateTradDetail objectAtIndex:i ]];
                
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }                
                
                SAAnnual = Nil;
                SASemiAnnual = Nil;
                SAQuaterly = Nil;
                SAMonthly = Nil;
                
            }
            
            sqlite3_close(contactDB);
        }
        
        statement = Nil;
        QuerySQL = Nil;
        
        NSLog(@"Update Trad Detail end");
    }
    
}

-(NSString *) roundingTwoDecimal:(NSString *)value
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];    
    [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];
    
    NSString *temp = [formatter stringFromNumber:[NSDecimalNumber numberWithFloat:[value floatValue ]]];
    
    return temp;
}

-(double) roundingTwoDecimalFloat:(float) value
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];    
    [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];    
    double temp = [ [formatter stringFromNumber:[NSNumber numberWithFloat:value]] doubleValue];
    
    return temp;
}

/** CK Quek - this should be changed. Use objects instead of lots of arrays **/
-(void)getAllPreDetails{
    
    sqlite3_stmt *statement;
    sqlite3_stmt *statement2;
    NSString *QuerySQL;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){		
        QuerySQL = [ NSString stringWithFormat:@"select \"PolicyTerm\", \"BasicSA\", \"premiumPaymentOption\", \"CashDividend\",  "
                    "\"YearlyIncome\", \"AdvanceYearlyIncome\", \"HL1KSA\",\"sex\",\"Class\",\"OccLoading_TL\", \"HL1KSATerm\",\"TempHL1KSA\",\"TempHL1KSATerm\" "
                    ", \"PartialAcc\", \"PartialPayout\", A.QuotationLang, D.OccpDesc from Trad_Details as A, "
                    "Clt_Profile as B, trad_LaPayor as C, Adm_Occp_Loading_Penta as D where A.Sino = C.Sino AND C.custCode = B.custcode AND "
                    "D.OccpCode = B.OccpCode AND A.sino = \"%@\" AND \"seq\" = 1 ", SINo];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                PolicyTerm = sqlite3_column_int(statement, 0);
                BasicSA = sqlite3_column_double(statement, 1);
                coveragePeriod = sqlite3_column_int(statement, 2);
                premiumPaymentOption = sqlite3_column_int(statement, 2);
                CashDividend = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                YearlyIncome = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                HealthLoading = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                OccpClass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                
                HealthLoadingTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)];
                TempHealthLoading = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)];
                TempHealthLoadingTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)];
                PartialAcc = sqlite3_column_int(statement, 13);
                PartialPayout = sqlite3_column_int(statement, 14);
                lang = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 15)];
                OccpDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 16)];
            }
            sqlite3_finalize(statement);
            
        }
        
        if (PartialPayout == 100) {
            YearlyIncome = @"POF";
        }else{
            YearlyIncome = @"ACC";
        }
        
        QuerySQL = [ NSString stringWithFormat:@"select CustCode from Trad_LaPayor where sino = \"%@\" AND PtypeCode = 'PY' ", SINo];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                NSString* CC  = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];                
                NSString* getFromCltProfileSQL  = [NSString stringWithFormat:@"Select Name, Smoker, sex, ALB from clt_profile where custcode  = \"%@\"",  CC];
                
                if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
                    
                    if (sqlite3_step(statement2) == SQLITE_ROW) {
                        PayorAge = sqlite3_column_int(statement2, 3);
                    }
                    sqlite3_finalize(statement2);
                }
                
                getFromCltProfileSQL = Nil;
            }
            sqlite3_finalize(statement);
        }
        
        QuerySQL = [ NSString stringWithFormat:@"select \"OccLoading_TL\" from Trad_Details as A, "
                    "Clt_Profile as B, trad_LaPayor as C, Adm_Occp_Loading_Penta as D where A.Sino = C.Sino AND C.custCode = B.custcode AND "
                    "D.OccpCode = B.OccpCode AND A.sino = \"%@\" AND \"seq\" = 1 ORDER By sequence ASC ", SINo];		
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [OccLoading addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];				
            }
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(contactDB);
    }
    
    wpGYIRidersPremAnnual = [ [NSMutableArray alloc] init];
    wpGYIRidersPremSemiAnnual = [ [NSMutableArray alloc] init];
    wpGYIRidersPremQuarter = [ [NSMutableArray alloc] init];
    wpGYIRidersPremMonth = [ [NSMutableArray alloc] init];
    
    wpGYIRidersCode = [ [NSMutableArray alloc] init ];
    wpGYIRidersSA = [ [NSMutableArray alloc] init ];
    wpGYIRidersTerm = [ [NSMutableArray alloc] init ];
    wpGYIRidersPayingTerm = [ [NSMutableArray alloc] init ];
    wpGYIRiderDesc = [[NSMutableArray alloc] init ];
    wpGYIRiderPlanOption = [[NSMutableArray alloc] init ];
    wpGYIRiderDeductible = [[NSMutableArray alloc] init ];
    wpGYIRiderHL1kSA = [[NSMutableArray alloc] init ];
    wpGYIRiderHL1kSATerm = [[NSMutableArray alloc] init ];
    wpGYIRiderHL100SA = [[NSMutableArray alloc] init ];
    wpGYIRiderHL100SATerm = [[NSMutableArray alloc] init ];
    wpGYIRiderHLPercentage = [[NSMutableArray alloc] init ];
    wpGYIRiderHLPercentageTerm = [[NSMutableArray alloc] init ];
    wpGYIRiderTempHL = [[NSMutableArray alloc] init ];
    wpGYIRiderTempHLTerm = [[NSMutableArray alloc] init ];
    wpGYIRidersPremAnnualWithoutHLoading = [[NSMutableArray alloc] init ];
    
    OtherRiderCode = [[NSMutableArray alloc] init ];
    OtherRiderTerm = [[NSMutableArray alloc] init ];
    OtherRiderPayingTerm = [[NSMutableArray alloc] init ];
    OtherRiderDesc = [[NSMutableArray alloc] init ];
    OtherRiderSA = [[NSMutableArray alloc] init ];
    OtherRiderPlanOption = [[NSMutableArray alloc] init ];
    OtherRiderDeductible = [[NSMutableArray alloc] init ];
    OtherRiderHL1kSA = [[NSMutableArray alloc] init ];
    OtherRiderHL1kSATerm = [[NSMutableArray alloc] init ];
    OtherRiderHL100SA = [[NSMutableArray alloc] init ];
    OtherRiderHL100SATerm = [[NSMutableArray alloc] init ];
    OtherRiderHLPercentage = [[NSMutableArray alloc] init ];
    OtherRiderHLPercentageTerm = [[NSMutableArray alloc] init ];
    OtherRiderTempHL = [[NSMutableArray alloc] init ];
    OtherRiderTempHLTerm = [[NSMutableArray alloc] init ];
    OtherRiderPremWithoutHLoading = [[NSMutableArray alloc] init ];
    
    NSString *tempOtherRiderSA;
    NSRange rangeofDotHL;
    NSString *Display;
    NSString *substring;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        QuerySQL = [ NSString stringWithFormat:@"Select A.RiderCode, \"RiderTerm\", B.RiderDesc, \"SumAssured\", \"PlanOption\", "
                    "\"Deductible\", \"HL1kSA\", \"HL1KSATerm\", \"HL100SA\", \"HL100SATerm\", \"HLPercentage\", \"HLPercentageTerm\", "
                    " \"TempHL1kSA\", \"TempHL1kSATerm\", ifnull(PayingTerm, '')  from trad_rider_details as A, "
                    "trad_sys_rider_profile as B  where \"sino\" = \"%@\" AND A.ridercode = B.RiderCode "
                    // hack
                    "AND A.riderCode not in(\"SP_PRE\", \"SP_STD\", \"LCWP\", \"PR\", \"PLCP\", \"PTR\") "
                    "ORDER BY B.RiderCode ASC ", SINo];
        NSString *rc;
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
            NSString *riderDesc = @"";
            NSString *riderPlan = @"";
            while(sqlite3_step(statement2) == SQLITE_ROW) {
                rc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                
                if ([rc isEqualToString:@"I20R"] || [rc isEqualToString:@"I30R"] || [rc isEqualToString:@"I40R"]
                    || [rc isEqualToString:@"ID20R"] || [rc isEqualToString:@"ID30R"]|| [rc isEqualToString:@"ID40R"] || [rc isEqualToString:@"IE20R"]
                    || [rc isEqualToString:@"IE30R"]) 
                {
                    
                    
                }
                else if ([rc isEqualToString:@"EDUWR"] || [rc isEqualToString:@"WB30R"] || [rc isEqualToString:@"WB50R"] || [rc isEqualToString:@"WBI6R30"] || [rc isEqualToString:@"WBD10R30"])
                {
                    
                    [wpGYIRidersCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)]];
                    [wpGYIRidersTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)]];
                    [wpGYIRiderDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)]];
                    
                    tempOtherRiderSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 3)];
                    rangeofDotHL = [tempOtherRiderSA rangeOfString:@"."];
                    Display = @"";
                    if (rangeofDotHL.location != NSNotFound) {
                        substring = [tempOtherRiderSA substringFromIndex:rangeofDotHL.location ];
                        if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                            Display = [tempOtherRiderSA substringToIndex:rangeofDotHL.location ];
                        } else {
                            Display = tempOtherRiderSA;
                        }
                    } else {
                        Display = tempOtherRiderSA;
                    }
                    
                    [wpGYIRidersSA addObject:Display];
                    if ([[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)] isEqualToString:@"(null)" ]   ) {
                        [wpGYIRiderPlanOption addObject:@""];
                    } else {
                        [wpGYIRiderPlanOption addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)]];
                    }
                    
                    [wpGYIRiderDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 5)]];
                    [wpGYIRiderHL1kSA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 6)]];
                    [wpGYIRiderHL1kSATerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 7)]];
                    [wpGYIRiderHL100SA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 8)]];
                    [wpGYIRiderHL100SATerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 9)]];
                    [wpGYIRiderHLPercentage addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 10)]];
                    [wpGYIRiderHLPercentageTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 11)]];
                    [wpGYIRiderTempHL addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 12)]];
                    [wpGYIRiderTempHLTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 13)]];
                    [wpGYIRidersPayingTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 14)]];
                    
                    [self getRiderWPGYIPrem:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)]];
                    
                } else {
                    [OtherRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)]];
                    [OtherRiderTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)]];
                    riderDesc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
//                    [OtherRiderDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)]];
                    
                    tempOtherRiderSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 3)];
                    rangeofDotHL = [tempOtherRiderSA rangeOfString:@"."];
                    Display = @"";
                    if (rangeofDotHL.location != NSNotFound) {
                        substring = [tempOtherRiderSA substringFromIndex:rangeofDotHL.location ];
                        if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                            Display = [tempOtherRiderSA substringToIndex:rangeofDotHL.location ];
                        } else {
                            Display = tempOtherRiderSA;
                        }
                    } else {
                        Display = tempOtherRiderSA;
                    }
                    
                    [OtherRiderSA addObject: Display];
                    riderPlan = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)];
                    if ([riderPlan isEqualToString:@"(null)" ]   ) {
                        [OtherRiderPlanOption addObject:@""];
                    } else {
                        [OtherRiderPlanOption addObject:riderPlan];
                        // special case for HMM
                        if ([riderPlan isEqual:@"HMM_1000"]) {
                            riderDesc = [NSString stringWithFormat:@"%@ Plus",riderDesc];
                        }
                    }
                    [OtherRiderDesc addObject:riderDesc];
                    
                    [OtherRiderDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 5)]];
                    [OtherRiderHL1kSA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 6)]];
                    [OtherRiderHL1kSATerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 7)]];
                    [OtherRiderHL100SA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 8)]];
                    [OtherRiderHL100SATerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 9)]];
                    [OtherRiderHLPercentage addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 10)]];
                    [OtherRiderHLPercentageTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 11)]];
                    [OtherRiderTempHL addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 12)]];
                    [OtherRiderTempHLTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 13)]];
                    [OtherRiderPayingTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 14)]];
                    
                    tempOtherRiderSA = Nil;
                    Display = Nil;
                }
                
                rc = Nil;
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(contactDB);
    }
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        QuerySQL = [ NSString stringWithFormat:@"Select A.RiderCode, \"RiderTerm\", B.RiderDesc, \"SumAssured\", \"PlanOption\", "
                    "\"Deductible\", \"HL1kSA\", \"HL1KSATerm\", \"HL100SA\", \"HL100SATerm\", \"HLPercentage\", \"HLPercentageTerm\", "
                    " \"TempHL1kSA\", \"TempHL1kSATerm\", ifnull(PayingTerm, '')  from trad_rider_details as A, "
                    "trad_sys_rider_profile as B  where \"sino\" = \"%@\" AND A.ridercode = B.RiderCode "
                    // hack
                    "AND A.riderCode in(\"SP_PRE\", \"SP_STD\") "
                    "ORDER BY B.RiderCode ASC ", SINo];
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
            while(sqlite3_step(statement2) == SQLITE_ROW) {
                [OtherRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)]];
                [OtherRiderTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)]];
                [OtherRiderDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)]];
                
                tempOtherRiderSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 3)];
                rangeofDotHL = [tempOtherRiderSA rangeOfString:@"."];
                Display = @"";
                if (rangeofDotHL.location != NSNotFound) {
                    substring = [tempOtherRiderSA substringFromIndex:rangeofDotHL.location ];
                    if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                        Display = [tempOtherRiderSA substringToIndex:rangeofDotHL.location ];
                    } else {
                        Display = tempOtherRiderSA;
                    }
                } else {
                    Display = tempOtherRiderSA;
                }
                
                [OtherRiderSA addObject: Display];
                if ([[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)] isEqualToString:@"(null)" ]   ) {
                    [OtherRiderPlanOption addObject:@""];
                } else {
                    [OtherRiderPlanOption addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)]];
                }
                
                [OtherRiderDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 5)]];
                [OtherRiderHL1kSA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 6)]];
                [OtherRiderHL1kSATerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 7)]];
                [OtherRiderHL100SA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 8)]];
                [OtherRiderHL100SATerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 9)]];
                [OtherRiderHLPercentage addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 10)]];
                [OtherRiderHLPercentageTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 11)]];
                [OtherRiderTempHL addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 12)]];
                [OtherRiderTempHLTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 13)]];
                [OtherRiderPayingTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 14)]];
                
                tempOtherRiderSA = Nil;
                Display = Nil;
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(contactDB);
    }
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        QuerySQL = [ NSString stringWithFormat:@"Select A.RiderCode, \"RiderTerm\", B.RiderDesc, \"SumAssured\", \"PlanOption\", "
                    "\"Deductible\", \"HL1kSA\", \"HL1KSATerm\", \"HL100SA\", \"HL100SATerm\", \"HLPercentage\", \"HLPercentageTerm\", "
                    " \"TempHL1kSA\", \"TempHL1kSATerm\", ifnull(PayingTerm, '')  from trad_rider_details as A, "
                    "trad_sys_rider_profile as B  where \"sino\" = \"%@\" AND A.ridercode = B.RiderCode "
                    // hack
                    "AND A.riderCode in(\"LCWP\", \"PR\", \"PLCP\", \"PTR\") "
                    "ORDER BY B.RiderCode ASC ", SINo];
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
            while(sqlite3_step(statement2) == SQLITE_ROW) {
                [OtherRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)]];
                [OtherRiderTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)]];
                [OtherRiderDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)]];
                
                tempOtherRiderSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 3)];
                rangeofDotHL = [tempOtherRiderSA rangeOfString:@"."];
                Display = @"";
                if (rangeofDotHL.location != NSNotFound) {
                    substring = [tempOtherRiderSA substringFromIndex:rangeofDotHL.location ];
                    if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                        Display = [tempOtherRiderSA substringToIndex:rangeofDotHL.location ];
                    } else {
                        Display = tempOtherRiderSA;
                    }
                } else {
                    Display = tempOtherRiderSA;
                }
                
                [OtherRiderSA addObject: Display];
                if ([[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)] isEqualToString:@"(null)" ]   ) {
                    [OtherRiderPlanOption addObject:@""];
                } else {
                    [OtherRiderPlanOption addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)]];
                }
                
                [OtherRiderDeductible addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 5)]];
                [OtherRiderHL1kSA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 6)]];
                [OtherRiderHL1kSATerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 7)]];
                [OtherRiderHL100SA addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 8)]];
                [OtherRiderHL100SATerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 9)]];
                [OtherRiderHLPercentage addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 10)]];
                [OtherRiderHLPercentageTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 11)]];
                [OtherRiderTempHL addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 12)]];
                [OtherRiderTempHLTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 13)]];
                [OtherRiderPayingTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 14)]];
                
                tempOtherRiderSA = Nil;
                Display = Nil;
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(contactDB);
    }
    
    //    NSLog(@"DDATA  OtherRiderCode: %@",OtherRiderCode);
    statement = Nil;
    statement2 = Nil;
    QuerySQL = Nil;
}

#pragma mark - PDF generation

-(void)copySIToDoc{    
    NSString *directory = @"SI";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentSIFolderPath = [documentsDirectory stringByAppendingPathComponent:directory];
    NSString *resourceSIFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:directory];    
    
    if (![fileManager fileExistsAtPath:documentSIFolderPath]) {
        [fileManager createDirectoryAtPath:documentSIFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    } else{
        [fileManager removeItemAtPath:documentSIFolderPath error:&error];
        [fileManager createDirectoryAtPath:documentSIFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:resourceSIFolderPath error:&error];
    NSString *newFilePath;
    NSString *oldFilePath;
    for (NSString *SIFiles in fileList) {
        newFilePath = [documentSIFolderPath stringByAppendingPathComponent:SIFiles];
        oldFilePath = [resourceSIFolderPath stringByAppendingPathComponent:SIFiles];
        [fileManager copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
    }
    
    
    
}

-(NSString*)getRiderCode:(NSString *)rider
{
    NSString *riderName;    
    if([[rider substringWithRange:NSMakeRange(0,3)] isEqualToString:@"WOP"]){
        riderName = [[rider componentsSeparatedByString:@") ("] objectAtIndex:0];
        riderName = [riderName stringByAppendingString:@")"];
    } else{
        riderName = [[rider componentsSeparatedByString:@" ("] objectAtIndex:0];
    }
    
    return [riderCode objectForKey:riderName];
}

@end
