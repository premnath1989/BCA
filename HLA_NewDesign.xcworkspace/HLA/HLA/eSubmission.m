//
//  eSubmission.m
//  iMobile Planner
//
//  Created by shawal sapuan on 5/9/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eSubmission.h"
#import "ColorHexCode.h"
#import "DataClass.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"


@interface eSubmission (){
    DataClass *obj;
}

@end

@implementation eSubmission
@synthesize idNoLabel,idTypeLabel,nameLabel,policyNoLabel,statusLabel,myTableView,btnDate;
@synthesize clientData,dateLabel,btnIDType,btnStatus, btnCancel,btnDelete;
@synthesize eAppsVC = _eAppsVC;
@synthesize statusPopover = _statusPopover;
@synthesize statusVC = _statusVC;
@synthesize IDTypePopover = _IDTypePopover;
@synthesize IDTypeVC = _IDTypeVC;
@synthesize eAppMenu = _eAppMenu;

- (void)viewDidLoad
{
    
    NSLog(@"11 KKY e-Submission!");
    [super viewDidLoad];
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application Listing";
    self.navigationItem.titleView = label;
    
  
    
    
    //fmdb start
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
	[database open];
	
	_POName = [[NSMutableArray alloc] init];
	_IDNo = [[NSMutableArray alloc] init];
	_ProposalNo = [[NSMutableArray alloc] init];
	_LastUpdated = [[NSMutableArray alloc] init];
	_Status = [[NSMutableArray alloc] init];
    _ClientName = [[NSMutableArray alloc] init];
    _SINo = [[NSMutableArray alloc] init];
    _planName = [[NSMutableArray alloc] init];
    _SIVersion = [[NSMutableArray alloc] init];
	
    //	FMResultSet *results = [database executeQuery:@"select POName,IDNumber,ProposalNo, DateCreated, status from eApp_Listing"];
    
    
    FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.ProposalNo, A.DateCreated, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion from eApp_Listing AS A, eProposal AS B, prospect_profile AS C ,eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode"];
    
    

    
    while([results next]) {
		NSString *poname = [results stringForColumn:@"POName"];
		NSString *idno = [results stringForColumn:@"IDNumber"];
		NSString *proposalno = [results stringForColumn:@"ProposalNo"];
		NSString *lastupdated = [results stringForColumn:@"DateCreated"];
		NSString *status = [results stringForColumn:@"status"];
        
        NSString *clientname = [results stringForColumn:@"ProspectName"];
		NSString *sino = [results stringForColumn:@"SINo"];
		NSString *planname = [results stringForColumn:@"BasicPlanCode"];
        
        NSString *siversion = [results stringForColumn:@"SIVersion"];
        if  ((NSNull *) siversion == [NSNull null])
            siversion = @"";
        
		[_POName addObject:poname];
		[_IDNo addObject:idno];
		[_ProposalNo addObject:proposalno];
		[_LastUpdated addObject:lastupdated];
		[_Status addObject:status];
        [_ClientName addObject:clientname];
        [_SINo addObject:sino];
        [_planName addObject:planname];
        [_SIVersion addObject:siversion];
	}
    
	[database close];
	[myTableView reloadData];
	//fmdb end
	isSearching = FALSE;
    
    btnDelete.hidden = TRUE;
    btnDelete.enabled = FALSE;
    ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];

    
}

