//
//  eAppsListing.m
//  iMobile Planner
//
//  Created by shawal sapuan on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eAppsListing.h"
#import "ColorHexCode.h"
#import "MainScreen.h"
#import "AppDelegate.h"
#import "SIMenuViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
#import "EditProspect.h"
#import "DataClass.h"
#import "ProspectListing.h"
#import "EverSeriesMasterViewController.h"
#import "CustomAlertBox.h"

@interface eAppsListing (){
    DataClass *obj;
    int partyID;
}

@end

@implementation eAppsListing
@synthesize SILabel,dateLabel,idTypeLabel,idNoLabel,nameLabel,planLabel;
@synthesize EditProspect = _EditProspect;
@synthesize myTableView,SINO,DateCreated,Name,PlanName,BasicSA,SIStatus,CustomerCode,popoverController,IdentifactionNo, QQFlag, PPIndexNo,SIStatus_Check,SIVersion_Check;
@synthesize DBDateSearch;
@synthesize outletDateSearch;
@synthesize SIDate = _SIDate;
@synthesize SIDatePopover = _SIDatePopover;

- (void)viewDidLoad
{
    [super viewDidLoad];
    partyID=0;
    obj=[DataClass getInstance];
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
     
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorColor = [UIColor clearColor];
    
    [self getSys_SI_Version];
    
    [self LoadAllResult];

    isSearching = NO;
    
    
  
}

- (void)LoadAllResult
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
    [database open];
    SecPo_LADetails = [[NSMutableArray alloc] init ];
    temp_clients_array = [[NSMutableArray alloc] init ];
    sqlite3_stmt *statement;
    sqlite3_stmt *statement2;
    const char *dbpath = [databasePath UTF8String];
    BOOL QQ = false;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
        
        
        //GET ALL SI FROM TRADITIONAL & EVERSERIES
        NSString *SIListingSQL = [NSString stringWithFormat:@"select A.Sino, createdAT, name, planname, basicSA, 'Not Created', A.CustCode,  E.IDTypeNo, E.OtherIDTypeNo, E.QQFlag, E.IndexNo, B.SIVersion, B.SIStatus , E.OtherIDType , E.ProspectDOB from trad_lapayor as A, trad_details as B, clt_profile as C, trad_sys_profile as D , prospect_profile as E where A.sino = B.sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Sequence = 1 AND A.ptypeCode = \"LA\"   AND E.IndexNo = c.indexNo AND E.QQFlag = 'false' UNION select A.Sino, B.DateCreated, name, planname, basicSA, 'Not Created', A.CustCode ,  E.IDTypeNo, E.OtherIDTypeNo, E.QQFlag, E.IndexNo, B.SIVersion, B.SIStatus , E.OtherIDType , E.ProspectDOB from UL_lapayor as A, UL_details as B, clt_profile as C, trad_sys_profile as D , prospect_profile as E where A.sino = B.sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Seq = 1 AND A.ptypeCode = \"LA\" AND E.IndexNo = c.indexNo AND E.QQFlag = 'false' order by B.DateCreated DESC"];
        
        
        NSLog(@"%@", SIListingSQL);
        
        
        if(sqlite3_prepare_v2(contactDB, [SIListingSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            
            
            
            SINO = [[NSMutableArray alloc] init ];
            DateCreated = [[NSMutableArray alloc] init ];
            Name = [[NSMutableArray alloc] init ];
            PlanName = [[NSMutableArray alloc] init ];
            BasicSA = [[NSMutableArray alloc] init ];
            SIStatus = [[NSMutableArray alloc] init ];
            CustomerCode = [[NSMutableArray alloc] init ];
            IdentifactionNo = [[NSMutableArray alloc] init];
            QQFlag = [[NSMutableArray alloc] init];
            PPIndexNo = [[NSMutableArray alloc] init];
            SIStatus_Check = [[NSMutableArray alloc] init];
            SIVersion_Check = [[NSMutableArray alloc] init];
            
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *SINumber = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *ItemDateCreated = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *ItemName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *ItemPlanName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *ItemBasicSA = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                NSString *ItemStatus = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                NSString *ItemCustomerCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                NSString *ItemIdentificationNo; //**E
                if (sqlite3_column_text(statement, 7) != NULL) {
                    ItemIdentificationNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                    if ([ItemIdentificationNo isEqualToString:@""]) {
                        ItemIdentificationNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                    }
                    else {
                        NSString *TempID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                        if (![ItemIdentificationNo isEqualToString:@""] && ![TempID isEqualToString:@""]) {
                            
                            ItemIdentificationNo = [NSString stringWithFormat:@"%@\n%@", ItemIdentificationNo, TempID];
                        }
                    }
                }
                else {
                    if (sqlite3_column_text(statement, 7) != NULL) {
                        ItemIdentificationNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                    }
                    else {
                        ItemIdentificationNo = @"";
                    }
                }
				 NSString *otherIDtype = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 13)];
				
				if ([otherIDtype isEqualToString:@"EDD"]) {
					ItemIdentificationNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 14)];
				}
				
                
                NSString *STR_QQFlag = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
                
                NSString *STR_PPIndexNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)];
                
                
                char *char_version = (char *) sqlite3_column_text(statement, 11);
                NSString *SIversion_check = char_version ? [[NSString alloc] initWithUTF8String:char_version] : nil;
                
                char *char_status = (char *) sqlite3_column_text(statement, 12);
                NSString *SIstatus_check = char_status ? [[NSString alloc] initWithUTF8String:char_status] : nil;
                
                
                NSString *SIListingSQL2;
                
                
                //EVER SERIES
                if([ItemPlanName isEqualToString:@"HLA EverLife Plus"] || [ItemPlanName isEqualToString:@"HLA EverGain Plus"])
                {
                    SIListingSQL2 = [NSString stringWithFormat:@"select A.SINo, C.CustCode, B.QQFlag, B.ProspectName  from UL_LAPayor AS A, prospect_profile AS B , Clt_Profile AS C where A.SINo = '%@'  AND A.CustCode = C.CustCode AND C.indexNo = B.IndexNo",SINumber];
                }
                else //TRADITIONAL
                {
                    SIListingSQL2 = [NSString stringWithFormat:@"select A.SINo, C.CustCode, B.QQFlag, B.ProspectName  from TRAD_LAPayor AS A, prospect_profile AS B , Clt_Profile AS C where A.SINo = '%@'  AND A.CustCode = C.CustCode AND C.indexNo = B.IndexNo",SINumber];
                }
                if(sqlite3_prepare_v2(contactDB, [SIListingSQL2 UTF8String], -1, &statement2, NULL) == SQLITE_OK) {
                    
                    while (sqlite3_step(statement2) == SQLITE_ROW){
                        
                        
                        NSString *LA_qqflag = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement2, 2)];
                        
                        if([LA_qqflag isEqualToString:@"true"])
                        {
                            QQ = true;
                        }
                        
                    }
                }
                sqlite3_finalize(statement2);
                
                
                
                if(QQ == false)
                {
                    NSString *plancode;
                    
                    NSLog(@"===%@===",ItemPlanName);
                    
                    if([ItemPlanName isEqualToString:@"HLA EverLife Plus"])
                        plancode = @"UV";
                    
                    else if([ItemPlanName isEqualToString:@"HLA EverGain Plus"])
                        plancode = @"UP";
                    else if([ItemPlanName isEqualToString:@"Life100"])
                        plancode = @"L100";
                    else if([ItemPlanName isEqualToString:@"HLA Wealth Plan"])
                        plancode = @"HLAWP";
					else if([ItemPlanName isEqualToString:@"Secure100"])
                        plancode = @"S100";
                    else 
                        plancode = @"HLACP";
					
					
					
                    FMResultSet *results = [database executeQuery:@"select eProposalNo from eProposal where SINo = ? AND BasicPlanCode = ?", SINumber, plancode];
                    // FMResultSet *results = [database executeQuery:@"select eProposalNo from eProposal where SINo = ?", SINumber];
                    NSString *proposal=@"";
                    while([results next]) {
                        
                        proposal = [results objectForColumnIndex:0];
                        
                    }
                    if (proposal.length==0)
                    {
                        [SINO addObject:SINumber];
                        [DateCreated addObject:ItemDateCreated ];
                        [Name addObject:ItemName ];
                        [PlanName addObject:ItemPlanName ];
                        [BasicSA addObject:ItemBasicSA ];
                        [SIStatus addObject:ItemStatus];
                        [CustomerCode addObject:ItemCustomerCode];
                        [IdentifactionNo addObject:ItemIdentificationNo];
                        [QQFlag addObject:STR_QQFlag];
                        [PPIndexNo addObject:STR_PPIndexNo];
                        [SIVersion_Check addObject:SIversion_check == NULL ? @"" :SIversion_check];
                        [SIStatus_Check addObject:SIstatus_check == NULL ? @"" :SIstatus_check];
                        
                    }
                    
                }
                
                QQ = false;
                SINumber = Nil;
                ItemDateCreated = Nil;
                ItemName = Nil;
                ItemPlanName = Nil;
                ItemBasicSA = Nil;
                ItemStatus = Nil;
                ItemCustomerCode = Nil;
                ItemIdentificationNo = Nil;
            }
            
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
        
        SIListingSQL = Nil;
        
    }
    statement = Nil;
    dbpath = Nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	if (textField == _DATETF) {
//		_itsRightBarButton.title  = @"Done";
//		_itsRightBarButton.style = UIBarButtonItemStyleDone;
//		_itsRightBarButton.target = self;
//		_itsRightBarButton.action = @selector(doneAction:);
//		
//		_itsDatePicker = [[UIDatePicker alloc] init];
//        _itsDatePicker.datePickerMode = UIDatePickerModeDate;
//        [_itsDatePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
//        //datePicker.tag = indexPath.row;
//        textField.inputView = _itsDatePicker;
//		[self resignFirstResponder];
		NSLog(@"edit date");
		[self.view endEditing:YES];
	
		UIViewController* popoverContent = [[UIViewController alloc] init]; //ViewController
	
		UIView *popoverView = [[UIView alloc] init];   //view
		popoverView.backgroundColor = [UIColor blackColor];
	
		_itsDatePicker=[[UIDatePicker alloc]init];//Date picker
//	_itsDatePicker.frame=CGRectMake(510,137,300, 210);
		_itsDatePicker.frame=CGRectMake(0,0,300, 210);
		_itsDatePicker.datePickerMode = UIDatePickerModeDate;
		[_itsDatePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
		[popoverView addSubview:_itsDatePicker];
	
		popoverContent.view = popoverView;
		popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
		popoverController.delegate=self;
	
		[popoverController setPopoverContentSize:CGSizeMake(300, 210)];
		NSLog(@"self.view: %@", self.view);
		[popoverController presentPopoverFromRect:textField.rightView.frame inView:self.popView permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self.view endEditing:YES];
    
    return YES;
}

- (IBAction)dateValueChanged:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	[dateFormatter setDateFormat:@"dd-MM-yyyy"];
    _DATETF.text = [dateFormatter stringFromDate:[_itsDatePicker date]];
}

