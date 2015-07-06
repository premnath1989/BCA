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
    int partyID;
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
    
    [super viewDidLoad];
    
   // NSLog(@"eSubmission");
     
	self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:20];
//    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor colorWithRed:49.0f/255.0f green:87.0f/255.0f blue:152.0f/255.0f alpha:1.0f];
//    label.shadowColor = [UIColor grayColor];
//    label.shadowOffset = CGSizeMake(0, -1);
    label.text = @"e-Application Listing";
    self.navigationItem.titleView = label;
    
    obj=[DataClass getInstance];
    [[obj.eAppData objectForKey:@"SecPO"] setValue:@"dqqwdqwd" forKey:@"Confirm_POIC"];
    
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
    _OtherIDNo = [[NSMutableArray alloc] init];
    
    _ProspectProfileName = [[NSMutableArray alloc] init];
	
    _SIClientSmoker = [[NSMutableArray alloc] init];
    _SIClientMarital = [[NSMutableArray alloc] init];
    _SIClientOccup = [[NSMutableArray alloc] init];
    
    _ProspectProfileSmoker = [[NSMutableArray alloc] init];
    _ProspectProfileOccup = [[NSMutableArray alloc] init];
    _ProspectProfileMarital = [[NSMutableArray alloc] init];
    
    
   // FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.ProposalNo, A.DateCreated, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion, A.OtherIDNo, C.Smoker, C.MaritalStatus, C.ProspectOccupationCode from eApp_Listing AS A, eProposal AS B, prospect_profile AS C, eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode order by A.DateCreated  DESC"];
    
    FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.ProposalNo, A.DateCreated, A.DateUpdated, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion, A.OtherIDNo, C.Smoker, C.MaritalStatus, C.ProspectOccupationCode from eApp_Listing AS A, eProposal AS B, prospect_profile AS C, eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode AND D.status in('Created','Failed')order by A.ID  DESC"];

    
    while([results next]) {
		NSString *poname = [results stringForColumn:@"POName"];
		NSString *idno = [results stringForColumn:@"IDNumber"];
		NSString *proposalno = [results stringForColumn:@"ProposalNo"];
        NSString *ptypeCode;
        int totalRecords;
        
        NSString *lastupdated = [results stringForColumn:@"DateUpdated"];
        
        if ([lastupdated isEqualToString:@""]||lastupdated==Nil)
        {
            lastupdated = [results stringForColumn:@"DateCreated"];
        }

		//NSString *lastupdated = [results stringForColumn:@"DateCreated"];
		NSString *status = [results stringForColumn:@"status"];
		NSString *sino = [results stringForColumn:@"SINo"];
		NSString *planncode = [results stringForColumn:@"BasicPlanCode"];
        NSString *otheridno = [results stringForColumn:@"OtherIDNo"];
        
        //Added by Andy to retrieve ID number and other ID number if PO if not determined yet.
        if ([poname isEqualToString:@""])
        {
            FMResultSet *getLAresults1 = [database executeQuery:@"select count(*) as cntLA from eProposal_LA_Details where eProposalNo = ?", proposalno];
            
            if ([getLAresults1 next]) {
                totalRecords = [getLAresults1 intForColumn:@"cntLA"];
            }
            
            FMResultSet *getLAresults = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?", proposalno];
            
            while ([getLAresults next])
            {
                ptypeCode = [getLAresults stringForColumn:@"PTypeCode"];
               // NSLog(@"Total Records %d",totalRecords);
                if (totalRecords > 1)
                {
                    if ([ptypeCode isEqualToString:@"LA2"] || [ptypeCode isEqualToString:@"PY1"])
                    {
                        poname =[getLAresults stringForColumn:@"LAName"];
                        //poname =[NSString stringWithFormat:@"%@ (*)",poname];
                        idno = [getLAresults stringForColumn:@"LANewICNo"];
                        otheridno = [getLAresults stringForColumn:@"LAOtherID"];
                    }
                }else {
                    if ([ptypeCode isEqualToString:@"LA1"])
                    {
                        poname =[getLAresults stringForColumn:@"LAName"];
                        //poname =[NSString stringWithFormat:@"%@ (*)",poname];
                        idno = [getLAresults stringForColumn:@"LANewICNo"];
                        otheridno = [getLAresults stringForColumn:@"LAOtherID"];
                    }
                }

            }
        }
        else if (![poname isEqualToString:@""] && [idno isEqualToString:@""] && [otheridno isEqualToString:@""])
        {

            FMResultSet *getLAresults1 = [database executeQuery:@"select count(*) as cntLA from eProposal_LA_Details where eProposalNo = ?", proposalno];
            
            if ([getLAresults1 next]) {
                totalRecords = [getLAresults1 intForColumn:@"cntLA"];
            }
            
            FMResultSet *getLAresults = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?", proposalno];
            
            while ([getLAresults next])
            {
                ptypeCode = [getLAresults stringForColumn:@"PTypeCode"];
              //  NSLog(@"Total Records %d",totalRecords);
                if (totalRecords > 1)
                {
                    if ([ptypeCode isEqualToString:@"LA2"] || [ptypeCode isEqualToString:@"PY1"])
                    {
                        poname =[getLAresults stringForColumn:@"LAName"];
                        idno = [getLAresults stringForColumn:@"LANewICNo"];
                        otheridno = [getLAresults stringForColumn:@"LAOtherID"];
                    }
                }else {
//                    if ([ptypeCode isEqualToString:@"LA1"])
//                    {
                        poname =[getLAresults stringForColumn:@"LAName"];
                        idno = [getLAresults stringForColumn:@"LANewICNo"];
                        otheridno = [getLAresults stringForColumn:@"LAOtherID"];
//                    }
                }
                
            }
        
        }
        
        //get the latest changed name from Client Profile
        NSString *prospectName = [results stringForColumn:@"ProspectName"];
        
        NSString *prospectSmoker = [results stringForColumn:@"Smoker"];
        
        if(prospectSmoker==NULL)
            prospectSmoker = @"";
        
        NSString *prospectMaritalStatus = [results stringForColumn:@"MaritalStatus"];
        if(prospectMaritalStatus == NULL)
            prospectMaritalStatus = @"";
        
        NSString *prospectProspectOccupationCode = [results stringForColumn:@"ProspectOccupationCode"];
        if(prospectProspectOccupationCode ==NULL)
            prospectProspectOccupationCode = @"";
        
        
        //client name store in eApp SI, if user changed the name in Client Profile, it won't update this name untill user goto
        //SI stand alone to resave again....
        NSString *SIclientname = @"";
        NSString *SIclientSmoker = @"";
        NSString *SIclientMarital = @"";
        NSString *SIclientOccup = @"";
        
        NSString *planname;
        
        NSString *getClientName =@"";
        
        if([planncode isEqualToString:@"UV"] || [planncode isEqualToString:@"UP"])
        {
            getClientName = [NSString stringWithFormat:
                             @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, "
                             "b.id, b.IndexNo, a.rowid, b.MaritalStatusCode FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
                             "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=1",sino];
        }
        else
        {
            getClientName = [NSString stringWithFormat:
                             @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, "
                             "b.id, b.IndexNo, a.rowid, b.MaritalStatusCode FROM TRAD_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
                             "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=1",sino];
        }
        // NSLog(@"ky - planncode - %@ |  query - %@",planncode,getClientName);
        
        
        FMResultSet *results2 = [database executeQuery:getClientName];
        
        while([results2 next]) {
            
            SIclientname = [results2 stringForColumn:@"Name"];
            
            SIclientSmoker = [results2 stringForColumn:@"Smoker"];
            if(SIclientSmoker==NULL)
                SIclientSmoker = @"";
            
            SIclientMarital = [results2 stringForColumn:@"MaritalStatusCode"];
            if(SIclientMarital==NULL)
                SIclientMarital = @"";
            
            
            SIclientOccup = [results2 stringForColumn:@"OccpCode"];
            if(SIclientOccup==NULL)
                SIclientOccup = @"";
            
        }
        
        [results2 close];
        
        
        
        if([planncode isEqualToString:@"UV"])
            planname = @"HLA EverLife Plus";
        else if([planncode isEqualToString:@"L100"])
            planname = @"Life100";
        else if([planncode isEqualToString:@"HLAWP"])
            planname = @"HLA Wealth Plan";
        
        else if([planncode isEqualToString:@"UP"])
            planname = @"HLA EverGain Plus";
        else
            planname = @"HLA Cash Promise";
        
        
        
        NSString *siversion = [results stringForColumn:@"SIVersion"];
        if  ((NSNull *) siversion == [NSNull null])
            siversion = @"";
        
        if  ((NSNull *) siversion == [NSNull null])
            siversion = @"";
        if  ((NSNull *) poname == [NSNull null] || poname==Nil)
            poname = @"";
        
        if(idno == nil)
            idno = @"";
        
        if  ((NSNull *) otheridno == [NSNull null])
            otheridno = @"";
		if(otheridno == nil)
            otheridno = @"";
        
        
        
		[_POName addObject:poname];
		[_IDNo addObject:idno];
		[_ProposalNo addObject:proposalno];
		[_LastUpdated addObject:lastupdated];
		[_Status addObject:status];
        [_ClientName addObject:SIclientname];
        
        [_SINo addObject:sino];
        [_planName addObject:planname];
        [_SIVersion addObject:siversion];
        [_OtherIDNo addObject:otheridno];
        
        [_ProspectProfileName addObject:prospectName];
        
        
        [_SIClientOccup addObject:SIclientOccup];
        [_SIClientSmoker addObject:SIclientSmoker];
        [_SIClientMarital addObject:SIclientMarital];
        
        
        [_ProspectProfileMarital addObject:prospectMaritalStatus];
        [_ProspectProfileSmoker addObject:prospectSmoker];
        [_ProspectProfileOccup addObject:prospectProspectOccupationCode];
        
	}
    
	[database close];
	[myTableView reloadData];
	//fmdb end
	isSearching = FALSE;
    
    btnDelete.hidden = TRUE;
    btnDelete.enabled = FALSE;
    ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeXMLData) name:@"StoreXMLData" object:nil];
    
    
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
	_ProspectProfileName = [[NSMutableArray alloc] init];
    _OtherIDNo  = [[NSMutableArray alloc] init];
    //	FMResultSet *results = [database executeQuery:@"select POName,IDNumber,ProposalNo, DateCreated, status from eApp_Listing"];
    
    
  //  FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.ProposalNo, A.DateCreated, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion, A.OtherIDNo, C.Smoker, C.MaritalStatus, C.ProspectOccupationCode from eApp_Listing AS A, eProposal AS B, prospect_profile AS C, eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode order by A.DateCreated  DESC"];
    
    FMResultSet *results = [database executeQuery:@"select A.POName, A.IDNumber, A.ProposalNo, A.DateCreated, A.DateUpdated, D.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion, A.OtherIDNo, C.Smoker, C.MaritalStatus, C.ProspectOccupationCode from eApp_Listing AS A, eProposal AS B, prospect_profile AS C, eProposal_Status AS D WHERE A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode AND D.status in('Created')order by A.ID  DESC"];

    
    while([results next]) {
		NSString *poname = [results stringForColumn:@"POName"];
		NSString *idno = [results stringForColumn:@"IDNumber"];
		NSString *proposalno = [results stringForColumn:@"ProposalNo"];
        NSString *ptypeCode;
        
        
        NSString *lastupdated = [results stringForColumn:@"DateUpdated"];
        
        if ([lastupdated isEqualToString:@""]||lastupdated==Nil)
        {
            lastupdated = [results stringForColumn:@"DateCreated"];
        }
        
        
      //  NSString *lastupdated = [results stringForColumn:@"DateCreated"];
		NSString *status = [results stringForColumn:@"status"];
		NSString *sino = [results stringForColumn:@"SINo"];
		NSString *plancode = [results stringForColumn:@"BasicPlanCode"];
        NSString *otheridno = [results stringForColumn:@"OtherIDNo"];
        int totalRecords;

	//	NSLog(@"eProposal TABLE: poname: %@, idno: %@, otheridni: %@, ptypecode: %@", poname, idno, otheridno, ptypeCode);
		
        if ([poname isEqualToString:@""])
        {
            //            FMResultSet *getLAresults = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and PTypeCode = ?", proposalno,ptypeCode];
            FMResultSet *getLAresults1 = [database executeQuery:@"select count(*) as cntLA from eProposal_LA_Details where eProposalNo = ?", proposalno];
            
            if ([getLAresults1 next]) {
                totalRecords = [getLAresults1 intForColumn:@"cntLA"];
            }
            
            FMResultSet *getLAresults = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?", proposalno];
            
            while ([getLAresults next])
            {
                ptypeCode = [getLAresults stringForColumn:@"PTypeCode"];
             //   NSLog(@"Total Records %d",totalRecords);
				
			//	NSLog(@"LA_DETAIL TABLE: poname: %@, idno: %@, otheridni: %@, ptypecode: %@", [getLAresults stringForColumn:@"LAName"], [getLAresults stringForColumn:@"LANewICNo"], [getLAresults stringForColumn:@"LAOtherID"], ptypeCode);
				
                if (totalRecords > 1)
                {
                    if ([ptypeCode isEqualToString:@"LA2"] || [ptypeCode isEqualToString:@"PY1"])
                    {
                        poname =[getLAresults stringForColumn:@"LAName"];
                        //poname =[NSString stringWithFormat:@"%@ (*)",poname];
                        idno = [getLAresults stringForColumn:@"LANewICNo"];
                        otheridno = [getLAresults stringForColumn:@"LAOtherID"];
                    }
					else if ([ptypeCode isEqualToString:@"PO"])
                    {
                        poname =[getLAresults stringForColumn:@"LAName"];
                        //poname =[NSString stringWithFormat:@"%@ (*)",poname];
                        idno = [getLAresults stringForColumn:@"LANewICNo"];
                        otheridno = [getLAresults stringForColumn:@"LAOtherID"];
                    }
                }else {
                    if ([ptypeCode isEqualToString:@"LA1"])
                    {
                        poname =[getLAresults stringForColumn:@"LAName"];
                        //poname =[NSString stringWithFormat:@"%@ (*)",poname];
                        idno = [getLAresults stringForColumn:@"LANewICNo"];
                        otheridno = [getLAresults stringForColumn:@"LAOtherID"];
                    }
                }
                
                
            }
        }
        else if (![poname isEqualToString:@""] && [idno isEqualToString:@""] && [otheridno isEqualToString:@""])
        {
            
            FMResultSet *getLAresults1 = [database executeQuery:@"select count(*) as cntLA from eProposal_LA_Details where eProposalNo = ?", proposalno];
            
            if ([getLAresults1 next]) {
                totalRecords = [getLAresults1 intForColumn:@"cntLA"];
            }
            
            FMResultSet *getLAresults = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?", proposalno];
            
            while ([getLAresults next])
            {
                ptypeCode = [getLAresults stringForColumn:@"PTypeCode"];
             //   NSLog(@"Total Records %d",totalRecords);
                if (totalRecords > 1)
                {
                    if ([ptypeCode isEqualToString:@"LA2"] || [ptypeCode isEqualToString:@"PY1"])
                    {
                        poname =[getLAresults stringForColumn:@"LAName"];
                        idno = [getLAresults stringForColumn:@"LANewICNo"];
                        otheridno = [getLAresults stringForColumn:@"LAOtherID"];
                    }
                }else {
                    //                    if ([ptypeCode isEqualToString:@"LA1"])
                    //                    {
                    poname =[getLAresults stringForColumn:@"LAName"];
                    idno = [getLAresults stringForColumn:@"LANewICNo"];
                    otheridno = [getLAresults stringForColumn:@"LAOtherID"];
                    //                    }
                }
                
            }
            
        }
        
        
        //get the latest changed name from Client Profile
        NSString *prospectName = [results stringForColumn:@"ProspectName"];
        
        //client name store in eApp SI, if user changed the name in Client Profile, it won't update this name untill user goto
        //SI stand alone to resave again....
        NSString *clientname = @"";
        
        
        //MUST GET THE LATEST SI CLIENT NAME FROM SI NOT FROM CLIENT PROFILE
        
        
        NSString *getClientName =@"";
        
        if([plancode isEqualToString:@"UV"] ||[plancode isEqualToString:@"UP"])
        {
            getClientName = [NSString stringWithFormat:
                             @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, "
                             "b.id, b.IndexNo, a.rowid, b.MaritalStatusCode FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
                             "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=1",sino];
        }
        else
        {
            getClientName = [NSString stringWithFormat:
                             @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, "
                             "b.id, b.IndexNo, a.rowid, b.MaritalStatusCode FROM TRAD_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
                             "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=1",sino];
        }
        
        
        
        FMResultSet *results2 = [database executeQuery:getClientName];
        while([results2 next]) {
            
            clientname = [results2 stringForColumn:@"Name"];
        }
        
        [results2 close];
        
        NSString *siversion = [results stringForColumn:@"SIVersion"];
        if  ((NSNull *) siversion == [NSNull null])
            siversion = @"";
        if  ((NSNull *) poname == [NSNull null] || poname == Nil)
            poname = @"";
        if  ((NSNull *) idno == [NSNull null])
            idno = @"";
        
        if(idno == nil)
            idno = @"";
        
        if  ((NSNull *) otheridno == [NSNull null])
            otheridno = @"";
		
		if(otheridno == nil)
            otheridno = @"";
		if(prospectName == nil)
            prospectName = @"";
        
		[_POName addObject:poname];
		[_IDNo addObject:idno];
		[_ProposalNo addObject:proposalno];
		[_LastUpdated addObject:lastupdated];
		[_Status addObject:status];
        [_ClientName addObject:clientname];
        [_SINo addObject:sino];
        [_planName addObject:plancode];
        [_SIVersion addObject:siversion];
        [_OtherIDNo addObject:otheridno];
        [_ProspectProfileName addObject:prospectName];
	}
    
    [results close];
    
	[database close];
	[myTableView reloadData];
    
	//fmdb end
	isSearching = FALSE;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    if(!isSearching)
        [self ReloadTableData];
    
	//[myTableView reloadData];
    
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    
    if (alertView.tag==1001 && buttonIndex == 0) //delete
    {
        // NSLog(@"delete!");
        // NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
        
        
      //  NSLog(@"Before search=%@     after search=%@",_ProposalNo,_ProposalNoSearch);
		NSString *DelErrAt = @"";
        
        if (ItemToBeDeleted.count < 1) {
            return;
        }
        else{
        //    NSLog(@"itemToBeDeleted:%d", ItemToBeDeleted.count);
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
                
                if (isSearching) {
                    proposal = [_ProposalNoSearch objectAtIndex:value];
                }
                else{
                    proposal = [_ProposalNo objectAtIndex:value];
                }
                
                
                //Delete eApp_Listing
                NSString *DeleteSQL = [NSString stringWithFormat:@"Delete from eApp_Listing where ProposalNo = \"%@\"", proposal];
                
                const char *Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
					DelErrAt = @"eApp_Listing";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
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
                    DelErrAt = @"eProposal_LA_Details";
                    NSLog(@"Error in Delete Statement - eProposal_CFF_SavingsInvest_Details");
                }
                
                
                
                
                
                if (isSearching) {
                    [_ProposalNoSearch removeObjectAtIndex:value];
                }
                else{
                    [_ProposalNo removeObjectAtIndex:value];
                }
                
                
                //DELETE CFF END
                
                
                //  NSLog(@"%@",_ProposalNo);
                
                
                // NSLog(@"%@",_ProposalNo);
            }
            sqlite3_close(contactDB);
        }
        
        // NSLog(@"%@",_ProposalNo);
        [self.myTableView beginUpdates];
        [self.myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.myTableView endUpdates];
        //[self ReloadTableData];
         [self.myTableView reloadData];
        
        if (ItemToBeDeleted==nil){
            ItemToBeDeleted = [[NSMutableArray alloc] init];
        }
        else{
            [ItemToBeDeleted removeAllObjects];
        }
        if (indexPaths==nil){
            indexPaths = [[NSMutableArray alloc] init];
        }
        else{
            [indexPaths removeAllObjects];
        }
        
        btnDelete.enabled = FALSE;
        [btnDelete setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
		
		if ([DelErrAt isEqualToString:@""])
        {
            [self ReloadTableData];
            [myTableView reloadData];
            
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"e-Application case has been successfully deleted." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
		}
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
			NSString *PONAME=nil;
            NSString *Status=nil;
            if (isSearching) {
                PONAME= [_PONameSearch objectAtIndex:selectedIndexPath.row];
                Status= [_StatusSearch objectAtIndex:selectedIndexPath.row];
            }
            else{
                PONAME= [_POName objectAtIndex:selectedIndexPath.row];
                Status= [_Status objectAtIndex:selectedIndexPath.row];
            }
			
			//**E
		   	if ([Status isEqualToString: @"Submitted"] || [Status isEqualToString: @"Received"] ) {
				RecCount = -3;
			}
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
	//**E
	//NSLog(@"RecCount: %d", RecCount);
	
	NSString *msg;
	if (RecCount == 1) {
		//msg = [NSString stringWithFormat:@"Delete %@",clt];
		msg = [NSString stringWithFormat:@"You have not submitted the case for processing. Should you wish to proceed, system will auto delete the record and you are required to recreate the eApp transaction should you wish to submit the case again."];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1001];
		[alert show];
	}
	
	else if (RecCount < 0) {
		NSString *msg = @"Error: Cannot delete status Submitted / Received";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
		[alert show];
	}
	
	else {
		//msg = @"Are you sure want to delete these Client(s)?";
		msg = [NSString stringWithFormat:@"You have not submitted the case for processing. Should you wish to proceed, system will auto delete the record and you are required to recreate the eApp transaction should you wish to submit the case again."];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1001];
		[alert show];
	}
	//}
	
}

