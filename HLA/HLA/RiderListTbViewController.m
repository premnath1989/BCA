//
//  RiderListTbViewController.m
//  HLA
//
//  Created by shawal sapuan on 8/29/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "RiderListTbViewController.h"

@interface RiderListTbViewController ()

@end

@implementation RiderListTbViewController
@synthesize requestPtype,requestSeq,ridCode,ridDesc,selectedCode,selectedDesc,requestOccpClass,requestAge,requestPlan, requestOccpCat;
@synthesize TradOrEver, requestSmoker,requestPayorSmoker,request2ndSmoker, requestOccpCPA,isRiderListEmpty, requestLASex, requestCovPeriod, requestEDD;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"RIDERLIST plan:%@, ptype:%@, seq:%d class:%d",[self.requestPlan description], [self.requestPtype description],self.requestSeq,self.requestOccpClass);
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
	if ([TradOrEver isEqualToString:@"TRAD"]) {
        [self getRiderListing];
	}
	else if (requestEDD == TRUE) {//@"EDD"
                [self getEverEddRiderListing];
	}
	else{
				[self getEverRiderListing];
	}

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)getEverEddRiderListing{

    
    sqlite3_stmt *statement;
    NSString *querySQL;
	isRiderListEmpty = TRUE;
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        //#EDD
        //querySQL goes here
        querySQL = @"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM UL_Rider_Profile A, UL_Rider_mtn B where A.Ridercode = B.Ridercode AND B.Plancode = 'UV' AND B.PTypeCode = 'LA' AND B.Seq = '1' AND B.isEDD = '1' AND A.Status = 1 order by B.RiderCode asc";
        
        NSString *tempRidercode;
        
        self.everEddRiderGroup1 = [NSMutableArray array];
        self.everEddRiderGroup2 = [NSMutableArray array];
        self.everEddRiderDescGroup1 = [NSMutableArray array];
        self.everEddRiderDescGroup2 = [NSMutableArray array];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [ridCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                [ridDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                
                
                tempRidercode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                if ([tempRidercode isEqualToString:@"ECAR"] || [tempRidercode isEqualToString:@"ECAR6"]  ) {
                    
                    [self.everEddRiderGroup1 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [self.everEddRiderDescGroup1 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                    
                }else if ([tempRidercode isEqualToString:@"ECRD"] || [tempRidercode isEqualToString:@"ECRP"] || [tempRidercode isEqualToString:@"ECRS"]) {
                    
                    [self.everEddRiderGroup2 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [self.everEddRiderDescGroup2 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                    
                }
                
                isRiderListEmpty = false;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    
    
    }
}

-(void)getEverRiderListing
{
    ridCode = [[NSMutableArray alloc] init];
    ridDesc = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    NSString *querySQL;
	isRiderListEmpty = TRUE;
	
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (self.requestOccpClass == 4 && ![self.requestOccpCPA isEqualToString:@"D"] ) { 

			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
							"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
							"AND B.Seq = '%d' AND B.Ridercode != 'MG_IV' AND B.MinAge <= '%d' ANd B.MaxAge >= '%d'",
							[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
			
        }
        else if (self.requestOccpClass > 4 || [self.requestOccpCPA isEqualToString:@"D"]) {
			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.Ridercode != 'DCA' AND B.RiderCode != 'DHI' AND B.Ridercode != 'MR' "
						"AND B.RiderCode != 'PA' AND B.Ridercode != 'HMM' AND B.Ridercode != 'MG_IV' AND B.MinAge "
						"<= '%d' AND B.MaxAge >= '%d' AND B.Ridercode != 'WI' AND B.Ridercode != 'TPDMLA' AND B.Ridercode != 'MDSR1' AND B.Ridercode != 'MDSR2' AND B.Ridercode != 'MCFR' ",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
        }
		else if ([self.requestOccpCat isEqualToString:@"UNEMP"]){

			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.Ridercode != 'DHI' AND B.MinAge <= '%d' ANd B.MaxAge >= '%d' AND B.Ridercode != 'WI' ",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
		else if ([self.requestPtype isEqualToString:@"LA"] && self.requestSeq == 2 && [self.request2ndSmoker isEqualToString:@"Y"]){
			
			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.Ridercode != 'CIRD' AND B.MinAge <= '%d' ANd B.MaxAge >= '%d'",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
        /*
		else if ([self.requestPtype isEqualToString:@"LA"] && self.requestSeq == 1 && [self.requestSmoker isEqualToString:@"Y"]){
			
			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.Ridercode != 'CIRD' AND B.MinAge <= '%d' ANd B.MaxAge >= '%d'",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
         */
		else if ([self.requestPtype isEqualToString:@"PY"] && [self.request2ndSmoker isEqualToString:@"Y"]){
			
			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.Ridercode != 'CIRD' AND B.MinAge <= '%d' ANd B.MaxAge >= '%d'",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
        else {
		
			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.MinAge <= '%d' AND B.MaxAge >= '%d'",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
        }
        
		
        if ([self.requestSmoker isEqualToString:@"Y"]){
            querySQL = [querySQL stringByAppendingFormat:@" AND B.RiderCode != \"CIRD\" "];
        }
        
        if ([self.requestLASex isEqualToString:@"M"] || [self.requestLASex isEqualToString:@"MALE"]){
            querySQL = [querySQL stringByAppendingFormat:@" AND B.RiderCode != \"LDYR\" "];
        }
        else{
            querySQL = [querySQL stringByAppendingFormat:@" AND B.RiderCode != \"MSR\" "];
        }
        
        //#WI
        //Check oocpCode
        if ([self checkOocpCode]) {
            querySQL = [querySQL stringByAppendingFormat:@" AND B.RiderCode != \"WI\" "];
        }
        
        querySQL = [querySQL stringByAppendingFormat:@" AND A.Status = 1 order by B.RiderCode asc"];
		
		        NSLog(@"%@",querySQL);
        
        NSString *tempRidercode;
        
        self.everRiderGroup1 = [NSMutableArray array];
        self.everRiderGroup2 = [NSMutableArray array];
        self.everRiderGroup3 = [NSMutableArray array];
        self.everRiderGroup4 = [NSMutableArray array];
        self.everRiderGroup5 = [NSMutableArray array];
        self.everRiderGroup6 = [NSMutableArray array];
        self.everRiderGroup7 = [NSMutableArray array];
        self.everRiderGroup8 = [NSMutableArray array];
        self.everRiderGroup9 = [NSMutableArray array];
        
        self.everRiderDescGroup1 = [NSMutableArray array];
        self.everRiderDescGroup2 = [NSMutableArray array];
        self.everRiderDescGroup3 = [NSMutableArray array];
        self.everRiderDescGroup4 = [NSMutableArray array];
        self.everRiderDescGroup5 = [NSMutableArray array];
        self.everRiderDescGroup6 = [NSMutableArray array];
        self.everRiderDescGroup7 = [NSMutableArray array];
        self.everRiderDescGroup8 = [NSMutableArray array];
        self.everRiderDescGroup9 = [NSMutableArray array];
        
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [ridCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                [ridDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                
                
                tempRidercode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];

                    
                    [self.everRiderGroup1 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [self.everRiderDescGroup1 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                

                
                isRiderListEmpty = false;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}


-(void)getRiderListing
{
    ridCode = [[NSMutableArray alloc] init];
    ridDesc = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    NSString *querySQL;
    isRiderListEmpty = TRUE;

    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (self.requestOccpClass == 4) { // add in MG4
            
            if ([requestOccpCPA isEqualToString:@"D"] || [requestOccpCPA isEqualToString:@"0"] || [requestOccpCPA isEqualToString:@"5"] || [requestOccpCPA isEqualToString:@"99"]   ) { // not allow to attach CPA
                querySQL = [NSString stringWithFormat:
                            @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                            "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\" AND a.RiderCode != \"CPA\" AND a.RiderCode != \"MG_IV\")j "
                            "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"", [self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
            }
            else{
                querySQL = [NSString stringWithFormat:
                            @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                            "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\"  AND a.RiderCode != \"MG_IV\")j "
                            "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"", [self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
            }

        }
        else if (self.requestOccpClass > 4) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\" AND a.RiderCode != \"CPA\" AND a.RiderCode != \"PA\" AND a.RiderCode != \"HMM\" AND a.RiderCode != \"HB\" AND a.RiderCode != \"MG_II\" AND a.RiderCode != \"MG_IV\" AND a.RiderCode != \"HSP_II\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
        }
		else if (([self.requestOccpCat isEqualToString:@"UNEMP"] || [self.requestOccpCat isEqualToString:@"HSEWIFE"] || [self.requestOccpCat isEqualToString:@"JUV"] || [self.requestOccpCat isEqualToString:@"RET"] ||
                  [self.requestOccpCat isEqualToString:@"STU"]) && self.requestEDD == FALSE){
			querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\" AND a.RiderCode != \"CPA\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
            
            if ([self.requestOccpCat isEqualToString:@"UNEMP"]){
                querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode NOT IN ('HB')"];
            }
		}
        else if (self.requestEDD == TRUE && requestSeq == 1 && [requestPtype isEqualToString:@"LA"]){
			querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\" AND a.RiderCode in ('EDUWR', 'WB30R', 'WB50R', 'WBI6R30', 'WBD10R30'))j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
        else {
			
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
        }
        
        /*
        if (self.requestAge > 60) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode != \"I20R\""];
        }
        if (self.requestAge > 65) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode != \"IE20R\""];
        }
        */
        
        if (self.requestCovPeriod < 50) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode NOT IN ('WB50R','WP50R','WPTPD50R')"];
        }
        
        if (self.requestAge < 20) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode NOT IN ('LCPR','CPA')"];
        }
        
        querySQL = [querySQL stringByAppendingFormat:@" order by j.RiderCode asc"];
        //NSLog(@"%@",querySQL);
        
        NSString *tempRidercode;
        
        RiderGroup1 = [[NSMutableArray alloc] init];
        RiderGroup2 = [[NSMutableArray alloc] init];
        RiderGroup3 = [[NSMutableArray alloc] init];
        RiderGroup4 = [[NSMutableArray alloc] init];
        RiderGroup5 = [[NSMutableArray alloc] init];
        RiderGroup6 = [[NSMutableArray alloc] init];
        RiderGroup7 = [[NSMutableArray alloc] init];
        
        RiderDescGroup1 = [[NSMutableArray alloc] init];
        RiderDescGroup2 = [[NSMutableArray alloc] init];
        RiderDescGroup3 = [[NSMutableArray alloc] init];
        RiderDescGroup4 = [[NSMutableArray alloc] init];
        RiderDescGroup5 = [[NSMutableArray alloc] init];
        RiderDescGroup6 = [[NSMutableArray alloc] init];
        RiderDescGroup7 = [[NSMutableArray alloc] init];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [ridCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                [ridDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                
                tempRidercode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                if ([tempRidercode isEqualToString:@"CPA"] || [tempRidercode isEqualToString:@"PA"]  ) {
                       [RiderGroup1 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                       [RiderDescGroup1 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                }
                else if ([tempRidercode isEqualToString:@"ACIR_MPP"] || [tempRidercode isEqualToString:@"CIR"]  ) {
                    [RiderGroup2 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [RiderDescGroup2 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                }
                else if ([tempRidercode isEqualToString:@"ICR"] || [tempRidercode isEqualToString:@"TPDYLA"]  ) {
                    [RiderGroup3 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [RiderDescGroup3 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                }
                else if ([tempRidercode isEqualToString:@"C+"] || [tempRidercode isEqualToString:@"HMM"] || [tempRidercode isEqualToString:@"HSP_II"] || [tempRidercode isEqualToString:@"HB"] ||
                         [tempRidercode isEqualToString:@"MG_II"] || [tempRidercode isEqualToString:@"MG_IV"] ) {
                    [RiderGroup4 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [RiderDescGroup4 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                }

                else if ([tempRidercode isEqualToString:@"CCTR"] || [tempRidercode isEqualToString:@"LCPR"] || [tempRidercode isEqualToString:@"PLCP"] || [tempRidercode isEqualToString:@"PTR"]||
                         [tempRidercode isEqualToString:@"WP30R"] || [tempRidercode isEqualToString:@"WP50R"] || [tempRidercode isEqualToString:@"WPTPD30R"] || [tempRidercode isEqualToString:@"WPTPD50R"] ) {
                    [RiderGroup5 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [RiderDescGroup5 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                }
                else if ([tempRidercode isEqualToString:@"CIWP"] || [tempRidercode isEqualToString:@"LCWP"] || [tempRidercode isEqualToString:@"PR"] || [tempRidercode isEqualToString:@"SP_PRE"] ||
                         [tempRidercode isEqualToString:@"SP_STD"]  ) {
                    [RiderGroup6 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [RiderDescGroup6 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                }
                else if ([tempRidercode isEqualToString:@"WB30R"] || [tempRidercode isEqualToString:@"WB50R"] || [tempRidercode isEqualToString:@"WBI6R30"] || [tempRidercode isEqualToString:@"WBD10R30"] ||
                         [tempRidercode isEqualToString:@"EDUWR"]  ) {
                    [RiderGroup7 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                    [RiderDescGroup7 addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
                }
                
                isRiderListEmpty = FALSE;
            }
            sqlite3_finalize(statement);
        }
        //added for Trad 7.1 ETPD requirements, has to be hardcoded @ Edwin 19-12-2013
        if( self.requestAge <= 63 ) //double check for ETPD age >30days <=63years old
        {
            /*
            if( [ridCode indexOfObject:@"ETPD"] == NSNotFound )
            {
                [ridCode addObject:@"ETPD"];
                [ridDesc addObject:@"TPD Yearly Living Allowance Rider"];
            }*/
        }
        sqlite3_close(contactDB);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([TradOrEver isEqualToString:@"TRAD"]) {
        if ([requestPlan isEqualToString:@"L100"] || [requestPlan isEqualToString:@"S100"]) {
            //return RiderGroup1.count > 0 ? 1 : 0 + RiderGroup2.count > 0 ? 1 : 0 + RiderGroup3.count > 0 ? 1 : 0 + RiderGroup4.count > 0 ? 1 : 0+ RiderGroup5.count > 0 ? 1 : 0 + RiderGroup6.count > 0 ? 1 : 0 ;
            return 6;
        }
        else if ([requestPlan isEqualToString:@"HLAWP"]) {
            return 7;
        }
        else{
            return 1;
        }

    }else if (requestEDD == TRUE){
        return 2;
    }
    else{
        return 1;
    }
    

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if ([TradOrEver isEqualToString:@"TRAD"]) {
        if(section == 0){
            return @"Accidental Coverage";
        }
        else if(section == 1){
            return @"Critical Illness";
        }
        else if(section == 2){
            return @"Disability Income";
        }
        else if(section == 3){
            return @"Health & Medical";
        }
        else if(section == 4){
            return @"Life Protection";
        }
        else if(section == 5){
            return @"Premium Waiver";
        }
        else if(section == 6){
            return @"Savings";
        }
        else{
            return @"";
        }

    }
    else if (requestEDD == TRUE) {//@"EDD"
        
        if(section == 0){
            return @"Guaranteed Cash";
        }
        else if(section == 1){
            return @"Pre-Natal Coverage";
        }
    }
    else{
        
            return @"";
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([TradOrEver isEqualToString:@"TRAD"]) {
        if (section == 0) {
            return [RiderGroup1 count];
        }
        else if (section == 1) {
            return [RiderGroup2 count];
        }
        else if (section == 2) {
            return [RiderGroup3 count];
        }
        else if (section == 3) {
            return [RiderGroup4 count];
        }
        else if (section == 4) {
            return [RiderGroup5 count];
        }
        else if (section == 5) {
            return [RiderGroup6 count];
        }
        else if (section == 6) {
            return [RiderGroup7 count];
        }
        else{
            return 0;
        }

    }else if (requestEDD == TRUE) {//@"EDD"
        if (section == 0) {
            return [self.everEddRiderGroup1 count];
        }
        else if (section == 1) {
            return [self.everEddRiderGroup2 count];
        }
    }
    else{

            return [self.everRiderGroup1 count];

    }
    //return [ridDesc count]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
/*
    NSString *itemDesc = [ridDesc objectAtIndex:indexPath.row];
    NSString *itemcode = [ridCode objectAtIndex:indexPath.row];

    if ([itemcode isEqualToString:@"WB30R"]|| [itemcode isEqualToString:@"WB50R"] || [itemcode isEqualToString:@"WBI6R30"] || [itemcode isEqualToString:@"WBD10R30"] ||
        [itemcode isEqualToString:@"WP30R"] || [itemcode isEqualToString:@"WP50R"] ||[itemcode isEqualToString:@"WPTPD30R"] || [itemcode isEqualToString:@"WPTPD50R"]) {
        NSRange temprange = [itemDesc rangeOfString:@"("]; // to hide (30 years term)
        itemDesc = [itemDesc substringToIndex:temprange.location];
    }
    
	cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",itemcode,itemDesc];
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
  */
    
    if ([TradOrEver isEqualToString:@"TRAD"]) {
        if (indexPath.section == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [RiderGroup1 objectAtIndex:indexPath.row], [RiderDescGroup1 objectAtIndex:indexPath.row]];
            
            
        }
        else if (indexPath.section == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [RiderGroup2 objectAtIndex:indexPath.row], [RiderDescGroup2 objectAtIndex:indexPath.row]];
            
        }
        else if (indexPath.section == 2) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [RiderGroup3 objectAtIndex:indexPath.row], [RiderDescGroup3 objectAtIndex:indexPath.row]];
            
        }
        else if (indexPath.section == 3) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [RiderGroup4 objectAtIndex:indexPath.row], [RiderDescGroup4 objectAtIndex:indexPath.row]];
            
        }
        else if (indexPath.section == 4) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [RiderGroup5 objectAtIndex:indexPath.row], [RiderDescGroup5 objectAtIndex:indexPath.row]];
            
        }
        else if (indexPath.section == 5) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [RiderGroup6 objectAtIndex:indexPath.row], [RiderDescGroup6 objectAtIndex:indexPath.row]];
            
        }
        else if (indexPath.section == 6) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [RiderGroup7 objectAtIndex:indexPath.row], [RiderDescGroup7 objectAtIndex:indexPath.row]];
            
        }
        
        cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];

        NSRange temprange = [cell.textLabel.text rangeOfString:@"("]; // to hide (30 years term)
        
        if (temprange.location != NSNotFound) {
            cell.textLabel.text = [cell.textLabel.text substringToIndex:temprange.location];
        }
        
        
        if (selectedIndexPath.section == indexPath.section) {
            if (indexPath.row == selectedIndex) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if (requestEDD == TRUE) {//@"EDD"
    
        if (indexPath.section == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.everEddRiderGroup1 objectAtIndex:indexPath.row], [self.everEddRiderDescGroup1 objectAtIndex:indexPath.row]];
            
            
        }
        else if (indexPath.section == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [self.everEddRiderGroup2 objectAtIndex:indexPath.row], [self.everEddRiderDescGroup2 objectAtIndex:indexPath.row]];
            
        }
        
        if (selectedIndexPath.section == indexPath.section) {
            if (indexPath.row == selectedIndex) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else{
        /*
        NSString *itemDesc = [ridDesc objectAtIndex:indexPath.row];
        NSString *itemcode = [ridCode objectAtIndex:indexPath.row];
        
        if ([itemcode isEqualToString:@"WB30R"]|| [itemcode isEqualToString:@"WB50R"] || [itemcode isEqualToString:@"WBI6R30"] || [itemcode isEqualToString:@"WBD10R30"] ||
            [itemcode isEqualToString:@"WP30R"] || [itemcode isEqualToString:@"WP50R"] ||[itemcode isEqualToString:@"WPTPD30R"] || [itemcode isEqualToString:@"WPTPD50R"]) {
            NSRange temprange = [itemDesc rangeOfString:@"("]; // to hide (30 years term)
            itemDesc = [itemDesc substringToIndex:temprange.location];
        }
        */
        
        
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.everRiderDescGroup1 objectAtIndex:indexPath.row]];
            
        
       
        cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        
        
            if (indexPath.row == selectedIndex) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        
    }
    

	
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([TradOrEver isEqualToString:@"TRAD"]) {
        [_delegate RiderPopOverCount:[RiderGroup1 count] + [RiderGroup2 count] + [RiderGroup3 count] + [RiderGroup4 count]+ [RiderGroup5 count] + [RiderGroup6 count] + [RiderGroup7 count]];
    }
    
    selectedIndex = indexPath.row;
    selectedIndexPath = indexPath;
    
    [_delegate RiderListController:self didSelectCode:self.selectedCode desc:self.selectedDesc];
    
    [tableView reloadData];
}



-(NSString *)selectedCode
{
    if ([TradOrEver isEqualToString:@"TRAD"]) {
        if (selectedIndexPath.section == 0) {
            return [RiderGroup1 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 1) {
            return [RiderGroup2 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 2) {
            return [RiderGroup3 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 3) {
            return [RiderGroup4 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 4) {
            return [RiderGroup5 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 5) {
            return [RiderGroup6 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 6) {
            return [RiderGroup7 objectAtIndex:selectedIndex];
        }
    }
    else if (requestEDD == TRUE) { //@"EDD"
    
        if (selectedIndexPath.section == 0) {
            return [self.everEddRiderGroup1 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 1) {
            return [self.everEddRiderGroup2 objectAtIndex:selectedIndex];
        }
    }
    else{
        
            return [self.everRiderGroup1 objectAtIndex:selectedIndex];
        
    }
    
    //
}

-(NSString *)selectedDesc
{
    if ([TradOrEver isEqualToString:@"TRAD"]) {
        if (selectedIndexPath.section == 0) {
            return [RiderDescGroup1 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 1) {
            return [RiderDescGroup2 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 2) {
            return [RiderDescGroup3 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 3) {
            return [RiderDescGroup4 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 4) {
            return [RiderDescGroup5 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 5) {
            return [RiderDescGroup6 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 6) {
            return [RiderDescGroup7 objectAtIndex:selectedIndex];
        }
    }
    else if (requestEDD == TRUE) {//@"EDD"
    
        if (selectedIndexPath.section == 0) {
            return [self.everEddRiderDescGroup1 objectAtIndex:selectedIndex];
        }
        else if (selectedIndexPath.section == 1) {
            return [self.everEddRiderDescGroup2 objectAtIndex:selectedIndex];
        }

    }
    else{

            return [self.everRiderDescGroup1 objectAtIndex:selectedIndex];

    }
    
    //
}


-(BOOL)checkOocpCode{
    //To block non-income earner from WI Rider
    NSArray *occpCodeArray = [NSArray arrayWithObjects:@"OCC00209",@"OCC00570",@"OCC01082",@"OCC01105",@"OCC01109",@"OCC01179",@"OCC01360",@"OCC01543",@"OCC01596",@"OCC01865",@"OCC01961",@"OCC01962",@"OCC02147",@"OCC02149",@"OCC02229",@"OCC02317",@"OCC02321", nil];
    
    if ([occpCodeArray containsObject:self.requestOccpCode]) {
        return YES;
    }else{
        return NO;
    }

}

#pragma mark - Memory management

- (void)viewDidUnload
{
    [self setDelegate:nil];
    [self setRequestPtype:nil];
    [self setRidCode:nil];
    [self setRidDesc:nil];
    [super viewDidUnload];
}

@end