- (IBAction)doneAction:(id)sender {
//	[_itsDatePicker resignFirstResponder];
}

- (IBAction)testDBSearch:(id)sender {

	
    if ([_SINOTF.text length] == 0 && [_NAMETF.text length] == 0 && [_PLANTF.text length] == 0 && [outletDateSearch.titleLabel.text isEqualToString:@"-Select-"] && [_IDNOTF.text length] == 0){
        
       
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
    else
    {
	isSearching = YES;

	FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
	[database open];
	
	_SINOSearch = [[NSMutableArray alloc] init];
	_NameSearch = [[NSMutableArray alloc] init];
	_PlanNameSearch = [[NSMutableArray alloc] init];
	_DateCreatedSearch = [[NSMutableArray alloc] init];
    _IdentificationNoSearch = [[NSMutableArray alloc] init];
	 SIVersion_Check = [[NSMutableArray alloc] init];
		//**E
		
		//NSString *search_sino = [NSString stringWithFormat:@"%%%@%%", _SINOTF.text];
		//NSString *search_name = [NSString stringWithFormat:@"%%%@%%", _NAMETF.text];
		//NSString *search_plan = [NSString stringWithFormat:@"%%%@%%", _PLANTF.text];
		//NSString *search_ic = [NSString stringWithFormat:@"%%%@%%", _IDNOTF.text];
		
		
		//NSString *search_datecreated = [NSString stringWithFormat:@"'%%%@%%'", _DATETF.text];
		
		//FMResultSet *results = [database executeQuery:@"select A.Sino, createdAT, name, planname, basicSA, 'Not Created', A.CustCode,  E.IDTypeNo, E.QQFlag, E.IndexNo, B.SIVersion, B.SIStatus from trad_lapayor as A, trad_details as B, clt_profile as C, trad_sys_profile as D , prospect_profile as E where A.Sino = B.Sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Sequence = 1 AND A.ptypeCode = \"LA\"   AND E.IndexNo = c.indexNo AND E.QQFlag = 'false' and name like ? and A.Sino like ? and planname like ? AND E.IDTypeNo like ? UNION select A.Sino, B.DateCreated, name, planname, basicSA, 'Not Created', A.CustCode ,  E.IDTypeNo, E.QQFlag, E.IndexNo, B.SIVersion, B.SIStatus from UL_lapayor as A, UL_details as B, clt_profile as C, trad_sys_profile as D , prospect_profile as E where A.Sino = B.Sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Seq = 1 AND A.ptypeCode = \"LA\" AND E.IndexNo = c.indexNo AND E.QQFlag = 'false' and name like ? and A.Sino like ? and planname like ? AND E.IDTypeNo like ?",search_name, search_sino, search_plan, search_ic,search_name, search_sino, search_plan,search_ic];
		
		
		NSString *querySQL, *querySQL2;
		
		querySQL = @"Select A.Sino, createdAT, name, planname, basicSA, 'Not Created', A.CustCode,  E.IDTypeNo, E.OtherIDTypeNo, E.QQFlag, E.IndexNo, B.SIVersion, B.SIStatus from trad_lapayor as A, trad_details as B, clt_profile as C, trad_sys_profile as D , prospect_profile as E where A.Sino = B.Sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Sequence = 1 AND A.ptypeCode = \"LA\"   AND E.IndexNo = c.indexNo AND E.QQFlag = 'false' ";
		
		querySQL2 = @"UNION select A.Sino, B.DateCreated, name, planname, basicSA, 'Not Created', A.CustCode ,  E.IDTypeNo, E.OtherIDTypeNo, E.QQFlag, E.IndexNo, B.SIVersion, B.SIStatus from UL_lapayor as A, UL_details as B, clt_profile as C, trad_sys_profile as D , prospect_profile as E where A.Sino = B.Sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Seq = 1 AND A.ptypeCode = \"LA\" AND E.IndexNo = c.indexNo AND E.QQFlag = 'false' ";
        
        
		
		//NSLog(@"Before DBDateSearch: %@", DBDateSearch);
		
		if ([DBDateSearch isEqualToString: @""]) {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"yyyy-MM-dd"];
			NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
			
			DBDateSearch = dateStr;
			NSLog(@"After DBDateSearch: %@", DBDateSearch);
		}
		
		
		if (![_NAMETF.text isEqualToString:@""]) {
			querySQL = [querySQL stringByAppendingFormat:@" and name like \"%%%@%%\" ", _NAMETF.text ];
		}
		if (![_SINOTF.text isEqualToString:@""]) {
			querySQL = [querySQL stringByAppendingFormat:@" and A.Sino like \"%%%@%%\" ", _SINOTF.text ];
		}
		if (![_PLANTF.text isEqualToString:@""]) {
			querySQL = [querySQL stringByAppendingFormat:@" and planname like \"%%%@%%\" ", _PLANTF.text ];
		}
		if (![outletDateSearch.titleLabel.text isEqualToString:@"-Select-"]){
			querySQL = [querySQL stringByAppendingFormat:@" and createdAT > \"%@ 00:00:00\" AND createdAT < \"%@ 23:59:59\" ", DBDateSearch, DBDateSearch];
		}
		if (![_IDNOTF.text isEqualToString:@""]) {
			querySQL = [querySQL stringByAppendingFormat:@" and (E.IDTypeNo like \"%%%@%%\" or E.OtherIDTypeNo like \"%%%@%%\") ", _IDNOTF.text, _IDNOTF.text];
		}
		
		querySQL = [querySQL stringByAppendingFormat: @" %@ ", querySQL2];
		
		if (![_NAMETF.text isEqualToString:@""]) {
			querySQL = [querySQL stringByAppendingFormat:@" and name like \"%%%@%%\" ", _NAMETF.text ];
		}
		if (![_SINOTF.text isEqualToString:@""]) {
			querySQL = [querySQL stringByAppendingFormat:@" and A.Sino like \"%%%@%%\" ", _SINOTF.text ];
		}
		if (![_PLANTF.text isEqualToString:@""]) {
			querySQL = [querySQL stringByAppendingFormat:@" and planname like \"%%%@%%\" ", _PLANTF.text ];
		}
		if (![outletDateSearch.titleLabel.text isEqualToString:@"-Select-"]){
			querySQL = [querySQL stringByAppendingFormat:@" and B.DateCreated > \"%@ 00:00:00\" AND B.DateCreated < \"%@ 23:59:59\" ", DBDateSearch, DBDateSearch];
		}
		if (![_IDNOTF.text isEqualToString:@""]) {
			querySQL = [querySQL stringByAppendingFormat:@" and (E.IDTypeNo like \"%%%@%%\" or E.OtherIDTypeNo like \"%%%@%%\") ", _IDNOTF.text, _IDNOTF.text];
		}
		
		querySQL = [querySQL stringByAppendingFormat:@" order by B.DateCreated DESC"];
					
	 		FMResultSet *results = [database executeQuery: querySQL];
		NSLog(@"EAPPLISTING_QUERY: %@", querySQL);
		int count_result = 0;
        
		while([results next]) {
            
            count_result=count_result+1;
			NSString *sino = [results stringForColumn:@"A.Sino"];
			NSString *name = [results stringForColumn:@"name"];
			NSString *IC = [results stringForColumn:@"E.IDTypeNo"];
            NSString *siversion_check = [results stringForColumn:@"B.SIVersion"];
			if ([IC isEqualToString:@""]) {
				IC = [results stringForColumn:@"E.OtherIDTypeNo"];
			}
			else {
			NSString *OtherID = [results stringForColumn:@"E.OtherIDTypeNo"];
				if (![IC isEqualToString:@""] && ![OtherID isEqualToString:@""]) {
					IC = [NSString stringWithFormat:@"%@\n%@", IC, OtherID];
				}
			}
			
			
			NSString *planname = [results stringForColumn:@"planname"];
			NSString *datecreated = [results stringForColumn:@"createdAT"];
			
		 
			
			[_SINOSearch addObject:sino];
			[_NameSearch addObject:name];
			[_IdentificationNoSearch addObject:IC];
			[_PlanNameSearch addObject:planname];
			[_DateCreatedSearch addObject:datecreated];
            [SIVersion_Check addObject:siversion_check == NULL ? @"" :siversion_check];
			
		}
        
        if(count_result == 0 )
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message:@"No record found"
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil, nil];
            
            
            [alert setTag:500];
            [alert show];
            alert = Nil;
        }
        
        
		[database close];
		[myTableView reloadData];
		[self hideKeyboard];
    }
}