- (void)hideKeyboard{
	
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
	
}

- (IBAction)btnResetPressed:(id)sender
{
    
    
    _policyOwnerNameTF.text = @"";
    _idNoTF.text = @"";
    _statusLbl.text=@"";
    [btnStatus setTitle:@"-Select-" forState:UIControlStateNormal];
    btnStatus.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    
    [self ReloadTableData];
    [myTableView reloadData];
	
	[self hideKeyboard];
    
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
                                  initWithTitle: @" "
                                  message:@"Search criteria is required. Please key in one of the criteria."
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
	
    if(_ProposalNoSearch==nil){
        _PONameSearch = [[NSMutableArray alloc] init];
        _IDNoSearch = [[NSMutableArray alloc] init];
        _StatusSearch = [[NSMutableArray alloc] init];
        _ProposalNoSearch = [[NSMutableArray alloc] init];
        _LastUpdatedSearch = [[NSMutableArray alloc] init];
        _OtherIDNoSearch = [[NSMutableArray alloc] init];
        _ClientNameSearch=[NSMutableArray new];
        _SIVersionSearch=[NSMutableArray new];
        _planNameSearch=[NSMutableArray new];
    }
    
    [_PONameSearch removeAllObjects];
    [_IDNoSearch removeAllObjects];
    [_StatusSearch removeAllObjects];
    [_ProposalNoSearch removeAllObjects];
    [_LastUpdatedSearch removeAllObjects];
    [_OtherIDNoSearch removeAllObjects];
    [_ClientNameSearch removeAllObjects];
    [_SIVersionSearch removeAllObjects];
    [_planNameSearch removeAllObjects];
	
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
    else
        status_code=@"";
    
	if ([btnStatus.titleLabel.text isEqualToString:@"-Select-"]) {
		search_status = @"%%%%";
	}
	else {
		search_status = [NSString stringWithFormat:@"%%%@%%", status_code];
	}
	
    
    
    //SEARCH BY OTHER ID NO
    //NSString *query  = @"SELECT poname, idnumber, proposalno, DateCreated, status, OtherIDNo FROM eApp_Listing";
	NSString *query  = @"Select A.POName, A.IDNumber, A.ProposalNo, A.DateCreated, A.DateUpdated, A.status,B.SINo, C.ProspectName, B.BasicPlanCode, B.SIVersion, A.OtherIDNo, C.Smoker, C.MaritalStatus, C.ProspectOccupationCode ,E.LAName, E.PTypeCode, E.LANewICNo, E.LAOtherID from eApp_Listing AS A, eProposal AS B, prospect_profile AS C, eProposal_Status AS D, eProposal_LA_Details AS E WHERE (A.ProposalNo = B.eProposalNo AND A.ClientProfileID = C.IndexNo AND A.status = D.StatusCode AND A.ProposalNo = E.eProposalNo) ";
    
	if (![_idNoTF.text isEqualToString:@""] && ![_policyOwnerNameTF.text isEqualToString:@""] && ![status_code isEqualToString:@""]) {
        query = [query stringByAppendingFormat:@" AND (A.POName like \'%%!\%@%%\' ESCAPE '!' OR E.LAName like \'%%!\%@%%\' ESCAPE '!') AND (A.IDNumber like \'%%!\%@%%\' ESCAPE '!' OR A.OtherIDNo like \'%%!\%@%%\' ESCAPE '!' OR E.LANewICNo like \'%%!\%@%%\' ESCAPE '!' OR E.LAOtherID like \'%%!\%@%%\' ESCAPE '!') and A.status = %@",_policyOwnerNameTF.text, _policyOwnerNameTF.text, _idNoTF.text, _idNoTF.text, _idNoTF.text, _idNoTF.text, status_code ];
    }
    else if (![_idNoTF.text isEqualToString:@""] && ![_policyOwnerNameTF.text isEqualToString:@""] && [status_code isEqualToString:@""]) {
        NSString *status_code1 = @"2";
        NSString *status_code2 = @"6";
        query = [query stringByAppendingFormat:@" AND (A.status = %@ or A.status = %@) AND (A.IDNumber like \'%%!\%@%%\' ESCAPE '!' OR A.OtherIDNo like \'%%!\%@%%\' ESCAPE '!' OR E.LANewICNo like \'%%!\%@%%\' ESCAPE '!' OR E.LAOtherID like \'%%!\%@%%\' ESCAPE '!')  and (A.POName like \'%%!\%@%%\' ESCAPE '!' OR E.LAName like \'%%!\%@%%\' ESCAPE '!') ",status_code1,status_code2, _idNoTF.text, _idNoTF.text, _idNoTF.text, _idNoTF.text, _policyOwnerNameTF.text, _policyOwnerNameTF.text];
    }
	else if ([_idNoTF.text isEqualToString:@""] && ![_policyOwnerNameTF.text isEqualToString:@""] && ![status_code isEqualToString:@""]) {
        query = [query stringByAppendingFormat:@" AND (A.POName like \'%%!\%@%%\' ESCAPE '!' OR E.LAName like \'%%!\%@%%\' ESCAPE '!') and A.status = %@" , _policyOwnerNameTF.text, _policyOwnerNameTF.text, status_code ];
    }
	else if (![_idNoTF.text isEqualToString:@""] && [_policyOwnerNameTF.text isEqualToString:@""] && ![status_code isEqualToString:@""]) {
        query = [query stringByAppendingFormat:@" AND (A.IDNumber like \'%%!\%@%%\' ESCAPE '!' OR A.OtherIDNo like \'%%!\%@%%\' ESCAPE '!' OR E.LANewICNo like \'%%!\%@%%\' ESCAPE '!' OR E.LAOtherID like \'%%!\%@%%\' ESCAPE '!') and A.status = %@" ,_idNoTF.text, _idNoTF.text, _idNoTF.text, _idNoTF.text, status_code ];
    }
    else  if (![_policyOwnerNameTF.text isEqualToString:@""]) {
        NSString *status_code1 = @"2";
        //NSString *status_code2 = @"6";
        query = [query stringByAppendingFormat:@" AND (A.POName like \'%%!\%@%%\' ESCAPE '!' OR E.LAName like \'%%!\%@%%\' ESCAPE '!') AND (A.status = %@)", _policyOwnerNameTF.text, _policyOwnerNameTF.text, status_code1];
    }
    else if (![_idNoTF.text isEqualToString:@""]) {
        // query = [query stringByAppendingFormat:@" AND A.IDNumber like \"%%%@%%\" OR A.OtherIDNo like \"%%%@%%\"",_idNoTF.text, _idNoTF.text ];
        NSString *status_code1 = @"2";
        NSString *status_code2 = @"6";
        query = [query stringByAppendingFormat:@" AND (A.IDNumber like \'%%!\%@%%\' ESCAPE '!' OR A.OtherIDNo like \'%%!\%@%%\' ESCAPE '!' OR E.LANewICNo like \'%%!\%@%%\' ESCAPE '!' OR E.LAOtherID like \'%%!\%@%%\' ESCAPE '!') AND (A.status = %@)",_idNoTF.text, _idNoTF.text, _idNoTF.text, _idNoTF.text,  status_code1];
    }
	else if (![status_code isEqualToString:@""]) {
		query = [query stringByAppendingFormat:@"AND (A.POName like \'%%!\%@%%\' ESCAPE '!' OR E.LAName like \'%%!\%@%%\' ESCAPE '!') AND A.status = %@ ", _policyOwnerNameTF.text, _policyOwnerNameTF.text, status_code];
	}
    
	query = [query stringByAppendingFormat:@" order by A.DateCreated  DESC"];
    
    FMResultSet *results = [database executeQuery:query];
    NSString *str_search;
	
	int count_result = 0;
	NSString *proposalno, *tempProposalNo;
	while([results next]) {
		NSString *poname = [results stringForColumn:@"POName"];
		//NSLog(@"proposalNo %@", [results stringForColumn:@"ProposalNo"]);
		if (![[results stringForColumn:@"ProposalNo"] isEqualToString:tempProposalNo]) {
			
			NSString *laname = [results stringForColumn:@"LAName"];
			NSString *LAOtherID = [results stringForColumn:@"LAOtherID"];
			NSString *LANewICNo = [results stringForColumn:@"LANewICNo"];
			//NSString *TypeCode = [results stringForColumn:@"PTypeCode"];
			NSRange rangeValue = [laname rangeOfString:_policyOwnerNameTF.text options:NSCaseInsensitiveSearch];
			NSRange rangeIDValue = [LAOtherID rangeOfString:_idNoTF.text options:NSCaseInsensitiveSearch];
			NSRange rangeID2Value = [LANewICNo rangeOfString:_idNoTF.text options:NSCaseInsensitiveSearch];
			
			if (![poname isEqualToString:@""] && rangeValue.length > 0 && ![poname isEqualToString:laname]) {
				//NSLog(@"PONAME: %@, LANAME: %@, policyOnwer %@", poname, laname, _policyOwnerNameTF.text);
				goto outer_done;
			}
			if (![poname isEqualToString:@""] && rangeIDValue.length > 0 && ![poname isEqualToString:laname]) {
				//Policy owner is determine, remove result from eProposal_LA_Details
				goto outer_done;
			}
			if (![poname isEqualToString:@""] && rangeID2Value.length > 0 && ![poname isEqualToString:laname]) {
				//Policy owner is determine, remove result from eProposal_LA_Details
				goto outer_done;
			}
			
			count_result = count_result+1;
			NSString *idno = [results stringForColumn:@"IDNumber"];
			if (idno == Nil)
				idno = @"";
			proposalno = [results stringForColumn:@"ProposalNo"];
            
            NSString *lastupdated = [results stringForColumn:@"DateUpdated"];
            
            if ([lastupdated isEqualToString:@""]||lastupdated==Nil)
            {
                lastupdated = [results stringForColumn:@"DateCreated"];
            }

            
			//NSString *lastupdated = [results stringForColumn:@"DateCreated"];
			NSString *status = [results stringForColumn:@"status"];
			NSString *sino = [results stringForColumn:@"SINo"];
			NSString *plancode = [results stringForColumn:@"BasicPlanCode"];
			NSString *otherIDNo = [results stringForColumn:@"OtherIDNo"];
			if (otherIDNo == nil) {
				otherIDNo = @"";
			}
			int totalRecords;
			NSString *ptypeCode;
			
			if ([poname isEqualToString:@""])
			{
				FMResultSet *getLAresults1 = [database executeQuery:@"select count(*) as cntLA from eProposal_LA_Details where eProposalNo = ?", proposalno];
				
				if ([getLAresults1 next]) {
					totalRecords = [getLAresults1 intForColumn:@"cntLA"];
				}
				
				FMResultSet *getLAresults = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?", proposalno];
				
				NSString *ProspectName = [results stringForColumn:@"ProspectName"];
				NSRange rangeProspectNameValue = [ProspectName rangeOfString:_policyOwnerNameTF.text options:NSCaseInsensitiveSearch];
				
				while ([getLAresults next])
				{
					ptypeCode = [getLAresults stringForColumn:@"PTypeCode"];
					//NSLog(@"Total Records %d",totalRecords);
					if (totalRecords > 1)
					{
						if ([ptypeCode isEqualToString:@"LA2"] || [ptypeCode isEqualToString:@"PY1"])
						{
							poname =[getLAresults stringForColumn:@"LAName"];
							//poname =[NSString stringWithFormat:@"%@ (*)",poname];
							idno = [getLAresults stringForColumn:@"LANewICNo"];
							otherIDNo = [getLAresults stringForColumn:@"LAOtherID"];
						}
						else if ([ptypeCode isEqualToString:@"LA1"] && !rangeProspectNameValue.length > 0) {
							count_result = count_result-1;
							goto outer_done;
						}
					}else {
						if ([ptypeCode isEqualToString:@"LA1"])
						{
							poname =[getLAresults stringForColumn:@"LAName"];
							//poname =[NSString stringWithFormat:@"%@ (*)",poname];
							idno = [getLAresults stringForColumn:@"LANewICNo"];
							otherIDNo = [getLAresults stringForColumn:@"LAOtherID"];
						}
					}
					
					
				}
			}
			else if (![poname isEqualToString:@""] && [idno isEqualToString:@""] && [otherIDNo isEqualToString:@""])
			{
				
				FMResultSet *getLAresults1 = [database executeQuery:@"select count(*) as cntLA from eProposal_LA_Details where eProposalNo = ?", proposalno];
				
				if ([getLAresults1 next]) {
					totalRecords = [getLAresults1 intForColumn:@"cntLA"];
				}
				
				FMResultSet *getLAresults = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?", proposalno];
				
				while ([getLAresults next])
				{
					ptypeCode = [getLAresults stringForColumn:@"PTypeCode"];
					//NSLog(@"Total Records %d",totalRecords);
					if (totalRecords > 1)
					{
						if ([ptypeCode isEqualToString:@"LA2"] || [ptypeCode isEqualToString:@"PY1"])
						{
							poname =[getLAresults stringForColumn:@"LAName"];
							idno = [getLAresults stringForColumn:@"LANewICNo"];
							otherIDNo = [getLAresults stringForColumn:@"LAOtherID"];
						}
					}else {
						//                    if ([ptypeCode isEqualToString:@"LA1"])
						//                    {
						poname =[getLAresults stringForColumn:@"LAName"];
						idno = [getLAresults stringForColumn:@"LANewICNo"];
						otherIDNo = [getLAresults stringForColumn:@"LAOtherID"];
						//                    }
					}
					
				}
				
			}
			
			
			
			NSString *prospectName = [results stringForColumn:@"ProspectName"];
			
			//client name store in eApp SI, if user changed the name in Client Profile, it won't update this name untill user goto
			//SI stand alone to resave again....
			NSString *clientname = @"";
			
			
			//MUST GET THE LATEST SI CLIENT NAME FROM SI NOT FROM CLIENT PROFILE
			
			
			NSString *getClientName =@"";
			if([plancode isEqualToString:@"UV"] ||[plancode isEqualToString:@"UP"])
			{
				getClientName = [NSString stringWithFormat:
								 @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, "
								 "b.id, b.IndexNo, a.rowid, b.MaritalStatusCode FROM UL_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
								 "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Seq=1",sino];
			}
			else
			{
				getClientName = [NSString stringWithFormat:
								 @"SELECT a.SINo, a.CustCode, b.Name, b.Smoker, b.Sex, b.DOB, b.ALB, b.OccpCode, b.DateCreated, "
								 "b.id, b.IndexNo, a.rowid, b.MaritalStatusCode FROM TRAD_LAPayor a LEFT JOIN Clt_Profile b ON a.CustCode=b.CustCode "
								 "WHERE a.SINo=\"%@\" AND a.PTypeCode=\"LA\" AND a.Sequence=1",sino];
			}
			
			
			
			FMResultSet *results2 = [database executeQuery:getClientName];
			while([results2 next]) {
				
				clientname = [results2 stringForColumn:@"Name"];
			}
			
			[results2 close];
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
			NSString *siversion = [results stringForColumn:@"SIVersion"];
			if  ((NSNull *) siversion == [NSNull null])
				siversion = @"";
			if  ((NSNull *) poname == [NSNull null] || poname == Nil)
				poname = @"";
			if  ((NSNull *) idno == [NSNull null])
				idno = @"";
			
			if(idno == nil)
				idno = @"";
			
	
			//if ((![poname isEqualToString:@""] && ) || [poname isEqualToString:@""] ){
				
			[_PONameSearch addObject:poname];
			[_IDNoSearch addObject:idno];
			[_ProposalNoSearch addObject:proposalno];
			[_LastUpdatedSearch addObject:lastupdated];
			[_StatusSearch addObject:str_search];
			[_OtherIDNoSearch addObject:otherIDNo];
			[_SINoSearch addObject:sino];	
			[_planNameSearch addObject:plancode];
			[_SIVersionSearch addObject:siversion];
			[_ClientNameSearch addObject:clientname];
			//}
		}
		tempProposalNo = [results stringForColumn:@"ProposalNo"];
	outer_done:
		tempProposalNo = tempProposalNo; //no real used, just need to put something
		}
	
    //NSLog(@"%i",count_result);
	if(count_result==0) {
		
        
        
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"No record found"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        alert.tag = 500;
        [alert show];
        alert = Nil;
        
	}
    
	[database close];
	[myTableView reloadData];
	
	[self hideKeyboard];
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
    
    //For Form and XML population
    NSMutableDictionary *dataset = [NSMutableDictionary dictionary];
    [obj.eAppData setObject:dataset forKey:@"EAPPDataSet"];
    
	
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
    
    
    
    
    
    
    
    //[[obj.eAppData objectForKey:@"Sections"] setValue:@"SecA" forKey:@"CurrentSection"];
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"NewProposal"];
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"SISelected2"];
    
    
    
    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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
    
    
    obj = [DataClass getInstance];
    
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
    NSString *otheridno;
    if (isSearching) {
		NSString *temp_name= [_PONameSearch objectAtIndex:indexPath.row];
        name = [NSString stringWithFormat:@"        %@",temp_name]; //for delete
		IDNo = [_IDNoSearch objectAtIndex:indexPath.row];
		proposalNo = [_ProposalNoSearch objectAtIndex:indexPath.row];
		lastupdate = [_LastUpdatedSearch objectAtIndex:indexPath.row];
	    status = [_StatusSearch objectAtIndex:indexPath.row];
        otheridno = [_OtherIDNoSearch objectAtIndex:indexPath.row];
        
	}
	else {
		NSString *temp_name= [_POName objectAtIndex:indexPath.row];
        name = [NSString stringWithFormat:@"        %@",temp_name]; //for delete
		IDNo = [_IDNo objectAtIndex:indexPath.row];
		proposalNo = [_ProposalNo objectAtIndex:indexPath.row];
		lastupdate =[_LastUpdated objectAtIndex:indexPath.row];
        status = [_Status objectAtIndex:indexPath.row];
        otheridno = [_OtherIDNo objectAtIndex:indexPath.row];
        
        
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
    
    
    //  [[obj.eAppData objectForKey:@"EAPP"] setValue:otheridno forKey:@"POOtherIDTypeNo"];
    
    
    
    if(![otheridno isEqualToString:@""] && ![IDNo isEqualToString:@""])
    {
        [label2 setNumberOfLines:2];
        label2.text = [NSString stringWithFormat:@"%@\n%@", IDNo, otheridno];
    }
    else if(![IDNo isEqualToString:@""])
    {
        [label2 setNumberOfLines:1];
        label2.text= IDNo ;
    }
    else if(![otheridno isEqualToString:@""])
    {
        [label2 setNumberOfLines:1];
        label2.text= otheridno ;
    }
    
    //  label2.text = IDNo;
    label2.textAlignment = UITextAlignmentLeft;
    label2.tag = 2002;
	
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
    appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    appobj.DeletePDF=YES;
    appobj.FormsTickMark=YES;
    
    //gmail
    
    SecPo_LADetails_ClientNew_Array = [[NSMutableArray alloc]init]; //for XML DATA
    
    
    
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
        
        
        
        //For Form and XML population
        
        NSMutableDictionary *dataset = [NSMutableDictionary dictionary];
        
        [obj.eAppData setObject:dataset forKey:@"EAPPDataSet"];
        
        [dataset removeAllObjects];
        
        
        
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
        
        
        NSString *sino =nil;
        NSString *clientname =nil;
        NSString *planname =nil;
        NSString *siversion =nil;
        NSString *POName =nil;
        NSString* proposalNumberString=nil;
        
        if(isSearching){
          proposalNumberString =  [_ProposalNoSearch objectAtIndex:indexPath.row];
            
        }
        else{
            proposalNumberString =  [_ProposalNo objectAtIndex:indexPath.row];
        }
       
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", proposalNumberString];
        
        
        
        NSUInteger index = [_ProposalNo  indexOfObjectPassingTest:^(id obj1, NSUInteger idx, BOOL *stop) {
            return [predicate evaluateWithObject:obj1];
        }];
       // NSLog(@"index==%i",index);
        sino= [_SINo objectAtIndex:index];
        
        
        clientname= [_ClientName objectAtIndex:index];
        
        
        planname=    [_planName objectAtIndex:index];
        
        siversion =
        [_SIVersion objectAtIndex:index];
        
        POName =
        [_POName objectAtIndex:index];
     /*   if(isSearching)
      
        {
            
            _ProposalNo =  [_ProposalNoSearch objectAtIndex:indexPath.row];
            
            sino=  [_SINoSearch objectAtIndex:indexPath.row];
            
            
            clientname=  [_ClientNameSearch objectAtIndex:indexPath.row];
            
            
            planname=   [_planNameSearch objectAtIndex:indexPath.row];
            
            siversion =
            [_SIVersionSearch
             objectAtIndex:indexPath.row];
            
            POName =
            [_PONameSearch objectAtIndex:indexPath.row];
            
        }
        
        else
            
        {
            
            _ProposalNo =  [_ProposalNo objectAtIndex:indexPath.row];
            
            sino= [_SINo objectAtIndex:indexPath.row];
            
            
            clientname= [_ClientName objectAtIndex:indexPath.row];
            
            
            planname=    [_planName objectAtIndex:indexPath.row];
            
            siversion =
            [_SIVersion objectAtIndex:indexPath.row];
            
            POName =
            [_POName objectAtIndex:indexPath.row];
            
        }
        
      */  
        appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        appobj.eappProposal=[NSString stringWithFormat:@"%@",proposalNumberString];
        
        
        
        
        NSString *ProspectName =  [_ProspectProfileName objectAtIndex:index];
        
        
		NSString *SICLientSmoker;
		
		if (_SIClientSmoker.count > index)
			SICLientSmoker =  [_SIClientSmoker objectAtIndex:index];
		
        //NSString *SICLientSmoker =  [_SIClientSmoker objectAtIndex:indexPath.row];
        
        if(SICLientSmoker==NULL)
            SICLientSmoker=@"";
        
        
        
        NSString *SIClientMarital;
		if (_SIClientMarital.count > index)
			SIClientMarital =  [_SIClientMarital objectAtIndex:index];
        
        if(SIClientMarital==NULL)
            SIClientMarital = @"";
        
		NSString *SIClientOccup;
		if (_SIClientOccup.count > index)
			SIClientOccup =  [_SIClientOccup objectAtIndex:index];
        
        if(SIClientOccup == NULL)
            SIClientOccup = @"";
        
        NSString *ProspectSmoker;
		if (_ProspectProfileSmoker.count > index)
			ProspectSmoker =  [_ProspectProfileSmoker objectAtIndex:index];
        
        if(ProspectSmoker==NULL)
            ProspectSmoker=@"";
        
        
        NSString *ProspectMarital;
		if (_ProspectProfileMarital.count > index)
			ProspectMarital =  [_ProspectProfileMarital objectAtIndex:index];
        
        if(ProspectMarital==NULL)
            
            ProspectMarital = @"";
        
        
		NSString *ProspectOccup;
		if (_ProspectProfileOccup.count > index)
			ProspectOccup =  [_ProspectProfileOccup objectAtIndex:index];
        
        if(ProspectOccup == NULL)
            ProspectOccup = @"";
        
		NSString *ProposalStatus;
		if (_Status.count > index)
			ProposalStatus = [_Status objectAtIndex:index];
		
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"YES" forKey:@"SISelected"];
        
        
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:planname forKey:@"SIPlanName"];
		
		
		eAppsListing *eAppList = [[eAppsListing alloc]init];
		NSString *sitype = [eAppList GetPlanData:3 :planname];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:sitype forKey:@"SIType"];
        
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:sino forKey:@"SINumber"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:ProspectName forKey:@"ProspectName"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:ProspectSmoker forKey:@"ProspectSmoker"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:ProspectMarital forKey:@"ProspectMarital"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:ProspectOccup forKey:@"ProspectOccup"];
        
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:clientname forKey:@"ClientName"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:SICLientSmoker forKey:@"ClientSmoker"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:SIClientMarital forKey:@"ClientMarital"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:SIClientOccup forKey:@"ClientOccup"];
        
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:clientname forKey:@"SIName"]; //Display SI Name in Proposal Form
        
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:planname forKey:@"Plan"];
        
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:proposalNumberString forKey:@"eProposalNo"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:ProposalStatus forKey:@"ProposalStatus"];
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"SISelected2"]; //Can't click and edit for SI table cell
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:siversion forKey:@"SISelected_SIVersion"];
        
        [[obj.eAppData objectForKey:@"SecPO"] setValue:POName forKey:@"Confirm_POName"];
        
        
        
        
        
        
        
        
        
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
        
        UIViewController *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"eAppMenuScreen"];
        
        vc.modalTransitionStyle = UIModalPresentationFullScreen;//UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:vc animated:YES completion:NULL];
        
        
        
        [self getSys_SIVersio_AND_Trad_UL_Details];
        
        
        
        
        
        //*****************START XML
        
        
        
        [self StoreXMLdata_AgentProfile];
        
        
        
        NSDictionary *eAppNo = [[NSDictionary alloc]init];
        
        eAppNo = @{@"eProposalNo":_ProposalNo};
        
        
        
        [SecPo_LADetails_ClientNew_Array addObject:eAppNo];
        
     
        [self storeXMLData];
        
        //XML DATA
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:SecPo_LADetails_ClientNew_Array forKey:@"AssuredInfo"];
        
        
        
        // NSLog(@"KY esub - SecPo_LADetails_ClientNew_Array - %@",SecPo_LADetails_ClientNew_Array);
        
        
        
        // NSLog(@"KY ESUB  AssuredInfo %@",SecPo_LADetails_ClientNew_Array);
        
        //*****************END XML
        
        
        
    }
    
}

