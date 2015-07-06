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
}

@end

@implementation eAppsListing
@synthesize SILabel,dateLabel,idTypeLabel,idNoLabel,nameLabel,planLabel;
@synthesize EditProspect = _EditProspect;
@synthesize myTableView,SINO,DateCreated,Name,PlanName,BasicSA,SIStatus,CustomerCode,popoverController,IdentifactionNo, QQFlag, PPIndexNo,SIStatus_Check,SIVersion_Check;

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    SecPo_LADetails = [[NSMutableArray alloc] init ];
    temp_clients_array = [[NSMutableArray alloc] init ];
    sqlite3_stmt *statement;
    sqlite3_stmt *statement2;
    const char *dbpath = [databasePath UTF8String];
    BOOL QQ = false;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
             
        
        //GET ALL SI FROM TRADITIONAL & EVERSERIES
        NSString *SIListingSQL = [NSString stringWithFormat:@"select A.Sino, createdAT, name, planname, basicSA, 'Not Created', A.CustCode,  E.IDTypeNo, E.QQFlag, E.IndexNo, B.SIVersion, B.SIStatus from trad_lapayor as A, trad_details as B, clt_profile as C, trad_sys_profile as D , prospect_profile as E where A.sino = B.sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Sequence = 1 AND A.ptypeCode = \"LA\"   AND E.IndexNo = c.indexNo AND E.QQFlag = 'false' UNION select A.Sino, B.DateCreated, name, planname, basicSA, 'Not Created', A.CustCode ,  E.IDTypeNo, E.QQFlag, E.IndexNo, B.SIVersion, B.SIStatus from UL_lapayor as A, UL_details as B, clt_profile as C, trad_sys_profile as D , prospect_profile as E where A.sino = B.sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Seq = 1 AND A.ptypeCode = \"LA\" AND E.IndexNo = c.indexNo AND E.QQFlag = 'false'"];
          
        
             

        
        
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
                NSString *ItemIdentificationNo;
                if (sqlite3_column_text(statement, 7) != NULL) {
                    ItemIdentificationNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                }
                else {
                    ItemIdentificationNo = @"";
                }
                
                NSString *STR_QQFlag = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                
                NSString *STR_PPIndexNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
               
                
                char *char_version = (char *) sqlite3_column_text(statement, 10);
                NSString *SIversion_check = char_version ? [[NSString alloc] initWithUTF8String:char_version] : nil;
                
                char *char_status = (char *) sqlite3_column_text(statement, 11);
                NSString *SIstatus_check = char_status ? [[NSString alloc] initWithUTF8String:char_status] : nil;
                
                
                NSString *SIListingSQL2 = [NSString stringWithFormat:@"select A.SINo, C.CustCode, B.QQFlag, B.ProspectName  from TRAD_LAPayor AS A, prospect_profile AS B , Clt_Profile AS C where A.SINo = '%@'  AND A.CustCode = C.CustCode AND C.indexNo = B.IndexNo",SINumber];
                
                
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _DATETF.text = [dateFormatter stringFromDate:[_itsDatePicker date]];
}

- (IBAction)doneAction:(id)sender {
//	[_itsDatePicker resignFirstResponder];
}