- (void) ReloadTableData
{
    
    //fmdb start
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
	[database open];
	
	_POName = [[NSMutableArray alloc] init];
	_IDNo = [[NSMutableArray alloc] init];
	_ProposalNo = [[NSMutableArray alloc] init];
	_LastUpdated = [[NSMutableArray alloc] init];
	_Status = [[NSMutableArray alloc] init];
    _ClientName = [[NSMutableArray alloc] init];
    _SINo = [[NSMutableArray alloc] init];
    _planName = [[NSMutableArray alloc] init];
    _SIVersion = [[NSMutableArray alloc] init];
	
    //	FMResultSet *results = [database executeQuery:@"select POName,IDNumber,ProposalNo, DateCreated, status from eApp_Listing"];
    
    
    FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.ProposalNo, A.DateCreated, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion from eApp_Listing AS A, eProposal AS B, prospect_profile AS C ,eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode"];
    
    
    
    
    while([results next]) {
		NSString *poname = [results stringForColumn:@"POName"];
		NSString *idno = [results stringForColumn:@"IDNumber"];
		NSString *proposalno = [results stringForColumn:@"ProposalNo"];
		NSString *lastupdated = [results stringForColumn:@"DateCreated"];
		NSString *status = [results stringForColumn:@"status"];
        
        NSString *clientname = [results stringForColumn:@"ProspectName"];
		NSString *sino = [results stringForColumn:@"SINo"];
		NSString *planname = [results stringForColumn:@"BasicPlanCode"];
        
        NSString *siversion = [results stringForColumn:@"SIVersion"];
        if  ((NSNull *) siversion == [NSNull null])
            siversion = @"";
        
		[_POName addObject:poname];
		[_IDNo addObject:idno];
		[_ProposalNo addObject:proposalno];
		[_LastUpdated addObject:lastupdated];
		[_Status addObject:status];
        [_ClientName addObject:clientname];
        [_SINo addObject:sino];
        [_planName addObject:planname];
        [_SIVersion addObject:siversion];
	}
    
	[database close];
	[myTableView reloadData];
    
	//fmdb end
	isSearching = FALSE;

}

