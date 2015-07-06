//
//  ReportToPdf.m
//  iMobile Planner
//
//  Created by infoconnect on 1/8/14.
//  Copyright (c) 2014 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ReportToPdf.h"
#import "AppDelegate.h"
#import "EverLifeViewController.h"
#import "PremiumViewController.h"

@interface ReportToPdf ()

@end

@implementation ReportToPdf
@synthesize getModule, getSINo, getPlanCode, PDFCreator;
@synthesize getCommDate,getDOB,getDOB2nd,getDOBPayor,getOccLoading,getOccpClass,getOccpClass2nd,getOccpClassPayor;
@synthesize getSex,getSex2nd,getSexPayor,getSmoker,getSmoker2nd,getSmokerPayor,Language, CustCode,CustCode2nd,CustCodePayor,OccpCode,OccpCode2nd,OccpCodePayor;
@synthesize NeedFurtherInfo;

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
	NSString *querySQL;
	sqlite3_stmt *statement;

	NSString *EverSustainCheckLevel = @"2";

	
	if ([NeedFurtherInfo isEqualToString:@"YES"]) {
		if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
		{/*
			querySQL = [NSString stringWithFormat:@"Select ComDate, QuotationLang from UL_Details where sino = '%@' ", getSINo];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					getCommDate = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					Language = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					
				}
				sqlite3_finalize(statement);
			}
			
			querySQL = [NSString stringWithFormat:@"Select CustCode From UL_LAPayor where sino = '%@' AND PTypeCode = 'LA' AND Seq = '1' ", getSINo];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					CustCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				}
				sqlite3_finalize(statement);
			}
			
			querySQL = [NSString stringWithFormat:@"Select CustCode From UL_LAPayor where sino = '%@' AND PTypeCode = 'LA' AND Seq = '2' ", getSINo];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					CustCode2nd = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				}
				else{
					CustCode2nd = @"";
				}
				sqlite3_finalize(statement);
			}
			
			querySQL = [NSString stringWithFormat:@"Select CustCode From UL_LAPayor where sino = '%@' AND PTypeCode = 'PY' AND Seq = '1' ", getSINo];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					CustCodePayor = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
				}
				else{
					CustCodePayor = @"";
				}
				sqlite3_finalize(statement);
			}
			
			querySQL = [NSString stringWithFormat:@"Select Sex, Smoker, DOB, OccpCode From Clt_Profile where custcode = '%@' ", CustCode];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					getSex = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					getSmoker = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					getDOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
					OccpCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
				}
				sqlite3_finalize(statement);
			}
			
			querySQL = [NSString stringWithFormat:@"Select Sex, Smoker, DOB, OccpCode From Clt_Profile where custcode = '%@' ", CustCode2nd];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					getSex2nd = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					getSmoker2nd = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					getDOB2nd = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
					OccpCode2nd = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
				}
				sqlite3_finalize(statement);
			}
			
			querySQL = [NSString stringWithFormat:@"Select Sex, Smoker, DOB, OccpCode From Clt_Profile where custcode = '%@' ", CustCodePayor];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					getSexPayor = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					getSmokerPayor = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					getDOBPayor = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
					OccpCodePayor = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
				}
				sqlite3_finalize(statement);
			}
			
			querySQL = [NSString stringWithFormat:@"Select Class,OccLoading_UL From Adm_Occp_Loading_Penta where occpcode = '%@' ", OccpCode];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					getOccpClass = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					getOccLoading = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
				}
				sqlite3_finalize(statement);
			}
			
		  
		  
			*/
			
			querySQL = [NSString stringWithFormat:@"Select PolicyTerm, PremiumPaymentOption, BasicSA, HL1KSA, TempHL1KSA From "
												"Trad_Details where sino = '%@' ", getSINo];
			
			if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
			{
				if (sqlite3_step(statement) == SQLITE_ROW)
				{
					getTerm = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
					getMOP = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
					getBasicSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
				}
				sqlite3_finalize(statement);
			}
			
			sqlite3_close(contactDB);
		}
	}
	
	EverLifeViewController *UVReport;
	if([getPlanCode isEqualToString:@"UV" ] || [getPlanCode isEqualToString:@"UP" ] ){
		UVReport = [[EverLifeViewController alloc] init ];
		UVReport.SINo = getSINo;
		UVReport.requestOccLoading = getOccLoading;
		UVReport.requestPlanCommDate = getCommDate;
		UVReport.PDSorSI = @"SI";
		UVReport.requestDOB = getDOB;
		UVReport.requestSexLA = getSex;
		UVReport.requestSmokerLA = getSmoker;
		UVReport.requestOccpClass = [getOccpClass intValue];
		UVReport.SimpleOrDetail = @"Detail";
		UVReport.CheckSustainLevel = EverSustainCheckLevel;
		UVReport.EngOrBm = Language;
		[self presentViewController:UVReport animated:NO completion:Nil];
	}
	
	if([getPlanCode isEqualToString:@"UV" ] || [getPlanCode isEqualToString:@"UP" ] ){
		[UVReport dismissViewControllerAnimated:NO completion:Nil];
	}
	
	[self generateJSON_UV];
	NSString *path;
	if ([Language isEqualToString:@"English"]) {
		[self copySIToDoc];
		path = [[NSBundle mainBundle] pathForResource:@"EverLife_SI/Page1" ofType:@"html"];
	}
	else{
		[self copySIToDoc_BM];
		path = [[NSBundle mainBundle] pathForResource:@"EverLife_SI_BM/Page1" ofType:@"html"];
	}
	
	NSURL *pathURL = [NSURL fileURLWithPath:path];
	NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
	NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
	
	NSData* data = [NSData dataWithContentsOfURL:pathURL];
	[data writeToFile:[NSString stringWithFormat:@"%@/SI_Temp.html",documentsDirectory] atomically:YES];
	
	NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"SI_Temp.html"];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:HTMLPath]) {
		NSURL *targetURL = [NSURL fileURLWithPath:HTMLPath];
		
		
		
		NSString *SIPDFName = [NSString stringWithFormat:@"Quotation_export_%@.pdf",self.getSINo];
		self.PDFCreator = [NDHTMLtoPDF exportPDFWithURL:targetURL
											 pathForPDF:[documentsDirectory stringByAppendingPathComponent:SIPDFName]
											   delegate:self
											   pageSize:kPaperSizeA4
												margins:UIEdgeInsetsMake(0, 0, 0, 0)
						   ];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
														message:@"Export success" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
		[alert show ];
		
	}
	
	

	
	
}