- (IBAction)testDBSearch:(id)sender {
	isSearching = YES;
	// Create (or open) our database
//	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docsDir = [dirPaths objectAtIndex:0];
//    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	FMDatabase *database = [FMDatabase databaseWithPath:databasePath];
	[database open];
	
	_SINOSearch = [[NSMutableArray alloc] init];
	_NameSearch = [[NSMutableArray alloc] init];
	_PlanNameSearch = [[NSMutableArray alloc] init];
	_DateCreatedSearch = [[NSMutableArray alloc] init];
    _IdentificationNoSearch = [[NSMutableArray alloc] init];
	
	NSString *search_sino = [NSString stringWithFormat:@"%%%@%%", _SINOTF.text];
	NSString *search_name = [NSString stringWithFormat:@"%%%@%%", _NAMETF.text];
	NSString *search_plan = [NSString stringWithFormat:@"%%%@%%", _PLANTF.text];
	NSString *search_datecreated = [NSString stringWithFormat:@"'%%%@%%'", _DATETF.text];
	NSLog(@"search_datecreated : %@", search_datecreated);
	
	FMResultSet *results = [database executeQuery:@"select A.Sino, createdAT, name, planname, basicSA,'Not Created', A.CustCode, E.IDTypeNo from trad_lapayor as A, trad_details as B,clt_profile as C, trad_sys_profile as D, prospect_profile as E where A.sino = B.sino and A.CustCode = C.custcode and B.plancode = D.plancode AND A.Sequence = 1 AND E.IndexNo = C.indexNo AND A.ptypeCode = 'LA' and name like ? and A.Sino like ? and planname like ?", search_name, search_sino, search_plan];
	while([results next]) {
		NSString *sino = [results stringForColumn:@"sino"];
		NSString *name = [results stringForColumn:@"name"];
		NSString *planname = [results stringForColumn:@"planname"];
		NSString *datecreated = [results stringForColumn:@"datecreated"];
		
		NSLog(@"User: %@ with si: %@ and date: %@",name, sino,datecreated);
		
		[_SINOSearch addObject:sino];
		[_NameSearch addObject:name];
		[_PlanNameSearch addObject:planname];
//		[_DateCreatedSearch addObject:datecreated];
	}
	[database close];
	[myTableView reloadData];
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
	CGRect frame2=CGRectMake(200,0, 50, 50);
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
	
	//	CGRect frame7=CGRectMake(867,0, 177, 50);
	CGRect frame7=CGRectMake(1000,15, 15, 20);
	UIButton *btn = [[UIButton alloc]initWithFrame:frame7];
	UIImage *doneImage = [UIImage imageNamed: @"viewSI.png"];
	[btn setBackgroundImage:doneImage forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(selectSI:) forControlEvents:UIControlEventTouchUpInside];
	//	btn.backgroundColor = [UIColor clearColor];
	btn.tag = 1007;
    [cell.contentView addSubview:btn];
	
    if (isSearching) {
		label1.text = [_SINOSearch objectAtIndex:indexPath.row];
		label2.text= @"6.9";
//		label3.text= [_DateCreatedSearch objectAtIndex:indexPath.row];
		label3.text= @"";
		label4.text = [_NameSearch objectAtIndex:indexPath.row];;
	    label5.text= @"880101117753";
		label6.text= [_PlanNameSearch objectAtIndex:indexPath.row];;
	}
	else {
		label1.text= [SINO objectAtIndex:indexPath.row];
		label2.text= @"6.9";
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
    str_SIVersion = [SIVersion_Check objectAtIndex:indexPath.row];
    
    if(![str_SIVersion isEqualToString:str_Sys_SI_Version])
        cell.contentView.backgroundColor = [CustomColor colorWithHexString:@"e98294"];
  
    
     
    
    
    return cell;
    CustomColor = Nil;
}


#pragma mark - Table view delegate
/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
 
    isLA2 = FALSE;
    isPY1 = FALSE;
    if (alertView.tag == 1002 && buttonIndex == 0)
    {
      
        [[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"SISelected2"];
    }
    else if (alertView.tag == 1002 && buttonIndex == 1)
    {
        
       
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
        
        //KKY - If QQFlag is true, then ask user to "Edit Client profile"
      //   NSLog(@"KKY QQFlag - %@ - sino - %@", qqflag, [SINO objectAtIndex:_indexPath2.row]);
       
      //   NSLog(@"QQFlag clickedButtonAtIndex- - qqflag%@ ", qqflag);
        if([qqflag isEqualToString:@"true"])
        {
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message: @"Please complete the client details before you can proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
            
            //KKY - HIDE THE PROSPECT LISTING PAGE, JUST SHOW THW CLIENT EDIT PAGE
            if(ProspectListingPage == Nil)
            {
                ProspectListingPage = [mainStoryboard instantiateViewControllerWithIdentifier:@"clientListing"];
                ProspectListingPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Client" image:[UIImage imageNamed:@"btn_prospect_off.png"] tag: 0];
            }
            ProspectListingPage.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentViewController:ProspectListingPage animated:YES completion:Nil];
            
            
            
           // NSLog(@"KKY -eAppsListing.....TAG - %@", [PPIndexNo objectAtIndex:_indexPath2.row]);
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"eApp_SI" object:[PPIndexNo objectAtIndex:_indexPath2.row]];
            
            
            //Display these data in "e-Application Checklist"
          
           
            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"SISelected"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"SISelected2"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:_SINumberSelected.text forKey:@"SINumber"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:_SINameSelected.text forKey:@"SIName"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:_SIPlanSelected.text forKey:@"SIPlanName"];
         
            
            
          

            
        }
        
        else{
            
          
            //Display these data in "e-Application Checklist"
            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"SISelected"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"SISelected2"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:_SINumberSelected.text forKey:@"SINumber"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:_SINameSelected.text forKey:@"SIName"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:_SIPlanSelected.text forKey:@"SIPlanName"];
            
             
            
            [self insert_eproposal];
            

             [self select_eproposal_LA_details];
          
            self.modalTransitionStyle = UIModalPresentationFormSheet;
            [self dismissViewControllerAnimated:TRUE completion:Nil];
            
        }
        
    }
    
    
}
 */
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
    NSString *querySQL = @"";
    
      SecPo_LADetails_Client = [NSMutableDictionary dictionary];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    database2 = [FMDatabase databaseWithPath:path];
    [database2 open];
    
    // FMResultSet *results;
    [database2 beginTransaction];
    NSString* si = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    
    
    if([_SIPlanSelected.text isEqualToString:@"HLA EverLife"])
        
         querySQL = [NSString stringWithFormat:@"select A.SINo, A.CustCode, A.PTypeCode, A.Seq, B.indexNo, B.Name, C.IDTypeNo, C.IndexNo from ul_lapayor as A, Clt_Profile as B, prospect_profile as C where A.SINO = '%@' and A.CustCode = B.CustCode AND C.IndexNo = B.indexNo",si ];
    else
        
         querySQL = [NSString stringWithFormat:@"select A.SINo, A.CustCode, A.PTypeCode, A.Sequence, B.indexNo, B.Name, C.IDTypeNo, C.IndexNo from trad_lapayor as A, Clt_Profile as B, prospect_profile as C where A.SINO = '%@' and A.CustCode = B.CustCode AND C.IndexNo = B.indexNo",si ];
    
   
    
    
   FMResultSet *results =  [database2 executeQuery:querySQL];
    
       while ([results next]) {
           
           custcode = [results objectForColumnIndex:1];
           PTypeCode = [results objectForColumnIndex:2];
           Sequence = [results objectForColumnIndex:3];
           indexNo = [results objectForColumnIndex:4];
           custname = [results objectForColumnIndex:5];
            ic = [results objectForColumnIndex:6];
            IndexNo = [results objectForColumnIndex:7];
           
           
       //    NSLog(@"!!!!KKY- insert_eproposal_LA_details- ...CUSTCODE = %@ || CustName = %@ || PTypeCode - %@ || Sequence - %@ || indexNo - %@",custname,custcode ,PTypeCode, Sequence, indexNo);
           
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
           
         //  [self insert_eproposal_LA_details:Final_PTypeCode index:indexNo];
          // [SecPo_LADetails addObject:SecPo_LADetails_Client];

          }
   
    BOOL payor = false;
    for(NSMutableDictionary *dic in temp_clients_array)
    {
        //NSLog(@"KKY OBJET temp_clients_dic - %@ - %@", [dic objectForKey:@"PTypeCode"], [dic objectForKey:@"indexNo"]);
        
        NSString *pcode = [dic objectForKey:@"PTypeCode"];
        NSString *index = [dic objectForKey:@"indexNo"];
        NSString *custname = [dic objectForKey:@"custname"];
        NSString *custcode = [dic objectForKey:@"custcode"];
       
        
        if([pcode isEqualToString:@"PY1"])
        {
             
            [self insert_eproposal_LA_details:pcode index:index POFlag:@"Y"];
           
            [self insert_eApp_Listing:pcode IC:ic POFlag:@"Y" POName:custname CustCode:custcode IndexNo:index];
        }
        else if([pcode isEqualToString:@"LA2"] && isLA2 == FALSE)
        {
            
            [self insert_eproposal_LA_details:pcode index:index POFlag:@"N"];
        }
        else if([pcode isEqualToString:@"LA2"] && isLA2 == TRUE)
        {
           
             
            
             if([_SIPlanSelected.text isEqualToString:@"HLA EverLife"])
             {
                 // FOR Ever Series - Set Name & IC to '' by default - user able to choose either LA1 or LA2 to be PO
                 [self insert_eproposal_LA_details:pcode index:index POFlag:@"N"];
                 [self insert_eApp_Listing:pcode IC:@"" POFlag:@"N" POName:@"" CustCode:custcode IndexNo:index];
             }
             else
             {
                 //FOR Traditional - SET LA2 TO Policy Owner by default
                 [self insert_eproposal_LA_details:pcode index:index POFlag:@"Y"];
                 [self insert_eApp_Listing:pcode IC:ic POFlag:@"Y" POName:custname CustCode:custcode IndexNo:index];
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
            
            [self insert_eproposal_LA_details:pcode index:index POFlag:@"N"];
            
            if(isPY1==FALSE && isLA2 == FALSE && [pcode isEqualToString:@"LA1"])// LA1 & NEW PO - DEFAULT VALUE '' FOR IC & NAME
                 [self insert_eApp_Listing:pcode IC:@"" POFlag:@"N" POName:@"" CustCode:custcode IndexNo:index];
        }
        [SecPo_LADetails addObject:SecPo_LADetails_Client];
    }
    
    [database2 commit];
    [database2 close];

  
      
    
    [[obj.eAppData objectForKey:@"SecPO"] setValue:SecPo_LADetails forKey:@"LADetails"];
    
    
    
 
    
    //basil -start
  /*  NSMutableArray *testDic = [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"];
     
     for(NSMutableDictionary *dic in testDic)
     {
      NSLog(@"KKY OBJET SECPO - %@ - %@", [dic objectForKey:@"eProposalNo"], [dic objectForKey:@"PTypeCode"]);
     
    }
 */
  
    //basil -end
    
    
  
}