- (void)viewDidAppear:(BOOL)animated
{
    
   // obj=[DataClass getInstance];
    [self ReloadTableData];
   /*
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
	databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
	[database open];
	
	_POName = [[NSMutableArray alloc] init];
	_IDNo = [[NSMutableArray alloc] init];
	_ProposalNo = [[NSMutableArray alloc] init];
	_LastUpdated = [[NSMutableArray alloc] init];
	_Status = [[NSMutableArray alloc] init];
    
    _ClientName = [[NSMutableArray alloc] init];
    _SINo = [[NSMutableArray alloc] init];
    _planName = [[NSMutableArray alloc] init];
	

 
    FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.ProposalNo, A.DateCreated, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion from eApp_Listing AS A, eProposal AS B, prospect_profile AS C ,eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode"];
    
    
    
    
    while([results next]) {
		NSString *poname = [results stringForColumn:@"POName"];
		NSString *idno = [results stringForColumn:@"IDNumber"];
		NSString *proposalno = [results stringForColumn:@"ProposalNo"];
		NSString *lastupdated = [results stringForColumn:@"DateCreated"];
		NSString *status = [results stringForColumn:@"status"];
        
        NSString *clientname = [results stringForColumn:@"ProspectName"];
		NSString *sino = [results stringForColumn:@"SINo"];
		NSString *planname = [results stringForColumn:@"BasicPlanCode"];
        
        NSString *siversion = [results stringForColumn:@"SIVersion"];
        if  ((NSNull *) siversion == [NSNull null])
            siversion = @"";
        
		[_POName addObject:poname];
		[_IDNo addObject:idno];
		[_ProposalNo addObject:proposalno];
		[_LastUpdated addObject:lastupdated];
		[_Status addObject:status];
        [_ClientName addObject:clientname];
        [_SINo addObject:sino];
        [_planName addObject:planname];
        [_SIVersion addObject:siversion];
	}
	[database close];
    */
	[myTableView reloadData];
    
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    if (alertView.tag==1001 && buttonIndex == 0) //delete
    {
        // NSLog(@"delete!");
        // NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        
        if (ItemToBeDeleted.count < 1) {
            return;
        }
        else{
            NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        }
        
        NSArray *sorted = [[NSArray alloc] init ];
        sorted = [ItemToBeDeleted sortedArrayUsingComparator:^(id firstObject, id secondObject){
            return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
        }];
        
        sqlite3_stmt *statement;
        NSString *proposal;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
			
            for(int a=0; a<sorted.count; a++) {
                int value = [[sorted objectAtIndex:a] intValue];
                value = value - a;
                
                 proposal = [_ProposalNo objectAtIndex:value];
                
                //Delete eApp_Listing
                NSString *DeleteSQL = [NSString stringWithFormat:@"Delete from eApp_Listing where ProposalNo = \"%@\"", proposal];
                
                const char *Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eApp_Listing");
                }
                
                //Delete eProposal_LA_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_LA_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_LA_Details");
                }
                

                
                
                //Delete eProposal
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal");
                }

                
                
                //Delete eProposal_Existing_Policy_1
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Existing_Policy_1 where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_1");
                }
                
                //Delete eProposal_Existing_Policy_2
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Existing_Policy_2 where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_Existing_Policy_2");
                }


                
                //Delete eProposal_NM_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_NM_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_NM_Details");
                }

                
                //Delete eProposal_Trustee_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Trustee_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_Trustee_Details");
                }

            
                //Delete eProposal_QuestionAns
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_QuestionAns where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_QuestionAns");
                }

                
                //Delete eProposal_Additional_Questions_1
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Additional_Questions_1 where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_1");
                }

                
                
                //Delete eProposal_Additional_Questions_2
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_Additional_Questions_2 where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_Additional_Questions_2");
                }
                
                
                //DELETE CFF START
                
                //Delete eProposal_CFF_Master
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Master where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Master");
                }

                
                
                
                //Delete eProposal_CFF_CA
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA");
                }

                
                //Delete eProposal_CFF_CA_Recommendation
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA_Recommendation where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation");
                }
                
                
                //Delete eProposal_CFF_CA_Recommendation_Rider
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_CA_Recommendation_Rider where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_CA_Recommendation_Rider");
                }
                
                
                //Delete eProposal_CFF_Education
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Education where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Education");
                }
                
                
                
                //Delete eProposal_CFF_Education_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Education_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Education_Details");
                }

                
                
                //Delete eProposal_CFF_Family_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Family_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Family_Details");
                }

                
                
                
                //Delete eProposal_CFF_Personal_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Personal_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Personal_Details");
                }


                
                
                //Delete eProposal_CFF_Protection
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Protection where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Protection");
                }

                
                
                
                
                //Delete eProposal_CFF_Protection_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Protection_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Protection_Details");
                }


                
                
                
                //Delete eProposal_CFF_RecordOfAdvice
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_RecordOfAdvice where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice");
                }

                
                
                //Delete eProposal_CFF_RecordOfAdvice_Rider
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_RecordOfAdvice_Rider");
                }

                
                
                //Delete eProposal_CFF_Retirement
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Retirement where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement");
                }
                
                
                //Delete eProposal_CFF_Retirement_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_Retirement_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_Retirement_Details");
                }

                
                
                //Delete eProposal_CFF_SavingsInvest
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest");
                }

                
                
                //Delete eProposal_CFF_SavingsInvest_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
                }

                
                
                
                //Delete eProposal_CFF_SavingsInvest_Details
                DeleteSQL = [NSString stringWithFormat:@"Delete from eProposal_CFF_SavingsInvest_Details where eProposalNo = \"%@\"", proposal];
                
                Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
                }



                

                
                 

                //DELETE CFF END

              
                
                
                [_ProposalNo removeObjectAtIndex:value];
            }
            sqlite3_close(contactDB);
        }
        [self.myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
         [self ReloadTableData];
        
      
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
        btnDelete.enabled = FALSE;
        [btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        
    }
}