//**E
- (IBAction)btnDateSearch:(id)sender {
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    //DOBLbl.text = dateString;
	//DOBLbl.textColor = [UIColor blackColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
    
    if (_SIDate == Nil) {
        
        self.SIDate = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIDate"];
        _SIDate.delegate = self;
        self.SIDatePopover = [[UIPopoverController alloc] initWithContentViewController:_SIDate];
    }
    
    [self.SIDatePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.SIDatePopover presentPopoverFromRect:[sender bounds ]  inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
    
    dateFormatter = Nil;
    dateString = Nil, mainStoryboard = nil;
	
}

-(void)DateSelected:(NSString *)strDate:(NSString *)dbDate{
    
        [outletDateSearch setTitle:strDate forState:UIControlStateNormal];
        DBDateSearch = dbDate;
 
	
}

-(void)CloseWindow{
    [self.SIDatePopover dismissPopoverAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (isSearching) {
		return [_SINOSearch count];
	}
    return [SINO count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    
    [[cell.contentView viewWithTag:1001] removeFromSuperview ];
    [[cell.contentView viewWithTag:1002] removeFromSuperview ];
    [[cell.contentView viewWithTag:1003] removeFromSuperview ];
    [[cell.contentView viewWithTag:1004] removeFromSuperview ];
    [[cell.contentView viewWithTag:1005] removeFromSuperview ];
    [[cell.contentView viewWithTag:1006] removeFromSuperview ];
	[[cell.contentView viewWithTag:1007] removeFromSuperview ];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
    str_SIVersion = [SIVersion_Check objectAtIndex:indexPath.row];
  
	//    CGRect frame=CGRectMake(0,0, 137, 50);
	CGRect frame=CGRectMake(20,0, 180, 50);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
	label1.backgroundColor = [UIColor clearColor];
    label1.tag = 1001;
	label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    label1.textAlignment = UITextAlignmentLeft;
    [cell.contentView addSubview:label1];
	
	//	CGRect frame2=CGRectMake(137,0, 163, 50);
	CGRect frame2=CGRectMake(175,0, 80, 50);
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
	label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = UITextAlignmentLeft;
    label2.tag = 1002;
	label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	[cell.contentView addSubview:label2];
	
	CGRect frame3=CGRectMake(250,0, 190, 50);
    UILabel *label3=[[UILabel alloc]init];
    label3.frame=frame3;
	label3.backgroundColor = [UIColor clearColor];
    label3.textAlignment = UITextAlignmentCenter;
    label3.tag = 1003;
	label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label3];
	
	//	CGRect frame4=CGRectMake(628,0, 219, 50);
	CGRect frame4=CGRectMake(440,0, 230, 50);
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=frame4;
	label4.backgroundColor = [UIColor clearColor];
    label4.tag = 1004;
	label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	label1.textAlignment = UITextAlignmentLeft;
    [cell.contentView addSubview:label4];
    
	//    CGRect frame5=CGRectMake(495,0, 135, 50);
	CGRect frame5=CGRectMake(670,0, 140, 50);
    UILabel *label5=[[UILabel alloc]init];
    label5.frame=frame5;
	label5.backgroundColor = [UIColor clearColor];
    label5.textAlignment = UITextAlignmentLeft;
    label5.tag = 1005;
	label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
	label5.textAlignment = UITextAlignmentCenter;
	[label5 setNumberOfLines:2];  //**E
    [cell.contentView addSubview:label5];
	
	//    CGRect frame6=CGRectMake(847,0, 10, 50);
	CGRect frame6=CGRectMake(810,0, 190, 50);
    UILabel *label6=[[UILabel alloc]init];
    label6.frame=frame6;
	label6.backgroundColor = [UIColor clearColor];
    label6.textAlignment = UITextAlignmentLeft;
    label6.tag = 1006;
	label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label6];
	
	 
	 	
    if (isSearching) {
		label1.text = [_SINOSearch objectAtIndex:indexPath.row];
		label2.text= str_SIVersion;
        label2.textAlignment =  UITextAlignmentLeft;
 		label3.text= [_DateCreatedSearch objectAtIndex:indexPath.row];
		label4.text = [_NameSearch objectAtIndex:indexPath.row];;
	    label5.text= [_IdentificationNoSearch objectAtIndex:indexPath.row];
		label6.text= [_PlanNameSearch objectAtIndex:indexPath.row];;
	}
	else {
		label1.text= [SINO objectAtIndex:indexPath.row];
		label2.text= str_SIVersion;
        label2.textAlignment =  UITextAlignmentLeft;
		label3.text= [DateCreated objectAtIndex:indexPath.row];
		label4.text = [Name objectAtIndex:indexPath.row];
	    label5.text= [IdentifactionNo objectAtIndex:indexPath.row];
		label6.text= [PlanName objectAtIndex:indexPath.row];
        
        
	}
	    
	cell.contentView.frame = CGRectMake(0, 0, 1024, 50);
    if (indexPath.row % 2 == 0) {
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
	}
    else {
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
	}
    
    
    //Hightligh red - SI Version is not updated
    
    
    CGRect frame7=CGRectMake(980,15, 30, 25);
    UIButton *btn = [[UIButton alloc]initWithFrame:frame7];
    
    
    if(![str_SIVersion isEqualToString:str_Sys_SI_Version])
    {
         
        UIImage *doneImage = [UIImage imageNamed: @"viewSI.png"];
        doneImage =   [self convertOriginalImageToBWImage:doneImage];
        [btn setBackgroundImage:doneImage forState:UIControlStateNormal];
      
        btn.tag = 1007;
        btn.enabled = FALSE;
        [cell.contentView addSubview:btn];
        
        
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"e98294"];
         
    }
    else{
        
        
        UIImage *doneImage = [UIImage imageNamed: @"viewSI.png"];
        
        [btn setBackgroundImage:doneImage forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectSI:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1007;
        [cell.contentView addSubview:btn];

    }
  
    
     
    
    
    return cell;
    CustomColor = Nil;
}


-(UIImage *)convertOriginalImageToBWImage:(UIImage *)originalImage
{
    UIImage *newImage;
    
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, originalImage.size.width * originalImage.scale, originalImage.size.height * originalImage.scale, 8, originalImage.size.width * originalImage.scale, colorSapce, kCGImageAlphaNone);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, originalImage.size.width, originalImage.size.height), [originalImage CGImage]);
    
    CGImageRef bwImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSapce);
    
    UIImage *resultImage = [UIImage imageWithCGImage:bwImage];
    CGImageRelease(bwImage);
    
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, originalImage.scale);
    [resultImage drawInRect:CGRectMake(0.0, 0.0, originalImage.size.width, originalImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return newImage;
}

#pragma mark - Table view delegate

-(void) getSys_SI_Version
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    database2 = [FMDatabase databaseWithPath:path];
    [database2 open];
    [database2 beginTransaction];
      
   NSString *querySQL = [NSString stringWithFormat:@"select SIVersion, MAX(SILastUpdated) from  Trad_Sys_SI_Version_Details" ];
    FMResultSet *results =  [database2 executeQuery:querySQL];
    
    while ([results next]) {
        
        str_Sys_SI_Version = [results objectForColumnIndex:0];

    }
    
    [database2 commit];
    [database2 close];

}
-(void) select_eproposal_LA_details
{
   
  
    NSString *PTypeCode = @"";
    NSString *Sequence = @"";
    NSString *custcode =@"";
    NSString *custname =@"";
    NSString *indexNo =@"";
     NSString *ic = @"";
     NSString *IndexNo = @"";
    NSString *otheridno =@"";
    NSString *querySQL = @"";
    
      SecPo_LADetails_ClientNew_Array = [[NSMutableArray alloc]init]; //for XML DATA
    
    
      SecPo_LADetails_Client = [NSMutableDictionary dictionary];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    database2 = [FMDatabase databaseWithPath:path];
    [database2 open];
    
    // FMResultSet *results;
    [database2 beginTransaction];
    NSString* si = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    
    
    if([_SIPlanSelected.text isEqualToString:@"HLA EverLife Plus"] || [_SIPlanSelected.text isEqualToString:@"HLA EverGain Plus"] )
        
         querySQL = [NSString stringWithFormat:@"select A.SINo, A.CustCode, A.PTypeCode, A.Seq, B.indexNo, B.Name, C.IDTypeNo, C.IndexNo, C.OtherIDTypeNo from ul_lapayor as A, Clt_Profile as B, prospect_profile as C where A.SINO = '%@' and A.CustCode = B.CustCode AND C.IndexNo = B.indexNo",si ];
    else
        
         querySQL = [NSString stringWithFormat:@"select A.SINo, A.CustCode, A.PTypeCode, A.Sequence, B.indexNo, B.Name, C.IDTypeNo, C.IndexNo, C.OtherIDTypeNo from trad_lapayor as A, Clt_Profile as B, prospect_profile as C where A.SINO = '%@' and A.CustCode = B.CustCode AND C.IndexNo = B.indexNo",si ];
    
   
    NSLog(@"%@", querySQL);
    
   FMResultSet *results =  [database2 executeQuery:querySQL];
    
       while ([results next]) {
           
           custcode = [results objectForColumnIndex:1];
           PTypeCode = [results objectForColumnIndex:2];
           Sequence = [results objectForColumnIndex:3];
           indexNo = [results objectForColumnIndex:4];
           custname = [results objectForColumnIndex:5];
            ic = [results objectForColumnIndex:6];
            IndexNo = [results objectForColumnIndex:7];
            otheridno = [results objectForColumnIndex:8];
           
           
           
           [[obj.eAppData objectForKey:@"SecPO"]  setValue:si forKey:@"SINumber"];
           [[obj.eAppData objectForKey:@"SecPO"]  setValue:custcode forKey:@"CustCode"];
           [[obj.eAppData objectForKey:@"SecPO"]  setValue:custname forKey:@"CustName"];
           
           NSString *Final_PTypeCode = [[NSString alloc] initWithFormat:@"%@%@",PTypeCode,Sequence];
           
           if([Final_PTypeCode isEqualToString:@"PY1"])
               isPY1 = TRUE;
           else if([Final_PTypeCode isEqualToString:@"LA2"])
               isLA2 = TRUE;
           
           
           temp_clients_dic = [NSMutableDictionary dictionary];
           [temp_clients_dic setValue:Final_PTypeCode forKey:@"PTypeCode"];
           [temp_clients_dic setValue:indexNo forKey:@"indexNo"];
           [temp_clients_dic setValue:custname forKey:@"custname"];
           [temp_clients_dic setValue:custcode forKey:@"custcode"];

            [temp_clients_array addObject:temp_clients_dic];
           
       
          }
   
    BOOL payor = false;
    for(NSMutableDictionary *dic in temp_clients_array)
    {
        
        
        NSString *pcode = [dic objectForKey:@"PTypeCode"];
        NSString *index = [dic objectForKey:@"indexNo"];
        NSString *custname = [dic objectForKey:@"custname"];
        NSString *custcode = [dic objectForKey:@"custcode"];
       
        
        if([pcode isEqualToString:@"PY1"])
        {
             
            [self insert_eproposal_LA_details:pcode index:index POFlag:@"Y" Custcode:custcode];
           
            [self insert_eApp_Listing:pcode IC:ic POFlag:@"Y" POName:custname CustCode:custcode IndexNo:index Otheridno:otheridno];
        }
        else if([pcode isEqualToString:@"LA2"] && isLA2 == FALSE)
        {
            
            [self insert_eproposal_LA_details:pcode index:index POFlag:@"N" Custcode:custcode];
        }
        else if([pcode isEqualToString:@"LA2"] && isLA2 == TRUE)
        {
           
             
            
             if([_SIPlanSelected.text isEqualToString:@"HLA EverLife Plus"] || [_SIPlanSelected.text isEqualToString:@"HLA EverGain Plus"])
             {
                 // FOR Ever Series - Set Name & IC to '' by default - user able to choose either LA1 or LA2 to be PO
                 [self insert_eproposal_LA_details:pcode index:index POFlag:@"N" Custcode:custcode];
                 [self insert_eApp_Listing:pcode IC:@"" POFlag:@"N" POName:@"" CustCode:custcode IndexNo:index Otheridno:otheridno];
             }
             else
             {
                 //FOR Traditional - SET LA2 TO Policy Owner by default
                 [self insert_eproposal_LA_details:pcode index:index POFlag:@"Y" Custcode:custcode];
                 [self insert_eApp_Listing:pcode IC:ic POFlag:@"Y" POName:custname CustCode:custcode IndexNo:index Otheridno:otheridno];
             }
        }
        else
        {
           // NSLog(@"isPY1 - %i", isPY1);
            
            if([pcode isEqualToString:@"LA1"] && isLA2 == TRUE)
                //TO Differentiate LA1 got NEW PO || LA1 got LA2
                [[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"AddNewPO"];
            
            else if([pcode isEqualToString:@"LA1"] && isPY1 == TRUE)
            {
                 [[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"AddNewPO"];//SET DEFAULT TO N
             
                
            }
            else
                 [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"AddNewPO"];
            
            [self insert_eproposal_LA_details:pcode index:index POFlag:@"N" Custcode:custcode];
            
            if(isPY1==FALSE && isLA2 == FALSE && [pcode isEqualToString:@"LA1"])// LA1 & NEW PO - DEFAULT VALUE '' FOR IC & NAME
                 [self insert_eApp_Listing:pcode IC:@"" POFlag:@"N" POName:@"" CustCode:custcode IndexNo:index Otheridno:otheridno];
        }
        [SecPo_LADetails addObject:SecPo_LADetails_Client];
        //array add dictionary!
    }
    
    [database2 commit];
    [database2 close];

  
      
    
    [[obj.eAppData objectForKey:@"SecPO"] setValue:SecPo_LADetails forKey:@"LADetails"];
    
     
  }

-(void) insert_eApp_Listing:(NSString*)FinalPTypeCode IC:(NSString*)ic POFlag:(NSString*)poflag POName:(NSString*)poname CustCode:(NSString*)custcode IndexNo:(NSString*)indexno Otheridno:(NSString*)otheridno
{
    NSString *ProspectID;
    
    NSString *querySQL = [NSString stringWithFormat:@"select IndexNo from prospect_profile where ProspectName = '%@'", poname];
    FMResultSet *results =  [database2 executeQuery:querySQL];
    while ([results next]) {
		ProspectID = [results objectForColumnIndex:0];
    }

  
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    
     
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr = [dateFormatter2 stringFromDate:[NSDate date]];
    
    //2 - Created
    NSLog(@"Profile id: %@, poname: %@", ProspectID, poname);
	NSString *querySQL3;
	if (ProspectID == NULL) {
		NSString *propectname = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"];
		NSString *querySQL = [NSString stringWithFormat:@"select IndexNo from prospect_profile where ProspectName = '%@'", propectname];
		FMResultSet *results =  [database2 executeQuery:querySQL];
		while ([results next]) {
			ProspectID = [results objectForColumnIndex:0];
		}
		
	}
	
//       querySQL3 = [NSString stringWithFormat:@"INSERT INTO eApp_Listing (ClientProfileID, POName, IDNumber, ProposalNo, DateCreated, Status, OtherIDNo) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\" ) ",ProspectID, poname, ic, eProposalNo,dateStr, @"2",otheridno];
	
	//ENS NOTE: Policy Owner still not set, lets Poname empty before save policy owner, only save clientProfile so can be view in eApp_listing
	querySQL3 = [NSString stringWithFormat:@"INSERT INTO eApp_Listing (ClientProfileID, POName, IDNumber, ProposalNo, DateCreated, Status, OtherIDNo) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\" ) ",ProspectID,@"",@"", eProposalNo,dateStr, @"2",@""];
    
    
        [database2 executeUpdate:querySQL3];
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:otheridno forKey:@"POOtherIDTypeNo"];
   
    
}
	
-(void) insert_eproposal_LA_details:(NSString*)FinalPTypeCode index:(NSString*)indexNo POFlag:(NSString*)poflag Custcode:(NSString*)custcode
{
     obj=[DataClass getInstance];
    sqlite3_stmt *statement;
     SecPo_LADetails_Client = [NSMutableDictionary dictionary];
   //  SecPo_LADetails_ClientNew = [NSMutableDictionary dictionary];
    
   
    
   FMResultSet *results;
          
        //KY PULL THE CLIENT INFO FROM prospect_profile table
        NSString *querySQL3 = [NSString stringWithFormat:@"SELECT * from prospect_profile where IndexNo = '%@'",indexNo];
 
    
        const char *query_stmt3 = [querySQL3 UTF8String];
         results = [database2 executeQuery:querySQL3];
    while ([results next]) {
                      
        NSString *ProspectID = [results objectForColumnIndex:0];
        
      
        NSString *NickName = [results objectForColumnIndex:1];
        if  ((NSNull *) NickName == [NSNull null])
              NickName = @"";

        
        NSString *ProspectName = [results objectForColumnIndex:2];
        if  ((NSNull *) ProspectName == [NSNull null])
            ProspectName = @"";
        
        NSString *ProspectDOB = [results objectForColumnIndex:3];
        
        if  ((NSNull *) ProspectDOB == [NSNull null])
            ProspectDOB = @"";
        
            ProspectDOB =  [ProspectDOB stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

        
        NSString *ProspectGender = [results objectForColumnIndex:4];
        if  ((NSNull *) ProspectGender == [NSNull null])
            ProspectGender = @"";
		
		if ([ProspectGender isEqualToString:@"MALE"]) {
			ProspectGender = @"M";
		}
		else if ([ProspectGender isEqualToString:@"FEMALE"]) {
			ProspectGender = @"F";
		}
        
        NSString *ResidenceAddress1 = [results objectForColumnIndex:5];
        if  ((NSNull *) ResidenceAddress1 == [NSNull null])
            ResidenceAddress1 = @"";
        
        
        NSString *ResidenceAddress2 = [results objectForColumnIndex:6];
        if  ((NSNull *) ResidenceAddress2 == [NSNull null])
            ResidenceAddress2 = @"";
        
        
        NSString *ResidenceAddress3 = [results objectForColumnIndex:7];
        if  ((NSNull *) ResidenceAddress3 == [NSNull null])
            ResidenceAddress3 = @"";
        
       
        NSString *ResidenceAddressTown = [results objectForColumnIndex:8];
        if  ((NSNull *) ResidenceAddressTown == [NSNull null])
            ResidenceAddressTown = @"";
        
 
        NSString *ResidenceAddressState = [results objectForColumnIndex:9];
        if  ((NSNull *) ResidenceAddressState == [NSNull null] || [ResidenceAddressState isEqualToString:@"(null)"])
            ResidenceAddressState = @"";
        
 
        NSString *ResidenceAddressPostCode = [results objectForColumnIndex:10];
        if  ((NSNull *) ResidenceAddressPostCode == [NSNull null])
            ResidenceAddressPostCode = @"";
        
   
        NSString *ResidenceAddressCountry = @"";
                ResidenceAddressCountry =   [results stringForColumnIndex:11];
                if  ((NSNull *) ResidenceAddressCountry == [NSNull null] || [ResidenceAddressCountry isEqualToString:@"(null)"] || (ResidenceAddressCountry == nil) || (ResidenceAddressCountry == NULL) || [ResidenceAddressCountry isEqualToString:@""])

            ResidenceAddressCountry = @"";
        
  
        NSString *OfficeAddress1 =[results objectForColumnIndex:12];
        if  ((NSNull *) OfficeAddress1 == [NSNull null])
            OfficeAddress1 = @"";
        
  
        NSString *OfficeAddress2 =[results objectForColumnIndex:13];
        if  ((NSNull *) OfficeAddress2 == [NSNull null])
            OfficeAddress2 = @"";
        
   
        NSString *OfficeAddress3 = [results objectForColumnIndex:14];
        if  ((NSNull *) OfficeAddress3 == [NSNull null])
            OfficeAddress3 = @"";
        
    
        NSString *OfficeAddressTown = [results objectForColumnIndex:15];
        if  ((NSNull *) OfficeAddressTown == [NSNull null])
            OfficeAddressTown = @"";
        
    
        NSString *OfficeAddressState = [results objectForColumnIndex:16];
        if  ((NSNull *) OfficeAddressState == [NSNull null])
            OfficeAddressState = @"";
        
    
        NSString *OfficeAddressPostCode = [results objectForColumnIndex:17];
        if  ((NSNull *) OfficeAddressPostCode == [NSNull null])
            OfficeAddressPostCode = @"";
        
        
   
        NSString *OfficeAddressCountry = [results objectForColumnIndex:18];
        if  ((NSNull *) OfficeAddressCountry == [NSNull null])
            OfficeAddressCountry = @"";
        
  
        NSString *ProspectEmail = [results objectForColumnIndex:19];
        if  ((NSNull *) ProspectEmail == [NSNull null])
            ProspectEmail = @"";
        
        NSString *ProspectOccupationCode = [results objectForColumnIndex:20];
        if  ((NSNull *) ProspectOccupationCode == [NSNull null])
            ProspectOccupationCode = @"";
    
     
        NSString *ExactDuties = [results objectForColumnIndex:21];
        if  ((NSNull *) ExactDuties == [NSNull null])
            ExactDuties = @"";

        
        NSString *ProspectRemark = [results objectForColumnIndex:22];
        if  ((NSNull *) ProspectRemark == [NSNull null])
            ProspectRemark = @"";
        
   
        NSString *ProspectGroup = [results objectForColumnIndex:27];
        if  ((NSNull *) ProspectGroup == [NSNull null])
            ProspectGroup = @"";
        
 
        NSString *ProspectTitle = [results objectForColumnIndex:28];
        if  ((NSNull *) ProspectTitle == [NSNull null])
            ProspectTitle = @"";
        
 
        NSString *IDTypeNo = [results objectForColumnIndex:29];
        if  ((NSNull *) IDTypeNo == [NSNull null])
            IDTypeNo = @"";
        
  
      NSString *OtherIDType = [results objectForColumnIndex:30];
		if  ((NSNull *) OtherIDType == [NSNull null])
            OtherIDType = @"";
        
        NSString *ProspectProfileChangesCounter = @"";
                ProspectProfileChangesCounter = [results stringForColumn:@"ProspectProfileChangesCounter"];
                if(ProspectProfileChangesCounter ==NULL ||[ProspectProfileChangesCounter isEqualToString:@""])
                    
                        ProspectProfileChangesCounter=@"1";
        
    
       if  ( ((NSNull *) OtherIDType == [NSNull null])  || [(NSString *)OtherIDType isEqualToString:@"(null)"] || [OtherIDType isEqualToString:@"- SELECT -"] )
               OtherIDType = @"";
        else
               OtherIDType =  [OtherIDType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
       
       
        
         
        NSString *OtherIDTypeNo = [results objectForColumnIndex:31];
        if(((NSNull *) OtherIDTypeNo == [NSNull null]) || [(NSString *)OtherIDTypeNo isEqualToString:@"(null)"] )
            OtherIDTypeNo = @"";

        else
            OtherIDTypeNo = [OtherIDTypeNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    
 
        NSString *Smoker = [results objectForColumnIndex:32];
        if  ((NSNull *) Smoker == [NSNull null])
            Smoker = @"";
        
   
        NSString *AnnIncome = [results objectForColumnIndex:33];
        if  ((NSNull *) AnnIncome == [NSNull null])
            AnnIncome = @"";
        
  
        NSString *BussinessType = [results objectForColumnIndex:34];
        if  ((NSNull *) BussinessType == [NSNull null])
            BussinessType = @"";
        
 
        NSString *Race = [results objectForColumnIndex:35];
        if  ((NSNull *) Race == [NSNull null])
                Race = @"";
        
        NSString *MaritalStatus = [results objectForColumnIndex:36];
        if  ((NSNull *) MaritalStatus == [NSNull null])
            MaritalStatus = @"";
        
        
        
        NSString *Religion = [results objectForColumnIndex:37];
        if  ((NSNull *) Religion == [NSNull null])
            Religion = @"";
        
        
        NSString *Nationality =[results objectForColumnIndex:38];
       
        if  ((NSNull *) Nationality == [NSNull null])
            Nationality = @"";
        
        
        NSString *GST_registered =[results objectForColumnName:@"GST_registered"];
        
        if  ((NSNull *) GST_registered == [NSNull null])
            GST_registered = @"";
        
        NSString *GST_registrationNo =[results objectForColumnName:@"GST_registrationNo"];
        
        if  ((NSNull *) GST_registrationNo == [NSNull null])
            GST_registrationNo = @"";
        
        NSString *GST_registrationDate =[results objectForColumnName:@"GST_registrationDate"];
        
        if  ((NSNull *) GST_registrationDate == [NSNull null])
            GST_registrationDate = @"";
        
        NSString *GST_exempted =[results objectForColumnName:@"GST_exempted"];
        
        if  ((NSNull *) GST_exempted == [NSNull null])
            GST_exempted = @"";
        
        NSString *BirthCountry =[results objectForColumnName:@"CountryOfBirth"];
        
        if  ((NSNull *) BirthCountry == [NSNull null])
            BirthCountry = @"";
        
        
                //insert into eProposal_LA_Details
                
                NSString *homeNo = @"";
                NSString *officeNo = @"";
                NSString *mobileNo = @"";
                NSString *faxNo = @"";
        
        
            NSString *homeNoPrefix = @"";
            NSString *officeNoPrefix = @"";
            NSString *mobileNoPrefix = @"";
            NSString *faxNoPrefix = @"";
        
            NSString *guardianName = @"";
            NSString *guardianNRIC = @"";
        
            
        
              //  FMDatabase *database = [FMDatabase databaseWithPath:path];
               // [database open];
                FMResultSet *results;
        results = [database2 executeQuery:@"SELECT * FROM CONTACT_INPUT WHERE IndexNo = ?", indexNo];
        while ([results next]) {
            if ([[results objectForColumnName:@"ContactCode"] isEqualToString:@"CONT006"]) {
                homeNo = [results objectForColumnName:@"ContactNo"];
                homeNoPrefix = [results objectForColumnName:@"Prefix"];
            }
            else if ([[results objectForColumnName:@"ContactCode"] isEqualToString:@"CONT008"]) {
                mobileNoPrefix = [results objectForColumnName:@"Prefix"];
                mobileNo = [results objectForColumnName:@"ContactNo"];
            }
            else if ([[results objectForColumnName:@"ContactCode"] isEqualToString:@"CONT007"]) {
                officeNoPrefix = [results objectForColumnName:@"Prefix"];
                officeNo = [results objectForColumnName:@"ContactNo"];
            }
            else {
                faxNoPrefix = [results objectForColumnName:@"Prefix"];
                faxNo = [results objectForColumnName:@"ContactNo"];
            }
        }
             //  [database close];
        
        
        
                NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
                [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
                NSString *currentdate = [dateFormatter2 stringFromDate:[NSDate date]];
        
        
        
          NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
          AppDelegate *appobj;
          appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
          appobj.eappProposal=[NSString stringWithFormat:@"%@",eProposalNo];
        
        results = nil;
        results = [database2 executeQuery:[NSString stringWithFormat:@"SELECT GuardianName, CONewICNo FROM eProposal WHERE eProposalNo = %@", eProposalNo]];
        while ([results next]) {
            guardianName = [results objectForColumnName:@"GuardianName"];
            guardianNRIC = [results objectForColumnName:@"CONewICNo"];
        }

        
		
		
       
                NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO eProposal_LA_Details (\"eProposalNo\", \"PTypeCode\", \"LATitle\", \"LAName\", \"LASex\", \"LADOB\", \"LASmoker\", \"LANewICNO\", \"LAOtherIDType\", \"LAOtherID\", \"LAMaritalStatus\", \"LARace\", \"LAReligion\", \"LANationality\", \"LAOccupationCode\", \"LAExactDuties\", \"LATypeOfBusiness\", \"LAEmployerName\", \"LAYearlyIncome\", \"LARelationship\", \"POFlag\", \"CorrespondenceAddress\", \"ResidenceOwnRented\", \"ResidenceAddress1\", \"ResidenceAddress2\", \"ResidenceAddress3\", \"ResidenceTown\", \"ResidenceState\", \"ResidencePostcode\", \"ResidenceCountry\", \"OfficeAddress1\", \"OfficeAddress2\", \"OfficeAddress3\", \"OfficeTown\", \"OfficeState\", \"OfficePostcode\", \"OfficeCountry\", \"ResidencePhoneNo\", \"OfficePhoneNo\", \"FaxPhoneNo\", \"MobilePhoneNo\", \"EmailAddress\", \"PentalHealthStatus\", \"PentalFemaleStatus\", \"PentalDeclarationStatus\", \"LACompleteFlag\", \"AddPO\", \"CreatedAt\", \"UpdatedAt\", \"ResidencePhoneNoPrefix\", \"OfficePhoneNoPrefix\", \"FaxPhoneNoPrefix\", \"MobilePhoneNoPrefix\", \"ProspectProfileChangesCounter\",\"ProspectProfileID\",\"GST_registered\",\"GST_registrationNO\",\"GST_registrationDate\",\"GST_exempted\",\"LABirthCountry\") VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", eProposalNo, FinalPTypeCode, ProspectTitle, ProspectName, ProspectGender, ProspectDOB, Smoker, IDTypeNo, OtherIDType, OtherIDTypeNo, MaritalStatus, Race, Religion, Nationality, ProspectOccupationCode, ExactDuties, BussinessType, @"", AnnIncome, @"", poflag, @"", @"", ResidenceAddress1, ResidenceAddress2, ResidenceAddress3, ResidenceAddressTown, ResidenceAddressState, ResidenceAddressPostCode, ResidenceAddressCountry, OfficeAddress1, OfficeAddress2, OfficeAddress3, OfficeAddressTown, OfficeAddressState, OfficeAddressPostCode, OfficeAddressCountry, homeNo, officeNo, faxNo, mobileNo, ProspectEmail, @"False", @"False", @"False", @"", @"", currentdate, @"", homeNoPrefix, officeNoPrefix, faxNoPrefix, mobileNoPrefix,ProspectProfileChangesCounter,indexNo,GST_registered,GST_registrationNo,GST_registrationDate,GST_exempted, BirthCountry];
       
        
                [database2 executeUpdate:sqlQuery];
        
      /*  NSMutableDictionary *dic = [[NSMutableDictionary alloc ]init];
        partyID = partyID+1;
        NSString *partyid = [NSString stringWithFormat:@"%i", partyID];
        */
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:IDTypeNo forKey:@"POIDTypeNo"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:OtherIDTypeNo forKey:@"POOtherIDTypeNo"];
        
        [SecPo_LADetails_Client setValue:eProposalNo forKey:@"eProposalNo"];
        
        [SecPo_LADetails_Client setValue:FinalPTypeCode forKey:@"PTypeCode"];
        
        
        [SecPo_LADetails_Client setValue:ProspectTitle forKey:@"LATitle"];
       
        
        [SecPo_LADetails_Client setValue:ProspectName forKey:@"LAName"];
       
        
        [SecPo_LADetails_Client setValue:ProspectGender forKey:@"LASex"];
    
        
        [SecPo_LADetails_Client setValue:ProspectDOB forKey:@"LADOB"];
       
        [SecPo_LADetails_Client setValue:Smoker forKey:@"LASmoker"];
        
        [SecPo_LADetails_Client setValue:MaritalStatus forKey:@"LAMaritalStatus"];
             
        [SecPo_LADetails_Client setValue:Race forKey:@"LARace"];
         
        
        [SecPo_LADetails_Client setValue:Religion forKey:@"LAReligion"];
        
        [SecPo_LADetails_Client setValue:Nationality forKey:@"LANationality"];
        
        [SecPo_LADetails_Client setValue:ProspectOccupationCode forKey:@"LAOccupationCode"];
        
        [SecPo_LADetails_Client setValue:ExactDuties forKey:@"LAExactDuties"];
        
        
        [SecPo_LADetails_Client setValue:BussinessType forKey:@"LATypeOfBusiness"];
        
        [SecPo_LADetails_Client setValue:IDTypeNo forKey:@"LANewICNO"];
        [SecPo_LADetails_Client setValue:OtherIDType forKey:@"LAOtherIDType"];
        
        [SecPo_LADetails_Client setValue:OtherIDTypeNo forKey:@"LAOtherID"];
         
         
        
        
         
        
        NSString *query = [NSString stringWithFormat:@"SELECT OccpDesc FROM Adm_Occp WHERE OccpCode = %@", ProspectOccupationCode];
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if ((sqlite3_step(statement)) == SQLITE_DONE) {
                const char *occp = (const char*)sqlite3_column_text(statement, 0);
                [SecPo_LADetails_Client setValue:[[NSString alloc] initWithUTF8String:occp] forKey:@"LAOccupationCode"];
            }
        }
        
         
        
        //
        [SecPo_LADetails_Client setValue:@"" forKey:@"LAEmployerName"];
        [SecPo_LADetails_Client setValue:AnnIncome forKey:@"LAYearlyIncome"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"LARelationship"];
        [SecPo_LADetails_Client setValue:FinalPTypeCode forKey:@"POFlag"]; //POFLAG
        
        [SecPo_LADetails_Client setValue:@"" forKey:@"CorrespondenceAddress"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"ResidenceOwnRented"];
        [SecPo_LADetails_Client setValue:ResidenceAddress1 forKey:@"ResidenceAddress1"];
        [SecPo_LADetails_Client setValue:ResidenceAddress2 forKey:@"ResidenceAddress2"];
        
        [SecPo_LADetails_Client setValue:ResidenceAddress3 forKey:@"ResidenceAddress3"];
        [SecPo_LADetails_Client setValue:ResidenceAddressTown forKey:@"ResidenceTown"];
        [SecPo_LADetails_Client setValue:ResidenceAddressState forKey:@"ResidenceState"];
        [SecPo_LADetails_Client setValue:ResidenceAddressPostCode forKey:@"ResidencePostcode"];
        
        [SecPo_LADetails_Client setValue:ResidenceAddressCountry forKey:@"ResidenceCountry"];
        [SecPo_LADetails_Client setValue:OfficeAddress1 forKey:@"OfficeAddress1"];
        [SecPo_LADetails_Client setValue:OfficeAddress2 forKey:@"OfficeAddress2"];
        [SecPo_LADetails_Client setValue:OfficeAddress3 forKey:@"OfficeAddress3"];
        
        //
        
        
        [SecPo_LADetails_Client setValue:OfficeAddressTown forKey:@"OfficeTown"];
        [SecPo_LADetails_Client setValue:OfficeAddressState forKey:@"OfficeState"];
        [SecPo_LADetails_Client setValue:OfficeAddressPostCode forKey:@"OfficePostcode"];
        [SecPo_LADetails_Client setValue:OfficeAddressCountry forKey:@"OfficeCountry"];
        
        [SecPo_LADetails_Client setValue:homeNoPrefix forKey:@"ResidencePhoneNoPrefix"];
        [SecPo_LADetails_Client setValue:homeNo forKey:@"ResidencePhoneNo"];
        [SecPo_LADetails_Client setValue:officeNoPrefix forKey:@"OfficePhoneNoPrefix"];
        [SecPo_LADetails_Client setValue:officeNo forKey:@"OfficePhoneNo"];
        [SecPo_LADetails_Client setValue:faxNoPrefix forKey:@"FaxPhoneNoPrefix"];
        [SecPo_LADetails_Client setValue:faxNo forKey:@"FaxPhoneNo"];
        [SecPo_LADetails_Client setValue:mobileNoPrefix forKey:@"MobilePhoneNoPrefix"];
        [SecPo_LADetails_Client setValue:mobileNo forKey:@"MobilePhoneNo"];
        
        [SecPo_LADetails_Client setValue:ProspectEmail forKey:@"EmailAddress"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"PentalHealthStatus"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"PentalFemaleStatus"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"PentalDeclarationStatus"];
        
        [SecPo_LADetails_Client setValue:guardianName forKey:@"GuardianName"];
        [SecPo_LADetails_Client setValue:guardianNRIC forKey:@"GuardianNRIC"];

        [SecPo_LADetails_Client setValue:GST_registered forKey:@"GST_registered"];
        [SecPo_LADetails_Client setValue:GST_registrationNo forKey:@"GST_registrationNo"];
        [SecPo_LADetails_Client setValue:GST_registrationDate forKey:@"GST_registrationDate"];
        [SecPo_LADetails_Client setValue:GST_exempted forKey:@"GST_exempted"];
        
        
        
        
        
        [SecPo_LADetails_Client setValue:@"" forKey:@"LACompleteFlag"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"AddPO"];
        [SecPo_LADetails_Client setValue:currentdate forKey:@"CreatedAt"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"UpdatedAt"];
        
       /* SecPo_LADetails_ClientNew = [[NSDictionary alloc] init];
        
        NSString *foreign_home_country;
        NSString *foreign_office_country;
        
        if([OfficeAddressCountry isEqualToString:@"MAL"])
                foreign_office_country = @"N";
        else
                foreign_office_country = @"Y";
        
        
        if([ResidenceAddressCountry isEqualToString:@"MAL"])
            foreign_home_country = @"N";
        else
            foreign_home_country = @"Y";
        
        SecPo_LADetails_ClientNew = @{@"Party ID":partyid,
                                      @"PTypeCode":FinalPTypeCode,
                                      @"Seq":partyid,
                                      @"DeclarationAuth":@"",
                                      @"ClientChoice":@"",
                                      @"LATitle":ProspectTitle,
                                      @"LAName":ProspectName,
                                      @"LASex":ProspectGender,
                                      @"LADOB":ProspectDOB,
                                      @"AgeAdmitted":@"",
                                      @"LAMaritalStatus":MaritalStatus,
                                      @"LARace":Race,
                                      @"LAReligion":Religion,
                                      @"LANationality":Nationality,
                                      @"LAOccupationCode":ProspectOccupationCode,
                                      @"LAExactDuties":ExactDuties,
                                      @"LATypeOfBusiness":BussinessType,
                                      @"LAEmployerName":@"",
                                      @"LAYearlyIncome":AnnIncome,
                                      @"LARelationship":@"",
                                      @"ChildFlag":@"",
                                      @"ResidenceOwnRented":@"",
                                      @"CorrespondenceAddress":@"",
                                      @"LANewIC":
                                          @{@"LANewICCode" : @"NRIC", @"LANewICNo" : IDTypeNo},
                                      @"LAOtherID":
                                          @{@"LAOtherIDType" : OtherIDType, @"LAOtherID" : OtherIDTypeNo},
                                      
                                      @"Addresses":@{@"Residence" :  @{@"AddressCode" : @"",
                                                                       @"Address1" :ResidenceAddress1,
                                                                       @"Address2" :ResidenceAddress2,
                                                                       @"Address3" :ResidenceAddress3,
                                                                       @"Town" :ResidenceAddressTown,
                                                                       @"State" :ResidenceAddressState,
                                                                       @"Postcode" :ResidenceAddressPostCode,
                                                                       @"Country" :ResidenceAddressCountry,
                                                                       @"ForeignAddress" :foreign_home_country,},
                                                     
                                                     @"Office" :  @{@"AddressCode" : @"",
                                                                    @"Address1" : OfficeAddress1,
                                                                    @"Address2" : OfficeAddress2,
                                                                    @"Address3" : OfficeAddress3,
                                                                    @"Town" : OfficeAddressTown,
                                                                    @"State" :OfficeAddressState,
                                                                    @"Postcode" :OfficeAddressPostCode,
                                                                    @"Country" :OfficeAddressCountry,
                                                                    @"ForeignAddress" :foreign_office_country}
                                                        },
                                      @"Contacts":@{
                                                      @"Residence": @{@"ContactCode": homeNoPrefix, @"ContactNo":homeNo},
                                                       @"Office": @{@"ContactCode": officeNoPrefix, @"ContactNo":officeNo},
                                                       @"Mobile": @{@"ContactCode": mobileNoPrefix, @"ContactNo":mobileNo},
                                                       @"Email": @{@"ContactCode": @"", @"ContactNo":ProspectEmail},
                                                       @"Fax": @{@"ContactCode": faxNoPrefix, @"ContactNo":faxNo}},
                                      
                                      @"PentalHealthDetails":@{
                                                     @"PentalHealth": @{@"Code": @"", @"Status":@""},
                                                     @"PentalHealth": @{@"Code": @"", @"Status":@""},
                                                     @"PentalHealth": @{@"Code": @"", @"Status":@""},
                                                                }
                                      
                                               };
        
            [SecPo_LADetails_ClientNew_Array addObject:SecPo_LADetails_ClientNew];
        */
  
                ProspectID = Nil;
                NickName = Nil;
                ProspectName = Nil ;
                ProspectDOB = Nil  ;
                ProspectGender = Nil;
                ResidenceAddress1 = Nil;
                ResidenceAddress2 = Nil;
                ResidenceAddress3 = Nil;
                ResidenceAddressTown = Nil;
                ResidenceAddressState = Nil;
                ResidenceAddressPostCode = Nil;
                ResidenceAddressCountry = Nil;
                OfficeAddress1 = Nil;
                OfficeAddress2 = Nil;
                OfficeAddress3 = Nil;
                OfficeAddressTown = Nil;
                OfficeAddressState = Nil;
                OfficeAddressPostCode = Nil;
                OfficeAddressCountry = Nil;
                ProspectEmail = Nil;
                ProspectOccupationCode = Nil;
                ExactDuties = Nil;
                ProspectRemark = Nil;
                ProspectTitle = Nil, ProspectGroup = Nil, IDTypeNo = Nil, OtherIDType = Nil, OtherIDTypeNo = Nil, Smoker = Nil;
                GST_registered = Nil;
                GST_registrationNo = Nil;
                GST_registrationDate = Nil;
                GST_exempted = Nil;
        
    }
    
     
    
    
    //basil -start
    /* NSDictionary *testDic = [obj.eAppData objectForKey:@"SecPO"];
     
     for(id key in testDic)
     {
     
     NSLog(@"Key = %@", key);
     if( [key isEqual:@"SINumber"]){
     NSLog(@"testtest - %@", [testDic objectForKey:key] );
     }
     
     }
     
     NSLog(@"OBJET SECPO - %@", testDic);
     */
    //basil -end
    
  


}
-(void) insert_eproposal
{
    NSString *eAppVersion = @"";
    NSString *SIType = @"";
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	FMResultSet *results;
	results = [database executeQuery:@"SELECT eAppVersion FROM eProposal_Version_Details where  eAppLastUpdatedDate IN (SELECT MAX(eAppLastUpdatedDate) from eProposal_Version_Details)"];
    
    
    
	while ([results next]) {
        
        eAppVersion = [results stringForColumn:@"eAppVersion"];
        
    }
    
    
    
    [results close];
    [database close];

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyMMddhhmmssSSS"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *plancode = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
	SIType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];

//    if([plancode isEqualToString:@"HLACP"] || [plancode isEqualToString:@"L100"] || [ plancode isEqualToString:@"HLAWP"])
//        SIType = @"TRAD";
//    else if([plancode isEqualToString:@"UV"] || [plancode isEqualToString:@"UP"])
//        SIType = @"ES";
    
    
    //Unit-Linked
    //Perfect Series
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
 
    [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr = [dateFormatter2 stringFromDate:[NSDate date]];

    // 2 - created
     NSString *systemName = @"IAPP(S)";
    
    NSString *SIListingSQL = [NSString stringWithFormat:
                              @"INSERT INTO eProposal (eProposalNo, SINo, Status, GuardianName, BasicPlanCode, SIType, SIVersion , eAppVersion, CreatedAt, ExistingPoliciesMandatoryFlag, SystemName) VALUES "
                                                            "(\"RN%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\") ",currentdate, _SINumberSelected.text, @"2", @"", plancode , SIType, str_SIVersion , eAppVersion ,dateStr, @"N",systemName];
    
    
    
    
    
   
    
    
 //   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 //   NSString *docsPath = [paths objectAtIndex:0];
 //   NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];

     
    
     database = [FMDatabase databaseWithPath:path];
    if (![database open]) {
        NSLog(@"Could not open db.");
    }
 
    [database open];
      
   // FMResultSet *results;
     [database beginTransaction];
          [database executeUpdate:SIListingSQL];
    
     
    [database commit];
    [database close];
   
  [[obj.eAppData objectForKey:@"EAPP"]  setValue:[NSString stringWithFormat:@"RN%@", currentdate] forKey:@"eProposalNo"];
 
    database = nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *error = @"";
     
    qqflag = [QQFlag objectAtIndex:indexPath.row];
    str_SIStatus = [SIStatus_Check objectAtIndex:indexPath.row];
    str_SIVersion = [SIVersion_Check objectAtIndex:indexPath.row];
    
    
 
    //Display these data in "e-Application Checklist"
        _IC =  [IdentifactionNo objectAtIndex:indexPath.row];
    
    
    _cellSelected = [tableView cellForRowAtIndexPath:indexPath];
    _SINumberSelected = (UILabel *)[_cellSelected.contentView viewWithTag:1001];
    _SINameSelected = (UILabel *)[_cellSelected.contentView viewWithTag:1004];
    _SIPlanSelected = (UILabel *)[_cellSelected.contentView viewWithTag:1006];
    
    _indexPath2 = indexPath;
    
    // CHECK IF THE SI WAS CREATED FOR eApp BEFORE
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    NSString *plancode;
    
	
	plancode = [self GetPlanData:2 :_SIPlanSelected.text];
	NSString * SIType = gSIType;
	
	NSLog(@"plancode %@, sitype %@", _SIPlanSelected.text, SIType);
	
//    if([_SIPlanSelected.text isEqualToString:@"HLA EverLife Plus"])
//        plancode = @"UV";
//    
//    else if([_SIPlanSelected.text isEqualToString:@"HLA EverGain Plus"])
//        plancode = @"UP";
//    else if([_SIPlanSelected.text isEqualToString:@"Life100"])
//        plancode = @"L100";
//    else if([_SIPlanSelected.text isEqualToString:@"HLAWP"])
//        plancode = @"HLA Wealth Plan";
//    else
//        plancode = @"HLACP";
    
	
	
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
	[database open];
	NSString *proposal;
 	
	FMResultSet *results = [database executeQuery:@"select eProposalNo from eProposal where SINo = ? AND BasicPlanCode = ?", _SINumberSelected.text, plancode];
	while([results next]) {
        
        proposal = [results objectForColumnIndex:0];
        
        }
	
	//CHECK if SI Commencement Date Before 1 April 2015
	
	NSString *ComDate;
	
	FMResultSet *results1 = [database executeQuery:@"select B.dateCreated from trad_laPayor as A, clt_profile as B where A.custcode = B.custcode AND ptypecode = 'LA' and sequence = '1' and A.SINO = ?", _SINumberSelected.text];
	while([results1 next]) {
        
//		NSString *str = [results1 objectForColumnIndex:0]; 
//		
//		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//		[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//		
//		NSDate *date = [dateFormatter dateFromString: str]; 
//		
//		dateFormatter = [[NSDateFormatter alloc] init];
//		[dateFormatter setDateFormat:@"dd/MM/yyyy"];// here set format which you want...
//		
//		ComDate = [dateFormatter stringFromDate:date];
		
		ComDate = [results1 objectForColumnIndex:0];
		
	}
    
    
    //START   **********************check SI got "Health Loading", if yes - not allow user to select!
    NSString *queryHL;
    NSString *hl1;
    NSString *hl2;
    BOOL healthLoading = NO;
    
//    if([ plancode isEqualToString:@"HLACP"] || [ plancode isEqualToString:@"L100"] || [ plancode isEqualToString:@"HLAWP"])
	if ([SIType isEqualToString:@"TRAD"])
    {
        queryHL = [NSString stringWithFormat:@"SELECT HL1KSA, TempHL1KSA from Trad_Details WHERE SINO = '%@'",_SINumberSelected.text];
    }
//    else if([ plancode isEqualToString:@"UV"] || [ plancode isEqualToString:@"UP"])
	else if([SIType isEqualToString:@"ES"])
    
    {
        queryHL = [NSString stringWithFormat:@"SELECT HLoading, HloadingPct from UL_Details WHERE SINO = '%@' ", _SINumberSelected.text];
    }
    
    FMResultSet *results2 = [database executeQuery:queryHL];
    
    while([results2 next]) {
        
        hl1 = [results2 stringForColumnIndex:0];
        hl2 = [results2 stringForColumnIndex:1];
        
    }

    
    if(hl1 == NULL)
        hl1 = @"";
    
    if(hl2 == NULL)
        hl2 = @"";
    
    
    
    
    if(![hl1 isEqualToString:@""] || ![hl2 isEqualToString:@""])
        healthLoading = YES;
    
    
    
     //START   **********************check SI got "Health Loading", if yes - not allow user to select!
    [results close];
    [results2 close];
	[database close];
   
    
    if(proposal.length >0)

        error = @"Cannot have duplicate SI in eApp because this SI is been using in the existing eApp.";

    else if([str_SIStatus isEqualToString:@"INVALID"] || [str_SIStatus isEqualToString:@""])
       // error = @"This SI is not valid, please fill up all details first.";
        error = @"Quotation was not created with latest SI. Please resave the quotation.";
    else if(![str_SIVersion isEqualToString:str_Sys_SI_Version])
        error = @"Quotation was not created with latest SI. Please resave the quotation.";
	else if([self CheckDate:ComDate] == 0)
		error = @"Commencement date before 01/04/2015 is not allowed for eApplication submission. Should you wish to opt for	commencement date before 01/04/2015, you are required to proceed with manual submission.";
    else if(healthLoading)
        error = @"Sales Illustration that contains Health Loading is not allowed to create e-Application case.";
    else
        error = @""; //OK
	

	
    if(error.length > 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:error
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        
        
        [alert setTag:1002];
        [alert show];
        alert = Nil;
    }
  
    else{
        
   //SI Acknowlege for Agreement - START
    CustomAlertBox *agree = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomAlertBox"];
   
    agree.delegate = self;
   
    agree.modalPresentationStyle = UIModalPresentationFormSheet;
    agree.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:agree animated:NO];
    agree.view.superview.frame = CGRectMake(120, 200, 350, 600);
    //SI Acknowlege for Agreement - END

    }
      
    
  }

-(int)CheckDate:(NSString *)date2 {
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
	[df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [df setLocale:[NSLocale systemLocale]];
    [df setDateFormat:@"dd/MM/yyyy"];

	NSDate* d2 = [df dateFromString:date2];
	
	NSDate* dateGst = [df dateFromString:@"01/01/2015"];  //##GSTDATE
	
	NSUInteger unitFlags = NSDayCalendarUnit;
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];

    
	NSDateComponents *compGST = [calendar components:unitFlags fromDate:d2 toDate:dateGst options:0];
    
	NSLog(@"GST date1: %d", [compGST day]);
    
	//NOTE: If +ve value, create before GST date, -ve, ok. 
	if ([compGST day] > 0) {
		return  0; //Date set before GST
	}
	
	return 1;
	
    
}


-(void)AgreeFlag:(NSString *)agree
{
    
    isLA2 = FALSE;
    isPY1 = FALSE;
    
    if([agree isEqualToString:@"Y"])
    {
        //Display these data in "e-Application Checklist"
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"SISelected"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"SISelected2"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:_SINumberSelected.text forKey:@"SINumber"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:_SINameSelected.text forKey:@"SIName"];
       
		
		NSString *plan;
		plan = [self GetPlanData:2 :_SIPlanSelected.text];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:plan forKey:@"SIPlanName"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:gSIType forKey:@"SIType"];
		
		
        [self insert_eproposal];
        
        
        [self select_eproposal_LA_details];
        
       // self.modalTransitionStyle = UIModalPresentationFormSheet;
       // [self dismissViewControllerAnimated:TRUE completion:Nil];
        
        if (![[self modalViewController] isBeingDismissed])
        {
         [self dismissViewControllerAnimated:TRUE completion:Nil];
        [self dismissModalViewControllerAnimated:YES];
        }
                
       
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    obj=[DataClass getInstance];
    [self getSys_SI_Version];
    [self LoadAllResult];
    [myTableView reloadData];
    
  //  DataClass *obj1=[DataClass getInstance];
    //NSString *SINumber;
    //SINumber = [[obj1.eAppData objectForKey:@"SI"] objectForKey:@"SINumber"];
    if ([[obj.eAppData objectForKey:@"SI"] objectForKey:@"SINumber"] == Nil || [[[obj.eAppData objectForKey:@"SI"] objectForKey:@"SINumber"] isEqualToString:@"Not Set"]){
        NSLog(@"is nil");
        }
    else{
        NSLog(@"not nil");
        [self dismissViewControllerAnimated:FALSE completion:nil];
    }
    
 
}

- (void)viewDidUnload
{
    [self setSILabel:nil];
    [self setDateLabel:nil];
    [self setIdTypeLabel:nil];
    [self setIdNoLabel:nil];
    [self setNameLabel:nil];
    [self setPlanLabel:nil];
    [self setMyTableView:nil];
	[self setSINO:nil];
	[self setDATETF:nil];
	[self setIDNOTF:nil];
	[self setNAMETF:nil];
	[self setPLANTF:nil];
	[self setPopView:nil];
    [super viewDidUnload];
}
- (IBAction)ActionClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)selectSI:(id)sender{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:myTableView];
	NSIndexPath *indexPath = [myTableView indexPathForRowAtPoint:buttonPosition];
    
    NSString *plan  =  [PlanName objectAtIndex:indexPath.row];
    
	plan = [self GetPlanData:2 :plan];