-(void) StoreXMLdata_AgentProfile
{
    
    obj=[DataClass getInstance];
    
    
    //BECAREFUL WITH THE PLAN CODE - CANNOT BE HLA CASH PROMISE/ HLA EVER LIFE!!
    NSString *plancode = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Plan"];
    NSString *SIType;
    if( [ plancode isEqualToString:@"HLACP"] || [ plancode isEqualToString:@"L100"] || [ plancode isEqualToString:@"HLAWP"])
        SIType = @"TRAD";
    else if([ plancode isEqualToString:@"UV"] || [ plancode isEqualToString:@"UP"])
        SIType = @"ES";
    else
        SIType = @"";
    
    
    
    //GET SYSTEM NAME, SYSTEM VERSION
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
	FMResultSet *results2;
    
    NSString *eAppVersion = @"";
    NSString *SystemName = @"";
    NSString *createdDate = @"";
    
    results2 = [db executeQuery:@"SELECT eAppVersion, SystemName, CreatedAt from eProposal WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    
	while ([results2 next]) {
        
        eAppVersion = [results2 stringForColumn:@"eAppVersion"];
        
        SystemName = [results2 stringForColumn:@"SystemName"];
        
        createdDate = [results2 stringForColumn:@"CreatedAt"];
        
    }
    
    NSString *BackDate = @"False";
    NSString *BackDating = @"";
    
    results2 = [db executeQuery:@"SELECT BackDating, blnBackdating from eProposal_Existing_Policy_1 WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    
	while ([results2 next]) {
        
        NSString  *backdating = [results2 stringForColumn:@"BackDating"];
		NSString  *blnBackdating = [results2 stringForColumn:@"blnBackdating"];
		
        
        //        if(backdating!=NULL){
        //            BackDating = backdating;
        //            BackDate = @"True";
        //        }
        //        else
        //            BackDate = @"False";
		
		if ([blnBackdating isEqualToString:@"Y"]){
			BackDating = backdating;
			BackDate = @"True";
		}
		else
			BackDate = @"False";
    }
    
    NSString *CFFStatus = @"";
    results2 = [db executeQuery:@"SELECT Status FROM eProposal_CFF_Master WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    
	while ([results2 next]) {
        
        NSString  *Status = [results2 stringForColumn:@"Status"];
        
        if (Status==NULL)
            CFFStatus = @"N";
        else
            CFFStatus = @"Y";
        
    }
    
    
    [results2 close];
    [db close];
    
    
    
    NSDictionary *eSystemInfo = [[NSDictionary alloc] init];
    
    eSystemInfo = @{@"SystemName": SystemName,
                    @"eSystemVersion": eAppVersion};
    
    
    NSDictionary *SubmissionInfo = [[NSDictionary alloc] init];
    
    SubmissionInfo = @{@"CreatedAt": createdDate,
                       @"XMLGeneratedAt": @"",
                       @"BackDate": BackDate,
                       @"Backdating": BackDating,
                       @"SIType": SIType,
                       @"CFFStatus": CFFStatus,
                       };
    
    
    
    
    
    NSMutableArray *AgentInfo = [[NSMutableArray alloc] init];
    NSDictionary *Agentcount = [[NSDictionary alloc] init];
    NSDictionary *Agent1 = [[NSDictionary alloc] init];
    NSMutableDictionary *editable_Agent1 = [[NSMutableDictionary alloc] init];
    NSDictionary *Agent2 = [[NSDictionary alloc] init];
    
    
    
    int agentcount=0;
    
    
    
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    
    
    
    
    
    
    //GET THE FIRST AGENT
    NSString *querySQL3 = [NSString stringWithFormat:@"SELECT AgentCode, AgentContactNumber, Channel, ImmediateLeaderCode, ImmediateLeaderName from Agent_profile"];
    NSString *Channel = @"";
    results = [database executeQuery:querySQL3];
    while ([results next]) {
        agentcount = agentcount+1;
        NSString *count = [NSString stringWithFormat:@"%i", agentcount];
        
        NSString *AgentCode = [results objectForColumnName:@"AgentCode"];
        NSString *AgentContactNo = [results objectForColumnName:@"AgentContactNumber"];
        Channel = [results objectForColumnName:@"Channel"];
        NSString *LeaderCode = [results objectForColumnName:@"ImmediateLeaderCode"];
        NSString *LeaderName = [results objectForColumnName:@"ImmediateLeaderName"];
        
        Agent1 = @{@"Agent ID": count,
                   @"Seq": count,
                   @"AgentCode": AgentCode,
                   @"AgentContactNo": AgentContactNo,
                   @"LeaderCode": LeaderCode,
                   @"LeaderName" : LeaderName,
                   @"BRCode" : @"",
                   @"ISONo" : @"",
                   @"BRClosed" :@"",
                   @"AgentPercentage":@"100"
                   };
        
        
    }
    
    
    
    
    
    //GET THE SECOND AGENT - FROM Policy Details - For Shared Case from Same Direct Unit
    
    querySQL3 = [NSString stringWithFormat:@"SELECT SecondAgentCode, SecondAgentName, SecondAgentContactNo from eProposal WHERE eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]];
    
    results = [database executeQuery:querySQL3];
    
    
    while ([results next]) {
        
        
        NSString *AgentCode = [results stringForColumn:@"SecondAgentCode"];
        NSString *AgentName = [results stringForColumn:@"SecondAgentName"];
        NSString *AgentContactNo = [results stringForColumn:@"SecondAgentContactNo"];
        if([AgentCode isEqualToString:@""]) {
            
            AgentCode=NULL;
        }
        if([AgentName isEqualToString:@""]) {
            
            AgentName=NULL;
        }
        
        if([AgentContactNo isEqualToString:@""]) {
            
            AgentContactNo=NULL;
        }
        if(AgentCode!=NULL && AgentName!=NULL && AgentContactNo!=NULL)
        {
            
            agentcount = agentcount+1;
            NSString *count = [NSString stringWithFormat:@"%i", agentcount];
            Agent2 = @{@"Agent ID": count,
                       @"Seq": count,
                       @"AgentCode": AgentCode,
                       @"AgentName":AgentName,
                       @"AgentContactNo": AgentContactNo,
                       @"LeaderCode": @"",
                       @"LeaderName" : @"",
                       @"BRCode" : @"",
                       @"ISONo" : @"",
                       @"BRClosed" :@"",
                       @"AgentPercentage":@"50"
                       };
        }
        
        
        
        
        
        
        
    }
    [results close];
    [database close];
    
    if(agentcount==2)
    {
        editable_Agent1 = [Agent1 mutableCopy];
        [editable_Agent1 setValue:@"50" forKey:@"AgentPercentage"];
        
        [AgentInfo addObject:editable_Agent1];
        
        [AgentInfo addObject:Agent2];
        
        
    }
    else
    {
        [AgentInfo addObject:Agent1];
        
    }
    
    
    
    
    
    
    
    
    NSDictionary *ChannelInfo = [[NSDictionary alloc] init];
    
    ChannelInfo = @{@"Channel": Channel};
    
    [results close];
    [database close];
    NSString *count = [NSString stringWithFormat:@"%i", agentcount];
    
    Agentcount = @{@"AgentCount": count, };
    
    
    
    [AgentInfo addObject:Agentcount];
    
    
    
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:eSystemInfo forKey:@"eSystemInfo"];
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:SubmissionInfo forKey:@"SubmissionInfo"];
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:ChannelInfo forKey:@"ChannelInfo"];
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:AgentInfo forKey:@"AgentInfo"];
    
    
    
}
-(void) storeXMLData
{
    partyID = 0;
    obj = [DataClass getInstance];
	
	[SecPo_LADetails_ClientNew_Array removeAllObjects];
	NSDictionary *eAppNo = [[NSDictionary alloc]init];
	eAppNo = @{@"eProposalNo":_ProposalNo};
	[SecPo_LADetails_ClientNew_Array addObject:eAppNo];
	
    NSMutableDictionary  *LA1 = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary  *PO = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary  *PY = [[NSMutableDictionary alloc] init];
    NSMutableDictionary  *LArelation = [[NSMutableDictionary alloc] init];
    
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    NSString *pentalhealth1 = @"";
    NSString *pentalhealth2 = @"";
    NSString *pentalhealth3 = @"";
	
	NSString *ResidenceOwnRented;
	NSString *ResidenceAddress1;
	NSString *ResidenceAddress2;
	NSString *ResidenceAddress3;
	NSString *ResidenceAddressTown;
	NSString *ResidenceAddressState;
	NSString *ResidenceAddressPostCode;
	NSString *ResidenceAddressCountry;
	NSString *ResidencePoBox;
	
	NSString *OfficeAddress1;
	NSString *OfficeAddress2;
	NSString *OfficeAddress3;
	NSString *OfficeAddressTown;
	NSString *OfficeAddressState;
	
	NSString *foreign_home_country;
	NSString *foreign_office_country;
	
	NSString *OfficeAddressPostCode;
	NSString *OfficeAddressCountry;
	NSString *OfficePoBox;
	
	NSString *CorrespondenceAddress;
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	FMResultSet *results;
    FMResultSet *resultsforEDD;
    
    NSString *ChildFlag = @"N";
    
	results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
    
	while ([results next]) {
        
        
        
		NSString *FinalPTypeCode = [results stringForColumn:@"PTypeCode"];
        NSString *ProspectTitle = [results stringForColumn:@"LATitle"];
        NSString *ProspectName = [results stringForColumn:@"LAName"];
        NSString *ProspectGender = [results stringForColumn:@"LASex"];
        NSString *ProspectDOB = [results stringForColumn:@"LADOB"];
		NSString *ProspectPlaceOfBirth = [results stringForColumn:@"LABirthCountry"];
		NSString *IDTypeNo = [results stringForColumn:@"LANewICNO"];
        NSString *OtherIDType = [results stringForColumn:@"LAOtherIDType"];
        NSString *OtherIDTypeNo = [results stringForColumn:@"LAOtherID"];
        NSString *MaritalStatus = [results stringForColumn:@"LAMaritalStatus"];
		NSString *PoBox = [results stringForColumn:@"MalaysianWithPOBox"];
        ChildFlag = [results stringForColumn:@"HaveChildren"];
        
        pentalhealth1 =  [results stringForColumn:@"PentalHealthStatus"];
        pentalhealth2 =  [results stringForColumn:@"PentalFemaleStatus"];
        pentalhealth3 =  [results stringForColumn:@"PentalDeclarationStatus"];
        
        if(ChildFlag==NULL || [ChildFlag isEqualToString:@""])
            ChildFlag = @"N";
		
        MaritalStatus = [MaritalStatus stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
        if([MaritalStatus isEqualToString:@"DIVORCED"])
            MaritalStatus = @"D";
        else if([MaritalStatus isEqualToString:@"MARRIED"])
            MaritalStatus = @"M";
        else if([MaritalStatus isEqualToString:@"WIDOWER"])
            MaritalStatus = @"R";
        else if([MaritalStatus isEqualToString:@"SINGLE"])
            MaritalStatus = @"S";
        else if([MaritalStatus isEqualToString:@"WINDOW"])
            MaritalStatus = @"W";
        
        if([MaritalStatus isEqualToString:@"D"] || [MaritalStatus isEqualToString:@"R"] ||[MaritalStatus isEqualToString:@"W"])
            
            ChildFlag=@"N";
        
        else
            
            ChildFlag=@"";
        
        NSString *Race = [results stringForColumn:@"LARace"];
		Race = [Race stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([Race isEqualToString:@"CHINESE"])
            Race = @"C";
        else if([Race isEqualToString:@"INDIAN"])
            Race = @"I";
        else if([Race isEqualToString:@"MALAY"])
            Race = @"M";
        else if([Race isEqualToString:@"OTHERS"])
            Race = @"O";
        
        NSString *OtherIdTypeEdd = [results stringForColumn:@"LAOtherIDType"];
        
        
        NSString *Religion = [results stringForColumn:@"LAReligion"];
        
        if([Religion isEqualToString:@"NON-MUSLIM"])
            Religion = @"REL002";
        else
            Religion = @"REL001";
        
        if ([OtherIdTypeEdd isEqualToString:@"EDD"])
        {
            Religion =@"";
        }
        if ([OtherIDType isEqualToString:@"EDD"])
        {
            resultsforEDD = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ? and PTypeCode = 'PY1' ",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
            while ([resultsforEDD next]) {
                OtherIDTypeNo = [resultsforEDD stringForColumn:@"LANewICNO"];
            }
        }
        
//        if ([OtherIdTypeEdd isEqualToString:@"EDD"] && [FinalPTypeCode isEqualToString:@"LA"])
//        {
//            OtherIDTypeNo = IDTypeNo;
//        }

        
        NSString *Nationality = [results stringForColumn:@"LANationality"];
        Nationality = [Nationality stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        //  eProposal_Nationality
        FMResultSet  *resultNation = [database executeQuery:@"select NationCode from eProposal_Nationality where NationDesc = ?", Nationality, Nil];
        
        while ([resultNation next]) {
            
            NSString *nationcode = [resultNation stringForColumn:@"NationCode"];
            
            Nationality = nationcode;
            
        }
        
        NSString *ProspectOccupationCode = [results stringForColumn:@"LAOccupationCode"];
        NSString *ExactDuties = [results stringForColumn:@"LAExactDuties"];
        NSString *BussinessType = [results stringForColumn:@"LATypeOfBusiness"];
        NSString *LAEmployerName = [results stringForColumn:@"LAEmployerName"];
        NSString *LAYearlyIncome1 = [results stringForColumn:@"LAYearlyIncome"];
        NSString *LAYearlyIncome =[LAYearlyIncome1 stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSString *POFlag = [results stringForColumn:@"POFlag"];
        CorrespondenceAddress = [results stringForColumn:@"CorrespondenceAddress"];
        
        
        if([CorrespondenceAddress isEqualToString:@"(null)"] || (CorrespondenceAddress == NULL) || (CorrespondenceAddress == nil))
            CorrespondenceAddress=@"";
        else{
            if([CorrespondenceAddress isEqualToString:@"residence"])
                CorrespondenceAddress = @"ADR001";
            else if([CorrespondenceAddress isEqualToString:@"office"])
                CorrespondenceAddress = @"ADR003";
            else
                CorrespondenceAddress = @"";
            
        }
        
        
        
        ResidenceOwnRented = [results stringForColumn:@"ResidenceOwnRented"];
        ResidenceAddress1 = [results stringForColumn:@"ResidenceAddress1"];
        ResidenceAddress2 = [results stringForColumn:@"ResidenceAddress2"];
        ResidenceAddress3 = [results stringForColumn:@"ResidenceAddress3"];
        ResidenceAddressTown = [results stringForColumn:@"ResidenceTown"];
        ResidenceAddressState = [results stringForColumn:@"ResidenceState"];
        
        
        
        
        
        if(ResidenceAddressState==NULL)
            ResidenceAddressState=@"";
        else
        {
            
            
            
            FMResultSet  *resultState = [database executeQuery:@"select StateCode from eProposal_State where StateDesc = ?",ResidenceAddressState, Nil];
            
            while ([resultState next]) {
                
                NSString *statecode = [resultState stringForColumn:@"StateCode"];
                
                ResidenceAddressState = statecode;
                
            }
            [resultState close];
            
            
        }
        
        
        ResidenceAddressPostCode = [results stringForColumn:@"ResidencePostcode"];
        ResidenceAddressCountry = [results stringForColumn:@"ResidenceCountry"];
		ResidencePoBox = [results stringForColumn:@"Residence_POBOX"];

        
        
        
        OfficeAddress1 = [results stringForColumn:@"OfficeAddress1"];
        OfficeAddress2 = [results stringForColumn:@"OfficeAddress2"];
        OfficeAddress3 = [results stringForColumn:@"OfficeAddress3"];
        
        OfficeAddressTown = [results stringForColumn:@"OfficeTown"];
        OfficeAddressState = [results stringForColumn:@"OfficeState"];
        
        if([OfficeAddressState isEqualToString:@"(null)"])
            OfficeAddressState = @"";
        
        
        
        
        if(OfficeAddressState==NULL)
            OfficeAddressState=@"";
        else
        {
            
            
            
            FMResultSet  *resultState = [database executeQuery:@"select StateCode from eProposal_State where StateDesc = ?",OfficeAddressState, Nil];
            
            while ([resultState next]) {
                
                NSString *statecode = [resultState stringForColumn:@"StateCode"];
                
                OfficeAddressState = statecode;
                
            }
            [resultState close];
            
            
        }
        
        OfficeAddressPostCode = [results stringForColumn:@"OfficePostcode"];
        
        OfficeAddressCountry = [results stringForColumn:@"OfficeCountry"];
		OfficePoBox = [results stringForColumn:@"Office_POBOX"];

        
        
        if([OfficeAddressCountry isEqualToString:@"(null)"])
            OfficeAddressCountry = @"";
        
        
        NSString *homeNo = [results stringForColumn:@"ResidencePhoneNo"];
        
        NSString *officeNo = [results stringForColumn:@"OfficePhoneNo"];
        
        NSString *faxNo = [results stringForColumn:@"FaxPhoneNo"];
        
        NSString *mobileNo = [results stringForColumn:@"MobilePhoneNo"];
        
        NSString *ProspectEmail = [results stringForColumn:@"EmailAddress"];
        NSString *contactcodeEmail = @"";
        if (![ProspectEmail isEqualToString:@""]){
            contactcodeEmail = @"CONT011";}
        
        NSString *homeNoPrefix = [results stringForColumn:@"ResidencePhoneNoPrefix"];
        
        NSString *officeNoPrefix = [results stringForColumn:@"OfficePhoneNoPrefix"];
        
        NSString *faxNoPrefix = [results stringForColumn:@"FaxPhoneNoPrefix"];
        
        NSString *mobileNoPrefix = [results stringForColumn:@"MobilePhoneNoPrefix"];
        
        NSString *LARelationship = [results stringForColumn:@"LARelationship"];
        
        
        
        FMResultSet  *resultRelationship = [database executeQuery:@"select RelCode from eProposal_Relation where RelDesc = ?",LARelationship, Nil];
        
        while ([resultRelationship next]) {
            
            NSString *relationship = [resultRelationship stringForColumn:@"RelCode"];
            
            LARelationship = relationship;
            
        }
        
        NSString *GST_registered = [results stringForColumn:@"GST_registered"];
        NSString *GST_registrationNo = [results stringForColumn:@"GST_registrationNo"];
        NSString *GST_registrationDate = [results stringForColumn:@"GST_registrationDate"];
        NSString *GST_exempted = [results stringForColumn:@"GST_exempted"];
        
        if([GST_registered isEqualToString:@"(null)"] || ((NSNull *) GST_registered == [NSNull null]) || [GST_registered isEqualToString:@"null"])
            GST_registered = @"";
        if([GST_registrationNo isEqualToString:@"(null)"] || ((NSNull *) GST_registrationNo == [NSNull null]) || [GST_registrationNo isEqualToString:@"null"])
            GST_registrationNo = @"";
        if([GST_registrationDate isEqualToString:@"(null)"] || ((NSNull *) GST_registrationDate == [NSNull null]) || [GST_registrationDate isEqualToString:@"null"])
            GST_registrationDate = @"";
        if([GST_exempted isEqualToString:@"(null)"] || ((NSNull *) GST_exempted == [NSNull null]) || [GST_exempted isEqualToString:@"null"])
            GST_exempted = @"";
        
        if(GST_registered == nil ||[ GST_registered isEqualToString:@"<nil>"]){
            GST_registered = @"";
        }
        if(GST_registrationNo == nil ||[ GST_registrationNo isEqualToString:@"<nil>"]){
            GST_registrationNo = @"";
        }
        if(GST_registrationDate == nil ||[ GST_registrationDate isEqualToString:@"<nil>"]){
            GST_registrationDate = @"";
        }
        if(GST_exempted == nil ||[ GST_exempted isEqualToString:@"<nil>"]){
            GST_exempted = @"";
        }
        
        NSString *contactcodeHome = @"";
        NSString *contactcodeOffice = @"";
        NSString *contactcodeMobile = @"";
        NSString *contactcodeFax = @"";
        
        
        NSString *HOME = [NSString stringWithFormat:@"%@%@", homeNoPrefix,homeNo];
        if (![HOME isEqualToString:@""]){
            contactcodeHome = @"CONT006";}
        NSString *OFFICE = [NSString stringWithFormat:@"%@%@", officeNoPrefix,officeNo];
        if (![OFFICE isEqualToString:@""]){
            contactcodeOffice = @"CONT007";}
        NSString *MOBILE = [NSString stringWithFormat:@"%@%@", mobileNoPrefix,mobileNo];
        if (![MOBILE isEqualToString:@""]){
            contactcodeMobile = @"CONT008";}
        NSString *FAX = [NSString stringWithFormat:@"%@%@", faxNoPrefix,faxNo];
        if (![FAX isEqualToString:@""]){
            contactcodeFax = @"CONT009";}
        
        
        //        NSString *HOME = [NSString stringWithFormat:@"%@%@", homeNoPrefix,homeNo];
        //        NSString *OFFICE = [NSString stringWithFormat:@"%@%@", officeNoPrefix,officeNo];
        //        NSString *MOBILE = [NSString stringWithFormat:@"%@%@", mobileNoPrefix,mobileNo];
        //        NSString *FAX = [NSString stringWithFormat:@"%@%@", faxNoPrefix,faxNo];
        
        
        
        
        if([OfficeAddressCountry isEqualToString:@"MAL"] || [OfficeAddressCountry isEqualToString:@""])
            foreign_office_country = @"N";
        else
            foreign_office_country = @"Y";
        
        
        if([ResidenceAddressCountry isEqualToString:@"MAL"] || [ResidenceAddressCountry isEqualToString:@""])
            foreign_home_country = @"N";
        else
            foreign_home_country = @"Y";
        
        //EXTRACT THE CHARACTER FROM STRING
        
        NSMutableArray *list = [NSMutableArray array];
        for (int i=0; i<FinalPTypeCode.length; i++) {
            [list addObject:[FinalPTypeCode substringWithRange:NSMakeRange(i, 1)]];
        }
        
        if([list[0] isEqualToString:@"L"] && [list[1] isEqualToString:@"A"])
            FinalPTypeCode = @"LA";
        else if([list[0] isEqualToString:@"P"] && [list[1] isEqualToString:@"Y"])
            FinalPTypeCode = @"PY";
        
        
        //DEFINE GENDER
        NSMutableArray *gender = [NSMutableArray array];
        for (int i=0; i<ProspectGender.length; i++) {
            [gender addObject:[ProspectGender substringWithRange:NSMakeRange(i, 1)]];
        }
        
        
        if(ProspectGender.length!=0)
        {
            
            if([gender[0] isEqualToString:@"F"])
                ProspectGender = @"F";
            else
                ProspectGender = @"M";
        }
        else
        {
            ProspectGender = @"";
        }
        
     
      

        NSString *DeclarationAuth = @"";
        NSString *ClientChoice = @"";
        
        FMResultSet  *result_DeclarationAuth = [database executeQuery:@"select ClientChoice, DeclarationAuthorization from eProposal where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
        
        while ([result_DeclarationAuth next]) {
            
            DeclarationAuth = [result_DeclarationAuth stringForColumn:@"DeclarationAuthorization"];
            ClientChoice = [result_DeclarationAuth stringForColumn:@"ClientChoice"];
            
            
            
        }
        if(DeclarationAuth==NULL)
            DeclarationAuth = @"";
        
        if(ClientChoice==NULL)
            ClientChoice=@"";
        
    
        
        partyID = partyID+1;
        NSString *partyid = [NSString stringWithFormat:@"%i", partyID];
        
        NSString *PTypeCode = [NSString stringWithFormat:@"LA%i", partyID];
        
        // Added by Andy Phan for retrieving Title Code - START
        NSString *ProspectTitleCode = @"";
        
        FMResultSet  *resultTitleCode = [database executeQuery:@"select TitleCode from eProposal_Title where TitleDesc = ?",ProspectTitle, Nil];
        
        while ([resultTitleCode next]) {
            
            NSString *ProspectTitleCode = [resultTitleCode stringForColumn:@"TitleCode"];
            ProspectTitle = ProspectTitleCode;
            
        }
        [resultTitleCode close];
        
       // NSLog(ProspectTitle);
        
        // Added by Andy Phan for retrieving Title Code - END
        
        NSString *PYChange = @"N";
        if([partyid isEqualToString:@"2"] && [FinalPTypeCode isEqualToString:@"PY"]){
            FinalPTypeCode=@"LA";
            PYChange =@"Y";
        }
        
        
        
        SecPo_LADetails_ClientNew = [[NSDictionary alloc] init];
        
        NSString *LATitle1 = ProspectTitle;
        NSString *LASex1 = ProspectGender;
        if ([LATitle1 isEqualToString:@"DT"] && [LASex1 isEqualToString:@"F"]) {
            LATitle1 = @"DT (FEMALE)";
        }
        // PTypeCode = LA/PO
        // Check for company case
        if (![OtherIDType isEqualToString:@"CR"]) {
            
			
		//ADD BY EMI, LA2 = PO, SKIP LA2 if PO dont's have coverage (Rider) 07/10/2014
			//NSLog(@"seq: %@, ptcode: %@, final: %@ , SINo: %@", partyid, PTypeCode, FinalPTypeCode, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
			if([PTypeCode isEqualToString:@"LA2"] || ([partyid isEqualToString:@"2"] && [FinalPTypeCode isEqualToString:@"LA"]))
			{
				BOOL LA2HasRider = FALSE;
				FMResultSet  *resultCheckRider = [database executeQuery:@"select PTypeCode, Seq from Trad_Rider_Details where SINO = ? ",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
				
				while ([resultCheckRider next]) {
					//NSLog(@"ENS CHECK RIDER");
					NSString * PTypeCode = [resultCheckRider stringForColumn:@"PTypeCode"];
					NSString *Seq = [resultCheckRider stringForColumn:@"Seq"];
					if (([PTypeCode isEqualToString:@"LA"] && [Seq isEqualToString:@"2"]) || [PTypeCode isEqualToString:@"PY"])
						LA2HasRider = TRUE;
				}
				[resultCheckRider close];
				
				if (!LA2HasRider){
					//NSLog(@"LA2 no coverage, skip");
					goto skip_LA2;
				}
			}
			
			if ([ProspectPlaceOfBirth isEqualToString:@""] || (ProspectPlaceOfBirth == NULL) || ([ProspectPlaceOfBirth isEqualToString:@"(null)"]) || ([ProspectPlaceOfBirth isEqualToString:@"(NULL)"]) || ([ProspectPlaceOfBirth isEqualToString:@"- SELECT -"]) || ([ProspectPlaceOfBirth isEqualToString:@"- Select -"]))
			{
				ProspectPlaceOfBirth =@"";
			}
			
			
			
			if ([PoBox isEqualToString:@""] || (PoBox == NULL) || ([PoBox isEqualToString:@"(null)"]) || ([PoBox isEqualToString:@"(NULL)"]) || ([PoBox isEqualToString:@"- SELECT -"]) || ([PoBox isEqualToString:@"- Select -"]))
			{
				PoBox =@"N";
			}
			
			if ([ResidencePoBox isEqualToString:@""] || (ResidencePoBox == NULL) || ([ResidencePoBox isEqualToString:@"(null)"]) || ([ResidencePoBox isEqualToString:@"(NULL)"]) || ([ResidencePoBox isEqualToString:@"- SELECT -"]) || ([ResidencePoBox isEqualToString:@"- Select -"]) || ResidencePoBox == nil)
			{
				ResidencePoBox =@"";
			}
			
			if ([OfficePoBox isEqualToString:@""] || (OfficePoBox == NULL) || ([OfficePoBox isEqualToString:@"(null)"]) || ([OfficePoBox isEqualToString:@"(NULL)"]) || ([OfficePoBox isEqualToString:@"- SELECT -"]) || ([OfficePoBox isEqualToString:@"- Select -"]) || OfficePoBox == nil)
			{
				OfficePoBox =@"";
			}
			
			
						      
        SecPo_LADetails_ClientNew = @{@"Party ID":partyid,
                                      @"PTypeCode":FinalPTypeCode,
                                      @"Seq":partyid,
                                      @"DeclarationAuth":[DeclarationAuth isEqualToString:@"Y"] ? @"True" : @"False",
                                      @"ClientChoice":ClientChoice,
                                      @"LATitle":LATitle1,
                                      @"LAName":ProspectName,
                                      @"LASex":ProspectGender,
                                      @"LADOB":ProspectDOB,
									  @"LABirthCountry":ProspectPlaceOfBirth,
                                      @"AgeAdmitted":@"No",
                                      @"LAMaritalStatus":MaritalStatus,
                                      @"LARace":Race,
                                      @"LAReligion":Religion,
                                      @"LANationality":Nationality,
                                      @"LAOccupationCode":ProspectOccupationCode,
                                      @"LAExactDuties":ExactDuties,
                                      @"LATypeOfBusiness":BussinessType,
                                      @"LAEmployerName":LAEmployerName,
                                      @"LAYearlyIncome":LAYearlyIncome,
                                      @"LARelationship":LARelationship,
                                      @"ChildFlag":ChildFlag,
                                      @"ResidenceOwnRented":ResidenceOwnRented,
									  @"MalaysianWithPOBox":PoBox,
                                      @"CorrespondenceAddress":CorrespondenceAddress,
                                      @"LANewIC":
                                          @{@"LANewICCode" : @"NRIC", @"LANewICNo" : IDTypeNo},
                                      @"LAOtherID":
                                          @{@"LAOtherIDType" : OtherIDType, @"LAOtherID" : OtherIDTypeNo},
                                      
                                      @"Addresses":@{@"Residence" :  @{@"AddressCode" : @"ADR001",
                                                                       @"Address1" :ResidenceAddress1,
                                                                       @"Address2" :ResidenceAddress2,
                                                                       @"Address3" :ResidenceAddress3,
                                                                       @"Town" :ResidenceAddressTown,
                                                                       @"State" :ResidenceAddressState,
                                                                       @"Postcode" :ResidenceAddressPostCode,
                                                                       @"Country" :ResidenceAddressCountry,
																	   @"PoBox" :ResidencePoBox,
                                                                       @"ForeignAddress" :foreign_home_country,},
                                                     
                                                     @"Office" :  @{@"AddressCode" : @"ADR003",
                                                                    @"Address1" : OfficeAddress1,
                                                                    @"Address2" : OfficeAddress2,
                                                                    @"Address3" : OfficeAddress3,
                                                                    @"Town" : OfficeAddressTown,
                                                                    @"State" :OfficeAddressState,
                                                                    @"Postcode" :OfficeAddressPostCode,
                                                                    @"Country" :OfficeAddressCountry,
																	@"PoBox" :OfficePoBox,
                                                                    @"ForeignAddress" :foreign_office_country}
                                                     },
                                      @"Contacts":@{
                                              @"Residence": @{@"ContactCode": contactcodeHome, @"ContactNo":HOME},
                                              @"Office": @{@"ContactCode": contactcodeOffice, @"ContactNo":OFFICE},
                                              @"Mobile": @{@"ContactCode": contactcodeMobile, @"ContactNo":MOBILE},
                                              @"Email": @{@"ContactCode": contactcodeEmail, @"ContactNo":ProspectEmail},
                                              @"Fax": @{@"ContactCode": contactcodeFax, @"ContactNo":FAX}},
                                      //                                              @"Residence": @{@"ContactCode": @"CONT006", @"ContactNo":HOME},
                                      //                                              @"Office": @{@"ContactCode": @"CONT007", @"ContactNo":OFFICE},
                                      //                                              @"Mobile": @{@"ContactCode": @"CONT008", @"ContactNo":MOBILE},
                                      //                                              @"Email": @{@"ContactCode": @"CONT011", @"ContactNo":ProspectEmail},
                                      //                                              @"Fax": @{@"ContactCode": @"CONT009", @"ContactNo":FAX}},
                                      
                                      @"PentalHealthDetails":@{
                                              @"PentalHealth1": @{@"Code": @"MDTAUW01", @"Status":pentalhealth1},
                                              @"PentalHealth2": @{@"Code": @"MDTAUW02", @"Status":pentalhealth2},
                                              @"PentalHealth3": @{@"Code": @"MDTAUW03", @"Status":pentalhealth3},
                                              },
                                      @"LAGST":
                                          @{@"GSTRegPerson" : GST_registered,
                                            @"GSTRegNo" : GST_registrationNo,
                                            @"GSTRegDate" : GST_registrationDate,
                                            @"GSTExempted" : GST_exempted
                                            }
                                      
                                      };
        
        [SecPo_LADetails_ClientNew_Array addObject:SecPo_LADetails_ClientNew];
        // NSLog(@"check if not skip.. ptypecode: %@, final %@, partyid: %@", PTypeCode, FinalPTypeCode, partyid);
        }
        
        if([PYChange isEqualToString:@"Y"]){
            FinalPTypeCode=@"PY";
            PYChange =@"N";
        }
        
        
        if([PTypeCode isEqualToString:@"LA1"])
        {
            LA1 = [SecPo_LADetails_ClientNew mutableCopy];
            
        }
        
	skip_LA2:
		
        if([POFlag isEqualToString:@"Y"])
        {
            
            // Added by Andy Phan for retrieving Title Code - START
            NSString *ProspectTitleCode = @"";
            
            FMResultSet  *resultTitleCode = [database executeQuery:@"select TitleCode from eProposal_Title where TitleDesc = ?",ProspectTitle, Nil];
            
            while ([resultTitleCode next]) {
                
                NSString *ProspectTitleCode = [resultTitleCode stringForColumn:@"TitleCode"];
                ProspectTitle = ProspectTitleCode;
                
            }
            [resultTitleCode close];
            
          //  NSLog(ProspectTitle);
            
            // Added by Andy Phan for retrieving Title Code - END
            
            SecPo_LADetails_ClientNew = [[NSDictionary alloc] init];
			
		
			
            NSString *LATitle1 = ProspectTitle;
            NSString *LASex1 = ProspectGender;
            if ([LATitle1 isEqualToString:@"DT"] && [LASex1 isEqualToString:@"F"]) {
                LATitle1 = @"DT (FEMALE)";
            }
			
            
            NSString *stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            FMResultSet *resultsXML = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
//            NSString *cardMemberAccountNo;
//            cardMemberAccountNo = [resultsXML stringForColumn:@"CardMemberAccountNo"] != NULL ? [resultsXML stringForColumn:@"CardMemberAccountNo"] : @"";
//          
////            if([cardMemberAccountNo isEqualToString:@""])
////            {
////                LARelationship=@"";
////            }
            
            // Check is company case
            if ([OtherIDType isEqualToString:@"CR"]) {
                Religion = @"";
                pentalhealth1 = @"False";
                pentalhealth2 = @"False";
                pentalhealth3 = @"True";
                
            }
			
			if ([PoBox isEqualToString:@""] || (PoBox == NULL) || ([PoBox isEqualToString:@"(null)"]) || ([PoBox isEqualToString:@"(NULL)"]) || ([PoBox isEqualToString:@"- SELECT -"]) || ([PoBox isEqualToString:@"- Select -"]))
			{
				PoBox =@"N";
			}
			
			if ([ResidencePoBox isEqualToString:@""] || (ResidencePoBox == NULL) || ([ResidencePoBox isEqualToString:@"(null)"]) || ([ResidencePoBox isEqualToString:@"(NULL)"]) || ([ResidencePoBox isEqualToString:@"- SELECT -"]) || ([ResidencePoBox isEqualToString:@"- Select -"]) || ResidencePoBox == nil)
			{
				ResidencePoBox =@"";
			}
			
			if ([OfficePoBox isEqualToString:@""] || (OfficePoBox == NULL) || ([OfficePoBox isEqualToString:@"(null)"]) || ([OfficePoBox isEqualToString:@"(NULL)"]) || ([OfficePoBox isEqualToString:@"- SELECT -"]) || ([OfficePoBox isEqualToString:@"- Select -"]) || OfficePoBox == nil)
			{
				OfficePoBox =@"";
			}
            
            SecPo_LADetails_ClientNew = @{@"Party ID":partyid,
                                          @"PTypeCode":@"PO",
                                          @"Seq":@"1",
                                          @"DeclarationAuth":[DeclarationAuth isEqualToString:@"Y"] ? @"True" : @"False",
                                          @"ClientChoice":ClientChoice,
                                          @"LATitle":LATitle1,
                                          @"LAName":ProspectName,
                                          @"LASex":ProspectGender,
                                          @"LADOB":ProspectDOB,
										  @"LABirthCountry":ProspectPlaceOfBirth,
                                          @"AgeAdmitted":@"No",
                                          @"LAMaritalStatus":MaritalStatus,
                                          @"LARace":Race,
                                          @"LAReligion":Religion,
                                          @"LANationality":Nationality,
                                          @"LAOccupationCode":ProspectOccupationCode,
                                          @"LAExactDuties":ExactDuties,
                                          @"LATypeOfBusiness":BussinessType,
                                          @"LAEmployerName":LAEmployerName,
                                          @"LAYearlyIncome":LAYearlyIncome,
                                          @"LARelationship":LARelationship,
                                          @"ChildFlag":ChildFlag,
                                          @"ResidenceOwnRented":ResidenceOwnRented,
                                          @"CorrespondenceAddress":CorrespondenceAddress,
										  @"MalaysianWithPOBox":PoBox,
                                          @"LANewIC":
                                              @{@"LANewICCode" : @"NRIC", @"LANewICNo" : IDTypeNo},
                                          @"LAOtherID":
                                              @{@"LAOtherIDType" : OtherIDType, @"LAOtherID" : OtherIDTypeNo},
                                          
                                          @"Addresses":@{@"Residence" :  @{@"AddressCode" : @"ADR001",
                                                                           @"Address1" :ResidenceAddress1,
                                                                           @"Address2" :ResidenceAddress2,
                                                                           @"Address3" :ResidenceAddress3,
                                                                           @"Town" :ResidenceAddressTown,
                                                                           @"State" :ResidenceAddressState,
                                                                           @"Postcode" :ResidenceAddressPostCode,
                                                                           @"Country" :ResidenceAddressCountry,
																		   @"PoBox" :ResidencePoBox,
                                                                           @"ForeignAddress" :foreign_home_country,},
                                                         
                                                         @"Office" :  @{@"AddressCode" : @"ADR003",
                                                                        @"Address1" : OfficeAddress1,
                                                                        @"Address2" : OfficeAddress2,
                                                                        @"Address3" : OfficeAddress3,
                                                                        @"Town" : OfficeAddressTown,
                                                                        @"State" :OfficeAddressState,
                                                                        @"Postcode" :OfficeAddressPostCode,
                                                                        @"Country" :OfficeAddressCountry,
																		@"PoBox" :OfficePoBox,
																		@"ForeignAddress" :foreign_office_country}
                                                         },
                                          @"Contacts":@{
                                                  @"Residence": @{@"ContactCode": contactcodeHome, @"ContactNo":HOME},
                                                  @"Office": @{@"ContactCode": contactcodeOffice, @"ContactNo":OFFICE},
                                                  @"Mobile": @{@"ContactCode": contactcodeMobile, @"ContactNo":MOBILE},
                                                  @"Email": @{@"ContactCode": contactcodeEmail, @"ContactNo":ProspectEmail},
                                                  @"Fax": @{@"ContactCode": contactcodeFax, @"ContactNo":FAX}},
                                          //                                                  @"Residence": @{@"ContactCode": @"CONT006", @"ContactNo":HOME},
                                          //                                                  @"Office": @{@"ContactCode": @"CONT007", @"ContactNo":OFFICE},
                                          //                                                  @"Mobile": @{@"ContactCode": @"CONT008", @"ContactNo":MOBILE},
                                          //                                                  @"Email": @{@"ContactCode": @"CONT011", @"ContactNo":ProspectEmail},
                                          //                                                  @"Fax": @{@"ContactCode": @"CONT009", @"ContactNo":FAX}},
                                          
                                          @"PentalHealthDetails":@{
                                                  @"PentalHealth1": @{@"Code": @"MDTAUW01", @"Status":pentalhealth1},
                                                  @"PentalHealth2": @{@"Code": @"MDTAUW02", @"Status":pentalhealth2},
                                                  @"PentalHealth3": @{@"Code": @"MDTAUW03", @"Status":pentalhealth3},                                              },
                                          @"LAGST":
                                              @{@"GSTRegPerson" : GST_registered,
                                                @"GSTRegNo" : GST_registrationNo,
                                                @"GSTRegDate" : GST_registrationDate,
                                                @"GSTExempted" : GST_exempted
                                                }
                                          
                                          };
            PO = [SecPo_LADetails_ClientNew mutableCopy];
            PY = [PO mutableCopy];
        }
        
        
	}
 
//skip_LA2:
	
    partyID = partyID+1;
    NSString *partyid = [NSString stringWithFormat:@"%i", partyID];
    
    [PO setValue:partyid forKey:@"Party ID"];
    [SecPo_LADetails_ClientNew_Array addObject:PO];
    
    
    
    //INSERT THE PY RECORD
    //  FMResultSet *results2;
	results = [database executeQuery:@"select * from eProposal where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
    NSString *RecurringPayment =@"";
    NSString *ProspectTitle = @"";
    NSString *ProspectName = @"";
    NSString *ProspectGender = @"";
    NSString *ProspectDOB = @"";
	
    
    NSString *IC = @"";
    
    NSString *OtherIDType = @"";
    
    NSString *OtherIDTypeNo = @"";
    
    NSString *LARelationship = @"";
    
    NSString *MOBILE = @"";
    
    NSString *PTypeCode = @"";
    NSString *ClientChoice = @"";
    NSString *DeclarationAuth = @"";
    
    
    partyID = partyID+1;
    partyid = [NSString stringWithFormat:@"%i", partyID];
    while ([results next]) {
        
        RecurringPayment = [results stringForColumn:@"RecurringPayment"];
        ProspectName = [results stringForColumn:@"CardMemberName"];
        ProspectGender = [results stringForColumn:@"CardMemberSex"];
        
        ProspectDOB = [results stringForColumn:@"CardMemberDOB"];
        
        IC = [results stringForColumn:@"CardMemberNewICNo"];
        
        OtherIDType = [results stringForColumn:@"CardMemberOtherIDType"];
        
        OtherIDTypeNo = [results stringForColumn:@"CardMemberOtherID"];
        
        MOBILE = [results stringForColumn:@"CardMemberContactNo"];
        MOBILE = [MOBILE stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *contactcodeMobile = @"";
        if (![MOBILE isEqualToString:@""]){
            contactcodeMobile = @"CONT008";}
        
        LARelationship = [results stringForColumn:@"CardMemberRelationship"];
        
        FMResultSet  *resultRelationship = [database executeQuery:@"select RelCode from eProposal_Relation where RelDesc = ?",LARelationship, Nil];
        
        while ([resultRelationship next]) {
            
            NSString *relationship = [resultRelationship stringForColumn:@"RelCode"];
            
            LARelationship = relationship;
            
        }
        
        NSString *GST_registered = [results stringForColumn:@"GST_registered"];
        NSString *GST_registrationNo = [results stringForColumn:@"GST_registrationNo"];
        NSString *GST_registrationDate = [results stringForColumn:@"GST_registrationDate"];
        NSString *GST_exempted = [results stringForColumn:@"GST_exempted"];
        
        
        if([GST_registered isEqualToString:@"(null)"] || ((NSNull *) GST_registered == [NSNull null]) || [GST_registered isEqualToString:@"null"])
            GST_registered = @"";
        if([GST_registrationNo isEqualToString:@"(null)"] || ((NSNull *) GST_registrationNo == [NSNull null]) || [GST_registrationNo isEqualToString:@"null"])
            GST_registrationNo = @"";
        if([GST_registrationDate isEqualToString:@"(null)"] || ((NSNull *) GST_registrationDate == [NSNull null]) || [GST_registrationDate isEqualToString:@"null"])
            GST_registrationDate = @"";
        if([GST_exempted isEqualToString:@"(null)"] || ((NSNull *) GST_exempted == [NSNull null]) || [GST_exempted isEqualToString:@"null"])
            GST_exempted = @"";
        
        if(GST_registered == nil ||[ GST_registered isEqualToString:@"<nil>"]){
            GST_registered = @"";
        }
        if(GST_registrationNo == nil ||[ GST_registrationNo isEqualToString:@"<nil>"]){
            GST_registrationNo = @"";
        }
        if(GST_registrationDate == nil ||[ GST_registrationDate isEqualToString:@"<nil>"]){
            GST_registrationDate = @"";
        }
        if(GST_exempted == nil ||[ GST_exempted isEqualToString:@"<nil>"]){
            GST_exempted = @"";
        }
        
        PTypeCode = [results stringForColumn:@"PTypeCode"];
        
        ClientChoice = [results stringForColumn:@"ClientChoice"];
        
        DeclarationAuth = [results stringForColumn:@"DeclarationAuthorization"];
        
        if(DeclarationAuth==NULL)
            DeclarationAuth = @"";
        
        if(ClientChoice==NULL)
            ClientChoice=@"";
        
        if(OtherIDType==NULL)
            OtherIDType=@"";
        
        if(OtherIDTypeNo==NULL)
            OtherIDTypeNo=@"";
        
        if(RecurringPayment==NULL)
            RecurringPayment = @"";
        
        if([RecurringPayment isEqualToString:@"05"])
        {
            
            
            if([PTypeCode isEqualToString:@"1st Life Assured"])
            {
                
                [LA1 setValue:partyid forKey:@"Party ID"];
                [LA1 setValue:partyid forKey:@"Seq"];
                [LA1 setValue:@"PY" forKey:@"PTypeCode"];
                
                
                
                [SecPo_LADetails_ClientNew_Array addObject:LA1];
                
                
                
            }
            else
            {
                
                NSString *partyid = [NSString stringWithFormat:@"%i", partyID];
                
                // Added by Andy Phan for retrieving Title Code - START
                NSString *ProspectTitleCode = @"";
                
                FMResultSet  *resultTitleCode = [database executeQuery:@"select TitleCode from eProposal_Title where TitleDesc = ?",ProspectTitle, Nil];
                
                while ([resultTitleCode next]) {
                    
                    NSString *ProspectTitleCode = [resultTitleCode stringForColumn:@"TitleCode"];
                    ProspectTitle = ProspectTitleCode;
                    
                }
                [resultTitleCode close];
                
              //  NSLog(ProspectTitle);
                
                // Added by Andy Phan for retrieving Title Code - END
                
                SecPo_LADetails_ClientNew = [[NSDictionary alloc] init];
                NSString *LATitle1 = ProspectTitle;
                NSString *LASex1 = ProspectGender;
                if ([LATitle1 isEqualToString:@"DT"] && [LASex1 isEqualToString:@"F"]) {
                    LATitle1 = @"DT (FEMALE)";
                }
//                NSString *cardMemberAccountNo;
//                cardMemberAccountNo = [results stringForColumn:@"CardMemberAccountNo"] != NULL ? [results stringForColumn:@"CardMemberAccountNo"] : @"";
//                NSString *PTypeCode = @"";
//                if([cardMemberAccountNo isEqualToString:@""])
//                {
//                    LARelationship=@"";
//                }
				
				
                
                SecPo_LADetails_ClientNew = @{@"Party ID":partyid,
                                              @"PTypeCode":@"PY",
                                              @"Seq":@"1",
                                              @"DeclarationAuth":[DeclarationAuth isEqualToString:@"Y"] ? @"True" : @"False",
                                              @"ClientChoice":ClientChoice,
                                              @"LATitle":LATitle1,
                                              @"LAName":ProspectName,
                                              @"LASex":ProspectGender,
                                              @"LADOB":ProspectDOB,
                                              @"AgeAdmitted":@"No",
                                              @"LAMaritalStatus":@"",
                                              @"LARace":@"",
                                              @"LAReligion":@"",
                                              @"LANationality":@"",
                                              @"LAOccupationCode":@"",
                                              @"LAExactDuties":@"",
                                              @"LATypeOfBusiness":@"",
                                              @"LAEmployerName":@"",
                                              @"LAYearlyIncome":@"",
                                              @"LARelationship":LARelationship,
                                              @"ChildFlag":ChildFlag,
                                              @"ResidenceOwnRented":@"",
                                              @"CorrespondenceAddress":CorrespondenceAddress,
											  @"MalaysianWithPOBox":@"",
                                              @"LANewIC":
                                                  @{@"LANewICCode" : @"NRIC", @"LANewICNo" : IC},
                                              @"LAOtherID":
                                                  @{@"LAOtherIDType" : OtherIDType, @"LAOtherID" : OtherIDTypeNo},
                                              
                                              @"Addresses":@{@"Residence" :  @{@"AddressCode" : @"ADR001",
																			   @"Address1" :ResidenceAddress1,
																			   @"Address2" :ResidenceAddress2,
																			   @"Address3" :ResidenceAddress3,
																			   @"Town" :ResidenceAddressTown,
																			   @"State" :ResidenceAddressState,
																			   @"Postcode" :ResidenceAddressPostCode,
																			   @"Country" :ResidenceAddressCountry,
																			   @"PoBox" :@"",
																			   @"ForeignAddress" :foreign_home_country,},
                                                             
                                                             @"Office" :  @{@"AddressCode" : @"ADR003",
																			@"Address1" : OfficeAddress1,
																			@"Address2" : OfficeAddress2,
																			@"Address3" : OfficeAddress3,
																			@"Town" : OfficeAddressTown,
																			@"State" :OfficeAddressState,
																			@"Postcode" :OfficeAddressPostCode,
																			@"Country" :OfficeAddressCountry,
																			@"PoBox" :@"",
																			@"ForeignAddress" :foreign_office_country}
                                                             },
                                              @"Contacts":@{
                                                      @"Residence": @{@"ContactCode": @"", @"ContactNo":@""},
                                                      @"Office": @{@"ContactCode": @"", @"ContactNo":@""},
                                                      @"Mobile": @{@"ContactCode": contactcodeMobile, @"ContactNo":MOBILE},
                                                      @"Email": @{@"ContactCode": @"", @"ContactNo":@""},
                                                      @"Fax": @{@"ContactCode": @"", @"ContactNo":@""}},
                                              
                                              @"PentalHealthDetails":@{
                                                      @"PentalHealth1": @{@"Code": @"MDTAUW01", @"Status":pentalhealth1},
                                                      @"PentalHealth2": @{@"Code": @"MDTAUW02", @"Status":pentalhealth2},
                                                      @"PentalHealth3": @{@"Code": @"MDTAUW03", @"Status":pentalhealth3},                                              },
                                              @"LAGST":
                                                  @{@"GSTRegPerson" : GST_registered,
                                                    @"GSTRegNo" : GST_registrationNo,
                                                    @"GSTRegDate" : GST_registrationDate,
                                                    @"GSTExempted" : GST_exempted
                                                    }
                                              
                                              };
                
                [SecPo_LADetails_ClientNew_Array addObject:SecPo_LADetails_ClientNew];
                
                
            }
            
        }
        
        else //PY always same as PO if there is no credit card payer
        {
            
            
            
            [PY setValue:partyid forKey:@"Party ID"];
            
            [PY setValue:@"PY" forKey:@"PTypeCode"];
            [PY setValue:@"" forKey:@"LARelationship"];
             [SecPo_LADetails_ClientNew_Array addObject:PY];
            //[LARelationship setValue:@"" forkey:@"LARelationship"];
//            [LArelation setValue:partyid forKey:@"Party ID"];
//            [LArelation setValue:@"" forKey:@"LARelationship"];
           
           // [SecPo_LADetails_ClientNew_Array addObject:LArelation];
        }
        
        
    }
    
    
    [results close];
    
    [database close];
    
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
    
    if([siplan isEqualToString:@"HLACP"] || [siplan isEqualToString:@"L100"] || [siplan isEqualToString:@"HLAWP"])
        
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
    
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
//    UIViewController *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"eSub"];
//    vc.modalTransitionStyle = UIModalPresentationFullScreen;//UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:vc animated:YES completion:NULL];
}

-(NSString*) getCountryDesc : (NSString*)country passdb:(FMDatabase*)db
{
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
        
        [db open];
    }
    FMResultSet *result = [db executeQuery:@"SELECT CountryDesc FROM eProposal_Country WHERE CountryCode = ?", country];
    
    while ([result next]) {
        code =[result objectForColumnName:@"CountryDesc"];
        
    }
    
    [result close];
    // [db close];
    
    return code;
    
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