- (IBAction)btnDeletePressed:(id)sender
{
    
    NSString *clt;
    int RecCount = 0;
    for (UITableViewCell *cell in [self.myTableView visibleCells])
    {
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [self.myTableView indexPathForCell:cell];
			NSString *PONAME = [_POName objectAtIndex:selectedIndexPath.row];
            if (RecCount == 0) {
                clt = PONAME;
            }
			
		/*	if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK) {
                 NSString *SQL = [NSString stringWithFormat:@"select * from trad_lapayor as A, clt_profile as B, prospect_profile as C where A.custcode = B.custcode "
								 "and B.indexno = c.indexno AND C.indexNo = '%@' ", pp.ProspectID];
				if(sqlite3_prepare_v2(contactDB, [SQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
					if (sqlite3_step(statement) == SQLITE_ROW) {
						CanDelete = FALSE;
					}
					else{
						CanDelete = TRUE;
					}
					sqlite3_finalize(statement);
				}
				sqlite3_close(contactDB);
			}
		*/	
		//	if (CanDelete == FALSE) {
		//		break;
		//	}
		//	else{
				RecCount = RecCount + 1;
				
				if (RecCount > 1) {
					break;
				}
			//}
            
            
        }
    }
    
	/*if (CanDelete == FALSE) {
		NSString *msg = @"Error, there is SI tie to the prospect";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
		[alert show];
        
	}
	else{
        */
		NSString *msg;
		if (RecCount == 1) {
			msg = [NSString stringWithFormat:@"Delete %@",clt];
		}
		else {
			msg = @"Are you sure want to delete these Client(s)?";
		}
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1001];
		[alert show];
	//}

}
- (IBAction)btnResetPressed:(id)sender
{
   
    
    _policyOwnerNameTF.text = @"";
    _idNoTF.text = @"";
    
    [self ReloadTableData];
    [myTableView reloadData];
    
}
- (IBAction)btnCancelPressed:(id)sender
{
    [self resignFirstResponder];
    if ([self.myTableView isEditing]) {
        
        [self.myTableView setEditing:NO animated:TRUE];
        btnDelete.hidden = true;
        btnDelete.enabled = false;
        [btnCancel setTitle:@"Delete" forState:UIControlStateNormal ];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
    }
    else{
        
        [self.myTableView setEditing:YES animated:TRUE];
        btnDelete.hidden = FALSE;
        [btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal ];
    }

    
}