//    if([plan isEqualToString:@"HLA Cash Promise"])
//        plan =@"HLACP";
//    else if([plan isEqualToString:@"Life100"])
//        plan =@"L100";
//	else if([plan isEqualToString:@"HLA Wealth Plan"])
//        plan =@"HLAWP";
//    else if([plan isEqualToString:@"HLA EverLife Plus"])
//        plan =@"UV";
//    else
//        plan=@"UP";
	
	
	
	
     // [[NSNotificationCenter defaultCenter] postNotificationName:@"eApp_SIPlan" object:self];
      //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDeleteNominee:) name:@"DeleteNominee" object:nil];
    
	[self.delegate updateChecklistSI];
    
    if([plan isEqualToString:@"HLACP"] || [plan isEqualToString:@"L100"] || [plan isEqualToString:@"HLAWP"])
    {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
        SIMenuViewController *main = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIPageView"];
        if (isSearching) {
            main.requestSINo = [_SINOSearch objectAtIndex:indexPath.row];
//          main.requestNameLA = [_NameSearch objectAtIndex:indexPath.row];
//          main.requestPlanName = [_PlanNameSearch objectAtIndex:indexPath.row];
        }
        else {
            main.requestSINo = [SINO objectAtIndex:indexPath.row];
//          main.requestNameLA = [Name objectAtIndex:indexPath.row];
            //main.requestPlanName = [PlanName objectAtIndex:indexPath.row];
        }
//	NSLog(@"sino test: %@", main.requestSINo);
        main.EAPPorSI = @"eAPP";
        [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
//      [[obj.eAppData objectForKey:@"SI"] setValue:main.requestNameLA forKey:@"NameLA"];
//      [[obj.eAppData objectForKey:@"SI"] setValue:main.requestPlanName forKey:@"PlanName"];
        main.modalTransitionStyle = UIModalPresentationFormSheet;
        [self presentViewController:main animated:YES completion:nil];
        
       
        
        mainStoryboard = Nil, main = Nil;
    }
    else if([plan isEqualToString:@"UV"] ||[plan isEqualToString:@"UP"])
    {
       
        
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
        EverSeriesMasterViewController *main = [mainStoryboard instantiateViewControllerWithIdentifier:@"EverSeriesMaster"];
        
        if (isSearching) {
            main.requestSINo = [_SINOSearch objectAtIndex:indexPath.row];
        }
        else
            main.requestSINo = [SINO objectAtIndex:indexPath.row];
        
         main.EAPPorSI = @"eAPP";
        [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
        
           
        
        main.modalTransitionStyle = UIModalPresentationFormSheet;
        [self presentViewController:main animated:YES completion:nil];
         NSLog(@"view EverSeriesMaster");
          mainStoryboard = Nil, main = Nil;
     
    }
    
}

-(void) StoreXMLdata_AgentProfile
{
   
    
    obj=[DataClass getInstance];
    
    NSString *plancode = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Plan"];
    NSString *SIType;
    if([ plancode isEqualToString:@"HLACP"] || [plancode isEqualToString:@"L100"] || [plancode isEqualToString:@"HLAWP"])
        SIType = @"TRAD";
    else if([ plancode isEqualToString:@"UV"] || [ plancode isEqualToString:@"UP"])
        SIType = @"ES";
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    FMResultSet *results2;

    NSString *eAppVersion = @"";
    NSString *SystemName = @"";
    NSString *createdDate = @"";
    results2 = [database executeQuery:@"SELECT eAppVersion, SystemName, CreatedAt from eProposal WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    
	while ([results2 next]) {
        
        eAppVersion = [results2 stringForColumn:@"eAppVersion"];
        
        SystemName = [results2 stringForColumn:@"SystemName"];
        
        createdDate = [results2 stringForColumn:@"CreatedAt"];
        
    }

    
    NSString *BackDate = @"False";
    NSString *BackDating = @"";
    
    results2 = [database executeQuery:@"SELECT BackDating from eProposal_Existing_Policy_1 WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    
	while ([results2 next]) {
        
        NSString  *backdating = [results2 stringForColumn:@"BackDating"];
        
        if(backdating!=NULL){
            BackDating = backdating;
             BackDate = @"True";
        }
        else
            BackDate = @"False";
        
        
    }

    NSString *CFFStatus = @"";
    results2 = [database executeQuery:@"SELECT Status FROM eProposal_CFF_Master WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    
	while ([results2 next]) {
        
       NSString  *Status = [results2 stringForColumn:@"Status"];
        
        if (Status==NULL)
            CFFStatus = @"N";
        else
            CFFStatus = @"Y";
        
    }

    
     
    
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
    NSDictionary *Agent2 = [[NSDictionary alloc] init];
    NSMutableDictionary *editable_Agent1 = [[NSMutableDictionary alloc] init];
    
    
    int agentcount=0;
    
    
    
   // FMDatabase *database = [FMDatabase databaseWithPath:path];
   // [database open];
   // FMResultSet *results;
    
    
    
    
    //GET THE FIRST AGENT
    NSString *querySQL3 = [NSString stringWithFormat:@"SELECT AgentCode, AgentContactNo, Channel, ImmediateLeaderCode, ImmediateLeaderName from Agent_profile"];
    NSString *Channel = @"";
    results = [database executeQuery:querySQL3];
    while ([results next]) {
        agentcount = agentcount+1;
        NSString *count = [NSString stringWithFormat:@"%i", agentcount];
        
        NSString *AgentCode = [results objectForColumnName:@"AgentCode"];
        NSString *AgentContactNo = [results objectForColumnName:@"AgentContactNo"];
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
    
    

    
    
    
    
    
    NSString *count = [NSString stringWithFormat:@"%i", agentcount];
    
    Agentcount = @{@"AgentCount": count, };
    
    
    NSDictionary *ChannelInfo = [[NSDictionary alloc] init];
    
    ChannelInfo = @{@"Channel": Channel};
    
    [AgentInfo addObject:Agentcount];
    
    
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:eSystemInfo forKey:@"eSystemInfo"];
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:SubmissionInfo forKey:@"SubmissionInfo"];
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:ChannelInfo forKey:@"ChannelInfo"];
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:AgentInfo forKey:@"AgentInfo"];
    
    
}

-(NSString *) GetPlanData: (int)searchType :(NSString *)strValue {
	
	//NOTE: SearchType: 1-by PlanCode, 2-By PlaneName, 3-SIType (plancode), 4-SIType (planName)
	
	if (strValue == nil)
		strValue = @"";
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
	gPlanCode = @"";
	gPlanName = @"";
	gSIType = @"";
	
    FMDatabase *database = [FMDatabase databaseWithPath:path];
	if ([database close]) {
		[database open];
	}
	
    FMResultSet *results;
	
	NSString *query = @"";
	
	if (searchType == 1 || searchType == 3) {
		query = [NSString stringWithFormat:@"SELECT PlanCode, PlanName, SIType from Trad_Sys_Profile where PlanCode = '%@'", strValue];
	}
	else if (searchType == 2 || searchType == 4) {
		query = [NSString stringWithFormat:@"SELECT PlanCode, PlanName, SIType from Trad_Sys_Profile where PlanName = '%@'", strValue];
	}
	
    results = [database executeQuery:query];
	
    while ([results next]) {
		gPlanCode = [results stringForColumn:@"PlanCode"];
		gPlanName = [results stringForColumn:@"PlanName"];
		gSIType = [results stringForColumn:@"SIType"];
	}
	
	if (searchType == 1){
		if (![gPlanName isEqualToString:@""])
			return gPlanName;
		else
			return strValue;
	}
	else if (searchType == 2) {
		if (![gPlanCode isEqualToString:@""])
			return gPlanCode;
		else
			return strValue;
	}
	else if (searchType == 3){
		if (![gSIType isEqualToString:@""])
			return gSIType;
		else
			return strValue;
	}
	else if (searchType == 4){
		if (![gSIType isEqualToString:@""])
			return gSIType;
		else
			return strValue;
	}
	else
		return strValue;
}

-(NSString *) GetPlanData2: (int)searchType :(NSString *)strValue passdb:(FMDatabase*)database{
	
	//NOTE: SearchType: 1-by PlanCode, 2-By PlaneName, 3-SIType (plancode), 4-SIType (planName)
	
	if (strValue == nil)
		strValue = @"";
    
	gPlanCode = @"";
	gPlanName = @"";
	gSIType = @"";
	
    FMResultSet *results;
	
	NSString *query = @"";
	
	if (searchType == 1 || searchType == 3) {
		query = [NSString stringWithFormat:@"SELECT PlanCode, PlanName, SIType from Trad_Sys_Profile where PlanCode = '%@'", strValue];
	}
	else if (searchType == 2 || searchType == 4) {
		query = [NSString stringWithFormat:@"SELECT PlanCode, PlanName, SIType from Trad_Sys_Profile where PlanName = '%@'", strValue];
	}
	
    results = [database executeQuery:query];
	
    while ([results next]) {
		gPlanCode = [results stringForColumn:@"PlanCode"];
		gPlanName = [results stringForColumn:@"PlanName"];
		gSIType = [results stringForColumn:@"SIType"];
	}
	
	if (searchType == 1){
		if (![gPlanName isEqualToString:@""])
			return gPlanName;
		else
			return strValue;
	}
	else if (searchType == 2) {
		if (![gPlanCode isEqualToString:@""])
			return gPlanCode;
		else
			return strValue;
	}
	else if (searchType == 3){
		if (![gSIType isEqualToString:@""])
			return gSIType;
		else
			return strValue;
	}
	else if (searchType == 4){
		if (![gSIType isEqualToString:@""])
			return gSIType;
		else
			return strValue;
	}
	else
		return strValue;
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (IBAction)reset:(id)sender
{
	[self hideKeyboard];
    isSearching = NO;
   
    _SINOTF.text =@"";
    _NAMETF.text =@"";
    _PLANTF.text = @"";
    _IDNOTF.text = @"";
    _DATETF.text =@"- SELECT -";
	outletDateSearch.titleLabel.text= @"-Select-";
    [self LoadAllResult];
   [myTableView reloadData];
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
