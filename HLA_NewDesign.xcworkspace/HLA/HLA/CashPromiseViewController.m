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

@interface CashPromiseViewController ()

@end
NSMutableArray *UpdateTradDetail, *gWaiverAnnual, *gWaiverSemiAnnual, *gWaiverQuarterly, *gWaiverMonthly, *UpdateTradDetailTerm;

@implementation CashPromiseViewController
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
    RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"HLA_Rates.sqlite"]];
    
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
    
    SummaryGuaranteedTotalGYI = [[NSMutableArray alloc] init ];
    SummaryGuaranteedAddValue = [[NSMutableArray alloc] init ];
    SummaryGuaranteedDBValueA = [[NSMutableArray alloc] init ];
    SummaryGuaranteedDBValueB = [[NSMutableArray alloc] init ];
    SummaryGuaranteedSurrenderValue = [[NSMutableArray alloc] init ];
	
    SummaryNonGuaranteedAccuCashDividendA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedAccuCashDividendB = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedAccuYearlyIncomeA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedAccuYearlyIncomeB = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedDBValueA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedDBValueB = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedSurrenderValueA = [[NSMutableArray alloc] init ];
    SummaryNonGuaranteedSurrenderValueB = [[NSMutableArray alloc] init ];
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
	
	[self deleteTemp]; //clear all temp data
	
    [self getAllPreDetails]; // get all the details needed before proceed
    
    
    [self InsertToSI_Temp_Trad_LA]; // for the front summary page
	
    [self InsertToSI_Temp_Trad_Details]; // for the front summary page figures
	
	
		[self InsertToSI_Temp_Trad_Basic];
	
	
    [self InsertToSI_Temp_Trad_Rider];
    
    if ([PDSorSI isEqualToString:@"SI"]) {
		[self InsertToSI_Temp_Trad];
		[self InsertToSI_Temp_Trad_Overall];
    }
	
    [self UpdateToSI_Temp_Trad_Details];

	if ([PDSorSI isEqualToString:@"SI"]) {
		NSString *siNo = @"";
		NSString *databaseName = @"hladb.sqlite";
		//NSString *databaseName1 = @"0000000000000001.db";
		//NSString *masterName = @"Databases.db";
		
		self.db = [DBController sharedDatabaseController:databaseName];
		
		NSString *sqlStmt = [NSString stringWithFormat:@"SELECT SiNo FROM SI_Temp_Trad"];
		_dataTable = [_db  ExecuteQuery:sqlStmt];
		
		NSArray* row = [_dataTable.rows objectAtIndex:0];
		siNo = [row objectAtIndex:0];
		//NSLog(@"%@",siNo);
		
		sqlStmt = [NSString stringWithFormat:@"SELECT RiderCode FROM Trad_Rider_Details Where SINo = '%@' ORDER BY RiderCode ASC",siNo];
		
		_dataTable = [_db  ExecuteQuery:sqlStmt];
		
		int pageNum = 0;
		int riderCount = 0;
		int riderCountStart = 19; //rider html page number
		NSString *desc = @"Page";
		int DBID;
		//desc = [desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]];
		//NSLog(@"%@", desc);
		
		//    sqlStmt = @"Delete from SI_Temp_Pages where PageNum NOT in ('1', '2', '3') ";
	    sqlStmt = @"Delete from SI_Temp_Pages";
		DBID = [_db ExecuteINSERT:sqlStmt];
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page1.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page2.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page3.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		for (row in _dataTable.rows)
		{
            riderCount++;
            if (riderCount % 3 == 1){
                pageNum++;
                riderCountStart++;
                
                sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('%@',%d,'%@')",
						   [desc stringByAppendingString:[NSString stringWithFormat:@"%d.html",riderCountStart]],pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
                DBID = [_db ExecuteINSERT:sqlStmt];
                if (DBID <= 0){
                    NSLog(@"Error inserting data into database.");
                }
            }
			
		}
		
		//description of basic plan, 2 pages
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page30.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		/*
		 pageNum++;
		 sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('HLACP_Page31.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		 DBID = [_db ExecuteINSERT:sqlStmt];
		 if (DBID <= 0){
		 NSLog(@"Error inserting data into database.");
		 }
		 */
		//rider benefits
		riderCount = 0; //reset rider count
		int descRiderCountStart = 35; //start of rider description page
		int riderInPageCount = 0; //number of rider in a page, maximum 3
		NSString *riderInPage = @""; //rider in a page, write to db
		//NSString *riderInPage1 = @"";
		NSString *curRider; //current rider
		NSString *prevRider; //previous rider
		NSString *headerTitle = @"tblHeader;";
		
		
		sqlStmt = [NSString stringWithFormat:@"SELECT RiderCode FROM Trad_Rider_Details Where SINo = '%@' ORDER BY RiderCode ASC ",siNo];
		//NSLog(@"%@",sqlStmt);
		_dataTable = [_db  ExecuteQuery:sqlStmt];
		
		for (row in _dataTable.rows)
		{
			riderCount++;
			curRider = [row objectAtIndex:0];
			
			//NSLog(@"%@",curRider);
			
			if ([curRider isEqualToString:@"CCTR"] || [curRider isEqualToString:@"ETPD"] || [curRider isEqualToString:@"HB"] ||
				[curRider isEqualToString:@"HMM"] || [curRider isEqualToString:@"HSP_II"] || [curRider isEqualToString:@"MG_II"] ||
				[curRider isEqualToString:@"MG_IV"] || [curRider isEqualToString:@"PR"] ||
				[curRider isEqualToString:@"SP_STD"] || [curRider isEqualToString:@"PTR"] || [curRider isEqualToString:@"EDB"] ||
				[curRider isEqualToString:@"ETPDB"] || [curRider isEqualToString:@"PA"]  ){
				riderInPageCount++;
				prevRider = curRider;
				
				if(riderCount == 1){
					riderInPage = [headerTitle stringByAppendingString:riderInPage];
				}
				
				riderInPage = [riderInPage stringByAppendingString:curRider];
				riderInPage = [riderInPage stringByAppendingString:@";"];
				if (riderInPageCount == 3){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					//if(riderCount == 1)
					//  riderInPage = [headerTitle stringByAppendingString:riderInPage];
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
					prevRider = @"";
				}
				
				if (riderInPageCount == 1 && riderCount == _dataTable.rows.count){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
				}
				
				if (riderInPageCount == 2 && riderCount == _dataTable.rows.count) {
					pageNum++;
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
				}
			}
			else{
				if (riderInPageCount == 2){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					if(riderCount == 1)
						riderInPage = [headerTitle stringByAppendingString:riderInPage];
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					prevRider= @"";
					riderInPageCount = 0;
					riderInPage = @"";
				}
				if ([prevRider isEqualToString:@"CCTR"] || [prevRider isEqualToString:@"ETPD"] || [prevRider isEqualToString:@"HB"] ||
					[prevRider isEqualToString:@"HMM"] || [prevRider isEqualToString:@"HSP_II"] || [prevRider isEqualToString:@"MG_II"] ||
					[prevRider isEqualToString:@"MG_IV"] || [prevRider isEqualToString:@"PR"] || [prevRider isEqualToString:@"PA"] ||
					[prevRider isEqualToString:@"SP_STD"] || [prevRider isEqualToString:@"PTR"] || [prevRider isEqualToString:@"ETPDB"]
					|| [prevRider isEqualToString:@"EDB"]){
					if (![curRider isEqualToString:@"ICR"] && ![curRider isEqualToString:@"LCPR"] && ![curRider isEqualToString:@"LCWP"]
						&& ![curRider isEqualToString:@"PLCP"] && ![prevRider isEqualToString:@""]) {
						prevRider = [prevRider stringByAppendingString:@";"];
						curRider = [prevRider stringByAppendingString:curRider];
						riderInPageCount = 0;
						riderInPage = @"";
						
					}
					else{
						pageNum++;
						
						if(riderCount == 1){
							riderInPage = [headerTitle stringByAppendingString:riderInPage];
						}
						
						sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
								   "('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
						DBID = [_db ExecuteINSERT:sqlStmt];
						if (DBID <= 0){
							NSLog(@"Error inserting data into database.");
						}
						prevRider = @"";
						riderInPage = @"";
						riderInPageCount = 0;
					}
					
				}
				//NSLog(@"%@",curRider);
				pageNum++;
				if(riderCount == 1)
					curRider = [headerTitle stringByAppendingString:curRider];
				//descRiderCountStart++;
				sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",curRider,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
				DBID = [_db ExecuteINSERT:sqlStmt];
				if (DBID <= 0){
					NSLog(@"Error inserting data into database.");
				}
				//NSLog(@"%@",sqlStmt);
			}
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page40.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page41.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		for (row in _dataTable.rows) {
			NSString *sss = [row objectAtIndex:0];
			
			if([sss isEqualToString:@"HMM" ] || [sss isEqualToString:@"HB" ] || [sss isEqualToString:@"MG_IV" ] || [sss isEqualToString:@"MG_II" ]
			   || [sss isEqualToString:@"CIR" ] || [sss isEqualToString:@"CIWP" ] || [sss isEqualToString:@"HSP_II" ] || [sss isEqualToString:@"LCPR" ]
			   || [sss isEqualToString:@"LCWP" ] || [sss isEqualToString:@"ICR"]  || [sss isEqualToString:@"SP_PRE" ] || [sss isEqualToString:@"PLCP" ] ){
				
				pageNum++;
				sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page42.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
				DBID = [_db ExecuteINSERT:sqlStmt];
				if (DBID <= 0){
					NSLog(@"Error inserting data into database.");
				}
				break;
			}
			sss = Nil;
		}
		
		// malay version here page201.html ---> page 220
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page50.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		/*
		 pageNum++;
		 sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page51.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		 DBID = [_db ExecuteINSERT:sqlStmt];
		 if (DBID <= 0){
		 NSLog(@"Error inserting data into database.");
		 }*/
		
		riderCount = 0; //reset rider count
		descRiderCountStart = 36; //start of rider description page
		riderInPageCount = 0; //number of rider in a page, maximum 3
		riderInPage = @""; //rider in a page, write to db
		//NSString *riderInPage1 = @"";
		curRider = @""; //current rider
		prevRider = @""; //previous rider
		headerTitle = @"tblHeader;";
		
		for (row in _dataTable.rows) //income rider
		{
			riderCount++;
			curRider = [row objectAtIndex:0];
			
			//NSLog(@"%@",curRider);
			
			if ([curRider isEqualToString:@"CCTR"] || [curRider isEqualToString:@"ETPD"] || [curRider isEqualToString:@"HB"] ||
				[curRider isEqualToString:@"HMM"] || [curRider isEqualToString:@"HSP_II"] || [curRider isEqualToString:@"MG_II"] ||
				[curRider isEqualToString:@"MG_IV"] || [curRider isEqualToString:@"PR"] || [curRider isEqualToString:@"PA"] ||
				[curRider isEqualToString:@"SP_STD"] || [curRider isEqualToString:@"PTR"] || [curRider isEqualToString:@"EDB"] || [curRider isEqualToString:@"ETPDB"]){
				riderInPageCount++;
				prevRider = curRider;
				
				if(riderCount == 1){
					riderInPage = [headerTitle stringByAppendingString:riderInPage];
				}
				riderInPage = [riderInPage stringByAppendingString:curRider];
				riderInPage = [riderInPage stringByAppendingString:@";"];
				if (riderInPageCount == 3){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					//if(riderCount == 1)
					//riderInPage = [headerTitle stringByAppendingString:riderInPage];
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
					prevRider = @"";
				}
				/*
				 if (riderInPageCount == 1 && riderCount == _dataTable.rows.count){
				 NSLog(@"%@",riderInPage);
				 }
				 */
				if (riderInPageCount == 1 && riderCount == _dataTable.rows.count){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
				}
				
				if (riderInPageCount == 2 && riderCount == _dataTable.rows.count) {
					pageNum++;
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					riderInPageCount = 0;
					riderInPage = @"";
				}
			}
			else{
				if (riderInPageCount == 2){
					//NSLog(@"%@",riderInPage);
					pageNum++;
					if(riderCount == 1)
						riderInPage = [headerTitle stringByAppendingString:riderInPage];
					//descRiderCountStart++;
					sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
					DBID = [_db ExecuteINSERT:sqlStmt];
					if (DBID <= 0){
						NSLog(@"Error inserting data into database.");
					}
					//NSLog(@"%@",sqlStmt);
					prevRider= @"";
					riderInPageCount = 0;
					riderInPage = @"";
				}
				if ([prevRider isEqualToString:@"CCTR"] || [prevRider isEqualToString:@"ETPD"] || [prevRider isEqualToString:@"HB"] ||
					[prevRider isEqualToString:@"HMM"] || [prevRider isEqualToString:@"HSP_II"] || [prevRider isEqualToString:@"MG_II"] ||
					[prevRider isEqualToString:@"MG_IV"] || [prevRider isEqualToString:@"PR"] || [prevRider isEqualToString:@"PA"] ||
					[prevRider isEqualToString:@"SP_STD"] || [prevRider isEqualToString:@"PTR"] || [prevRider isEqualToString:@"ETPDB"]
					|| [prevRider isEqualToString:@"EDB"]){
					if (![curRider isEqualToString:@"ICR"] && ![curRider isEqualToString:@"LCPR"] && ![curRider isEqualToString:@"LCWP"]
						&& ![curRider isEqualToString:@"PLCP"] && ![prevRider isEqualToString:@""]) {
						prevRider = [prevRider stringByAppendingString:@";"];
						curRider = [prevRider stringByAppendingString:curRider];
						riderInPageCount = 0;
						riderInPage = @"";
						
					}
					else{
						pageNum++;
						if(riderCount == 1){
							riderInPage = [headerTitle stringByAppendingString:riderInPage];
						}
						sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES "
								   "('%@','Page%d.html',%d,'%@')",riderInPage,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
						DBID = [_db ExecuteINSERT:sqlStmt];
						if (DBID <= 0){
							NSLog(@"Error inserting data into database.");
						}
						prevRider = @"";
						riderInPage = @"";
						riderInPageCount = 0;
					}
					
				}
				//NSLog(@"%@",curRider);
				pageNum++;
				if(riderCount == 1)
					curRider = [headerTitle stringByAppendingString:curRider];
				//descRiderCountStart++;
				sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(riders,htmlName, PageNum, PageDesc) VALUES ('%@','Page%d.html',%d,'%@')",curRider,descRiderCountStart,pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
				DBID = [_db ExecuteINSERT:sqlStmt];
				if (DBID <= 0){
					NSLog(@"Error inserting data into database.");
				}
				//NSLog(@"%@",sqlStmt);
			}
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page60.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		pageNum++;
		sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page61.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
		DBID = [_db ExecuteINSERT:sqlStmt];
		if (DBID <= 0){
			NSLog(@"Error inserting data into database.");
		}
		
		for (row in _dataTable.rows) {
			NSString *sss = [row objectAtIndex:0];
			
			if([sss isEqualToString:@"HMM" ] || [sss isEqualToString:@"HB" ] || [sss isEqualToString:@"MG_IV" ] || [sss isEqualToString:@"MG_II" ]
			   || [sss isEqualToString:@"CIR" ] || [sss isEqualToString:@"CIWP" ] || [sss isEqualToString:@"HSP_II" ]|| [sss isEqualToString:@"LCPR" ]
			   || [sss isEqualToString:@"LCWP" ] || [sss isEqualToString:@"ICR"]   || [sss isEqualToString:@"SP_PRE" ] || [sss isEqualToString:@"PLCP" ] ){
				
				pageNum++;
				sqlStmt = [NSString stringWithFormat:@"INSERT INTO SI_Temp_Pages(htmlName, PageNum, PageDesc) VALUES ('Page62.html',%d,'%@')",pageNum,[desc stringByAppendingString:[NSString stringWithFormat:@"%d",pageNum]]];
				DBID = [_db ExecuteINSERT:sqlStmt];
				if (DBID <= 0){
					NSLog(@"Error inserting data into database.");
				}
				
				break;
			}
			sss = Nil;
		}
		
		sqlStmt = Nil;
		riderInPage = Nil;
		headerTitle = Nil;
		curRider = Nil;
		prevRider = Nil;
		dirPaths = Nil;
		docsDir = Nil;
		siNo = Nil;
		databaseName = Nil;
		desc = Nil;
		
	}
	
    
    
    //------- end ---------
    
    /*
    NSString* library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString* documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    
    NSString *WebSQLSubdir;
    NSString *WebSQLPath;
    NSString *WebSQLDb;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    
    if (IsAtLeastiOSVersion(@"6.0")){
     
     
        NSString *viewerPlist = [library stringByAppendingPathComponent:@"viewer.plist"];
        BOOL plistExist = [fileManager fileExistsAtPath:viewerPlist];
        if (!plistExist){
            NSLog(@"not exist!");
            NSString *viewerPlistFromDoc = [documents stringByAppendingPathComponent:@"viewer.plist"];
            [fileManager copyItemAtPath:viewerPlistFromDoc toPath:viewerPlist error:&error];
			
			NSLog(@"Error at copying plist file --> %@", error);
     
            databaseName = @"hladb.sqlite";//actual
            databaseName1 = @"hladb.sqlite";//dummy
            WebSQLSubdir = @"Caches";
            WebSQLPath = [library stringByAppendingPathComponent:WebSQLSubdir];
            WebSQLDb = [WebSQLPath stringByAppendingPathComponent:@"file__0"];
     
            viewerPlistFromDoc =Nil;
     
        }
        else{
            NSLog(@"exist!");
     
            databaseName = @"hladb.sqlite";//actual
            databaseName1 = @"hladb.sqlite";//dummy
            WebSQLSubdir = @"WebKit/LocalStorage";
            WebSQLPath = [library stringByAppendingPathComponent:WebSQLSubdir];
            WebSQLDb = [WebSQLPath stringByAppendingPathComponent:@"file__0"];
     
     
        }
		
        viewerPlist = Nil;
    }
    else{
     
        databaseName = @"hladb.sqlite";//actual
        databaseName1 = @"hladb.sqlite";//dummy
        WebSQLSubdir = (IsAtLeastiOSVersion(@"5.1")) ? @"Caches" : @"WebKit/Databases";
        WebSQLPath = [library stringByAppendingPathComponent:WebSQLSubdir];
        WebSQLDb = [WebSQLPath stringByAppendingPathComponent:@"file__0"];
    }
    
    NSString *masterFile = [WebSQLPath stringByAppendingPathComponent:masterName];
    //NSString *databaseFile = [WebSQLDb stringByAppendingPathComponent:databaseName1]; //edited on 19/3/13
    NSString *databaseFile = [WebSQLDb stringByAppendingPathComponent:databaseName];
	
    [fileManager removeItemAtPath:databaseFile error:&error];
	if(!error){
		NSLog(@"Error at remove databaseFile --> %@", error);
	}
		
    [fileManager removeItemAtPath:masterFile error:&error];
	if(!error){
		NSLog(@"Error at remove masterFile --> %@", error);
	}
    //NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    NSString *masterPathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:masterName];
    
    
    NSString *databasePathFromDoc = [docsDir stringByAppendingPathComponent:databaseName];
    //NSString *masterPathFromDoc = [docsDir stringByAppendingPathComponent:masterName];
    
    [fileManager createDirectoryAtPath:WebSQLDb withIntermediateDirectories:YES attributes:nil error:&error];
	if(!error){
		NSLog(@"Error at createDirectory --> %@", error);
	}
    [fileManager copyItemAtPath:databasePathFromDoc toPath:databaseFile error:&error];
	if(!error){
		NSLog(@"Error at copying to databasepath --> %@", error);
	}

    [fileManager copyItemAtPath:masterPathFromApp toPath:masterFile error:&error];
	if(!error){
		NSLog(@"Error at copying to masterpath --> %@", error);
	}
	
	 
	error = Nil;
    fileManager = Nil;
    masterFile = Nil;
    databaseFile = Nil;
    masterPathFromApp = Nil;
    databasePathFromDoc = Nil;
    library = Nil;
    documents = Nil;
    WebSQLSubdir = Nil;
	 
    WebSQLPath = Nil;
    WebSQLDb = Nil;
	 */
    _dataTable = Nil;
    _db = Nil;
    
    SINo = Nil, RatesDatabasePath = Nil;
    YearlyIncome = Nil;
    CashDividend = Nil;
    CustCode = Nil;
    Name = Nil;
    strBasicAnnually = Nil, strBasicSemiAnnually = Nil, strBasicQuarterly = Nil, strBasicMonthly = Nil;
    strOriBasicAnnually = Nil, strOriBasicSemiAnnually = Nil, strOriBasicQuarterly = Nil, strOriBasicMonthly = Nil;
    sex = Nil, OccpClass = Nil;
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
    databasePath = Nil, contactDB = Nil;
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)deleteTemp{
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        
        
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

-(void)InsertToSI_Temp_Trad_Details{
    sqlite3_stmt *statement;
    NSString *QuerySQL;
    NSString *RiderSQL;
    NSString *SelectSQL = @"";
    NSString *firstLifeLoading = [OccLoading objectAtIndex:0];
    NSString *secondtLifeLoading = @"";
    
    //if ([firstLifeLoading isEqualToString:@"STD"]) { //<-- for non penta
	if ([firstLifeLoading isEqualToString:@"0.0"]) { //<-- for penta
        firstLifeLoading = @"";
    }
	else{
		firstLifeLoading = [NSString stringWithFormat:@"%d", [firstLifeLoading intValue]];
	}
    
    if (OccLoading.count > 1) {
        //secondtLifeLoading = [[OccLoading objectAtIndex:1] isEqualToString:@"STD"] ? @"" : [OccLoading objectAtIndex:1] ;
		secondtLifeLoading = [[OccLoading objectAtIndex:1] isEqualToString:@"0.0"] ? @"" : [OccLoading objectAtIndex:1] ;
    }
    else{
        secondtLifeLoading = @"";
    }
	
	if (![secondtLifeLoading isEqualToString:@""]) {
			secondtLifeLoading = [NSString stringWithFormat:@"%d", [secondtLifeLoading intValue]];
	}
	
	

	if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		/*
		 double annually =arc4random() % 5000 + 500;
		 double semiAnnually = annually * 0.5125;
		 double Quarterly = annually * 0.2625;
		 double monthly = annually * 0.0875;
		 */
		NSString *strAnnually = @"";
		NSString *strSemiAnnually = @"";
		NSString *strQuarterly = @"";
		NSString *strMonthly = @"";
		NSString *HL1KSA = @"";
		NSString *TempHL1KSA = @"";
		
		
		SelectSQL = @"Select * from SI_Store_Premium where type = \"B\" ";
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
		
		SelectSQL = @"Select * from SI_Store_Premium where type = \"BOriginal\" ";
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
		
		NSString *totalHLoading = [NSString stringWithFormat:@"%d", [HL1KSA intValue ] + [TempHL1KSA intValue]];
		
		if ([totalHLoading isEqualToString:@"0"]) {
			totalHLoading = @"";
		}
		else{
			totalHLoading = [NSString stringWithFormat:@"%.0f", [totalHLoading doubleValue]];
		}
		
		if (![totalHLoading isEqualToString:@""]) {
			
			for (int i = 1; i <= PolicyTerm;  i++) {
				
				double ActualPremium;
				
					if (![HL1KSA isEqualToString:@"0"]) {
						if(i > [HealthLoadingTerm intValue ]){
							
							ActualPremium = [[strBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue]
							- ([HL1KSA doubleValue] * BasicSA/1000);
							
							//[aStrBasicSA addObject:strBasicAnnually];
						}
						else{
							ActualPremium = [[strBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
						}
						
					}
					else{
						ActualPremium = [[strBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@""] doubleValue];
					}
					
					if (![TempHL1KSA isEqualToString:@"0"]) {
						if (i > [TempHealthLoadingTerm intValue ]) {
							ActualPremium = ActualPremium - ([TempHL1KSA doubleValue] * BasicSA/1000);
						}
						
					}
					
					[aStrBasicSA addObject: [NSString stringWithFormat:@"%.2f", ActualPremium]];
				
			}
		}
		else{
			for (int i = 1; i <= PolicyTerm;  i++) {
				
				[aStrBasicSA addObject:[strBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
				
			}
		}
		/*
		 for (int i = 1; i <= PolicyTerm;  i++) {
		 NSLog(@"%@", [aStrBasicSA objectAtIndex:i-1]);
		 }
		 */
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
					"\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\") "
					" VALUES ( "
					" \"%@\",\"1\",\"DATA\",\"HLA Cash Promise\",\"\",\"0\",\"%.2f\",\"%d\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\" "
					")", SINo, BasicSA,PolicyTerm,@"6",strAnnually, strSemiAnnually, strQuarterly, strMonthly, totalHLoading, firstLifeLoading ];
		
		if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
			if (sqlite3_step(statement) == SQLITE_DONE) {
				
				NSLog(@"insert to SI_Temp_Trad_Details --- start");
				
				
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
    
    for (int a=0; a<OtherRiderCode.count; a++) {
        
        NSString *strAnnually = @"";
        NSString *strSemiAnnually = @"";
        NSString *strQuarterly = @"";
        NSString *strMonthly = @"";
        NSString *strUnits = @"";
        NSString *seq = @"", *OtherHLoading= @"", *OtherTempHLoading= @"";;
        
        if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"ICR" ]) {
            seq = @"4";
        }
        else if(([[OtherRiderCode objectAtIndex:a] characterAtIndex:0] > 64 && [[OtherRiderCode objectAtIndex:a] characterAtIndex:0] < 73) ||
                ([[OtherRiderCode objectAtIndex:a] characterAtIndex:0] > 96 && [[OtherRiderCode objectAtIndex:a] characterAtIndex:0] < 105)){
            seq = @"2";
        }
        else{
            seq = @"6";
        }
		
		
		//for total CI
		if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"CIR" ] ||
			[[OtherRiderCode objectAtIndex:a] isEqualToString:@"LCPR" ]  ) {
			TotalCI = TotalCI + [[OtherRiderSA objectAtIndex:a] doubleValue];
			[CIRiders addObject:[OtherRiderCode objectAtIndex:a]];
		}
		else if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"ICR" ]){
			TotalCI = TotalCI + ([[OtherRiderSA objectAtIndex:a] doubleValue] * 10);
			[CIRiders addObject:[OtherRiderCode objectAtIndex:a]];
		}
		else if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"PLCP" ]){
			TotalCI2 = TotalCI2 + ([[OtherRiderSA objectAtIndex:a] doubleValue]);
			[CIRiders2 addObject:[OtherRiderCode objectAtIndex:a]];
		}
		//end
		
		
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
			
            SelectSQL = [ NSString stringWithFormat:@"Select \"Type\", \"Annually\",\"SemiAnnually\",\"Quarterly\",\"Monthly\", \"Units\"  "
						 " from SI_Store_Premium as A, trad_rider_details as B where A.Type = B.riderCode AND \"type\" = \"%@\" "
						 " AND \"FromAge\" is NULL AND B.SINO = \"%@\" ", [OtherRiderCode objectAtIndex:a], SINo];
			
            if(sqlite3_prepare_v2(contactDB, [SelectSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_ROW) {
                    strAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    strSemiAnnually = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    strQuarterly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                    strMonthly = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                    strUnits = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
					//NSLog(@"%@ -- %@", strUnits, [OtherRiderCode objectAtIndex:a]);
                    [aStrOtherRiderAnnually addObject:[strAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    [aStrOtherRiderSemiAnnually addObject:[strSemiAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    [aStrOtherRiderQuarterly addObject:[strQuarterly stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                    [aStrOtherRiderMonthly addObject:[strMonthly stringByReplacingOccurrencesOfString:@"," withString:@"" ]];
                }
                sqlite3_finalize(statement);
            }
			
            if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"C+"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"CCTR"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"CIR"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"C+"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"CPA"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"ETPD"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"LCPR"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"C+"] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PA"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PLCP"]
				|| [[OtherRiderCode objectAtIndex:a] isEqualToString:@"ICR"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PTR"]
				|| [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"EDB" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"ETPDB" ]) {
                
                SelectSQL = [NSString stringWithFormat:@"Select HL1KSA, TempHL1KSA from Trad_Rider_Details where Sino = \"%@\" AND Ridercode = \"%@\"  ", SINo, [OtherRiderCode objectAtIndex:a]];
                
            }
            else if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"CIWP"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"LCWP"] ||
					 [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PR"] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"SP_PRE"] ||
					 [[OtherRiderCode objectAtIndex:a] isEqualToString:@"SP_STD"]){
                SelectSQL = [NSString stringWithFormat:@"Select HL100SA, TempHL1KSA from Trad_Rider_Details where Sino = \"%@\" AND Ridercode = \"%@\"  ", SINo, [OtherRiderCode objectAtIndex:a]];
                
            }
            else{
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
            }
            else{
                OtherHLoading = [NSString stringWithFormat:@"%d", [OtherHLoading intValue]];
            }
            
			if (![OtherTempHLoading isEqualToString:@"" ]) {
                OtherHLoading = [NSString stringWithFormat:@"%d",[OtherHLoading intValue ] + [OtherTempHLoading intValue]];
            }
            
			
			
            
			
            // special case for LCWP, PR, SP_PRE, SP_STD --> second life assured riders
            if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"LCWP" ] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"PR" ] || [[OtherRiderCode objectAtIndex:a] isEqualToString:@"SP_PRE" ] ||
                [[OtherRiderCode objectAtIndex:a] isEqualToString:@"SP_STD" ]) {
                [UpdateTradDetail addObject:[OtherRiderCode objectAtIndex:a]];
                [UpdateTradDetailTerm addObject:[OtherRiderTerm objectAtIndex:a]];
				
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, [[OtherRiderDesc objectAtIndex:a] stringByAppendingString:[ NSString stringWithFormat:@" (%@%%)", [OtherRiderSA objectAtIndex:a]]],
                            [OtherRiderPlanOption objectAtIndex:a], @"-", [OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], @"-",
                            @"-", @"-", @"-", OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a] ];
                
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, @"-Annual",@"-", @"500.00", @"", @"", strAnnually, @"-", @"-", @"-",OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a]];
                
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, @"-Semi-annual",@"-", @"400.00", @"", @"", @"-", strSemiAnnually, @"-", @"-",OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, @"-Quarterly",@"-", @"300.00", @"", @"", @"-", @"-", strQuarterly, @"-", OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, @"-Monthly",@"-", @"200.00", @"", @"", @"-", @"-", @"-", strMonthly,OtherHLoading, secondtLifeLoading, [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
            }
            //special case for ciwp only --> first life assured riders
            else if ([[OtherRiderCode objectAtIndex:a] isEqualToString:@"CIWP"  ]) {
                [UpdateTradDetail addObject:[OtherRiderCode objectAtIndex:a]];
				[UpdateTradDetailTerm addObject:[OtherRiderTerm objectAtIndex:a]];
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, [[OtherRiderDesc objectAtIndex:a] stringByAppendingString:[ NSString stringWithFormat:@" (%@%%)", [OtherRiderSA objectAtIndex:a]]],
                            [OtherRiderPlanOption objectAtIndex:a], @"-", [OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], @"-",
                            @"-", @"-", @"-",OtherHLoading, @"", [OtherRiderCode objectAtIndex:a] ];
                
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, @"-Annual",@"-", @"500.00", @"", @"", strAnnually, @"-", @"-", @"-",OtherHLoading, @"", [OtherRiderCode objectAtIndex:a]];
                
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, @"-Semi-annual",@"-", @"400.00", @"", @"", @"-", strSemiAnnually, @"-", @"-",OtherHLoading, @"", [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, @"-Quarterly",@"-", @"300.00", @"", @"", @"-", @"-", strQuarterly, @"-", OtherHLoading, @"", [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
                RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                            "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\") VALUES ( "
                            " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"0\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\" "
                            ")", SINo, seq, @"-Monthly",@"-", @"200.00", @"", @"", @"-", @"-", @"-", strMonthly, OtherHLoading, @"", [OtherRiderCode objectAtIndex:a]];
                if(sqlite3_prepare_v2(contactDB, [RiderSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        
                    }
                    sqlite3_finalize(statement);
                }
                
            }
            else {
                NSString *RiderDesc = @"";
                NSString *SA = @"";
                if (![[OtherRiderDeductible objectAtIndex:a] isEqualToString:@"(null)" ]) {
                    RiderDesc= [NSString stringWithFormat:@"%@ (Class %@) (Deductible %@ )", [OtherRiderDesc objectAtIndex:a],
                                OccpClass ,[OtherRiderDeductible objectAtIndex:a] ];
					
                }
                else if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"CPA" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"PA" ]
                         || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HMM" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HSP_II" ]
                         || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_IV" ]){
                    RiderDesc= [NSString stringWithFormat:@"%@ (Class %@)", [OtherRiderDesc objectAtIndex:a],
                                OccpClass ];
                }
                else {
                    RiderDesc = [OtherRiderDesc objectAtIndex:a];
                }
                
                if ( [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HMM" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HSP_II" ]
                    || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"MG_IV" ]
                    || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"HB" ]){
                    
                    SA = @"-";
					if (![OtherHLoading isEqualToString:@""]) {
							OtherHLoading = [OtherHLoading stringByAppendingFormat:@"%%" ];
					}
					
                }
                else{
                    SA = [OtherRiderSA objectAtIndex:a];
                }
                
				
				
                NSString *planOption = [OtherRiderPlanOption objectAtIndex:a];
                if ([planOption isEqualToString:@"Level"]) {
                    planOption = @"Option 1";
                }
                else if ([planOption isEqualToString:@"Increasing"]) {
                    planOption = @"Option 2";
                }
                else if ([planOption isEqualToString:@"Level_NCB"]) {
                    planOption = @"Option 3";
                }
                else if ([planOption isEqualToString:@"Increasing_NCB"]) {
                    planOption = @"Option 4";
                }
				
				
                if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"CCTR" ]) {
                    RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
                                "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\") VALUES ( "
                                " \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\" "
                                ")", SINo, seq, RiderDesc,planOption, strUnits, [OtherRiderSA objectAtIndex:a],
                                [OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], strAnnually,
                                strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, firstLifeLoading];
                }
                else{
					
					if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"EDB" ] || [[OtherRiderCode objectAtIndex:a ] isEqualToString:@"ETPDB" ] ) {
						RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
									"\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\") VALUES ( "
									" \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\" "
									")", SINo, seq, RiderDesc,planOption, strUnits, SA,
									[OtherRiderTerm objectAtIndex:a], @"6", strAnnually,
									strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, firstLifeLoading];
						
					}
					else if ([[OtherRiderCode objectAtIndex:a ] isEqualToString:@"LCPR"]){ // add in occ loading
						RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
									"\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\") VALUES ( "
									" \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\" "
									")", SINo, seq, RiderDesc,planOption, strUnits, SA,
									[OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], strAnnually,
									strSemiAnnually, strQuarterly, strMonthly, OtherHLoading, firstLifeLoading];
					}
					else{
						// without occ loading in quotation
						RiderSQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Details (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
									"\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\") VALUES ( "
									" \"%@\",\"%@\",\"DATA\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"\" "
									")", SINo, seq, RiderDesc,planOption, strUnits, SA,
									[OtherRiderTerm objectAtIndex:a], [OtherRiderTerm objectAtIndex:a], strAnnually,
									strSemiAnnually, strQuarterly, strMonthly, OtherHLoading];
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
	
    NSLog(@"insert to SI_Temp_Trad_Details --- End");
    statement = Nil;
    QuerySQL = Nil;
    RiderSQL = Nil;
    SelectSQL =  Nil;
    firstLifeLoading = Nil;
    secondtLifeLoading = Nil;
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
				
				getFromCltProfileSQL  = [NSString stringWithFormat:@"Select Name, Smoker, sex, ALB from clt_profile where custcode  = \"%@\"",  CustCode];
				
				if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
					
					if (sqlite3_step(statement2) == SQLITE_ROW) {
						Name = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
						smoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
						sex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
						Age = sqlite3_column_int(statement2, 3);
						
						QuerySQL  = [ NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_LA (\"SINo\", \"LADesc\", "
									 "\"PtypeCode\", \"Seq\", \"Name\", \"Age\", \"Sex\", \"Smoker\", \"LADescM\") "
									 " VALUES (\"%@\",\"Life Assured\",\"LA\",\"%d\",\"%@\",\"%d\", \"%@\", \"%@\", "
									 " \"Hayat yang Diinsuranskan\")", SINo, 1, Name, Age, sex, smoker ];
						
						if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement3, NULL) == SQLITE_OK) {
							if (sqlite3_step(statement3) == SQLITE_DONE) {
								//NSLog(@"done insert to temp_trad_LA");
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
                                     " \"Hayat yang Diinsuranskan ke-2\")", SINo, 2, SecName, SecAge, Secsex, Secsmoker ];
                        
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
    
    NSLog(@"insert to SI_Temp_Trad_Basic --- start");
    
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        //------------------- GYI / BasicSA
        
		for (int a = 0; a< PolicyTerm; a++) {
			[rates addObject:[NSString stringWithFormat:@"%.2f", BasicSA]];
		}
			
        //---------------- surrender value
        
            QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_CSV where PlanCode = 'HLACP'  "
                        " AND age = \"%d\" ", Age];
        

        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [SurrenderRates addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
		
		
        /*
        //------------------------ DB start of the year

            QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_DB where advOption = \"N\" "
                        " AND  age = \"%d\" ", Age];
        
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [DBRates addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            sqlite3_finalize(statement);
        }
        
        //--------------------------- DB end of the year
        
            QuerySQL = [NSString stringWithFormat: @"Select rate from trad_sys_Basic_DB where advOption = \"N\" "
                        " AND age = \"%d\" and PolYear > 1 ", Age];
        
		
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [DBRatesEnd addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
            }
            
            if (DBRatesEnd.count > 0) {
                NSString *zzz = [DBRatesEnd objectAtIndex:DBRatesEnd.count - 1];
                [DBRatesEnd addObject:zzz];
            }
            
            sqlite3_finalize(statement);
        }
		 */
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
    
	if (PolicyTerm > 25) {
		PolicyTerm = 25;
	}
		
    for (int i =1; i <= PolicyTerm; i++) {
        
		if (i <= 6) {
			[AnnualPremium addObject:[aStrBasicSA objectAtIndex:i-1]];
		}
		else{
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
		
        //BasicTotalYearlyIncome = BasicTotalYearlyIncome + [[arrayYearlyIncome objectAtIndex:i -1] doubleValue ];
        //EntireTotalYearlyIncome = EntireTotalYearlyIncome + [[arrayYearlyIncome objectAtIndex: i-1] doubleValue ];

		BasicTotalYearlyIncome = BasicTotalYearlyIncome + [[TotalPartialYearlyIncome objectAtIndex:i -1] doubleValue ];
        EntireTotalYearlyIncome = EntireTotalYearlyIncome + [[TotalPartialYearlyIncome objectAtIndex: i-1] doubleValue ];
		
        [SummaryGuaranteedTotalGYI addObject:[[arrayYearlyIncome objectAtIndex:i-1] stringByReplacingOccurrencesOfString:@"#" withString:@"" ]];

        [SurrenderValue addObject:[NSString stringWithFormat:@"%.9f", [[SurrenderRates objectAtIndex:i-1] doubleValue ] * BasicSA/1000 ]];

        [SummaryGuaranteedSurrenderValue addObject:[SurrenderValue objectAtIndex:i-1]];
		        				
		// --------------------
		if (Age <= 40) {
			
			[DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 12.5 * BasicSA ]];
		}
		else if (Age > 40 && Age <= 50){
			if ((26 - i) * BasicSA + 6.25 * BasicSA >= 12.5 * BasicSA) {
				[DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 6.25 * BasicSA ]];
			}
			else{
				[DBValue addObject:[NSString stringWithFormat:@"%.3f", 12.5 * BasicSA]];
			}
		}
        else if (Age > 50 && Age <= 60){
			if ((26 - i) * BasicSA + 5.5 * BasicSA >= 11 * BasicSA) {
				[DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 5.5 * BasicSA ]];
			}
			else{
				[DBValue addObject:[NSString stringWithFormat:@"%.3f", 11.0 * BasicSA]];
			}
		}
		else if (Age > 60 && Age <= 63){
			if ((26 - i) * BasicSA + 5.0 * BasicSA >= 10 * BasicSA) {
				[DBValue addObject:[NSString stringWithFormat:@"%.3f", (26 - i) * BasicSA + 5.0 * BasicSA ]];
			}
			else{
				[DBValue addObject:[NSString stringWithFormat:@"%.3f", 10.0 * BasicSA]];
			}
		}

		//-------------------
		
		if (Age <= 40) {
			
			if (i == 25) {
				[DBValueEnd addObject:[NSString stringWithFormat:@"%.3f",  BasicSA + 12.5 * BasicSA ]];
			}
			else{
				[DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 12.5 * BasicSA ]];
			}
			
			
		}
		else if (Age > 40 && Age <= 50){
			if ((25 - i) * BasicSA + 6.25 * BasicSA >= 12.5 * BasicSA) {
				[DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 6.25 * BasicSA ]];
			}
			else{
				[DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 12.5 * BasicSA]];
			}
		}
        else if (Age > 50 && Age <= 60){
			if ((25 - i) * BasicSA + 5.5 * BasicSA >= 11 * BasicSA) {
				[DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 5.5 * BasicSA ]];
			}
			else{
				[DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 11.0 * BasicSA]];
			}
		}
		else if (Age > 60 && Age <= 63){
			if ((25 - i) * BasicSA + 5.0 * BasicSA >= 10 * BasicSA) {
				[DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", (25 - i) * BasicSA + 5.0 * BasicSA ]];
			}
			else{
				[DBValueEnd addObject:[NSString stringWithFormat:@"%.3f", 10.0 * BasicSA]];
			}
		}
		
        [SummaryGuaranteedDBValueA addObject:[DBValue objectAtIndex:i-1]];
        [SummaryGuaranteedDBValueB addObject:[DBValueEnd objectAtIndex:i-1]];
        
        //------------------------


		if (i <= 6) {
			if (i+ Age <= 64) {
				if (i == 1) {
					
					//TotalAD = [[aStrBasicSA objectAtIndex:0]doubleValue ];
					TotalAD = [[AnnualPremium objectAtIndex:i -1]doubleValue ];
				}
				else{
					TotalAD = TotalAD + [[AnnualPremium objectAtIndex:i -1]doubleValue ];
				}
			}
			else{
				TotalAD = 0.00;
			}
		}
		else{
			TotalAD = 0.00;
		}
        
        
        [aValue addObject: [NSString stringWithFormat:@"%.3f", TotalAD] ];
        [SummaryGuaranteedAddValue addObject:[aValue objectAtIndex:i-1]];
        //-----------------------------------
        
        //---------------- total premium paid ----------
        
        double sumBasic = 0.0;
        double sumOtherRider = 0.0;
        
		sumBasic = [[AnnualPremium objectAtIndex:i -1] doubleValue ];
        
        for (int j =0; j<OtherRiderCode.count; j++) {
            if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HMM" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_IV" ]
                || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"MG_II" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HSP_II" ] ) {
				
                if ( i <= [[OtherRiderTerm objectAtIndex:j] intValue ]   ) {
                    double tempHMMRates = 0.00;
                    
                    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                        QuerySQL = [NSString stringWithFormat:@"Select Annually from SI_Store_premium Where Type = \"%@\" AND "
                                    "FromAge <= \"%d\" AND ToAge >= \"%d\"", [OtherRiderCode objectAtIndex:j ], Age + i - 1, Age + i - 1];
                        
                        
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
					/*
					if([tempHLPercentage isEqualToString:@"(null)"]) {
						sumOtherRider = sumOtherRider + tempHMMRates;
					}
					else{
						if(i <= [tempHLPercentageTerm intValue ] ){
							sumOtherRider = sumOtherRider + tempHMMRates;
						}
						else{
							sumOtherRider = sumOtherRider + tempHMMRates/( [tempHLPercentage doubleValue ]/100 + 1 );
							
						}
					}
					*/
					
					
					double actualPremium = 0.0;
					double baseValue = tempHMMRates/([tempHLPercentage doubleValue]/100 + 1);
					
					if([tempHLPercentage isEqualToString:@"(null)"]) {
						actualPremium = baseValue;
					}
					else{
						if ([tempTempHL isEqualToString:@"(null)"]) {
							actualPremium = baseValue;
						}
						else{
							if(i <= [tempHLPercentageTerm intValue ] && i <= [tempTempHLTerm intValue ]    ){
								actualPremium = baseValue * ([tempHLPercentage doubleValue]/100 + [tempTempHL doubleValue]/100  + 1.00);
							}
							else if(i <= [tempHLPercentageTerm intValue ] && i > [tempTempHLTerm intValue ]    ){
								actualPremium = baseValue * ([tempHLPercentage doubleValue]/100  + 1.00);
								
							}
							else if(i > [tempHLPercentageTerm intValue ] && i  <= [tempTempHLTerm intValue ]    ){
								actualPremium = baseValue * ([tempTempHL doubleValue]/100  + 1.00);
								
							}
							else if(i  > [tempHLPercentageTerm intValue ] && i  > [tempTempHLTerm intValue ]    ){
								actualPremium = baseValue;
							}
						}
						
					}
					
					sumOtherRider = sumOtherRider +  actualPremium;
					
					tempHLPercentage = Nil;
					tempHLPercentageTerm = Nil;
					
					
                }
            }
            else{ //non medical rider
                if ( i <= [[OtherRiderTerm objectAtIndex:j] intValue ]   ) {
                    
					if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"EDB" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"ETPDB" ]) {
					
						NSString *tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
						NSString *tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
						NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:j];
						NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
						
						if (i <= 6) {
							/*
							if([tempHL1KSA isEqualToString:@"(null)"]) {
								sumOtherRider = sumOtherRider +
								[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
							}
							else{
								if (i <= [tempHL1KSATerm integerValue ]) {
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ] -
									([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000) * [tempHL1KSA doubleValue ] ;
								}
							}
							*/
							double actualPremium = 0.0;
							if([tempHL1KSA isEqualToString:@"(null)"]) {
								actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
							}
							else{
								if(i <= [tempHL1KSATerm intValue ] ){
									actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
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
						}
						else{
							sumOtherRider = sumOtherRider + 0.00;
						}
						
						tempHL1KSA = nil, tempHL1KSATerm = Nil;
						
					}
					else{
						
						if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"CIWP" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"LCWP" ] ||
							[[OtherRiderCode objectAtIndex:j ] isEqualToString:@"PR" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"SP_PRE" ] ||
							[[OtherRiderCode objectAtIndex:j ] isEqualToString:@"SP_STD" ] ) {
							
							double waiverRiderSA;
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
										
									}
								}
							}
							
							//NSString *tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
							//NSString *tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
							NSString *tempHL100SA = [OtherRiderHL100SA objectAtIndex:j];
							NSString *tempHL100SATerm = [OtherRiderHL100SATerm objectAtIndex:j];
							NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:j];
							NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
							/*
							if ([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"CIWP" ] || [[OtherRiderCode objectAtIndex:j ] isEqualToString:@"LCWP" ]) {
								if([tempHL100SA isEqualToString:@"(null)"]) {
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
									if (i <= [tempHL100SATerm integerValue ]) {
										sumOtherRider = sumOtherRider +
										[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
									}
									else{
										sumOtherRider = sumOtherRider +
										[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ] -
										(waiverRiderSA/100) * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/100) * [tempHL100SA doubleValue ] ;
										
									}
								}
							}
							else{
								if([tempHL1KSA isEqualToString:@"(null)"]) {
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
									if (i <= [tempHL1KSATerm integerValue ]) {
										sumOtherRider = sumOtherRider +
										[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
									}
									else{
										sumOtherRider = sumOtherRider +
										[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ] -
										(waiverRiderSA/1000) * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/100) * [tempHL1KSA doubleValue ] ;
									}
								}
							}
							*/
							/*
							if([tempHL100SA isEqualToString:@"(null)"]) {
								sumOtherRider = sumOtherRider +
								[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
							}
							else{
								if (i <= [tempHL100SATerm integerValue ]) {
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ] -
									(waiverRiderSA/100) * ([[OtherRiderSA objectAtIndex:j] doubleValue ]/100) * [tempHL100SA doubleValue ] ;
									
								}
							}
							*/
							
							double actualPremium = 0.0;
							if([tempHL100SA isEqualToString:@"(null)"]) {
								actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
							}
							else{
								if(i  <= [tempHL100SATerm intValue ] ){
									actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
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
							
						}
						else if([[OtherRiderCode objectAtIndex:j ] isEqualToString:@"HB" ] ){
							NSString *tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:j];
							NSString *tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:j];
							NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:j];
							NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
							/*
							if([tempHLPer isEqualToString:@"(null)"]) {
								sumOtherRider = sumOtherRider +
								[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
							}
							else{
								if (i <= [tempHLPerTerm integerValue ]) {
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]/ ([tempHLPer doubleValue]/100 + 1);
								}
							}
							*/
							
							
							
							double actualPremium = 0.0;
							double baseValue = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ]
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
							
						}
						else{ //rider is not CIWP, PR, LCWP, SP_PRE, SP_STD, HB
							NSString *tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:j];
							NSString *tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:j];
							NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:j];
							NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:j];
							/*
							if([tempHL1KSA isEqualToString:@"(null)"]) {
								sumOtherRider = sumOtherRider +
								[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
							}
							else{
								if (i <= [tempHL1KSATerm integerValue ]) {
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
									sumOtherRider = sumOtherRider +
									[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ] -
									([[OtherRiderSA objectAtIndex:j] doubleValue ]/1000) * [tempHL1KSA doubleValue ] ;
								}
							}
							*/
							
							double actualPremium = 0.0;
							if([tempHL1KSA isEqualToString:@"(null)"]) {
								actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
							}
							else{
								if(i <= [tempHL1KSATerm intValue ] ){
									actualPremium = [[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								}
								else{
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
							//sumOtherRider = sumOtherRider +
							//[[[aStrOtherRiderAnnually objectAtIndex:j ] stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
						}
						
						
					}
					
                    
                }
            }
			
        }
        
        double TotalBasicAndRider = sumBasic + sumOtherRider;
        [TotalAllPremium addObject: [NSString stringWithFormat:@"%.2f", TotalBasicAndRider ]];
        

        //----------------- total premium paid end ----------
        
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
            }
            else {
                [AccuCashDividendValueA addObject: [NSString stringWithFormat: @"%.8f",
													[[AccuCashDividendValueA objectAtIndex:i-2] doubleValue ] * (1.00 + CDInterestRateHigh) +
                                                    [[CurrentCashDividendValueA objectAtIndex:i-1] doubleValue ] ] ];
                [AccuCashDividendValueB addObject: [NSString stringWithFormat: @"%.9f",
													[[AccuCashDividendValueB objectAtIndex:i-2] doubleValue ] * (1.00 + CDInterestRateLow) +
													[[CurrentCashDividendValueB objectAtIndex:i-1] doubleValue ] ] ];
				
            }
            
            
        }
        else {
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
                }
                else {
                    [AccuYearlyIncomeValueA addObject:[NSString stringWithFormat:@"%.8f",
													   [[AccuYearlyIncomeValueA objectAtIndex:i-2] doubleValue] * (1.00 + CDInterestRateHigh)
													   + [[arrayYearlyIncome objectAtIndex:i -1] doubleValue ] ] ];
                    [AccuYearlyIncomeValueB addObject:[NSString stringWithFormat:@"%.9f",
													   [[AccuYearlyIncomeValueB objectAtIndex:i-2] doubleValue] * (1.00 + CDInterestRateLow)
													   + [[arrayYearlyIncome objectAtIndex:i -1] doubleValue ] ] ];
                    
                }
            
            
        }
        else {
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
        double dTotalSurrenderValueA = 0.00;
        double dTotalSurrenderValueB = 0.00;
        
        if ([YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"] ) {
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
			[[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
			[[AccuYearlyIncomeValueA objectAtIndex:i - 1] doubleValue ] +
			[[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueB objectAtIndex:i - 1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        }
        else if ([YearlyIncome isEqualToString:@"ACC"] && ![CashDividend isEqualToString:@"ACC"]) {
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueA objectAtIndex:i - 1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
            [[AccuYearlyIncomeValueB objectAtIndex:i - 1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        }
        else if (![YearlyIncome isEqualToString:@"ACC"] && [CashDividend isEqualToString:@"ACC"]) {
            dTotalSurrenderValueA = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
			[[AccuCashDividendValueA objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueA objectAtIndex:i - 1 ] doubleValue ];
            
            dTotalSurrenderValueB = [[SurrenderValue objectAtIndex:i-1] doubleValue ] +
			[[AccuCashDividendValueB objectAtIndex:i-1] doubleValue ] +
            [[tDividendValueB objectAtIndex:i - 1 ] doubleValue ];
        }
        else {
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
            
        }
        else if ([YearlyIncome isEqualToString:@"ACC"] && ![CashDividend isEqualToString:@"ACC"]) {
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
	
	
    
    for (int a= 1; a<=PolicyTerm; a++) {
        
        //if (a <= 20 || (a > 20 && a % 5  == 0) || (a == PolicyTerm && a%5 != 0) ) {
		if (a <= 25) {
            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
				if (Age >= 0){
					
					inputAge = Age + a;
					
					/*
					 QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Basic (\"SINO\", \"SeqNo\", \"DataType\",\"col0_1\",\"col0_2\",\"col1\",\"col2\", "
					 "\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\",\"col13\", "
					 "\"col14\",\"col15\",\"col16\",\"col17\",\"col18\",\"col19\",\"col20\",\"col21\",\"col22\") VALUES ( "
					 " \"%@\",\"%d\",\"DATA\",\"%d\",\"%d\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\",\"%d\",\"%d\", "
					 "\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\")",
					 SINo, a, a, inputAge, [AnnualPremium objectAtIndex:a -1],[arrayYearlyIncome objectAtIndex:a-1], [SurrenderValue objectAtIndex:a-1],
					 [DBValue objectAtIndex:a-1],[DBValueEnd objectAtIndex:a-1],[aValue objectAtIndex:a-1 ],
					 [aValueEnd objectAtIndex:a-1],arc4random()%10000 + 1000,arc4random()%10000 + 1000,arc4random()%10000 + 1000,arc4random()%10000 + 1000,
					 arc4random()%10000 + 1000,arc4random()%10000 + 1000,arc4random()%10000 + 1000,arc4random()%10000 + 1000,arc4random()%10000 + 1000,
					 arc4random()%10000 + 1000,arc4random()%10000 + 1000,arc4random()%10000 + 1000,arc4random()%10000 + 1000,arc4random()%10000 + 1000,
					 arc4random()%10000 + 1000 ];
					 */
					
					NSString *strAccuCDA = @"";
					NSString *strAccuCDB = @"";
					NSString *strAccuYIA = @"";
					NSString *strAccuYIB = @"";
					
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
					
					NSString *DBYearlyIncome = @"";

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
				sqlite3_close(contactDB);
			}
            
        }
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
        
        int page;
        
        int NoOfPages = ceil(OtherRiderCode.count/3.00);
        
        for (page =1; page <=NoOfPages; page++) {
            
            NSMutableArray *RiderCol1 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol2 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol3 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol4 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol5 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol6 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol7 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol8 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol9 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol10 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol11 = [[NSMutableArray alloc] init ];
            NSMutableArray *RiderCol12 = [[NSMutableArray alloc] init ];
            
            
            for (int Rider =0; Rider < 3; Rider++) {
                int item = 3 * (page - 1) + Rider;
                
                if (item < OtherRiderCode.count) {
                    
                    NSString *tempRiderCode = [OtherRiderCode objectAtIndex:item];
                    NSString *tempRiderDesc = [OtherRiderDesc objectAtIndex:item];
                    NSString *tempRiderPlanOption = [OtherRiderPlanOption objectAtIndex:item];
                    double tempRiderSA = [[OtherRiderSA objectAtIndex:item] doubleValue ];
                    int tempRiderTerm = [[OtherRiderTerm objectAtIndex:item] intValue ];
                    double tempPremium = [[aStrOtherRiderAnnually objectAtIndex:item] doubleValue ];
                    NSMutableArray *tempCol1 = [[NSMutableArray alloc] init ];
                    NSMutableArray *tempCol2 = [[NSMutableArray alloc] init ];
                    NSMutableArray *tempCol3 = [[NSMutableArray alloc] init ];
                    NSMutableArray *tempCol4 = [[NSMutableArray alloc] init ];
					NSString *tempHL1KSA = [OtherRiderHL1kSA objectAtIndex:item];
                    NSString *tempHL1KSATerm = [OtherRiderHL1kSATerm objectAtIndex:item];
                    NSString *tempHL100SA = [OtherRiderHL100SA objectAtIndex:item];
					NSString *tempHL100SATerm = [OtherRiderHL100SATerm objectAtIndex:item];
                    NSString *tempHLPercentage = [OtherRiderHLPercentage objectAtIndex:item];
                    NSString *tempHLPercentageTerm = [OtherRiderHLPercentageTerm objectAtIndex:item];
					NSString *tempTempHL = [OtherRiderTempHL objectAtIndex:item];
					NSString *tempTempHLTerm = [OtherRiderTempHLTerm objectAtIndex:item];
					
					NSLog(@"dsadasdas %@, %d", [OtherRiderCode objectAtIndex:item], item);
					
					for (int row = 0; row < 3; row++) {
						
						if (row == 0) {
							[tempCol1 addObject:tempRiderDesc ];
							[tempCol2 addObject:@"" ];
							[tempCol3 addObject:@"" ];
							[tempCol4 addObject:@"" ];
							
						}
						
						if (row == 1) {
							if ([tempRiderCode isEqualToString:@"CCTR"]) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Surrender<br/> Value" ];
								[tempCol3 addObject:@"Death/TPD<br/> Benefit" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"SP_PRE"] || [tempRiderCode isEqualToString:@"SP_STD"] ||
									 [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Sum<br/>Assured" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"PTR"]) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Surrender<br/>Value" ];
								[tempCol3 addObject:@"Death/TPD<br/>Benefit" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"LPPR"]) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Surrender<br/>Value" ];
								[tempCol3 addObject:@"Death/TPD<br/>Benefit" ];
								[tempCol4 addObject:@"Guaranteed<br/>Cash Payment" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"PA"] ) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Accidental Death/TPD Benefit" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"CIR"] || [tempRiderCode isEqualToString:@"ACIR"] || [tempRiderCode isEqualToString:@"ACIR_WL"] ||
									 [tempRiderCode isEqualToString:@"ACIR_MPP"] || [tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"] ||
									 [tempRiderCode isEqualToString:@"ACIR_EXC"]) {
								
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Critical illness Benefit" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"LCPR"] || [tempRiderCode isEqualToString:@"PLCP"] ) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Surrender<br/>Value" ];
								[tempCol3 addObject:@"Death/TPD<br/>Benefit" ];
								[tempCol4 addObject:@"Critical Illness Benefit" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"C+"] ) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Sum<br/>Assured" ];
								[tempCol3 addObject:@"Guaranteed Surrender Value(if no claim admitted)" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"HPP"] || [tempRiderCode isEqualToString:@"HPPP"] ) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Sum<br/>Assured" ];
								[tempCol3 addObject:@"Guaranteed Surrender Value" ];
								[tempCol4 addObject:@"-" ];
							}
							else if ([tempRiderCode isEqualToString:@"EDB"] ) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"Death<br/>Benefit" ];
								[tempCol3 addObject:@"Cash Surrender Value" ];
								[tempCol4 addObject:@"-" ];
							}
							else if ([tempRiderCode isEqualToString:@"ETPDB"] ) {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"TPD<br/>Benefit" ];
								[tempCol3 addObject:@"OAD<br/>Benefit" ];
								[tempCol4 addObject:@"Cash Surrender Value" ];
							}
							else {
								[tempCol1 addObject:@"Annual Premium (Beg. of Year)" ];
								[tempCol2 addObject:@"-" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
							}
						}
						
						if (row == 2) {
							if ([tempRiderCode isEqualToString:@"CCTR"]) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Nilai Penyerahan" ];
								[tempCol3 addObject:@"Faedah kematian/TPD" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"CIWP"] || [tempRiderCode isEqualToString:@"SP_PRE"] || [tempRiderCode isEqualToString:@"SP_STD"] ||
									 [tempRiderCode isEqualToString:@"PR"] || [tempRiderCode isEqualToString:@"LCWP"]) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Jumlah Diinsuranskan" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"PTR"]) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Nilai Penyerahan" ];
								[tempCol3 addObject:@"Faedah kematian/TPD" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"LPPR"]) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Nilai Penyerahan" ];
								[tempCol3 addObject:@"Faedah kematian/TPD" ];
								[tempCol4 addObject:@"Cash Payment Terjamin" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"PA"] ) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Faedah Kematian kemalangan/TPD" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"CIR"] || [tempRiderCode isEqualToString:@"ACIR"] || [tempRiderCode isEqualToString:@"ACIR_WL"] ||
									 [tempRiderCode isEqualToString:@"ACIR_MPP"] || [tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"] ||
									 [tempRiderCode isEqualToString:@"ACIR_EXC"]) {
								
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Faedah Penyakit Kritikal" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"LCPR"] || [tempRiderCode isEqualToString:@"PLCP"] ) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Nilai Penyerahan" ];
								[tempCol3 addObject:@"Faedah kematian/TPD" ];
								[tempCol4 addObject:@"Faedah Penyakit Kritikal" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"C+"] ) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Jumlah Diinsuranskan" ];
								[tempCol3 addObject:@"Nilai Penyerahan Terjamin(jika tiada tuntutan)" ];
								[tempCol4 addObject:@"-" ];
							}
							
							else if ([tempRiderCode isEqualToString:@"HPP"] || [tempRiderCode isEqualToString:@"HPPP"] ) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Jumlah Diinsuranskan" ];
								[tempCol3 addObject:@"Nilai Penyerahan Terjamin" ];
								[tempCol4 addObject:@"-" ];
							}
							else if ([tempRiderCode isEqualToString:@"EDB"] ) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Kematian TPD" ];
								[tempCol3 addObject:@"Nilai Penyerahan Tunai" ];
								[tempCol4 addObject:@"-" ];
							}
							else if ([tempRiderCode isEqualToString:@"ETPDB"] ) {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"Faedah TPD" ];
								[tempCol3 addObject:@"Faedah OAD" ];
								[tempCol4 addObject:@"Nilai Penyerahan Tunai" ];
							}
							else {
								[tempCol1 addObject:@"Premium Tahunan (Permulaan Tahun)" ];
								[tempCol2 addObject:@"-" ];
								[tempCol3 addObject:@"-" ];
								[tempCol4 addObject:@"-" ];
							}
						}
					}
					
					double CPlusSA = 0.00;
					double tempTotalRiderSurrenderValue = 0.00;
					NSMutableArray *Rate = [[NSMutableArray alloc] init ];
                    
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
										
										int rowsToAdd = PolicyTerm - Rate.count;
										for (int u =0; u<rowsToAdd; u++) {
											[Rate addObject:@"0.00"];
										}
									}
								}
								
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
								
								double waiverRiderSA;
								double waiverRiderSASemiAnnual;
								double waiverRiderSAQuarterly;
								double waiverRiderSAMonthly;
								
								/*
								 waiverRiderSA = [[strBasicAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								 waiverRiderSASemiAnnual = [[strBasicSemiAnnually stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								 waiverRiderSAQuarterly = [[strBasicQuarterly stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								 waiverRiderSAMonthly = [[strBasicMonthly stringByReplacingOccurrencesOfString:@"," withString:@"" ] doubleValue ];
								 */
								
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
								/*
								if ([tempRiderCode isEqualToString:@"LCWP"] || [tempRiderCode isEqualToString:@"CIWP"] ) {
									if([tempHL100SA isEqualToString:@"(null)"]) {
										[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
									}
									else{
										if(i + 1 <= [tempHL100SATerm intValue ] ){
											[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
										}
										else{
											[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium - ((waiverRiderSA *  tempRiderSA/100)/100) * [tempHL100SA doubleValue] ]];
										}
									}
								}
								else{
									if([tempHL1KSA isEqualToString:@"(null)"]) {
										[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
									}
									else{
										if(i + 1 <= [tempHL1KSATerm intValue ] ){
											[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
										}
										else{
											[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium - ((waiverRiderSA *  tempRiderSA/100)/1000) * [tempHL1KSA doubleValue] ]];
										}
									}
								}
								*/
								/*
								if([tempHL100SA isEqualToString:@"(null)"]) {
									[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
								}
								else{
									if(i + 1 <= [tempHL100SATerm intValue ] ){
										[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
									}
									else{
										[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium - ((waiverRiderSA *  tempRiderSA/100)/100) * [tempHL100SA doubleValue] ]];
									}
								}
								*/
								double actualPremium = 0.0;
								if([tempHL100SA isEqualToString:@"(null)"]) {
									//[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
									actualPremium = tempPremium;
								}
								else{
									if(i + 1 <= [tempHL100SATerm intValue ] ){
										//[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
										actualPremium = tempPremium;
									}
									else{
										//[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium - (tempRiderSA/1000) * [tempHL1KSA doubleValue] ]];
										actualPremium = tempPremium - ((waiverRiderSA *  tempRiderSA/100)/100) * [tempHL100SA doubleValue];
									}
								}
								
								if (![tempTempHL isEqualToString:@"(null)"] ) {
									if (i + 1 > [tempTempHLTerm intValue]) {
										actualPremium = actualPremium - ((waiverRiderSA *  tempRiderSA/100)/100) * [tempTempHL doubleValue];
									}
									
								}
								
								[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", actualPremium]];
								[tempCol2 addObject:[NSString stringWithFormat:@"%.3f", waiverRiderSA *  tempRiderSA/100]];
								[tempCol3 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
								
								/*
								 CIWPAnnual = waiverRiderSA *  tempRiderSA/100.00;
								 CIWPSemiAnnual = waiverRiderSASemiAnnual *  tempRiderSA/100.00;
								 CIWPQuarterly = waiverRiderSAQuarterly *  tempRiderSA/100.00;
								 CIWPMonthly = waiverRiderSAMonthly *  tempRiderSA/100.00;
								 */
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
										
										int rowsToAdd = PolicyTerm - Rate.count;
										for (int u =0; u<rowsToAdd; u++) {
											[Rate addObject:@"0.00"];
										}
									}
								}
								
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
										
										int rowsToAdd = PolicyTerm - Rate.count;
										for (int u =0; u<rowsToAdd; u++) {
											[Rate addObject:@"0.00"];
										}
									}
								}
								
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
								[tempCol2 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
								[tempCol3 addObject:[NSString stringWithFormat:@"%.0f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
								[tempCol4 addObject:[NSString stringWithFormat:@"%.0f", tempRiderSA]];
								
								tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
								tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol2 objectAtIndex:i] doubleValue ];
								[TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
							}
							
							else if ([tempRiderCode isEqualToString:@"CPA"] || [tempRiderCode isEqualToString:@"PA"]) {
								
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
								[tempCol2 addObject:[NSString stringWithFormat:@"%0ff", tempRiderSA]];
								[tempCol3 addObject:[NSString stringWithFormat:@"-"]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
							}
							
							else if ([tempRiderCode isEqualToString:@"CIR"] || [tempRiderCode isEqualToString:@"ACIR"] || [tempRiderCode isEqualToString:@"ACIR_WL"] ||
									 [tempRiderCode isEqualToString:@"ACIR_MPP"] || [tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"] ||
									 [tempRiderCode isEqualToString:@"ACIR_EXC"]) {
								
								double CI = 0.0;
								double juv;
								
								if (Age + i < 2) {
									juv = 0.2;
								}
								else if (Age + i == 2) {
									juv = 0.4;
								}
								else if (Age + i == 3) {
									juv = 0.6;
								}
								else if (Age + i == 4) {
									juv = 0.8;
								}
								else {
									juv = 1.0;
								}
								
								if ([tempRiderCode isEqualToString:@"CIR"] ||
									[tempRiderCode isEqualToString:@"ACIR"]) {
									CI = tempRiderSA;
								}
								else if ([tempRiderCode isEqualToString:@"ACIR_TWD"] || [tempRiderCode isEqualToString:@"ACIR_TWP"]) {
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
							}
							
							else if ([tempRiderCode isEqualToString:@"LCPR"] || [tempRiderCode isEqualToString:@"PLCP"] ) {
								if (i == 0) {
									if (sqlite3_open([RatesDatabasePath UTF8String], &contactDB) == SQLITE_OK){
										if ([tempRiderCode isEqualToString:@"LCPR"]) {
											QuerySQL = [NSString stringWithFormat:@"Select rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND Age = \"%d\" AND Term = \"%d\""
														, tempRiderCode, Age, tempRiderTerm ];
										}
										else{ //for payor only
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
										
										int rowsToAdd = PolicyTerm - Rate.count;
										for (int u =0; u<rowsToAdd; u++) {
											[Rate addObject:@"0.00"];
										}
									}
								}
								
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
										NSString *strplanOption = @"";
										
										if ([tempRiderPlanOption isEqualToString:@"Increasing"]) {
											strplanOption = @"I";
										}
										else if ([tempRiderPlanOption isEqualToString:@"Increasing_NCB"]) {
											strplanOption = @"N";
										}
										else if ([tempRiderPlanOption isEqualToString:@"Level"]) {
											strplanOption = @"L";
										}
										else if ([tempRiderPlanOption isEqualToString:@"Level_NCB"]) {
											strplanOption = @"B";
										}
										
										QuerySQL = [NSString stringWithFormat:@"Select Rate from Trad_Sys_Rider_CSV Where plancode = \"%@\" AND "
													" Age = \"%d\" AND Term = \"%d\" AND Sex = \"%@\" AND planOption = \"%@\""
													, tempRiderCode, Age, tempRiderTerm, sex, strplanOption ];
										
										if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
											while  (sqlite3_step(statement) == SQLITE_ROW) {
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
								
								if ([tempRiderPlanOption isEqualToString:@"Increasing"] || [tempRiderPlanOption isEqualToString:@"Increasing_NCB"]  ) {
									
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
									if ([tempRiderPlanOption isEqualToString:@"Level"] || [tempRiderPlanOption isEqualToString:@"Level_NCB"]  ) {
										CPlusSA = tempRiderSA;
									}
								}
								
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
								[tempCol2 addObject:[NSString stringWithFormat:@"%.2f", CPlusSA] ];
								[tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
								/*
								 tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
								 tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol3 objectAtIndex:i] doubleValue ];
								 [TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
								 */
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
										
										int rowsToAdd = PolicyTerm - Rate.count;
										for (int u =0; u<rowsToAdd; u++) {
											[Rate addObject:@"0.00"];
										}
									}
								}
								
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
								[tempCol2 addObject:[NSString stringWithFormat:@"%.2f", tempRiderSA] ];
								[tempCol3 addObject:[NSString stringWithFormat:@"%.3f", [[Rate objectAtIndex:i ]doubleValue ] * tempRiderSA/1000.00   ]];
								[tempCol4 addObject:[NSString stringWithFormat:@"-"]];
								
								tempTotalRiderSurrenderValue = [[TotalRiderSurrenderValue objectAtIndex:i] doubleValue ];
								tempTotalRiderSurrenderValue = tempTotalRiderSurrenderValue + [[tempCol3 objectAtIndex:i] doubleValue ];
								[TotalRiderSurrenderValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%.3f", tempTotalRiderSurrenderValue]];
							}
							else if ([tempRiderCode isEqualToString:@"EDB"]) {
								
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
								double tempHMMRates = 0.00;
								
								if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
									QuerySQL = [NSString stringWithFormat:@"Select Annually from SI_Store_premium Where Type = \"%@\" AND FromAge <= \"%d\" AND ToAge >= \"%d\"  "
												, tempRiderCode, Age + i, Age + i];
									
									
									if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
										if (sqlite3_step(statement) == SQLITE_ROW) {
											tempHMMRates = [[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] doubleValue ];
											
										}
										sqlite3_finalize(statement);
									}
									sqlite3_close(contactDB);
								}
								
								/*
								//[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempHMMRates]];
								if([tempHLPercentage isEqualToString:@"(null)"]) {
									[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempHMMRates]];
								}
								else{
									if(i + 1 <= [tempHLPercentageTerm intValue ] ){
										[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempHMMRates]];
									}
									else{
										[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempHMMRates / ([tempHLPercentage doubleValue]/100 + 1) ]];
									}
								}
								*/
								/*
								double actualPremium = 0.0;
								if([tempHLPercentage isEqualToString:@"(null)"]) {
									actualPremium = tempHMMRates;
								}
								else{
									if(i + 1 <= [tempHLPercentageTerm intValue ] ){
										actualPremium = tempHMMRates;
									}
									else{
										actualPremium = tempHMMRates / ([tempHLPercentage doubleValue]/100 + 1);
									}
								}
								
								if (![tempTempHL isEqualToString:@"(null)"] ) {
									if (i + 1 > [tempTempHLTerm intValue]) {
										actualPremium = actualPremium / ([tempTempHL doubleValue]/100 + 1);
									}
									
								}
								*/
								double actualPremium = 0.0;
								double baseValue = tempHMMRates/([tempHLPercentage doubleValue]/100 + 1);
								
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
							else if([tempRiderCode isEqualToString:@"HB"]){
								/*
								if([tempHLPercentage isEqualToString:@"(null)"]) {
									[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
								}
								else{
									if(i + 1 <= [tempHLPercentageTerm intValue ] ){
										[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium]];
									}
									else{
										[tempCol1 addObject:[NSString stringWithFormat:@"%.2f", tempPremium/([tempHLPercentage doubleValue]/100 + 1.00)]  ];
									}
								}
								*/
								
								
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
                            " , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" )", SINo, -1, page, @"Policy Year", @"Life Ass'd Age at the end of Year",
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
            
            
            for (int j=1; j <= PolicyTerm; j++) {
                
                //if (j <= 20 || (j > 20 && j % 5  == 0) || (j == PolicyTerm && j%5 != 0) ) {
                if (j <= 25) {
					int currentAge = Age + j;
                    
                    NSString *strSeqNo = @"";
                    if (j < 10) {
                        strSeqNo = [NSString stringWithFormat:@"0%d", j];
                    }
                    else {
                        strSeqNo = [NSString stringWithFormat:@"%d", j];
                    }
                    
                    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
						
						NSString *value1 = [[RiderCol1 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol1 objectAtIndex:j + 2] doubleValue ]];
						NSString *value2 = [[RiderCol2 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol2 objectAtIndex:j + 2] doubleValue ])];
						NSString *value3 = [[RiderCol3 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol3 objectAtIndex:j + 2] doubleValue ])];
						NSString *value4 = [[RiderCol4 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol4 objectAtIndex:j + 2] doubleValue ])];
						NSString *value5 = [[RiderCol5 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol5 objectAtIndex:j + 2] doubleValue ]];
						NSString *value6 = [[RiderCol6 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol6 objectAtIndex:j + 2] doubleValue ])];
						NSString *value7 = [[RiderCol7 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol7 objectAtIndex:j + 2] doubleValue ])];
						NSString *value8 = [[RiderCol8 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol8 objectAtIndex:j + 2] doubleValue ])];
						NSString *value9 = [[RiderCol9 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.2f", [[RiderCol9 objectAtIndex:j + 2] doubleValue ]];
						NSString *value10 = [[RiderCol10 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol10 objectAtIndex:j + 2] doubleValue ])];
						NSString *value11 = [[RiderCol11 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol11 objectAtIndex:j + 2] doubleValue ])];
						NSString *value12 = [[RiderCol12 objectAtIndex:j + 2] isEqualToString: @"-"] ? @"-" : [NSString stringWithFormat:@"%.0f", round([[RiderCol12 objectAtIndex:j + 2] doubleValue ])];
						
						
						QuerySQL = [NSString stringWithFormat:@"Insert INTO SI_Temp_Trad_Rider(\"SINO\", \"SeqNo\", \"DataType\", \"PageNo\",\"col0_1\",\"col0_2\", "
									" \"col1\",\"col2\",\"col3\",\"col4\",\"col5\",\"col6\",\"col7\",\"col8\",\"col9\",\"col10\",\"col11\",\"col12\" ) VALUES ("
									" \"%@\", \"%@\", \"DATA\", \"%d\", \"%d\", \"%d\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" "
									" , \"%@\", \"%@\", \"%@\", \"%@\", \"%@\" )", SINo, strSeqNo , page, j, currentAge, value1,value2,
									value3,value4,value5,value6,value7, value8, value9, value10, value11, value12];
						
						
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
                        
						sqlite3_close(contactDB);
					}
					strSeqNo = Nil;
                }
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
        
		if ([PDSorSI isEqualToString:@"SI"]) {
			for (int v= 0; v < PolicyTerm; v ++) {
				double tempA;
				double tempB;
				tempA = [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:v] doubleValue ];
				tempA = tempA + [[TotalRiderSurrenderValue objectAtIndex:v] doubleValue ];
				[SummaryNonGuaranteedSurrenderValueA replaceObjectAtIndex:v withObject: [NSString stringWithFormat:@"%.3f", tempA]];
				
				tempB = [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:v] doubleValue ];
				tempB = tempB + [[TotalRiderSurrenderValue objectAtIndex:v] doubleValue ];
				[SummaryNonGuaranteedSurrenderValueB replaceObjectAtIndex:v withObject: [NSString stringWithFormat:@"%.3f", tempB]];
				
				//NSLog(@"%@", [TotalRiderSurrenderValue objectAtIndex:v]);
				
				if (v  == PolicyTerm - 1) {
					// EntireMaturityValueA = EntireMaturityValueA + [[SummaryNonGuaranteedSurrenderValueA objectAtIndex:v] doubleValue ];
					// EntireMaturityValueB = EntireMaturityValueB + [[SummaryNonGuaranteedSurrenderValueB objectAtIndex:v] doubleValue ];
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

            strEngYearlyIncome = [NSString stringWithFormat: @"(Yearly Income %d%% Accumulate & %d%% Pay Out)", PartialAcc, PartialPayout];
            strBMYearlyIncome = [NSString stringWithFormat: @"(Pendapatan Tahunan  %d%% Terkumpul & %d%% Dibayar)", PartialAcc, PartialPayout];
        
        QuerySQL = [NSString stringWithFormat:@"INSERT INTO SI_Temp_trad(\"SINo\",\"LAName\",\"PlanCode\",\"PlanName\",\"PlanDesc\", "
                    " \"MPlanDesc\",\"CashPaymentT\",\"CashPaymentD\",\"MCashPaymentT\",\"MCashPaymentD\",\"HLoadingT\",\"MHLoadingT\", "
                    " \"OccLoadingT\",\"MOccLoadingT\",\"PolTerm\",\"TotPremPaid\",\"SurrenderValueHigh\",\"SurrenderValueLow\",\"CashPayment\", "
                    " \"SurrenderValuePaidUpHigh\",\"SurrenderValuePaidUpLow\",\"GlncPaid\",\"SumTotPremPaid\",\"SurrenderValuePaidUpHigh2\", "
                    " \"SurrenderValuePaidUpLow2\",\"SumTotPremPaid2\",\"TotalYearlylncome\",\"SumTotalYearlyIncome\",\"SumTotalYearlyIncome2\", "
                    " \"TotalPremPaid2\",\"SurrenderValueHigh2\",\"SurrenderValueLow2\",\"TotalYearlyIncome2\") VALUES "
                    " (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%d\",\"%.3f\",\"%.8f\", "
                    " \"%.9f\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%.3f\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\") ",
                    SINo, Name, @"HLACP", @"HLA Cash Promise", @"Participating Whole Life Plan with Guaranteed Yearly Income and",
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
		
		QuerySQL = [NSString stringWithFormat: @"Insert INTO SI_Temp_Trad_Overall (\"SINO\", \"SurrenderValueHigh1\", "
					" \"SurrenderValueLow1\",\"TotPremPaid1\",\"TotYearlyIncome1\", "
					" \"SurrenderValuehigh2\",\"SurrenderValueLow2\",\"TotPremPaid2\",\"TotYearlyIncome2\") VALUES ( "
					" \"%@\",\"%.8f\",\"%.9f\",\"%.2f\",\"%.2f\",\"%.8f\",\"%.9f\",\"%.2f\",\"%.2f\")",
					SINo, EntireMaturityValueA, EntireMaturityValueB, EntireTotalPremiumPaid,
					EntireTotalYearlyIncome,EntireMaturityValueA,EntireMaturityValueB,TotalPremiumBasicANDIncomeRider,EntireTotalYearlyIncome];
		
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
        
        for (int i = 0; i< UpdateTradDetail.count; i++) {
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            //[formatter setMaximumFractionDigits:3];

            [formatter setRoundingMode: NSNumberFormatterRoundHalfUp];
			
            NSString *SAAnnual = [formatter stringFromNumber:[NSDecimalNumber numberWithFloat:[[gWaiverAnnual objectAtIndex:i] floatValue ]]];
            NSString *SASemiAnnual = [formatter stringFromNumber:[NSNumber numberWithFloat:[[gWaiverSemiAnnual objectAtIndex:i] doubleValue ]]];
            NSString *SAQuaterly = [formatter stringFromNumber:[NSNumber numberWithFloat:[[gWaiverQuarterly objectAtIndex:i] doubleValue ]]];
            NSString *SAMonthly = [formatter stringFromNumber:[NSNumber numberWithFloat:[[gWaiverMonthly objectAtIndex:i] doubleValue ]]];
            
            //NSLog(@"dasdasdasdas%.9f", [[gWaiverAnnual objectAtIndex:i] doubleValue ]);
		
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

            if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
                //QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%@\" where col0_1 = \"-Annual\" AND col11 = \"%@\" ",
                //            SAAnnual, [UpdateTradDetail objectAtIndex:i ]];
                
				QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%.2f\" where col0_1 = \"-Annual\" AND col11 = \"%@\" ",
                             [[gWaiverAnnual objectAtIndex:i] doubleValue ] , [UpdateTradDetail objectAtIndex:i ]];
                
				
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                
				/*
                QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%@\" where col0_1 = \"-Semi-annual\" AND col11 = \"%@\" ",
                            SASemiAnnual, [UpdateTradDetail objectAtIndex:i ]];
                */
				QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%.2f\" where col0_1 = \"-Semi-annual\" AND col11 = \"%@\" ",
                            [[gWaiverSemiAnnual objectAtIndex:i] doubleValue ] , [UpdateTradDetail objectAtIndex:i ]];
				
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                
				/*
                QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%@\" where col0_1 = \"-Quarterly\" AND col11 = \"%@\" ",
                            SAQuaterly, [UpdateTradDetail objectAtIndex:i ]];
                */
				QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%.2f\" where col0_1 = \"-Quarterly\" AND col11 = \"%@\" ",
                            [[gWaiverQuarterly objectAtIndex:i] doubleValue ], [UpdateTradDetail objectAtIndex:i ]];
				
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                
                /*
                QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%@\" where col0_1 = \"-Monthly\" AND col11 = \"%@\" ",
                            SAMonthly, [UpdateTradDetail objectAtIndex:i ]];
                */
				QuerySQL = [ NSString stringWithFormat:@"UPDATE SI_Temp_Trad_Details set col2 = \"%.2f\" where col0_1 = \"-Monthly\" AND col11 = \"%@\" ",
                            [[gWaiverMonthly objectAtIndex:i] doubleValue ], [UpdateTradDetail objectAtIndex:i ]];
				
                if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                    }
                    sqlite3_finalize(statement);
                }
                
                sqlite3_close(contactDB);
            }
            
            SAAnnual = Nil;
            SASemiAnnual = Nil;
            SAQuaterly = Nil;
            SAMonthly = Nil;
            formatter = Nil;
			
			
			
            
        }
        
        statement = Nil;
        QuerySQL = Nil;
        
        NSLog(@"Update Trad Detail end");
    }
    
}