- (IBAction)searchProposalList:(id)sender {
    
    if ([_policyOwnerNameTF.text length] == 0 && [_idNoTF.text length] == 0){
        
        if ([btnStatus.titleLabel.text isEqualToString:@"-Select-"]){
            
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:@"Search criteria is required."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            alert.tag = 500;
            [alert show];
            alert = Nil;
            return;
        }
        
        
        
    }

    
	isSearching = TRUE;
	
	FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
	[database open];
	
	_PONameSearch = [[NSMutableArray alloc] init];
	_IDNoSearch = [[NSMutableArray alloc] init];
	_StatusSearch = [[NSMutableArray alloc] init];
	_ProposalNoSearch = [[NSMutableArray alloc] init];
	_LastUpdatedSearch = [[NSMutableArray alloc] init];
	
	NSString *search_poname = [NSString stringWithFormat:@"%%%@%%", _policyOwnerNameTF.text];
	NSString *search_idno = [NSString stringWithFormat:@"%%%@%%", _idNoTF.text];
	NSString *search_status;
    NSString *status_code;
    
     if([_statusLbl.text isEqualToString:@"Created"])
         status_code = @"2";
     else if([_statusLbl.text isEqualToString:@"Confirmed"])
        status_code = @"3";
     else if([_statusLbl.text isEqualToString:@"Submitted"])
         status_code = @"4";
     else if([_statusLbl.text isEqualToString:@"Received"])
         status_code = @"7";
     else if([_statusLbl.text isEqualToString:@"Failed"])
         status_code = @"6";
    
	if ([btnStatus.titleLabel.text isEqualToString:@"-Select-"]) {
		search_status = @"%%%%";
	}
	else {
		search_status = [NSString stringWithFormat:@"%%%@%%", status_code];
	}
	
    
    NSString *query = [NSString stringWithFormat:@"select poname, idnumber, proposalno, DateCreated, status from eApp_Listing  where  poname like '%@' and idnumber like '%@' and status like '%@'", search_poname, search_idno, search_status];

  
	 FMResultSet *results = [database executeQuery:query];
     NSString *str_search;
    
    
	while([results next]) {
		NSString *poname = [results stringForColumn:@"poname"];
		NSString *idno = [results stringForColumn:@"idnumber"];
		NSString *proposalno = [results stringForColumn:@"proposalno"];
		NSString *lastupdated = [results stringForColumn:@"DateCreated"];
		NSString *status = [results stringForColumn:@"status"];
		
        if([status isEqualToString:@"2"])
            str_search = @"Created";
        else  if([status isEqualToString:@"3"])
            str_search = @"Confirmed";
        else  if([status isEqualToString:@"4"])
            str_search = @"Submitted";
        else  if([status isEqualToString:@"7"])
            str_search = @"Received";
        else  if([status isEqualToString:@"6"])
            str_search = @"Failed";
        
       
        
        
		[_PONameSearch addObject:poname];
		[_IDNoSearch addObject:idno];
		[_ProposalNoSearch addObject:proposalno];
		[_LastUpdatedSearch addObject:lastupdated];
        
		[_StatusSearch addObject:str_search];
	}
	[database close];
	[myTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - action

- (IBAction)btnDatePressed:(id)sender
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    [btnDate setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", dateString] forState:UIControlStateNormal];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender frame ]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
}

- (IBAction)addNew:(id)sender
{
    
    /*
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    self.eAppMenu = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppMenuScreen"];
    self.eAppMenu.modalPresentationStyle = UIModalPresentationFullScreen;
    self.eAppMenu.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:self.eAppMenu animated:YES];
//    [self.navigationController pushViewController:self.eAppMenu animated:YES];
    
    nextStoryboard = nil;
     */
    
    //obj=[DataClass getInstance];
    //obj.str= @"singleton data class";
    //NSMutableDictionary *SI = [NSMutableDictionary dictionary];
    //obj.eAppData = [NSMutableDictionary dictionary];
    //[obj.eAppData setObject:SI forKey:@"SI"];
    //[obj.eAppData setObject:SI forKey:@"PolicyOwner"];
    //[obj.eAppData setObject:SI forKey:@"CFF"];
    //[obj.eAppData setObject:SI forKey:@"Proposal"];
    //[obj.eAppData setObject:SI forKey:@"eSign"];
    
    obj=[DataClass getInstance];
    obj.str= @"singleton data class";
	
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    obj.eAppData = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:data forKey:@"EAPP"];
    [data removeAllObjects];
	
//	data = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:data forKey:@"Sections"];
    [data removeAllObjects];
    
    //KY - Add New PO
	data = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:data forKey:@"SecPO"];
    data = [NSMutableDictionary dictionary];
    [[obj.eAppData objectForKey:@"SecPO"] setObject:data forKey:@"LADetails"];
	
	
	NSMutableDictionary *secData = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:secData forKey:@"SecA"];
	
	secData = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:secData forKey:@"SecB"];
	
	secData = [NSMutableDictionary dictionary];
    [[obj.eAppData objectForKey:@"SecB"] setObject:secData forKey:@"PREMIUM"];
	
	secData = [NSMutableDictionary dictionary];
	[[obj.eAppData objectForKey:@"SecB"] setObject:secData forKey:@"Mode"];
	
	secData = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:secData forKey:@"SecC"];
	
	secData = [NSMutableDictionary dictionary];
    [[obj.eAppData objectForKey:@"SecC"] setObject:secData forKey:@"ExistingPolicy"];
	
	secData = [NSMutableDictionary dictionary];
	[[obj.eAppData objectForKey:@"SecC"] setObject:secData forKey:@"ExistingPolicyPO"];
	
	secData = [NSMutableDictionary dictionary];
	[[obj.eAppData objectForKey:@"SecC"] setObject:secData forKey:@"ExistingPolicyLA2"];
	
	secData = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:secData forKey:@"SecD"];
	
	secData = [NSMutableDictionary dictionary];
    [[obj.eAppData objectForKey:@"SecD"] setObject:secData forKey:@"Trustees"];
	
	secData = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:secData forKey:@"SecE"];
	
	secData = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:secData forKey:@"SecF"];
	
	secData = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:secData forKey:@"SecG"];
    
    
    NSLog(@"llllll: %@", [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"ExistingPolicy"] objectForKey:@"DateIssued"]);
    //[obj.eAppData setObject:data forKey:@"Sections"];
    
    
    
    
    
    //[[obj.eAppData objectForKey:@"Sections"] setValue:@"SecA" forKey:@"CurrentSection"];
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"NewProposal"];
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"SISelected2"];
    
    NSLog(@"ESUB addNew - SISelected2 - %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected2"]);
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
    UIViewController *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"eAppMenuScreen"];
    vc.modalTransitionStyle = UIModalPresentationFullScreen;//UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
    
}

