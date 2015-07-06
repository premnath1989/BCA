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
@synthesize TradOrEver, requestSmoker,requestPayorSmoker,request2ndSmoker, requestOccpCPA;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"RIDERLIST plan:%@, ptype:%@, seq:%d class:%d",[self.requestPlan description], [self.requestPtype description],self.requestSeq,self.requestOccpClass);
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
	if ([TradOrEver isEqualToString:@"TRAD"]) {
			    [self getRiderListing];
	}
	else{
				[self getEverRiderListing];
	}

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)getEverRiderListing
{
    ridCode = [[NSMutableArray alloc] init];
    ridDesc = [[NSMutableArray alloc] init];
    
    sqlite3_stmt *statement;
    NSString *querySQL;
	
	
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
						"<= '%d' AND B.MaxAge >= '%d' AND B.Ridercode != 'WI' AND B.Ridercode != 'TPDMLA' ",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
        }
		else if ([self.requestOccpCat isEqualToString:@"UNEMP"]){

			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.Ridercode != 'DHI' AND B.MinAge <= '%d' ANd B.MaxAge >= '%d' AND B.Ridercode != 'TPDMLA' AND B.Ridercode != 'WI' ",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
		else if ([self.requestPtype isEqualToString:@"LA"] && self.requestSeq == 2 && [self.request2ndSmoker isEqualToString:@"Y"]){
			
			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.Ridercode != 'CIRD' AND B.MinAge <= '%d' ANd B.MaxAge >= '%d'",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
		else if ([self.requestPtype isEqualToString:@"LA"] && self.requestSeq == 1 && [self.requestSmoker isEqualToString:@"Y"]){
			
			querySQL = [NSString stringWithFormat:@"select A.ridercode, A.riderdesc, b.minAge, b.Maxage FROM "
						"UL_Rider_Profile A, UL_Rider_mtn  B where A.Ridercode = B.Ridercode AND B.Plancode = '%@' AND B.PTypeCode = '%@' "
						"AND B.Seq = '%d' AND B.Ridercode != 'CIRD' AND B.MinAge <= '%d' ANd B.MaxAge >= '%d'",
						[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
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
        
		
		
        if (self.requestAge > 60) {
            querySQL = [querySQL stringByAppendingFormat:@" AND B.RiderCode != \"I20R\""];
        }
        if (self.requestAge > 65) {
            querySQL = [querySQL stringByAppendingFormat:@" AND B.RiderCode != \"IE20R\""];
        }
        
        querySQL = [querySQL stringByAppendingFormat:@" order by B.RiderCode asc"];
		
		        NSLog(@"%@",querySQL);
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [ridCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                [ridDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
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

    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        if (self.requestOccpClass == 4) { // add in MG4
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\" AND a.RiderCode != \"CPA\" AND a.RiderCode != \"MG_IV\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"", [self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
        }
        else if (self.requestOccpClass > 4) {
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\" AND a.RiderCode != \"CPA\" AND a.RiderCode != \"PA\" AND a.RiderCode != \"HMM\" AND a.RiderCode != \"HB\" AND a.RiderCode != \"MG_II\" AND a.RiderCode != \"MG_IV\" AND a.RiderCode != \"HSP_II\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
        }
		else if ([self.requestOccpCat isEqualToString:@"UNEMP"]){
			querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\" AND a.RiderCode != \"CPA\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
		}
        else {
			
            querySQL = [NSString stringWithFormat:
                        @"SELECT j.*, k.MinAge, k.MaxAge FROM"
                        "(SELECT a.RiderCode,b.RiderDesc FROM Trad_Sys_RiderComb a LEFT JOIN Trad_Sys_Rider_Profile b ON a.RiderCode=b.RiderCode WHERE a.PlanCode=\"%@\" AND a.PTypeCode=\"%@\" AND a.Seq=\"%d\")j "
                        "LEFT JOIN Trad_Sys_Rider_Mtn k ON j.RiderCode=k.RiderCode WHERE k.MinAge <= \"%d\" AND k.MaxAge >= \"%d\"",[self.requestPlan description], [self.requestPtype description], self.requestSeq, self.requestAge, self.requestAge];
        }
        
        if (self.requestAge > 60) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode != \"I20R\""];
        }
        if (self.requestAge > 65) {
            querySQL = [querySQL stringByAppendingFormat:@" AND j.RiderCode != \"IE20R\""];
        }
        
        querySQL = [querySQL stringByAppendingFormat:@" order by j.RiderCode asc"];
//        NSLog(@"%@",querySQL);
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                [ridCode addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]];
                [ridDesc addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)]];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ridDesc count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *itemDesc = [ridDesc objectAtIndex:indexPath.row];
    NSString *itemcode = [ridCode objectAtIndex:indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",itemcode,itemDesc];
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    
	if (indexPath.row == selectedIndex) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = indexPath.row;
    [_delegate RiderListController:self didSelectCode:self.selectedCode desc:self.selectedDesc];
    [tableView reloadData];
}

-(NSString *)selectedCode
{
    return [ridCode objectAtIndex:selectedIndex];
}

-(NSString *)selectedDesc
{
    return [ridDesc objectAtIndex:selectedIndex];
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