-(void)getAllPreDetails{
	
    sqlite3_stmt *statement;
    sqlite3_stmt *statement2;
    NSString *QuerySQL;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
		/*
		QuerySQL = [ NSString stringWithFormat:@"select \"PolicyTerm\", \"BasicSA\", \"premiumPaymentOption\", \"CashDividend\",  "
					"\"YearlyIncome\", \"AdvanceYearlyIncome\", \"HL1KSA\",\"sex\",\"Class\",\"OccLoading\", \"HL1KSATerm\",\"TempHL1KSA\",\"TempHL1KSATerm\" "
					", \"PartialAcc\", \"PartialPayout\"  from Trad_Details as A, "
					"Clt_Profile as B, trad_LaPayor as C, Adm_Occp_Loading as D where A.Sino = C.Sino AND C.custCode = B.custcode AND "
					"D.OccpCode = B.OccpCode AND A.sino = \"%@\" AND \"seq\" = 1 ", SINo];
        */
		
		QuerySQL = [ NSString stringWithFormat:@"select \"PolicyTerm\", \"BasicSA\", \"premiumPaymentOption\", \"CashDividend\",  "
					"\"YearlyIncome\", \"AdvanceYearlyIncome\", \"HL1KSA\",\"sex\",\"Class\",\"OccLoading\", \"HL1KSATerm\",\"TempHL1KSA\",\"TempHL1KSATerm\" "
					", \"PartialAcc\", \"PartialPayout\"  from Trad_Details as A, "
					"Clt_Profile as B, trad_LaPayor as C, Adm_Occp_Loading_Penta as D where A.Sino = C.Sino AND C.custCode = B.custcode AND "
					"D.OccpCode = B.OccpCode AND A.sino = \"%@\" AND \"seq\" = 1 ", SINo];
			
		NSLog(@"%@", QuerySQL);
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            if (sqlite3_step(statement) == SQLITE_ROW) {
                PolicyTerm = sqlite3_column_int(statement, 0);
                BasicSA = sqlite3_column_double(statement, 1);
                CashDividend = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                YearlyIncome = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                HealthLoading = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                OccpClass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                HealthLoadingTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)];
                TempHealthLoading = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)];
                TempHealthLoadingTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)];
				PartialAcc = sqlite3_column_int(statement, 13);
                PartialPayout = sqlite3_column_int(statement, 14);
                
				
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
				NSLog(@"Got payor");
                NSString* CC  = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                NSString* getFromCltProfileSQL  = [NSString stringWithFormat:@"Select Name, Smoker, sex, ALB from clt_profile where custcode  = \"%@\"",  CC];
                
                if(sqlite3_prepare_v2(contactDB, [getFromCltProfileSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
                    
                    if (sqlite3_step(statement2) == SQLITE_ROW) {
                        /*
						NSString *PYName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                        NSString *PYsmoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)];
                        NSString *PYsex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
                        */
						PayorAge = sqlite3_column_int(statement2, 3);
                        /*
                        PYName = Nil;
                        PYsmoker = Nil;
                        PYsex = Nil;
						 */
                    }
                    sqlite3_finalize(statement2);
                }
				
				getFromCltProfileSQL = Nil;
            }
            sqlite3_finalize(statement);
        }
		
		/*
		QuerySQL = [ NSString stringWithFormat:@"select \"OccLoading\" from Trad_Details as A, "
                    "Clt_Profile as B, trad_LaPayor as C, Adm_Occp_Loading as D where A.Sino = C.Sino AND C.custCode = B.custcode AND "
                    "D.OccpCode = B.OccpCode AND A.sino = \"%@\" AND \"seq\" = 1 ORDER By sequence ASC ", SINo];
		 */
		
        QuerySQL = [ NSString stringWithFormat:@"select \"OccLoading_TL\" from Trad_Details as A, "
                    "Clt_Profile as B, trad_LaPayor as C, Adm_Occp_Loading_Penta as D where A.Sino = C.Sino AND C.custCode = B.custcode AND "
                    "D.OccpCode = B.OccpCode AND A.sino = \"%@\" AND \"seq\" = 1 ORDER By sequence ASC ", SINo];
	
        
		NSLog(@"%@", QuerySQL);
		
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                [OccLoading addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
				
            }
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(contactDB);
    }
    
    OtherRiderCode = [[NSMutableArray alloc] init ];
    OtherRiderTerm = [[NSMutableArray alloc] init ];
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
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        QuerySQL = [ NSString stringWithFormat:@"Select A.RiderCode, \"RiderTerm\",\"RiderDesc\", \"SumAssured\", \"PlanOption\", "
					"\"Deductible\", \"HL1kSA\", \"HL1KSATerm\", \"HL100SA\", \"HL100SATerm\", \"HLPercentage\", \"HLPercentageTerm\", "
					" \"TempHL1kSA\", \"TempHL1kSATerm\"  from trad_rider_details as A, "
                    "trad_sys_rider_profile as B  where \"sino\" = \"%@\" AND A.ridercode = B.RiderCode ORDER BY B.RiderCode ASC ", SINo];
        
		//NSLog(@"%@", QuerySQL);
		
        if(sqlite3_prepare_v2(contactDB, [QuerySQL UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(statement2) == SQLITE_ROW) {
				
                NSString *zzz = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)];
                
                if ([zzz isEqualToString:@"I20R"] || [zzz isEqualToString:@"I30R"] || [zzz isEqualToString:@"I40R"]
                    || [zzz isEqualToString:@"ID20R"]|| [zzz isEqualToString:@"ID30R"]|| [zzz isEqualToString:@"ID40R"]|| [zzz isEqualToString:@"IE20R"]
                    || [zzz isEqualToString:@"IE30R"]) {
                    
                    
                }
                else {
                    [OtherRiderCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 0)]];
                    [OtherRiderTerm addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 1)]];
                    [OtherRiderDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)]];
                    
                    NSString *tempOtherRiderSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 3)];
                    NSRange rangeofDotHL = [tempOtherRiderSA rangeOfString:@"."];
                    NSString *Display = @"";
                    if (rangeofDotHL.location != NSNotFound) {
                        NSString *substring = [tempOtherRiderSA substringFromIndex:rangeofDotHL.location ];
                        if (substring.length == 2 && [substring isEqualToString:@".0"]) {
                            Display = [tempOtherRiderSA substringToIndex:rangeofDotHL.location ];
                        }
                        else {
                            Display = tempOtherRiderSA;
                        }
                    }
                    else {
                        Display = tempOtherRiderSA;
                    }
                    
                    [OtherRiderSA addObject: Display];
                    if ([[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 4)] isEqualToString:@"(null)" ]   ) {
                        [OtherRiderPlanOption addObject:@""];
                    }
                    else {
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
					
					tempOtherRiderSA = Nil;
                    Display = Nil;
                }
                
                zzz = Nil;
            }
            sqlite3_finalize(statement2);
        }
        sqlite3_close(contactDB);
    }
    
    statement = Nil;
    statement2 = Nil;
    QuerySQL = Nil;
}



@end