- (IBAction)ActionIDType:(id)sender
{
    if (_IDTypeVC == nil) {
        
        self.IDTypeVC = [[IDTypeViewController alloc] initWithStyle:UITableViewStylePlain];
        _IDTypeVC.delegate = self;
        self.IDTypePopover = [[UIPopoverController alloc] initWithContentViewController:_IDTypeVC];
    }
    
    [self.IDTypePopover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)ActionStatus:(id)sender
{
	[btnStatus setTitle:@"-Select-" forState:UIControlStateNormal];
	btnStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    if (_statusVC == Nil) {
        
        self.statusVC = [[eAppStatusList alloc] initWithStyle:UITableViewStylePlain];
        _statusVC.delegate = self;
        self.statusPopover = [[UIPopoverController alloc] initWithContentViewController:_statusVC];
    }
    
    [self.statusPopover presentPopoverFromRect:[sender frame ]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
}


#pragma mark - delegate

-(void)DateSelected:(NSString *)strDate :(NSString *)dbDate
{
    btnDate.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnDate setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", strDate] forState:UIControlStateNormal];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *d = [NSDate date];
    NSDate* d2 = [df dateFromString:dbDate];
    
    if ([d compare:d2] == NSOrderedAscending) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Entered date cannot be greater than today." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [alert show];
        [btnDate setTitle:@"" forState:UIControlStateNormal ];
        alert = Nil;
    }
    
    df = Nil, d = Nil, d2 = Nil;
}

-(void)CloseWindow
{
    [self resignFirstResponder];
    [self.view endEditing:YES];
    [_SIDatePopover dismissPopoverAnimated:YES];
}

-(void)selectedStatus:(NSString *)theStatus
{
    btnStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnStatus setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", theStatus] forState:UIControlStateNormal];
    [self.statusPopover dismissPopoverAnimated:YES];
	_statusLbl.text = theStatus;
}

-(void)selectedIDType:(NSString *)selectedIDType
{
    btnIDType.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnIDType setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@", selectedIDType] forState:UIControlStateNormal];
    [self.IDTypePopover dismissPopoverAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (isSearching) {
		return [_ProposalNoSearch count];
	}
	else {
		return [_ProposalNo count];
	}
     
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    [[cell.contentView viewWithTag:2001] removeFromSuperview ];
    [[cell.contentView viewWithTag:2002] removeFromSuperview ];
    [[cell.contentView viewWithTag:2003] removeFromSuperview ];
    [[cell.contentView viewWithTag:2004] removeFromSuperview ];
    [[cell.contentView viewWithTag:2005] removeFromSuperview ];
    [[cell.contentView viewWithTag:2006] removeFromSuperview ];
 
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    NSString *name;
    NSString *IDNo;
    NSString *proposalNo;
    NSString *lastupdate;
    NSString *status;
    
    if (isSearching) {
		NSString *temp_name= [_PONameSearch objectAtIndex:indexPath.row];
        name = [NSString stringWithFormat:@"        %@",temp_name]; //for delete
		IDNo = [_IDNoSearch objectAtIndex:indexPath.row];
		proposalNo = [_ProposalNoSearch objectAtIndex:indexPath.row];
		lastupdate = [_LastUpdatedSearch objectAtIndex:indexPath.row];
	    status = [_StatusSearch objectAtIndex:indexPath.row];
	}
	else {
		NSString *temp_name= [_POName objectAtIndex:indexPath.row];
        name = [NSString stringWithFormat:@"        %@",temp_name]; //for delete
		IDNo = [_IDNo objectAtIndex:indexPath.row];
		proposalNo = [_ProposalNo objectAtIndex:indexPath.row];
		lastupdate =[_LastUpdated objectAtIndex:indexPath.row];
        status = [_Status objectAtIndex:indexPath.row];
	}

    
	//CGRect frame=CGRectMake(20,0, 300, 50);
   CGRect frame=CGRectMake(-30,0, 400, 50);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= name;
    label1.textAlignment = UITextAlignmentLeft;
    label1.tag = 2001;
	//label1.backgroundColor = [UIColor clearColor];
	label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	[cell.contentView addSubview:label1];

	CGRect frame2=CGRectMake(300,0, 170, 50);
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
    label2.text = IDNo;
    label2.textAlignment = UITextAlignmentLeft;
    label2.tag = 2002;
	//label2.backgroundColor = [UIColor clearColor];
	label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	[cell.contentView addSubview:label2];

	CGRect frame3=CGRectMake(470,0, 190, 50);
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=frame3;
    //	NSLog(@"label 3: %@", label3.text);
    label3.textAlignment = UITextAlignmentLeft;
    label3.tag = 2003;
    label3.text = proposalNo;
	//label3.backgroundColor = [UIColor clearColor];
	label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	[cell.contentView addSubview:label3];

	CGRect frame5=CGRectMake(660,0, 180, 50);
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=frame5;
    label5.text = lastupdate;
	label5.textAlignment = UITextAlignmentLeft;
    label5.tag = 2005;
	//label5.backgroundColor = [UIColor clearColor];
	label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	[cell.contentView addSubview:label5];

	CGRect frame6=CGRectMake(820,0, 150, 50);
    UILabel *label6=[[UILabel alloc]init];
    label6.frame=frame6;
    label6.text = status;
    label6.textAlignment = UITextAlignmentCenter;
    label6.tag = 2006;
//	label6.backgroundColor = [UIColor clearColor];
	label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	[cell.contentView addSubview:label6];
	
	/*
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
	}
    else {
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
    }
     */
    
    if (indexPath.row % 2 == 0) {
        label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label5.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label6.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
    /*
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
     */
    }
    else {
        label1.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label5.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label6.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];

       /* label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        */
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [self.myTableView visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            btnDelete.enabled = FALSE;
        }
        else {
            [btnDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btnDelete.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted removeObject:zzz];
        [indexPaths removeObject:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([self.myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [self.myTableView visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
        
        if (!gotRowSelected) {
            [btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            btnDelete.enabled = FALSE;
        }
        else {
            [btnDelete setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btnDelete.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted addObject:zzz];
        [indexPaths addObject:indexPath];
    }

    else{
    obj=[DataClass getInstance];
     
     obj.str= @"singleton data class";
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    obj.eAppData = [NSMutableDictionary dictionary];
    
    [obj.eAppData setObject:data forKey:@"EAPP"];
		[data removeAllObjects];
	
	[obj.eAppData setObject:data forKey:@"Sections"];
		[data removeAllObjects];
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[obj.eAppData setObject:dict forKey:@"SecA"];
		
		dict = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:dict forKey:@"SecB"];
		
		dict = [NSMutableDictionary dictionary];
    [[obj.eAppData objectForKey:@"SecB"] setObject:dict forKey:@"PREMIUM"];
		
		dict = [NSMutableDictionary dictionary];
	[[obj.eAppData objectForKey:@"SecB"] setObject:dict forKey:@"Mode"];
		
		dict = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:dict forKey:@"SecC"];
		
		dict = [NSMutableDictionary dictionary];
    [[obj.eAppData objectForKey:@"SecC"] setObject:dict forKey:@"ExistingPolicy"];
		
		dict = [NSMutableDictionary dictionary];
	[[obj.eAppData objectForKey:@"SecC"] setObject:dict forKey:@"ExistingPolicyPO"];
		
		dict = [NSMutableDictionary dictionary];
	[[obj.eAppData objectForKey:@"SecC"] setObject:dict forKey:@"ExistingPolicyLA2"];
		
		dict = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:dict forKey:@"SecD"];
		
		dict = [NSMutableDictionary dictionary];
    [[obj.eAppData objectForKey:@"SecD"] setObject:dict forKey:@"Trustees"];
		
		dict = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:dict forKey:@"SecE"];
		
		dict = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:dict forKey:@"SecF"];
		
		dict = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:dict forKey:@"SecG"];
	
//	[data removeAllObjects];
    
    NSString *proposalNO =  [_ProposalNo objectAtIndex:indexPath.row];
    NSString *sino =  [_SINo objectAtIndex:indexPath.row];
    NSString *clientname =  [_ClientName objectAtIndex:indexPath.row];
    NSString *planname =  [_planName objectAtIndex:indexPath.row];
    NSString *siversion =  [_SIVersion objectAtIndex:indexPath.row];
        
    
   // NSLog(@"kky esub clientname - %@",  clientname);
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"YES" forKey:@"SISelected"];
  
    [[obj.eAppData objectForKey:@"EAPP"] setValue:planname forKey:@"SIPlanName"];
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:sino forKey:@"SINumber"];
    [[obj.eAppData objectForKey:@"EAPP"] setValue:clientname forKey:@"ClientName"];
    [[obj.eAppData objectForKey:@"EAPP"] setValue:clientname forKey:@"SIName"]; //Display SI Name in Proposal Form
    [[obj.eAppData objectForKey:@"EAPP"] setValue:planname forKey:@"Plan"];
    [[obj.eAppData objectForKey:@"EAPP"] setValue:proposalNO forKey:@"eProposalNo"];
    
     [[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"SISelected2"]; //Can't click and edit for SI table cell
     [[obj.eAppData objectForKey:@"EAPP"] setValue:siversion forKey:@"SISelected_SIVersion"];
    
  
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
    UIViewController *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"eAppMenuScreen"];
    vc.modalTransitionStyle = UIModalPresentationFullScreen;//UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
        
        [self getSys_SIVersio_AND_Trad_UL_Details];
    
    }
}