-(void)copySIToDoc{
	NSString *directory = @"EverLife_SI";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentSIFolderPath = [documentsDirectory stringByAppendingPathComponent:directory];
    NSString *resourceSIFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:directory];
    
    
    if (![fileManager fileExistsAtPath:documentSIFolderPath]) {
        [fileManager createDirectoryAtPath:documentSIFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
	else{
		[fileManager removeItemAtPath:documentSIFolderPath error:&error];
		[fileManager createDirectoryAtPath:documentSIFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
	}
    
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:resourceSIFolderPath error:&error];
    for (NSString *SIFiles in fileList) {
        NSString *newFilePath = [documentSIFolderPath stringByAppendingPathComponent:SIFiles];
        NSString *oldFilePath = [resourceSIFolderPath stringByAppendingPathComponent:SIFiles];
        [fileManager copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
    }
	
}

-(void)copySIToDoc_BM{
	NSString *directory = @"EverLife_SI_BM";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentSIFolderPath = [documentsDirectory stringByAppendingPathComponent:directory];
    NSString *resourceSIFolderPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:directory];
    
    
    if (![fileManager fileExistsAtPath:documentSIFolderPath]) {
        [fileManager createDirectoryAtPath:documentSIFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
	else{
		[fileManager removeItemAtPath:documentSIFolderPath error:&error];
		[fileManager createDirectoryAtPath:documentSIFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
	}
    
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:resourceSIFolderPath error:&error];
    for (NSString *SIFiles in fileList) {
        NSString *newFilePath = [documentSIFolderPath stringByAppendingPathComponent:SIFiles];
        NSString *oldFilePath = [resourceSIFolderPath stringByAppendingPathComponent:SIFiles];
        [fileManager copyItemAtPath:oldFilePath toPath:newFilePath error:&error];
    }
	
}


-(void)generateJSON_UV{
	NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath2 = [paths2 objectAtIndex:0];
    NSString *path2 = [docsPath2 stringByAppendingPathComponent:@"hladb.sqlite"];
	
	
	FMDatabase *database = [FMDatabase databaseWithPath:path2];
    [database open];
	
	FMResultSet *results;
    NSString *query;
    int totalRecords = 0;
    int currentRecord = 0;
    
    results = [database executeQuery:@"select AgentCode,AgentName from Agent_profile"];
    NSString *agentCode;
    NSString *agentName;
    while([results next]) {
        agentCode = [results stringForColumn:@"AgentCode"];
        agentName  = [results stringForColumn:@"AgentName"];
    }
	
	results = [database executeQuery:[NSString stringWithFormat:@"select Class,OccLoading_UL from Adm_Occp_Loading_Penta where occpcode = '%@'", OccpCode]];
    NSString *OccpClass;
	NSString *OccpLoading;
    while([results next]) {
		OccpClass = [results stringForColumn:@"Class"];
		OccpLoading = [results stringForColumn:@"OccLoading_UL"];
    }
	
	int TotalPages = 0;
	
	results = [database executeQuery:@"select count(*) as cnt from UL_Temp_Pages"];
	
	if ([results next]) {
        TotalPages = [results intForColumn:@"cnt"];
    }
	
	results = Nil;
	query = [NSString stringWithFormat:@"Select FromYear, ForYear, Amount from UL_TPExcess where SINo ='%@'",getSINo];
	
	results = [database executeQuery:query];
	NSString *TopupStart;
	NSString *TopupEnd;
	NSString *TopupAmount;
	if ( results.next == TRUE) {
		//[results next];
		TopupStart = [NSString stringWithFormat:@"%d", [[results stringForColumnIndex:0] integerValue ] - 1];
		TopupEnd = [NSString stringWithFormat:@"%d", [TopupStart intValue ] + [[results stringForColumnIndex:1] intValue ]];
		TopupAmount = [NSString stringWithFormat:@"%f",[[results stringForColumnIndex:2] doubleValue ]];
	}
	else{
		TopupStart = @"-";
		TopupEnd = @"-";
		TopupAmount = @"-";
	}
	
	results = Nil;
	query = [NSString stringWithFormat:@"Select FromAge, ToAge, YearInt, Amount  from UL_RegWithdrawal where SINo ='%@'",getSINo];
	
	results = [database executeQuery:query];
	NSString *WithdrawAgeFrom;
	NSString *WithdrawAgeTo;
	NSString *WithdrawAmount;
	NSString *WithdrawInterval;
	if ( results.next == TRUE) {
		WithdrawAgeFrom = [results stringForColumnIndex:0];
		WithdrawAgeTo = [results stringForColumnIndex:1];
		WithdrawInterval = [results stringForColumnIndex:2];
		WithdrawAmount = [results stringForColumnIndex:3];
		
	}
	else{
		WithdrawAgeFrom = @"-";
		WithdrawAgeTo = @"-";
		WithdrawAmount = @"-";
		WithdrawInterval = @"-";
	}
	
	results = Nil;
	query = [NSString stringWithFormat:@"Select RRTUOFromYear, RRTUOYear, Premium from UL_Rider_Details where SINo ='%@' AND ridercode = 'RRTUO'",getSINo];
	
	results = [database executeQuery:query];
	NSString *RRTUOFrom;
	NSString *RRTUOTo;
	NSString *RRTUOAmount;
	
	if ( results.next == TRUE) {
		RRTUOFrom = [results stringForColumnIndex:0];
		RRTUOTo = [NSString stringWithFormat:@"%d", [[results stringForColumnIndex:1] intValue ] + [RRTUOFrom intValue ] - 1];
		RRTUOAmount = [results stringForColumnIndex:2];
		
	}
	else{
		RRTUOFrom = @"-";
		RRTUOTo = @"-";
		RRTUOAmount = @"-";
		
	}
	
	NSString *ReducedPaidUpYear;
	NSString *ReducedSA;
	NSString *ReducedCharge;
	
	query = [NSString stringWithFormat:@"SELECT * FROM UL_ReducedPaidUp Where sino = '%@'", getSINo];
	results = [database executeQuery:query];
    if (results.next == TRUE){
        ReducedPaidUpYear = [results stringForColumn:@"ReducedYear"];
        ReducedSA = [results stringForColumn:@"Amount"];
    }
	
	query = [NSString stringWithFormat:@"SELECT col2 FROM UL_Temp_RPUO Where col1 = 'Charge'"];
    results = [database executeQuery:query];
    if (results.next == TRUE){
        ReducedCharge = [results stringForColumnIndex:0];
    }
	
	query = [NSString stringWithFormat:@"SELECT col8,col9 FROM UL_Temp_ECAR60 where seqno = '1'"];
    results = [database executeQuery:query];
	NSString *Annuity;
	NSString *AnnuityPrem;
	
	if ([results next]) {
		Annuity = [results stringForColumnIndex:0];
		AnnuityPrem = [results stringForColumnIndex:1];
	}
	
	query = [NSString stringWithFormat:@"Select DateModified, ComDate, ATPrem, basicSA, CovPeriod, replace(Hloading, '(null)', '0') Hloading, HloadingTerm, "
			 "hloadingPct, hloadingPctTerm, BumpMode from UL_Details where SINo ='%@'",getSINo];
	
	results = [database executeQuery:query];
    NSString *DateModified;
	NSString *ComDate;
	NSString *ATPrem;
	NSString *bSA;
	NSString *CovPeriod;
	NSString *HLoad;
	NSString *HLoadTerm;
	NSString *HLoadPct;
	NSString *HLoadPctTerm;
	NSString *BumpMode;
	
    if ([results next]) {
		DateModified = [results stringForColumnIndex:0];
        ComDate = [results stringForColumnIndex:1];
		ATPrem = [results stringForColumnIndex:2];
		bSA = [results stringForColumnIndex:3];
		CovPeriod = [results stringForColumnIndex:4];
		HLoad = [[results stringForColumnIndex:5] isEqualToString:@""] ? @"0" : [results stringForColumnIndex:5];
		HLoadTerm = [results stringForColumnIndex:6];
		HLoadPct = [[results stringForColumnIndex:7] isEqualToString:@""] ? @"0" : [results stringForColumnIndex:7];
		HLoadPctTerm = [results stringForColumnIndex:8];
		BumpMode = [results stringForColumnIndex:9];
    }
	
	NSString *jsonFile = [docsPath2 stringByAppendingPathComponent:@"SI.json"];
	NSString *content = @"{\n";
    content = [content stringByAppendingString:@"\"SI\": [\n"];
	
	content = [content stringByAppendingString:@"{\n"];
    content = [content stringByAppendingFormat:@"\"agentCode\":\"%@\",\n", agentCode];
    content = [content stringByAppendingFormat:@"\"agentName\":\"%@\",\n", agentName];
	content = [content stringByAppendingFormat:@"\"DateModified\":\"%@\",\n", DateModified];
	content = [content stringByAppendingFormat:@"\"TotalPages\":\"%d\",\n", TotalPages];
	content = [content stringByAppendingFormat:@"\"ComDate\":\"%@\",\n", ComDate];
	content = [content stringByAppendingFormat:@"\"ATPrem\":\"%@\",\n", ATPrem];
	content = [content stringByAppendingFormat:@"\"BasicSA\":\"%@\",\n", bSA];
	content = [content stringByAppendingFormat:@"\"CovPeriod\":\"%@\",\n", CovPeriod];
	content = [content stringByAppendingFormat:@"\"HLoad\":\"%@\",\n", HLoad];
	content = [content stringByAppendingFormat:@"\"HLoadTerm\":\"%@\",\n", HLoadTerm];
	content = [content stringByAppendingFormat:@"\"HLoadPct\":\"%@\",\n", HLoadPct];
	content = [content stringByAppendingFormat:@"\"HLoadPctTerm\":\"%@\",\n", HLoadPctTerm];
	content = [content stringByAppendingFormat:@"\"TopupStart\":\"%@\",\n", TopupStart];
	content = [content stringByAppendingFormat:@"\"TopupEnd\":\"%@\",\n", TopupEnd];
	content = [content stringByAppendingFormat:@"\"TopupAmount\":\"%@\",\n", TopupAmount];
	content = [content stringByAppendingFormat:@"\"WithdrawAgeFrom\":\"%@\",\n", WithdrawAgeFrom];
	content = [content stringByAppendingFormat:@"\"WithdrawAgeTo\":\"%@\",\n", WithdrawAgeTo];
	content = [content stringByAppendingFormat:@"\"WithdrawAmount\":\"%@\",\n", WithdrawAmount];
	content = [content stringByAppendingFormat:@"\"WithdrawInterval\":\"%@\",\n", WithdrawInterval];
	content = [content stringByAppendingFormat:@"\"RRTUOFrom\":\"%@\",\n", RRTUOFrom];
	content = [content stringByAppendingFormat:@"\"RRTUOTo\":\"%@\",\n", RRTUOTo];
	content = [content stringByAppendingFormat:@"\"RRTUOAmount\":\"%@\",\n", RRTUOAmount];
	content = [content stringByAppendingFormat:@"\"Annuity\":\"%@\",\n", Annuity];
	content = [content stringByAppendingFormat:@"\"AnnuityPrem\":\"%@\",\n", AnnuityPrem];
	content = [content stringByAppendingFormat:@"\"ReducedPaidUpYear\":\"%@\",\n", ReducedPaidUpYear];
	content = [content stringByAppendingFormat:@"\"ReducedSA\":\"%@\",\n", ReducedSA];
	content = [content stringByAppendingFormat:@"\"ReducedCharge\":\"%@\",\n", ReducedCharge];
	content = [content stringByAppendingFormat:@"\"BumpMode\":\"%@\",\n", BumpMode];
	content = [content stringByAppendingFormat:@"\"SINo\":\"%@\",\n", getSINo];
	if ([OccpClass integerValue ] > 4) {
		content = [content stringByAppendingFormat:@"\"OccpClass\":\" Class D\",\n"];
	}
	else{
		content = [content stringByAppendingFormat:@"\"OccpClass\":\"%@\",\n", OccpClass ];
	}
	if ([OccpLoading integerValue ] > 0) {
		content = [content stringByAppendingFormat:@"\"OccpLoading\":\"%@\",\n", OccpLoading ];
	}
	else{
		content = [content stringByAppendingFormat:@"\"OccpLoading\":\"STD\",\n" ];
	}
	
	//UL_Temp_Trad_LA start
    totalRecords = 0;
    currentRecord = 0;
    
    query = [NSString stringWithFormat:@"Select count(*) as cnt from UL_Temp_Trad_LA where SINo ='%@'",getSINo];
    results = [database executeQuery:query];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
	
	NSString *PayorOrSecondOccpClass;
	NSString *PayorOrSecondOccpLoading;
	
	if (totalRecords > 1) {
		if (OccpCodePayor.length > 0) {
			results = [database executeQuery:[NSString stringWithFormat:@"select Class,OccLoading_UL from Adm_Occp_Loading_Penta where occpcode = '%@'", OccpCodePayor]];
			
		}
		else{
			results = [database executeQuery:[NSString stringWithFormat:@"select Class,OccLoading_UL from Adm_Occp_Loading_Penta where occpcode = '%@'", OccpCode2nd]];
			
		}
		
		while([results next]) {
			PayorOrSecondOccpClass = [results stringForColumn:@"Class"];
			PayorOrSecondOccpLoading = [results stringForColumn:@"OccLoading_UL"];
		}
		
	}
	
    results = Nil;
    query = [NSString stringWithFormat:@"Select LADesc,LADescM,Name,Age,Sex,Smoker,PTypeCode from UL_Temp_trad_LA where SINo ='%@'",getSINo];
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_trad_LA\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"LADesc\":\"%@\",\n", [results stringForColumn:@"LADesc"]];
        content = [content stringByAppendingFormat:@"\"LADescM\":\"%@\",\n", [results stringForColumn:@"LADescM"]];
        content = [content stringByAppendingFormat:@"\"Name\":\"%@\",\n", [results stringForColumn:@"Name"]];
        content = [content stringByAppendingFormat:@"\"Age\":\"%@\",\n", [results stringForColumn:@"Age"]];
        content = [content stringByAppendingFormat:@"\"Sex\":\"%@\",\n", [results stringForColumn:@"Sex"]];
        content = [content stringByAppendingFormat:@"\"Smoker\":\"%@\",\n", [results stringForColumn:@"Smoker"]];
		if (currentRecord == 2) {
			if ([[results stringForColumn:@"PTypeCode"] isEqualToString:@"LA"]) {
				content = [content stringByAppendingFormat:@"\"DOB\":\"%@\",\n", getDOB2nd];
			}
			else{
				content = [content stringByAppendingFormat:@"\"DOB\":\"%@\",\n", getDOBPayor];
			}
			content = [content stringByAppendingFormat:@"\"OccpClass\":\"%@\",\n", PayorOrSecondOccpClass ];
			content = [content stringByAppendingFormat:@"\"OccpLoading\":\"%@\",\n", PayorOrSecondOccpLoading ];
		}
		else if (currentRecord == 3){
			content = [content stringByAppendingFormat:@"\"OccpClass\":\"%@\",\n", PayorOrSecondOccpClass ];
			content = [content stringByAppendingFormat:@"\"OccpLoading\":\"%@\",\n", PayorOrSecondOccpLoading ];
		}
		else{
			content = [content stringByAppendingFormat:@"\"DOB\":\"%@\",\n", getDOB];
			content = [content stringByAppendingFormat:@"\"OccpClass\":\"%@\",\n", OccpClass ];
			content = [content stringByAppendingFormat:@"\"OccpLoading\":\"%@\",\n", OccpLoading ];
		}
        content = [content stringByAppendingFormat:@"\"PTypeCode\":\"%@\"\n", [results stringForColumn:@"PTypeCode"]];
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //UL_Temp_Trad_LA end
	
	//LA info starts********************** @added by Edwin 24-10-2013
    query = [NSString stringWithFormat:
             @"SELECT b.Name, b.ANB, b.ALB FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
             "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=1",getSINo];
    
    totalRecords = 0;
    currentRecord = 0;
    
    results = [database executeQuery:query];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"LAInfo\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        //currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"Name\":\"%@\",\n", [results stringForColumn:@"Name"]];
        content = [content stringByAppendingFormat:@"\"ALB\":\"%@\",\n", [results stringForColumn:@"ALB"]];
        content = [content stringByAppendingFormat:@"\"ANB\":\"%@\"\n", [results stringForColumn:@"ANB"]];
        content = [content stringByAppendingString:@"}\n"];
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //LA info ends*****************************************************//
	
	//UL_Temp_Pages start
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from UL_Temp_Pages"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
	
	if (totalRecords == 0) {
		NSLog(@"generate json - no data found in UL_Temp_Pages ");
	}
	
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_Pages ORDER BY PageNum"];
    results = [database executeQuery:query];
    
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_Pages\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"htmlName\":\"%@\",\n", [results stringForColumn:@"htmlName"]];
        content = [content stringByAppendingFormat:@"\"PageNum\":\"%@\",\n", [results stringForColumn:@"PageNum"]];
        content = [content stringByAppendingFormat:@"\"PageDesc\":\"%@\",\n", [results stringForColumn:@"PageDesc"]];
        content = [content stringByAppendingFormat:@"\"riders\":\"%@\"\n", [results stringForColumn:@"riders"]];
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //SI_Temp_Pages end
	
	//UL_Temp_Fund start
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery: [NSString stringWithFormat:@"select count(*) as cnt from UL_Fund_Maturity_Option Where sino = '%@'", getSINo]];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
	
    results = Nil;
    query = [NSString stringWithFormat:@"select * from ul_fund_maturity_option as A, ul_temp_fund as B where "
			 "A.sino = B.sino AND A.fund = B.col1 AND A.sino = '%@' order by Fund", getSINo];
    results = [database executeQuery:query];
    
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_Fund\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"Fund\":\"%@\",\n", [results stringForColumn:@"Fund"]];
        content = [content stringByAppendingFormat:@"\"Option\":\"%@\",\n", [results stringForColumn:@"option"]];
        content = [content stringByAppendingFormat:@"\"Partial\":\"%@\",\n", [results stringForColumn:@"Partial_Withd_Pct"]];
		content = [content stringByAppendingFormat:@"\"Fund2025\":\"%@\",\n", [results stringForColumn:@"EverGreen2025"]];
		content = [content stringByAppendingFormat:@"\"Fund2028\":\"%@\",\n", [results stringForColumn:@"EverGreen2028"]];
		content = [content stringByAppendingFormat:@"\"Fund2030\":\"%@\",\n", [results stringForColumn:@"EverGreen2030"]];
		content = [content stringByAppendingFormat:@"\"Fund2035\":\"%@\",\n", [results stringForColumn:@"EverGreen2035"]];
		content = [content stringByAppendingFormat:@"\"CashFund\":\"%@\",\n", [results stringForColumn:@"CashFund"]];
        content = [content stringByAppendingFormat:@"\"RetireFund\":\"%@\",\n", [results stringForColumn:@"RetireFund"]];
		content = [content stringByAppendingFormat:@"\"DanaFund\":\"%@\",\n", [results stringForColumn:@"DanaFund"]];
		content = [content stringByAppendingFormat:@"\"WithdrawBull\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"WithdrawFlat\":\"%@\",\n", [results stringForColumn:@"col3"]];
		content = [content stringByAppendingFormat:@"\"WithdrawBear\":\"%@\",\n", [results stringForColumn:@"col4"]];
		content = [content stringByAppendingFormat:@"\"ReInvestBull\":\"%@\",\n", [results stringForColumn:@"col5"]];
		content = [content stringByAppendingFormat:@"\"ReInvestFlat\":\"%@\",\n", [results stringForColumn:@"col6"]];
		content = [content stringByAppendingFormat:@"\"ReInvestBear\":\"%@\"\n", [results stringForColumn:@"col7"]];
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //UL_Temp_Fund end
	
	/*
	 //UL_Temp_Fund start
	 totalRecords = 0;
	 currentRecord = 0;
	 results = [database executeQuery: [NSString stringWithFormat:@"select count(*) as cnt from UL_Temp_Fund Where sino = '%@'", getSINo]];
	 if ([results next]) {
	 totalRecords = [results intForColumn:@"cnt"];
	 }
	 
	 results = Nil;
	 query = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_Fund Where sino = '%@' order by col1", getSINo];
	 results = [database executeQuery:query];
	 
	 if (results != Nil){
	 content = [content stringByAppendingString:@"\"UL_Temp_Fund\":{\n"];
	 content = [content stringByAppendingString:@"\"data\":[\n"];
	 }
	 while([results next]) {
	 currentRecord++;
	 content = [content stringByAppendingString:@"{\n"];
	 content = [content stringByAppendingFormat:@"\"Fund\":\"%@\",\n", [results stringForColumn:@"col1"]];
	 content = [content stringByAppendingFormat:@"\"WithdrawBull\":\"%@\",\n", [results stringForColumn:@"col2"]];
	 content = [content stringByAppendingFormat:@"\"WithdrawFlat\":\"%@\",\n", [results stringForColumn:@"col3"]];
	 content = [content stringByAppendingFormat:@"\"WithdrawBear\":\"%@\",\n", [results stringForColumn:@"col4"]];
	 content = [content stringByAppendingFormat:@"\"ReInvestBull\":\"%@\",\n", [results stringForColumn:@"col5"]];
	 content = [content stringByAppendingFormat:@"\"ReInvestFlat\":\"%@\",\n", [results stringForColumn:@"col6"]];
	 content = [content stringByAppendingFormat:@"\"ReInvestBear\":\"%@\"\n", [results stringForColumn:@"col7"]];
	 
	 if (currentRecord == totalRecords){ //last record
	 content = [content stringByAppendingString:@"}\n"];
	 }
	 else{
	 content = [content stringByAppendingString:@"},\n"];
	 }
	 }
	 content = [content stringByAppendingString:@"]\n"];
	 content = [content stringByAppendingString:@"},\n"];
	 //UL_Temp_Fund end
	 */
	//UL_Temp_Trad_Details start
    totalRecords = 0;
    currentRecord = 0;
    
    query = [NSString stringWithFormat:@"Select count(*) as cnt from UL_Rider_Details where SINo ='%@'",getSINo];
    results = [database executeQuery:query];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"Select RiderCode, RiderDesc, PTypeCode, Seq, RiderTerm, SumAssured, Units, "
			 "PlanOption, HLoading, HLoadingTerm, HLoadingPct, HLoadingPctTerm, Premium, "
			 "PaymentTerm, Deductible, RRTUOFromYear,RRTUOYear, ReinvestGYI, RiderLoadingPremium "
			 "from UL_Rider_Details where SINo ='%@' ORDER BY RiderCode",getSINo];
	
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_trad_Details\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"RiderCode\":\"%@\",\n", [results stringForColumn:@"RiderCode"]];
        content = [content stringByAppendingFormat:@"\"RiderDesc\":\"%@\",\n", [results stringForColumn:@"RiderDesc"]];
		content = [content stringByAppendingFormat:@"\"PTypeCode\":\"%@\",\n", [results stringForColumn:@"PTypeCode"]];
		content = [content stringByAppendingFormat:@"\"Seq\":\"%@\",\n", [results stringForColumn:@"Seq"]];
		
		if ([[results stringForColumn:@"PTypeCode" ] isEqualToString:@"LA"]) {
			if ([[results stringForColumn:@"Seq" ] isEqualToString:@"1" ]) {
				content = [content stringByAppendingFormat:@"\"InsuredLives\":\"1st Life Assured\",\n" ];
			}
			else{
				content = [content stringByAppendingFormat:@"\"InsuredLives\":\"2nd Life Assured\",\n"];
			}
		}
		else{
			content = [content stringByAppendingFormat:@"\"InsuredLives\":\"Payor\",\n"];
		}
		
        content = [content stringByAppendingFormat:@"\"SumAssured\":\"%@\",\n", [results stringForColumn:@"SumAssured"]];
        content = [content stringByAppendingFormat:@"\"CovPeriod\":\"%@\",\n", [results stringForColumn:@"RiderTerm"]];
        content = [content stringByAppendingFormat:@"\"PaymentTerm\":\"%@\",\n", [results stringForColumn:@"PaymentTerm"]];
        content = [content stringByAppendingFormat:@"\"AnnualTarget\":\"%@\",\n", [results stringForColumn:@"Premium"]];
		content = [content stringByAppendingFormat:@"\"AnnualLoading\":\"%@\",\n", @"0.00"];
		content = [content stringByAppendingFormat:@"\"RiderHLoading\":\"%@\",\n", [[results stringForColumn:@"HLoading"] isEqualToString:@""] ? @"0" : [results stringForColumn:@"HLoading"]];
		content = [content stringByAppendingFormat:@"\"RiderHLoadingTerm\":\"%@\",\n", [results stringForColumn:@"HLoadingTerm"]];
		content = [content stringByAppendingFormat:@"\"RiderHLoadingPct\":\"%@\",\n", [[results stringForColumn:@"HLoadingPct"] isEqualToString:@""] ? @"0" : [results stringForColumn:@"HLoadingPct"]];
		content = [content stringByAppendingFormat:@"\"RiderHLoadingPctTerm\":\"%@\",\n", [results stringForColumn:@"HLoadingPctTerm"]];
		content = [content stringByAppendingFormat:@"\"TotalPremium\":\"%@\",\n", [results stringForColumn:@"Premium"]];
		content = [content stringByAppendingFormat:@"\"RiderLoadingPremium\":\"%@\",\n", [results stringForColumn:@"RiderLoadingPremium"]];
		content = [content stringByAppendingFormat:@"\"PlanOption\":\"%@\",\n", [results stringForColumn:@"PlanOption"]];
		content = [content stringByAppendingFormat:@"\"Deductible\":\"%@\",\n", [results stringForColumn:@"Deductible"]];
		content = [content stringByAppendingFormat:@"\"ReinvestGYI\":\"%@\",\n", [results stringForColumn:@"ReinvestGYI"]];
		content = [content stringByAppendingFormat:@"\"RRTUOFromYear\":\"%@\",\n", [results stringForColumn:@"RRTUOFromYear"]];
		content = [content stringByAppendingFormat:@"\"RRTUOYear\":\"%@\"\n", [results stringForColumn:@"RRTUOYear"]];
		
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //UL_Temp_Trad_Details end
	
	//UL_Temp_Trad_Basic start
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from UL_Temp_Trad_Basic where DataType = 'DATA'"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    
	if (totalRecords == 0) {
		NSLog(@"generate json - no data found in UL_Temp_Trad_Basic ");
	}
	
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT col0_1,col0_2,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10 "
			 ",col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,col22, "
			 "col23,col24,col25,col26,col27,col28,col29,col30,col31 FROM UL_Temp_Trad_Basic where DataType = 'DATA'"];
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_Trad_Basic\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        content = [content stringByAppendingFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        content = [content stringByAppendingFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        content = [content stringByAppendingFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        content = [content stringByAppendingFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        content = [content stringByAppendingFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        content = [content stringByAppendingFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        content = [content stringByAppendingFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        content = [content stringByAppendingFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        content = [content stringByAppendingFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        content = [content stringByAppendingFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        content = [content stringByAppendingFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        content = [content stringByAppendingFormat:@"\"col12\":\"%@\",\n", [results stringForColumn:@"col12"]];
        content = [content stringByAppendingFormat:@"\"col13\":\"%@\",\n", [results stringForColumn:@"col13"]];
        content = [content stringByAppendingFormat:@"\"col14\":\"%@\",\n", [results stringForColumn:@"col14"]];
        content = [content stringByAppendingFormat:@"\"col15\":\"%@\",\n", [results stringForColumn:@"col15"]];
        content = [content stringByAppendingFormat:@"\"col16\":\"%@\",\n", [results stringForColumn:@"col16"]];
        content = [content stringByAppendingFormat:@"\"col17\":\"%@\",\n", [results stringForColumn:@"col17"]];
        content = [content stringByAppendingFormat:@"\"col18\":\"%@\",\n", [results stringForColumn:@"col18"]];
        content = [content stringByAppendingFormat:@"\"col19\":\"%@\",\n", [results stringForColumn:@"col19"]];
        content = [content stringByAppendingFormat:@"\"col20\":\"%@\",\n", [results stringForColumn:@"col20"]];
        content = [content stringByAppendingFormat:@"\"col21\":\"%@\",\n", [results stringForColumn:@"col21"]];
        content = [content stringByAppendingFormat:@"\"col22\":\"%@\",\n", [results stringForColumn:@"col22"]];
        content = [content stringByAppendingFormat:@"\"col23\":\"%@\",\n", [results stringForColumn:@"col23"]];
		content = [content stringByAppendingFormat:@"\"col24\":\"%@\",\n", [results stringForColumn:@"col24"]];
        content = [content stringByAppendingFormat:@"\"col25\":\"%@\",\n", [results stringForColumn:@"col25"]];
        content = [content stringByAppendingFormat:@"\"col26\":\"%@\",\n", [results stringForColumn:@"col26"]];
        content = [content stringByAppendingFormat:@"\"col27\":\"%@\",\n", [results stringForColumn:@"col27"]];
        content = [content stringByAppendingFormat:@"\"col28\":\"%@\",\n", [results stringForColumn:@"col28"]];
        content = [content stringByAppendingFormat:@"\"col29\":\"%@\",\n", [results stringForColumn:@"col29"]];
        content = [content stringByAppendingFormat:@"\"col30\":\"%@\",\n", [results stringForColumn:@"col30"]];
        content = [content stringByAppendingFormat:@"\"col31\":\"%@\"\n", [results stringForColumn:@"col31"]];
		
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //SI_Temp_Trad_Basic end
    
	//SI_Temp_Trad_Rider start
    content = [content stringByAppendingString:@"\"UL_Temp_Trad_Rider\":{\n"];
    //page1 start
    content = [content stringByAppendingString:@"\"p1\":[\n"];
    content = [content stringByAppendingString:@"{\n"];
    content = [content stringByAppendingString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM UL_Temp_Trad_Rider where PageNo = '1' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_Trad_Rider where PageNo = '1' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        content = [content stringByAppendingFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        content = [content stringByAppendingFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        content = [content stringByAppendingFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        content = [content stringByAppendingFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        content = [content stringByAppendingFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        content = [content stringByAppendingFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        content = [content stringByAppendingFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        content = [content stringByAppendingFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        content = [content stringByAppendingFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        content = [content stringByAppendingFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        content = [content stringByAppendingFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        content = [content stringByAppendingFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        content = [content stringByAppendingFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        content = [content stringByAppendingFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        content = [content stringByAppendingFormat:@"\"col12\":\"%@\",\n", [results stringForColumn:@"col12"]];
		content = [content stringByAppendingFormat:@"\"col13\":\"%@\"\n", [results stringForColumn:@"col13"]];
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"}\n"];
    content = [content stringByAppendingString:@"],\n"];
    //page1 end
    
    //page2 start
    content = [content stringByAppendingString:@"\"p2\":[\n"];
    content = [content stringByAppendingString:@"{\n"];
    content = [content stringByAppendingString:@"\"data\":[\n"];
    
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"SELECT count(*) as cnt FROM UL_Temp_Trad_Rider where PageNo = '8' order by CAST(SeqNo AS INT) asc"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_Trad_Rider where PageNo = '8' order by CAST(SeqNo AS INT) asc"];
    results = [database executeQuery:query];
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        content = [content stringByAppendingFormat:@"\"DataType\":\"%@\",\n", [results stringForColumn:@"DataType"]];
        content = [content stringByAppendingFormat:@"\"PageNo\":\"%@\",\n", [results stringForColumn:@"PageNo"]];
        content = [content stringByAppendingFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        content = [content stringByAppendingFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        content = [content stringByAppendingFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        content = [content stringByAppendingFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        content = [content stringByAppendingFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        content = [content stringByAppendingFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        content = [content stringByAppendingFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        content = [content stringByAppendingFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        content = [content stringByAppendingFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        content = [content stringByAppendingFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        content = [content stringByAppendingFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        content = [content stringByAppendingFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        content = [content stringByAppendingFormat:@"\"col12\":\"%@\"\n", [results stringForColumn:@"col12"]];
		content = [content stringByAppendingFormat:@"\"col13\":\"%@\"\n", [results stringForColumn:@"col13"]];
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"}\n"];
    content = [content stringByAppendingString:@"]\n"];
    //page2 end
    
    content = [content stringByAppendingString:@"},\n"];
    //UL_Temp_Trad_Rider end
    
	//UL_Temp_ECAR60 start
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from UL_Temp_ECAR60 where DataType = 'DATA'"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT col0_1,col0_2,col1,col2,col3,col4,col5,col6,col7 FROM UL_Temp_ECAR60 where DataType = 'DATA'"];
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_ECAR60\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        content = [content stringByAppendingFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        content = [content stringByAppendingFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        content = [content stringByAppendingFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        content = [content stringByAppendingFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        content = [content stringByAppendingFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        content = [content stringByAppendingFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        content = [content stringByAppendingFormat:@"\"col7\":\"%@\"\n", [results stringForColumn:@"col7"]];
		
		
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //SI_Temp_ECAR60 end
	
	//UL_Temp_ECAR1 start
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from UL_Temp_ECAR where DataType = 'DATA'"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT col0_1,col0_2,col1,col2,col3,col4,col5,col6,col7,col8 FROM UL_Temp_ECAR where DataType = 'DATA'"];
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_ECAR\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        content = [content stringByAppendingFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        content = [content stringByAppendingFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        content = [content stringByAppendingFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        content = [content stringByAppendingFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        content = [content stringByAppendingFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        content = [content stringByAppendingFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
		content = [content stringByAppendingFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        content = [content stringByAppendingFormat:@"\"col8\":\"%@\"\n", [results stringForColumn:@"col8"]];
		
		
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }	
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //SI_Temp_ECAR1 end
	
	//UL_Temp_ECAR6 start
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from UL_Temp_ECAR6 where DataType = 'DATA'"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT col0_1,col0_2,col1,col2,col3,col4,col5,col6,col7,col8 FROM UL_Temp_ECAR6 where DataType = 'DATA'"];
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_ECAR6\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        content = [content stringByAppendingFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        content = [content stringByAppendingFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        content = [content stringByAppendingFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        content = [content stringByAppendingFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        content = [content stringByAppendingFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        content = [content stringByAppendingFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
		content = [content stringByAppendingFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        content = [content stringByAppendingFormat:@"\"col8\":\"%@\"\n", [results stringForColumn:@"col8"]];
		
		
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //SI_Temp_ECAR6 end
	
	//UL_Temp_RPUO start
    totalRecords = 0;
    currentRecord = 0;
	
	
    results = [database executeQuery:@"select count(*) as cnt from UL_Temp_RPUO WHERE SeqNo <> 0"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
    
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM UL_Temp_RPUO WHERE SeqNo <> 0 ORDER BY col1, SeqNo"];
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_RPUO\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
		content = [content stringByAppendingFormat:@"\"SeqNo\":\"%@\",\n", [results stringForColumn:@"SeqNo"]];
        content = [content stringByAppendingFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        content = [content stringByAppendingFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        content = [content stringByAppendingFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        content = [content stringByAppendingFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        content = [content stringByAppendingFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        content = [content stringByAppendingFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
		content = [content stringByAppendingFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
		content = [content stringByAppendingFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
		content = [content stringByAppendingFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
		content = [content stringByAppendingFormat:@"\"col11\":\"%@\"\n", [results stringForColumn:@"col11"]];
		
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //SI_Temp_RPUO end
	
	//UL_Temp_Summary start
    totalRecords = 0;
    currentRecord = 0;
    results = [database executeQuery:@"select count(*) as cnt from UL_Temp_Summary where DataType = 'DATA'"];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
    }
	
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT col0_1,col0_2,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10 "
			 ",col11,col12,col13,col14,col15,col16,col17,col18,col19,col20,col21,col22, "
			 "col23,col24,col25,col26,col27,col28,col29,col30,col31 FROM UL_Temp_Summary where DataType = 'DATA'"];
	
    results = [database executeQuery:query];
    if (results != Nil){
        content = [content stringByAppendingString:@"\"UL_Temp_Summary\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"col0_1\":\"%@\",\n", [results stringForColumn:@"col0_1"]];
        content = [content stringByAppendingFormat:@"\"col0_2\":\"%@\",\n", [results stringForColumn:@"col0_2"]];
        content = [content stringByAppendingFormat:@"\"col1\":\"%@\",\n", [results stringForColumn:@"col1"]];
        content = [content stringByAppendingFormat:@"\"col2\":\"%@\",\n", [results stringForColumn:@"col2"]];
        content = [content stringByAppendingFormat:@"\"col3\":\"%@\",\n", [results stringForColumn:@"col3"]];
        content = [content stringByAppendingFormat:@"\"col4\":\"%@\",\n", [results stringForColumn:@"col4"]];
        content = [content stringByAppendingFormat:@"\"col5\":\"%@\",\n", [results stringForColumn:@"col5"]];
        content = [content stringByAppendingFormat:@"\"col6\":\"%@\",\n", [results stringForColumn:@"col6"]];
        content = [content stringByAppendingFormat:@"\"col7\":\"%@\",\n", [results stringForColumn:@"col7"]];
        content = [content stringByAppendingFormat:@"\"col8\":\"%@\",\n", [results stringForColumn:@"col8"]];
        content = [content stringByAppendingFormat:@"\"col9\":\"%@\",\n", [results stringForColumn:@"col9"]];
        content = [content stringByAppendingFormat:@"\"col10\":\"%@\",\n", [results stringForColumn:@"col10"]];
        content = [content stringByAppendingFormat:@"\"col11\":\"%@\",\n", [results stringForColumn:@"col11"]];
        content = [content stringByAppendingFormat:@"\"col12\":\"%@\",\n", [results stringForColumn:@"col12"]];
        content = [content stringByAppendingFormat:@"\"col13\":\"%@\",\n", [results stringForColumn:@"col13"]];
        content = [content stringByAppendingFormat:@"\"col14\":\"%@\",\n", [results stringForColumn:@"col14"]];
        content = [content stringByAppendingFormat:@"\"col15\":\"%@\",\n", [results stringForColumn:@"col15"]];
        content = [content stringByAppendingFormat:@"\"col16\":\"%@\",\n", [results stringForColumn:@"col16"]];
        content = [content stringByAppendingFormat:@"\"col17\":\"%@\",\n", [results stringForColumn:@"col17"]];
        content = [content stringByAppendingFormat:@"\"col18\":\"%@\",\n", [results stringForColumn:@"col18"]];
        content = [content stringByAppendingFormat:@"\"col19\":\"%@\",\n", [results stringForColumn:@"col19"]];
        content = [content stringByAppendingFormat:@"\"col20\":\"%@\",\n", [results stringForColumn:@"col20"]];
        content = [content stringByAppendingFormat:@"\"col21\":\"%@\",\n", [results stringForColumn:@"col21"]];
        content = [content stringByAppendingFormat:@"\"col22\":\"%@\",\n", [results stringForColumn:@"col22"]];
        content = [content stringByAppendingFormat:@"\"col23\":\"%@\",\n", [results stringForColumn:@"col23"]];
		content = [content stringByAppendingFormat:@"\"col24\":\"%@\",\n", [results stringForColumn:@"col24"]];
        content = [content stringByAppendingFormat:@"\"col25\":\"%@\",\n", [results stringForColumn:@"col25"]];
        content = [content stringByAppendingFormat:@"\"col26\":\"%@\",\n", [results stringForColumn:@"col26"]];
        content = [content stringByAppendingFormat:@"\"col27\":\"%@\",\n", [results stringForColumn:@"col27"]];
        content = [content stringByAppendingFormat:@"\"col28\":\"%@\",\n", [results stringForColumn:@"col28"]];
        content = [content stringByAppendingFormat:@"\"col29\":\"%@\",\n", [results stringForColumn:@"col29"]];
        content = [content stringByAppendingFormat:@"\"col30\":\"%@\",\n", [results stringForColumn:@"col30"]];
        content = [content stringByAppendingFormat:@"\"col31\":\"%@\"\n", [results stringForColumn:@"col31"]];
		
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //SI_Temp_Summary end
    
	//SI_Store_Premium start
    totalRecords = 0;
    currentRecord = 0;
	
	NSString *dasdas = [NSString stringWithFormat:@"select count(*) as cnt from SI_Store_premium where Sino = '%@'", getSINo];
    
	//NSLog(@"%@", dasdas);
	results = [database executeQuery:dasdas];
    if ([results next]) {
        totalRecords = [results intForColumn:@"cnt"];
		
    }
    results = Nil;
    query = [NSString stringWithFormat:@"SELECT * FROM SI_Store_premium where SIno = '%@'", getSINo];
    results = [database executeQuery:query];
    
    if (results != Nil){
        content = [content stringByAppendingString:@"\"SI_Store_Premium\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
    }
    while([results next]) {
        currentRecord++;
        content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"Type\":\"%@\",\n", [results stringForColumn:@"Type"]];
        content = [content stringByAppendingFormat:@"\"Annually\":\"%@\",\n", [results stringForColumn:@"Annually"]];
        content = [content stringByAppendingFormat:@"\"SemiAnnually\":\"%@\",\n", [results stringForColumn:@"SemiAnnually"]];
        content = [content stringByAppendingFormat:@"\"Quarterly\":\"%@\",\n", [results stringForColumn:@"Quarterly"]];
        content = [content stringByAppendingFormat:@"\"Monthly\":\"%@\",\n", [results stringForColumn:@"Monthly"]];
        content = [content stringByAppendingFormat:@"\"FromAge\":\"%@\",\n", [results stringForColumn:@"FromAge"]];
        content = [content stringByAppendingFormat:@"\"ToAge\":\"%@\"\n", [results stringForColumn:@"ToAge"]];
        if (currentRecord == totalRecords){ //last record
            content = [content stringByAppendingString:@"}\n"];
        }
        else{
            content = [content stringByAppendingString:@"},\n"];
        }
    }
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"},\n"];
    //SI_Store_Premium end
    
	
	//page3 start
    totalRecords = 0;
    currentRecord = 0;
    
	NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"dd/MM/yyyy"];
	NSDate* now =  [NSDate date];
	NSString* ccc = [df stringFromDate:now];
	NSDate* d = [df dateFromString:ccc];
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
	
	
	double YearDiff2023 = [round2 doubleValue];
	double YearDiff2025 = [round3 doubleValue];
	double YearDiff2028 = [round4 doubleValue];
	double YearDiff2030 = [round5 doubleValue];
	double YearDiff2035 = [round6 doubleValue];
	
	query = [NSString stringWithFormat:@"Select VU2023,VU2025,VU2028,VU2030,VU2035,VUCash,VUDana,VURet,VURetOpt, VUCashOpt,VUDanaOpt From UL_Details "
			 " WHERE sino = '%@'", getSINo];
	
    results = [database executeQuery:query];
    if (results != Nil){
		[results next];
        content = [content stringByAppendingString:@"\"UL_Page3\":{\n"];
        content = [content stringByAppendingString:@"\"data\":[\n"];
		content = [content stringByAppendingString:@"{\n"];
        content = [content stringByAppendingFormat:@"\"VU2023\":\"%@\",\n", [results stringForColumn:@"VU2023"]];
        content = [content stringByAppendingFormat:@"\"VU2025\":\"%@\",\n", [results stringForColumn:@"VU2025"]];
        content = [content stringByAppendingFormat:@"\"VU2028\":\"%@\",\n", [results stringForColumn:@"VU2028"]];
        content = [content stringByAppendingFormat:@"\"VU2030\":\"%@\",\n", [results stringForColumn:@"VU2030"]];
        content = [content stringByAppendingFormat:@"\"VU2035\":\"%@\",\n", [results stringForColumn:@"VU2035"]];
		content = [content stringByAppendingFormat:@"\"VUDana\":\"%@\",\n", [results stringForColumn:@"VUDana"]];
        content = [content stringByAppendingFormat:@"\"VURet\":\"%@\",\n", [results stringForColumn:@"VURet"]];
		content = [content stringByAppendingFormat:@"\"VUCash\":\"%@\",\n", [results stringForColumn:@"VUCash"]];
		content = [content stringByAppendingFormat:@"\"VUDanaOpt\":\"%@\",\n", [results stringForColumn:@"VUDanaOpt"]];
        content = [content stringByAppendingFormat:@"\"VURetOpt\":\"%@\",\n", [results stringForColumn:@"VURetOpt"]];
		content = [content stringByAppendingFormat:@"\"VUCashOpt\":\"%@\",\n", [results stringForColumn:@"VUCashOpt"]];
		content = [content stringByAppendingFormat:@"\"YearDiff2023\":\"%f\",\n", YearDiff2023 ];
		content = [content stringByAppendingFormat:@"\"YearDiff2025\":\"%f\",\n", YearDiff2025 ];
		content = [content stringByAppendingFormat:@"\"YearDiff2028\":\"%f\",\n", YearDiff2028 ];
		content = [content stringByAppendingFormat:@"\"YearDiff2030\":\"%f\",\n", YearDiff2030 ];
		content = [content stringByAppendingFormat:@"\"YearDiff2035\":\"%f\"\n", YearDiff2035 ];
		content = [content stringByAppendingString:@"}\n"];
    }
	
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"}\n"];
    //page3 end
	
	
	
	content = [content stringByAppendingString:@"}\n"];
    content = [content stringByAppendingString:@"]\n"];
    content = [content stringByAppendingString:@"}"];
	
	[content writeToFile:jsonFile atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];
    [database close];
	
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dasd{
	
	NSString *query = [NSString stringWithFormat:@"Select VU2025,VU2028,VU2030,VU2035,VUCash,VUDana,VURet,VURetOpt, VUCashOpt,VUDanaOpt From UL_Details "
			 " WHERE sino = '%@'", getSINo];
	
	FMDatabase *database = [FMDatabase databaseWithPath:@""];
    [database open];
	
	FMResultSet *results;
	NSString *F2025, *F2028, *F2030, *F2035, *FDana, *FRet, *FCash, *FDanaOpt, *FRetOpt, *FCashOpt;
	
	
    results = [database executeQuery:query];
    if (results != Nil){
		[results next];

        F2025 = [F2025 stringByAppendingFormat:@"\"VU2025\":\"%@\",\n", [results stringForColumn:@"VU2025"]];
        F2028 = [F2028 stringByAppendingFormat:@"\"VU2028\":\"%@\",\n", [results stringForColumn:@"VU2028"]];
        F2030 = [F2030 stringByAppendingFormat:@"\"VU2030\":\"%@\",\n", [results stringForColumn:@"VU2030"]];
		F2035 = [F2035 stringByAppendingFormat:@"\"VU2035\":\"%@\",\n", [results stringForColumn:@"VU2035"]];
		FDana = [FDana stringByAppendingFormat:@"\"VUDana\":\"%@\",\n", [results stringForColumn:@"VUDana"]];
        FRet = [FRet stringByAppendingFormat:@"\"VURet\":\"%@\",\n", [results stringForColumn:@"VURet"]];
		FCash = [FCash stringByAppendingFormat:@"\"VUCash\":\"%@\",\n", [results stringForColumn:@"VUCash"]];
		FDanaOpt = [FDanaOpt stringByAppendingFormat:@"\"VUDanaOpt\":\"%@\",\n", [results stringForColumn:@"VUDanaOpt"]];
        FRetOpt = [FRetOpt stringByAppendingFormat:@"\"VURetOpt\":\"%@\",\n", [results stringForColumn:@"VURetOpt"]];
		FCashOpt = [FCashOpt stringByAppendingFormat:@"\"VUCashOpt\":\"%@\",\n", [results stringForColumn:@"VUCashOpt"]];
		
    }
	
	NSMutableArray *aDesc = [[NSMutableArray alloc] init];
	NSMutableArray *a2025 = [[NSMutableArray alloc] init];
	NSMutableArray *a2028 = [[NSMutableArray alloc] init];
	NSMutableArray *a2030 = [[NSMutableArray alloc] init];
	NSMutableArray *a2035 = [[NSMutableArray alloc] init];
	NSMutableArray *aDana = [[NSMutableArray alloc] init];
	NSMutableArray *aRet = [[NSMutableArray alloc] init];
	NSMutableArray *aCash = [[NSMutableArray alloc] init];
	
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
	
	if([FCashOpt intValue] != '0'){
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

@end