-(void) insert_eApp_Listing:(NSString*)FinalPTypeCode IC:(NSString*)ic POFlag:(NSString*)poflag POName:(NSString*)poname CustCode:(NSString*)custcode IndexNo:(NSString*)indexno
{
    NSString *ProspectID;
    
   // NSLog(@"......NameLA....... - %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"]);
    
     NSString *propectname = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"];

    NSString *querySQL = [NSString stringWithFormat:@"select IndexNo from prospect_profile where ProspectName = '%@'", propectname];
    
    
    
    
    FMResultSet *results =  [database2 executeQuery:querySQL];
    
    while ([results next]) {
        
         ProspectID = [results objectForColumnIndex:0];

       
    }
    
  
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    
     
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    
    [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr = [dateFormatter2 stringFromDate:[NSDate date]];
    
    //2 - Created
       NSString *querySQL3 = [NSString stringWithFormat:@"INSERT INTO eApp_Listing (ClientProfileID, POName, IDNumber, ProposalNo, DateCreated, Status) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\" ) ",ProspectID,poname,ic, eProposalNo,dateStr, @"2"];
        [database2 executeUpdate:querySQL3];
    //NSLog(@"eApp_Listing - %@", querySQL3);
    
}
-(void) insert_eproposal_LA_details:(NSString*)FinalPTypeCode index:(NSString*)indexNo POFlag:(NSString*)poflag
{
    
    sqlite3_stmt *statement;
     SecPo_LADetails_Client = [NSMutableDictionary dictionary];
   FMResultSet *results;
   
   // const char *dbpath = [databasePath UTF8String];        
   //     NSString* si = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
        
        //KY PULL THE CLIENT INFO FROM prospect_profile table
        NSString *querySQL3 = [NSString stringWithFormat:@"SELECT * from prospect_profile where IndexNo = '%@'",indexNo];
 //   NSLog(@"querySQL3 - %@", querySQL3);
    
        const char *query_stmt3 = [querySQL3 UTF8String];
      /*  if (sqlite3_prepare_v2(contactDB, query_stmt3, -1, &statement, NULL) == SQLITE_OK)
        {
            if(sqlite3_step(statement) == SQLITE_ROW)
            {
        */
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
        if  ((NSNull *) ResidenceAddressState == [NSNull null])
            ResidenceAddressState = @"";
        
 
        NSString *ResidenceAddressPostCode = [results objectForColumnIndex:10];
        if  ((NSNull *) ResidenceAddressPostCode == [NSNull null])
            ResidenceAddressPostCode = @"";
        
   
        NSString *ResidenceAddressCountry =   [results objectForColumnIndex:11];
        if  ((NSNull *) ResidenceAddressCountry == [NSNull null])
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
    
       if  ( ((NSNull *) OtherIDType == [NSNull null])  || [(NSString *)OtherIDType isEqualToString:@"(null)"] )
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
        
        
        
                //insert into eProposal_LA_Details
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *docsPath = [paths objectAtIndex:0];
         //       NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
                
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
        
        results = nil;
        results = [database2 executeQuery:[NSString stringWithFormat:@"SELECT GuardianName, CONewICNo FROM eProposal WHERE eProposalNo = %@", eProposalNo]];
        while ([results next]) {
            guardianName = [results objectForColumnName:@"GuardianName"];
            guardianNRIC = [results objectForColumnName:@"CONewICNo"];
        }

        
                NSString *sqlQuery = [NSString stringWithFormat:@"INSERT INTO eProposal_LA_Details (\"eProposalNo\", \"PTypeCode\", \"LATitle\", \"LAName\", \"LASex\", \"LADOB\", \"LANewICNO\", \"LAOtherIDType\", \"LAOtherID\", \"LAMaritalStatus\", \"LARace\", \"LAReligion\", \"LANationality\", \"LAOccupationCode\", \"LAExactDuties\", \"LATypeOfBusiness\", \"LAEmployerName\", \"LAYearlyIncome\", \"LARelationship\", \"POFlag\", \"CorrespondenceAddress\", \"ResidenceOwnRented\", \"ResidenceAddress1\", \"ResidenceAddress2\", \"ResidenceAddress3\", \"ResidenceTown\", \"ResidenceState\", \"ResidencePostcode\", \"ResidenceCountry\", \"OfficeAddress1\", \"OfficeAddress2\", \"OfficeAddress3\", \"OfficeTown\", \"OfficeState\", \"OfficePostcode\", \"OfficeCountry\", \"ResidencePhoneNo\", \"OfficePhoneNo\", \"FaxPhoneNo\", \"MobilePhoneNo\", \"EmailAddress\", \"PentalHealthStatus\", \"PentalFemaleStatus\", \"PentalDeclarationStatus\", \"LACompleteFlag\", \"AddPO\", \"CreatedAt\", \"UpdatedAt\") VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", eProposalNo, FinalPTypeCode, ProspectTitle, ProspectName, ProspectGender, ProspectDOB, IDTypeNo, OtherIDType, OtherIDTypeNo, MaritalStatus, Race, Religion, Nationality, ProspectOccupationCode, ExactDuties, BussinessType, @"", AnnIncome, @"", poflag, @"", @"", ResidenceAddress1, ResidenceAddress2, ResidenceAddress3, ResidenceAddressTown, ResidenceAddressState, ResidenceAddressPostCode, ResidenceAddressCountry, OfficeAddress1, OfficeAddress2, OfficeAddress3, OfficeAddressTown, OfficeAddressState, OfficeAddressPostCode, OfficeAddressCountry, homeNo, officeNo, faxNo, mobileNo, ProspectEmail, @"", @"", @"", @"", @"", currentdate, @""];
        
     //    NSLog(@"!!!!!kky sqlQuery - %@", sqlQuery);
                [database2 executeUpdate:sqlQuery];
        
       
            /*
                const char *query_stmt = [sqlQuery UTF8String];
        
           

                if(sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    
                     if (sqlite3_step(statement) == SQLITE_DONE){
                    NSLog(@"Insert into eProspect_LA_Details Successfull");
                 
                    }
                     else
                         NSLog(@"Insert into eProspect_LA_Details Failed");
                }
                
            */
        
        [[obj.eAppData objectForKey:@"EAPP"] setValue:IDTypeNo forKey:@"POIDTypeNo"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:OtherIDTypeNo forKey:@"POOtherIDTypeNo"];
        
        [SecPo_LADetails_Client setValue:eProposalNo forKey:@"eProposalNo"];
        [SecPo_LADetails_Client setValue:FinalPTypeCode forKey:@"PTypeCode"];
        [SecPo_LADetails_Client setValue:ProspectTitle forKey:@"LATitle"];
        [SecPo_LADetails_Client setValue:ProspectName forKey:@"LAName"];
        
        [SecPo_LADetails_Client setValue:ProspectGender forKey:@"LASex"];
        
       
        
        [SecPo_LADetails_Client setValue:ProspectDOB forKey:@"LADOB"];
        [SecPo_LADetails_Client setValue:IDTypeNo forKey:@"LANewICNO"];
        [SecPo_LADetails_Client setValue:OtherIDType forKey:@"LAOtherIDType"];
        
        [SecPo_LADetails_Client setValue:OtherIDTypeNo forKey:@"LAOtherID"];
        [SecPo_LADetails_Client setValue:MaritalStatus forKey:@"LAMaritalStatus"];
        [SecPo_LADetails_Client setValue:Race forKey:@"LARace"];
        [SecPo_LADetails_Client setValue:Religion forKey:@"LAReligion"];
        
        [SecPo_LADetails_Client setValue:ProspectOccupationCode forKey:@"LAOccupationCode"];
        
        NSString *query = [NSString stringWithFormat:@"SELECT OccpDesc FROM Adm_Occp WHERE OccpCode = %@", ProspectOccupationCode];
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if ((sqlite3_step(statement)) == SQLITE_DONE) {
                const char *occp = (const char*)sqlite3_column_text(statement, 0);
                [SecPo_LADetails_Client setValue:[[NSString alloc] initWithUTF8String:occp] forKey:@"LAOccupationCode"];
            }
        }
        
        [SecPo_LADetails_Client setValue:Nationality forKey:@"LANationality"];
        [SecPo_LADetails_Client setValue:ExactDuties forKey:@"LAExactDuties"];
        [SecPo_LADetails_Client setValue:BussinessType forKey:@"LATypeOfBusiness"];
        
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
        
        
        
        
        
        [SecPo_LADetails_Client setValue:@"" forKey:@"LACompleteFlag"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"AddPO"];
        [SecPo_LADetails_Client setValue:currentdate forKey:@"CreatedAt"];
        [SecPo_LADetails_Client setValue:@"" forKey:@"UpdatedAt"];
        
        
        
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
                
    }
          //  }
     //   }

    //    sqlite3_finalize(statement);
        
        
 
    
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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyMMddhhmmssSSS"];
    NSString *currentdate = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *plancode = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
  
 //   sqlite3_stmt *statement;
  //  const char *dbpath = [databasePath UTF8String];
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
 
    [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr = [dateFormatter2 stringFromDate:[NSDate date]];

    // 2 - created
    NSString *SIListingSQL = [NSString stringWithFormat:
                              @"INSERT INTO eProposal (eProposalNo, SINo, Status, GuardianName, BasicPlanCode, SIVersion , CreatedAt) VALUES "
                              "(\"RN%@\", \"%@\", \"%@\", \"%@\", \"%@\",\"%@\",\"%@\") ",currentdate, _SINumberSelected.text, @"2", @"", plancode ,str_SIVersion ,dateStr];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];

     
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
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
    
    
   // NSLog(@"status - %@ || sys version || - |%@|version - |%@| - ",str_SIStatus, str_Sys_SI_Version, str_SIVersion);
    if([str_SIStatus isEqualToString:@"INVALID"] || [str_SIStatus isEqualToString:@""])
        error = @"This SI is not valid, please fill up all details first.";
    else if(![str_SIVersion isEqualToString:str_Sys_SI_Version])
        error = @"This SI is not updated. Please update it in SI Module first.";
    else
        error = @""; //OK
    if(error.length > 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
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
    agree.view.superview.frame = CGRectMake(230, 230, 350, 640);
    //SI Acknowlege for Agreement - END

    }
      
    
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
        [[obj.eAppData objectForKey:@"EAPP"] setValue:_SIPlanSelected.text forKey:@"SIPlanName"];
        
        
        
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
    NSLog(@"KKY .......selectSI - plan  - %@",plan );
	
     // [[NSNotificationCenter defaultCenter] postNotificationName:@"eApp_SIPlan" object:self];
      //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDeleteNominee:) name:@"DeleteNominee" object:nil];
    
	[self.delegate updateChecklistSI];
    
    if([plan isEqualToString:@"HLA Cash Promise"])
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
        
        NSLog(@"view SIPageView");
        
        mainStoryboard = Nil, main = Nil;
    }
    else if([plan isEqualToString:@"HLA EverLife"])
    {
        NSLog(@"selectSI.....EVERLIFE");
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
        EverSeriesMasterViewController *main = [mainStoryboard instantiateViewControllerWithIdentifier:@"EverSeriesMaster"];
        main.modalTransitionStyle = UIModalPresentationFormSheet;
        [self presentViewController:main animated:YES completion:nil];
         NSLog(@"view EverSeriesMaster");
          mainStoryboard = Nil, main = Nil;
     
    }
    
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