-(void) getSys_SIVersio_AND_Trad_UL_Details
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    NSString *str_Sys_SI_Version;
    NSString *str_UL_Trad_SIVersion;
    
    database2 = [FMDatabase databaseWithPath:path];
    [database2 open];
    [database2 beginTransaction];
    
    NSString *querySQL = [NSString stringWithFormat:@"select SIVersion, MAX(SILastUpdated) from  Trad_Sys_SI_Version_Details" ];
    FMResultSet *results =  [database2 executeQuery:querySQL];
    
    while ([results next]) {
        
        str_Sys_SI_Version = [results objectForColumnIndex:0];
        
    }
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:str_Sys_SI_Version forKey:@"Sys_SIVersion"];
    
    
    NSString *siplan =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Plan"];
    NSString *sino =     [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    if([siplan isEqualToString:@"HLA Cash Promise"])
        
        querySQL = [NSString stringWithFormat:@"select SIVersion from Trad_Details WHERE SINo = '%@'", sino ];
    else
         querySQL = [NSString stringWithFormat:@"select SIVersion from UL_Details WHERE SINo = '%@'", sino ];
    
    
    results =  [database2 executeQuery:querySQL];
    
    while ([results next]) {
        
        str_UL_Trad_SIVersion = [results objectForColumnIndex:0];
        
    }
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:str_UL_Trad_SIVersion forKey:@"UL_Trad_SIVersion"];

       
    [database2 commit];
    [database2 close];
    
}

- (void)viewDidUnload
{
    [self setIdTypeLabel:nil];
    [self setIdNoLabel:nil];
    [self setPolicyNoLabel:nil];
    [self setNameLabel:nil];
    [self setStatusLabel:nil];
    [self setMyTableView:nil];
    [self setBtnDate:nil];
    [self setDateLabel:nil];
    [self setBtnIDType:nil];
    [self setBtnStatus:nil];
    [self setDoESubmission:nil];
	[self setPolicyOwnerNameTF:nil];
	[self setIdNoTF:nil];
	[self setStatusLbl:nil];
    [super viewDidUnload];
}
- (IBAction)doEsubmissionBtn:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
    UIViewController *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"eSub"];
    vc.modalTransitionStyle = UIModalPresentationFullScreen;//UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

@end
