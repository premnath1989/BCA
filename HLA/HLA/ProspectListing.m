//
//  ProspectListing.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ProspectListing.h"
#import <sqlite3.h>
#import "ProspectProfile.h"
#import "ProspectViewController.h"
#import "EditProspect.h"
#import "AppDelegate.h"
#import "MainScreen.h"
#import "ColorHexCode.h"
#import "IDTypeViewController.h"
#import "MBProgressHUD.h"
#import "CustomAlertBox.h"
#import "ClearData.h"
#import "Cleanup.h"

@interface ProspectListing ()

@end

@implementation ProspectListing
@synthesize ProspectTableData, FilteredProspectTableData, isFiltered;
@synthesize txtIDTypeNo,btnGroup,groupLabel;
@synthesize EditProspect = _EditProspect;
@synthesize ProspectViewController = _ProspectViewController;
@synthesize idNoLabel,idTypeLabel,clientNameLabel,editBtn,deleteBtn,nametxt;
@synthesize GroupList = _GroupList;
@synthesize GroupPopover = _GroupPopover;
@synthesize dataMobile,dataPrefix;
@synthesize OrderBy;

int RecDelete = 0;
int totalView = 20;
int TotalData;

MBProgressHUD *HUD;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.noMoreResultsAvail =NO;
	totalView = 20;
	
    [btnGroup setTitle:@"- SELECT -" forState:UIControlStateNormal];
    btnGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    _btnSortBy.hidden=true;
   
    _outletOrder.hidden=true;
    
	AppDelegate *appDel= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	appDel.MhiMessage = Nil;
	appDel = Nil;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eApp_SI:) name:@"eApp_SI" object:nil];
    
  
    
    [self.view endEditing:YES];
    [self resignFirstResponder];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
//    searchBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Client Profile Listing";
    self.navigationItem.titleView = label;
    
//    searchBar.delegate = (id)self;
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    NSString *ProspectID = @"";
    NSString *NickName = @"";
    NSString *ProspectName = @"";
    NSString *ProspectDOB = @"" ;
    NSString *ProspectGender = @"";
    NSString *ResidenceAddress1 = @"";
    NSString *ResidenceAddress2 = @"";
    NSString *ResidenceAddress3 = @"";
    NSString *ResidenceAddressTown = @"";
    NSString *ResidenceAddressState = @"";
    NSString *ResidenceAddressPostCode = @"";
    NSString *ResidenceAddressCountry = @"";
    NSString *OfficeAddress1 = @"";
    NSString *OfficeAddress2 = @"";
    NSString *OfficeAddress3 = @"";
    NSString *OfficeAddressTown = @"";
    NSString *OfficeAddressState = @"";
    NSString *OfficeAddressPostCode = @"";
    NSString *OfficeAddressCountry = @"";
    NSString *ProspectEmail = @"";
    NSString *ProspectOccupationCode = @"";
    NSString *ExactDuties = @"";
    NSString *ProspectRemark = @"";
    //basvi added
    NSString *DateCreated = @"";
    NSString *CreatedBy = @"";
    NSString *DateModified = @"";
    NSString *ModifiedBy = @"";
    //
    NSString *ProspectGroup = @"";
    NSString *ProspectTitle = @"";
    NSString *IDTypeNo = @"";
    NSString *OtherIDType = @"";
    NSString *OtherIDTypeNo = @"";
    NSString *Smoker = @"";
   
    NSString *Race = @"";
    
    NSString *Nationality = @"";
    NSString *MaritalStatus = @"";
    NSString *Religion = @"";
    
    NSString *AnnIncome = @"";
    NSString *BussinessType = @"";
	
	NSString *registration = @"";
	NSString *registrationNo = @"";
	NSString *registrationDate = @"";
	NSString *exempted = @"";
	
	NSString *CountryOfBirth = @"";
	
	
    [self getTotal]; //just to get total row of data.
	
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
		
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by LOWER(ProspectName) ASC LIMIT 20"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            ProspectTableData = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                

               

                ProspectID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];

                const char *name = (const char*)sqlite3_column_text(statement, 1);
                NickName = name == NULL ? nil : [[NSString alloc] initWithUTF8String:name];
                
                ProspectName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                ProspectDOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                ProspectGender = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
                const char *Address1 = (const char*)sqlite3_column_text(statement, 5);
                ResidenceAddress1 = Address1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address1];
                
                const char *Address2 = (const char*)sqlite3_column_text(statement, 6);
                ResidenceAddress2 = Address2 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address2];
                
                const char *Address3 = (const char*)sqlite3_column_text(statement, 7);
                ResidenceAddress3 = Address3 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address3];
                
                const char *AddressTown = (const char*)sqlite3_column_text(statement, 8);
                ResidenceAddressTown = AddressTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressTown];
                
                const char *AddressState = (const char*)sqlite3_column_text(statement, 9);
                ResidenceAddressState = AddressState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressState];
                
                const char *AddressPostCode = (const char*)sqlite3_column_text(statement, 10);
                ResidenceAddressPostCode = AddressPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressPostCode];
                
                const char *AddressCountry = (const char*)sqlite3_column_text(statement, 11);
                ResidenceAddressCountry = AddressCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressCountry];
                
                const char *AddressOff1 = (const char*)sqlite3_column_text(statement, 12);
                OfficeAddress1 = AddressOff1 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff1];
                
                const char *AddressOff2 = (const char*)sqlite3_column_text(statement, 13);
                OfficeAddress2 = AddressOff2 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff2];
                
                const char *AddressOff3 = (const char*)sqlite3_column_text(statement, 14);
                OfficeAddress3 = AddressOff3 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff3];
                
                const char *AddressOffTown = (const char*)sqlite3_column_text(statement, 15);
                OfficeAddressTown = AddressOffTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffTown];
                
                const char *AddressOffState = (const char*)sqlite3_column_text(statement, 16);
                OfficeAddressState = AddressOffState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffState];
                
                const char *AddressOffPostCode = (const char*)sqlite3_column_text(statement, 17);
                OfficeAddressPostCode = AddressOffPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffPostCode];
                
                const char *AddressOffCountry = (const char*)sqlite3_column_text(statement, 18);
                OfficeAddressCountry = AddressOffCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffCountry];
                
                const char *Email = (const char*)sqlite3_column_text(statement, 19);
                ProspectEmail = Email == NULL ? nil : [[NSString alloc] initWithUTF8String:Email];
                
                ProspectOccupationCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 20)];
                
                const char *Duties = (const char*)sqlite3_column_text(statement, 21);
                ExactDuties = Duties == NULL ? nil : [[NSString alloc] initWithUTF8String:Duties];
                
                const char *Remark = (const char*)sqlite3_column_text(statement, 22);
                ProspectRemark = Remark == NULL ? nil : [[NSString alloc] initWithUTF8String:Remark];
                
                //basvi added
                const char *DateCr = (const char*)sqlite3_column_text(statement, 23);
                DateCreated = DateCr == NULL ? nil : [[NSString alloc] initWithUTF8String:DateCr];
                
                const char *CrBy = (const char*)sqlite3_column_text(statement, 24);
                CreatedBy = CrBy == NULL ? nil : [[NSString alloc] initWithUTF8String:CrBy];
                
                const char *DateMod = (const char*)sqlite3_column_text(statement, 25);
                DateModified = DateMod == NULL ? nil : [[NSString alloc] initWithUTF8String:DateMod];
                
                const char *ModBy = (const char*)sqlite3_column_text(statement, 26);
                ModifiedBy = ModBy == NULL ? nil : [[NSString alloc] initWithUTF8String:ModBy];
                //
                const char *Group = (const char*)sqlite3_column_text(statement, 27);
                ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                
                const char *Title = (const char*)sqlite3_column_text(statement, 28);
                ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                
                const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
                IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                
                const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
                OtherIDType = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
				if ([OtherIDType isEqualToString:@"(NULL)"] || [OtherIDType isEqualToString:@"(null)"])
					OtherIDType = @"";
                
                const char *OtherTypeNo = (const char*)sqlite3_column_text(statement, 31);
                OtherIDTypeNo = OtherTypeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherTypeNo];
                
                const char *smok = (const char*)sqlite3_column_text(statement, 32);
                Smoker = smok == NULL ? nil : [[NSString alloc] initWithUTF8String:smok];
                
                const char *ann = (const char*)sqlite3_column_text(statement, 33);
                AnnIncome = ann == NULL ? nil : [[NSString alloc] initWithUTF8String:ann];
                
                const char *buss = (const char*)sqlite3_column_text(statement, 34);
                BussinessType = buss == NULL ? nil : [[NSString alloc] initWithUTF8String:buss];
                
                const char *rac = (const char*)sqlite3_column_text(statement, 35);
                Race = rac == NULL ? nil : [[NSString alloc] initWithUTF8String:rac];
                
                const char *marstat = (const char*)sqlite3_column_text(statement, 36);
                MaritalStatus = marstat == NULL ? nil : [[NSString alloc] initWithUTF8String:marstat];
                
                const char *rel = (const char*)sqlite3_column_text(statement, 37);
                Religion = rel == NULL ? nil : [[NSString alloc] initWithUTF8String:rel];
                
                const char *nat = (const char*)sqlite3_column_text(statement, 38);
                Nationality = nat == NULL ? nil : [[NSString alloc] initWithUTF8String:nat];
				
				
				const char *gst = (const char*)sqlite3_column_text(statement, 40);
                registration = gst == NULL ? nil : [[NSString alloc] initWithUTF8String:gst];
				const char *regNo = (const char*)sqlite3_column_text(statement, 41);
                registrationNo = regNo == NULL ? nil : [[NSString alloc] initWithUTF8String:regNo];
				const char *regDate = (const char*)sqlite3_column_text(statement, 42);
                registrationDate = regDate == NULL ? nil : [[NSString alloc] initWithUTF8String:regDate];
				const char *exemp = (const char*)sqlite3_column_text(statement, 43);
                exempted = exemp == NULL ? nil : [[NSString alloc] initWithUTF8String:exemp];
				
				const char *isG = (const char*)sqlite3_column_text(statement, 45);
                NSString *isGrouping = isG == NULL ? nil : [[NSString alloc] initWithUTF8String:isG];
				
				const char *CountryOfBirth = (const char*)sqlite3_column_text(statement, 46);
                NSString *COB = CountryOfBirth == NULL ? nil : [[NSString alloc] initWithUTF8String:CountryOfBirth];
				
//				NSLog(@"GST value: %@, %@, %@, %@", registrationNo, registration, registrationDate, exempted);
                

                
                
                [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                                  AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                              AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3  
                                                           AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                                       AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry 
                                                                 AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown 
                                                             AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                           AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndDateCreated:DateCreated AndDateModified:DateModified AndCreatedBy:CreatedBy AndModifiedBy:ModifiedBy
                                                         AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB
																	AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:registrationNo AndRegistration:registration AndRegistrationDate:registrationDate AndRegistrationExempted:exempted AndProspect_IsGrouping:isGrouping AndCountryOfBirth:COB]];
				
                
            }
				
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(contactDB);
        query_stmt = Nil, query_stmt = Nil;
    }
    
    label = Nil, dirPaths = Nil, docsDir = Nil, dbpath = Nil, statement = Nil, statement = Nil;
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
    //basvi
    DateCreated = Nil;
    CreatedBy = Nil;
    DateModified = Nil;
    ModifiedBy = Nil;
    //
    ProspectTitle = Nil, ProspectGroup = Nil, IDTypeNo = Nil, OtherIDType = Nil, OtherIDTypeNo = Nil, Smoker = Nil;
    Race = Nil, Religion = Nil, MaritalStatus = Nil, Nationality = Nil;
    
    self.myTableView.rowHeight = 50;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.separatorColor = [UIColor clearColor];
    self.myTableView.opaque = NO;
    
    
    
    deleteBtn.hidden = TRUE;
    deleteBtn.enabled = FALSE;
    ItemToBeDeleted = [[NSMutableArray alloc] init];
    indexPaths = [[NSMutableArray alloc] init];
    
    CGRect frame1=CGRectMake(-40,169, 196, 50);
    idTypeLabel.frame = frame1;
    idTypeLabel.textAlignment = UITextAlignmentCenter;
    idTypeLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    idTypeLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    idTypeLabel.font=[UIFont boldSystemFontOfSize:15];
    idTypeLabel.text = @"Name";
    
    CGRect frame2=CGRectMake(156,169, 196, 50);
    idNoLabel.frame = frame2;
    idNoLabel.textAlignment = UITextAlignmentCenter;
    idNoLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    idNoLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    idNoLabel.font=[UIFont boldSystemFontOfSize:15];
    
    
    CGRect frame3=CGRectMake(312,169, 196, 50);
    clientNameLabel.frame = frame3;
    clientNameLabel.textAlignment = UITextAlignmentCenter;
    clientNameLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    clientNameLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    clientNameLabel.font=[UIFont boldSystemFontOfSize:15];
    clientNameLabel.text = @"Mobile Number";
    
    //    CGRect frame4=CGRectMake(750,169, 220, 50);
    //    groupLabel.frame = frame4;
    //    groupLabel.textAlignment = UITextAlignmentCenter;
    //    groupLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    //    groupLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    
    CGRect frame4=CGRectMake(478,169, 156, 50);
    UILabel *DateCreatedlbl=[[UILabel alloc]init];
    DateCreatedlbl.frame = frame4;
    DateCreatedlbl.textAlignment = UITextAlignmentCenter;
    DateCreatedlbl.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    DateCreatedlbl.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    DateCreatedlbl.font=[UIFont boldSystemFontOfSize:15];
    DateCreatedlbl.text=@"1st Creation Date";
    [self.view addSubview:DateCreatedlbl];
    
    
    CGRect frame5=CGRectMake(624,169, 196, 50);
    UILabel *DateUpdatedlbl=[[UILabel alloc]init];
    DateUpdatedlbl.frame = frame5;
    DateUpdatedlbl.textAlignment = UITextAlignmentCenter;
    DateUpdatedlbl.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    DateUpdatedlbl.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    DateUpdatedlbl.font=[UIFont boldSystemFontOfSize:15];
    DateUpdatedlbl.text=@"Last Updated Date";
    [self.view addSubview:DateUpdatedlbl];
	
	
	CGRect frame6=CGRectMake(790,169, 196, 50);
    UILabel *TimeRemaining=[[UILabel alloc]init];
    TimeRemaining.frame = frame6;
    TimeRemaining.textAlignment = UITextAlignmentCenter;
    TimeRemaining.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    TimeRemaining.backgroundColor =[CustomColor colorWithHexString:@"4F81BD"];
    TimeRemaining.font=[UIFont boldSystemFontOfSize:15];
    TimeRemaining.text=[NSString stringWithFormat:@"Time Remaining"];
    [self.view addSubview:TimeRemaining];

    
//    CGRect frame4=CGRectMake(750,169, 220, 50);  
//    groupLabel.frame = frame4;
//    groupLabel.textAlignment = UITextAlignmentCenter;
//    groupLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
//    groupLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CustomColor = Nil;
    
    [self getMobileNo];
    
    OrderBy = @"ASC";
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ReloadTableData) name:@"ReloadData" object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
   
    [super viewDidAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}


#pragma mark - `Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//	return [ProspectTableData count]; ORIGINAL
	
	if([ ProspectTableData count] ==0){
        return 0;
    }
    else {
        return [ProspectTableData count]+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
   
	//change
	
	if (ProspectTableData.count != 0) {
		if (indexPath.row == [ProspectTableData count]){
			
			cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//			if (cell == nil) {
				cell = [[UITableViewCell alloc]
						initWithStyle:UITableViewCellStyleDefault
						reuseIdentifier:CellIdentifier];
//			}
			
			//		NSLog(@"totalview: %d, tabledata %d", totalView, count);
			
			if ([ProspectTableData count] == TotalData) {
				cell.textLabel.text = @"No More records Available";
			}
			else {
				cell.textLabel.text = @"Load more records...";
				
				//			cell.detailTextLabel.text = @"Load more items...";
			}
			
			cell.textLabel.textColor = [UIColor grayColor];
			cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
            cell.userInteractionEnabled = NO;
		
		}
        else if(indexPath.row <[ProspectTableData count]){
			
//			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
				cell.userInteractionEnabled = YES;
//			});
			
			cell.textLabel.text = nil;

			
			//ORIGINAL
			[[cell.contentView viewWithTag:2001] removeFromSuperview ];
			[[cell.contentView viewWithTag:2002] removeFromSuperview ];
			[[cell.contentView viewWithTag:2003] removeFromSuperview ];
			[[cell.contentView viewWithTag:2004] removeFromSuperview ];
			[[cell.contentView viewWithTag:2005] removeFromSuperview ];
			[[cell.contentView viewWithTag:2006] removeFromSuperview ];
			
			ProspectProfile *pp = [ProspectTableData objectAtIndex:indexPath.row];
			ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
			
			CGRect frame=CGRectMake(-30,0, 206, 50);
			UILabel *label1=[[UILabel alloc]init];
			label1.frame=frame;
			label1.text= [NSString stringWithFormat:@"        %@",pp.ProspectName];
			label1.textAlignment = UITextAlignmentLeft;
			label1.tag = 2001;
			cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
			[cell.contentView addSubview:label1];
			
			CGRect frame2=CGRectMake(156,0, 196, 50);
			UILabel *label2=[[UILabel alloc]init];
			label2.frame=frame2;
			
			pp.OtherIDTypeNo = [pp.OtherIDTypeNo stringByTrimmingCharactersInSet:
								[NSCharacterSet whitespaceCharacterSet]];
			
			if(([pp.OtherIDType isEqualToString:@"EXPECTED DELIVERY DATE"] || [pp.OtherIDType isEqualToString:@"EDD"]) && [pp.IDTypeNo isEqualToString:@""])
			{
				
				[label2 setNumberOfLines:1];
				label2.text= pp.ProspectDOB ;
			}
			
			else if(![pp.OtherIDTypeNo isEqualToString:@""] && ![pp.IDTypeNo isEqualToString:@""])
			{
				
				[label2 setNumberOfLines:2];
				label2.text = [NSString stringWithFormat:@"%@\n%@", pp.IDTypeNo, pp.OtherIDTypeNo];
			}
			else if(![pp.IDTypeNo isEqualToString:@""])
			{
				
				[label2 setNumberOfLines:1];
				label2.text= pp.IDTypeNo;
			}
			else if(![pp.OtherIDTypeNo isEqualToString:@""])
			{
				
				[label2 setNumberOfLines:1];
				label2.text= pp.OtherIDTypeNo;
			}
			
			
			
			
			
			label2.textAlignment = UITextAlignmentCenter;
			label2.tag = 2002;
			cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
			[cell.contentView addSubview:label2];
			
			CGRect frame3=CGRectMake(312,0, 196, 50);
			UILabel *label3=[[UILabel alloc]init];
			label3.frame=frame3;
			if (![[dataPrefix objectAtIndex:indexPath.row] isEqualToString:@""]) {
				label3.text= [NSString stringWithFormat:@"%@ - %@",[dataPrefix objectAtIndex:indexPath.row],[dataMobile objectAtIndex:indexPath.row]];
			}
			else {
				label3.text = @"";
			}
			label3.textAlignment = UITextAlignmentCenter;
			label3.tag = 2003;
			cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
			[cell.contentView addSubview:label3];
			
			
			
			
			//date format for date created
			
			NSArray *dateArray = [pp.DateCreated componentsSeparatedByString:@" "];
			
			NSString *dateF =[dateArray objectAtIndex:0];
			
			NSDateFormatter *df = [[NSDateFormatter alloc] init];
			[df setDateFormat:@"yyyy-MM-dd"];
			NSDate *myDate = [df dateFromString: dateF];
			
			
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"dd/MM/yyyy"];
			NSDate * CurrentdateString = [dateFormat stringFromDate:myDate];
			
			NSString *timeF =[dateArray objectAtIndex:1];
			
			
			
			
			CGRect frame4=CGRectMake(478,0, 156, 50);
			UILabel *label4=[[UILabel alloc]init];
			label4.frame=frame4;
			label4.textAlignment = UITextAlignmentCenter;
			label4.tag = 2004;
			label4.text= [NSString stringWithFormat:@"%@\n%@",CurrentdateString,timeF];
			[label4 setNumberOfLines:2];
			cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
			[cell.contentView addSubview:label4];
			NSString *finaldate;
			//date formatted for date modified
			if([pp.DateModified isEqualToString:@""])
			{
				finaldate=pp.DateModified;
				
				
			}
			else
			{
				NSArray *dateArray1 = [pp.DateModified componentsSeparatedByString:@" "];
				
				NSString *dateF1 =[dateArray1 objectAtIndex:0];
				
				NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
				[df1 setDateFormat:@"yyyy-MM-dd"];
				NSDate *myDate1 = [df dateFromString: dateF1];
				
				
				NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
				[dateFormat1 setDateFormat:@"dd/MM/yyyy"];
				NSDate * CurrentdateString1 = [dateFormat1 stringFromDate:myDate1];
				
				
				NSString *timeF1 =[dateArray1 objectAtIndex:1];
				finaldate =[NSString stringWithFormat:@"%@\n%@",CurrentdateString1,timeF1];
				
			}
			
			
			CGRect frame5=CGRectMake(614,0, 196, 50);
			UILabel *label5=[[UILabel alloc]init];
			label5.frame=frame5;
			label5.textAlignment = UITextAlignmentCenter;
			label5.tag = 2005;
			label5.text= finaldate;
			[label5 setNumberOfLines:2];
						
			
			NSArray *CreatedDate = [pp.DateCreated componentsSeparatedByString:@" "];
			
			NSString *CreatedDateString = [CreatedDate objectAtIndex:0];
			
			NSString *CreatedTimeString = [CreatedDate objectAtIndex:1];
			
			NSString *DateNTime = [NSString stringWithFormat:@"%@ %@",CreatedDateString,CreatedTimeString];
			
			
			NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
            // this is imporant - we set our input date format to match our input string
            // if format doesn't match you'll get nil from your string, so be careful
            [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *dateFromString1 = [[NSDate alloc] init];
            // voila!
            dateFromString1 = [dateFormatter1 dateFromString:DateNTime];
			
			
			NSDate *currDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate:currDate];
			
			NSDate *FinalDate = dateFromString1;
            NSLog(@"dttt %@",dateFromString1);
    //        NSLog(@"dyyy %@",FinalDate);
            
            NSString *strNewDate;
            NSString *strCurrentDate;
            NSDateFormatter *df1 =[[NSDateFormatter alloc]init];
            [df1 setDateStyle:NSDateFormatterMediumStyle];
            [df1 setTimeStyle:NSDateFormatterMediumStyle];
            strCurrentDate = [df1 stringFromDate:FinalDate];
   //         NSLog(@"Current Date and Time: %@",strCurrentDate);
            int hoursToAdd = 720;
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setHour:hoursToAdd];
            NSDate *newDate= [calendar dateByAddingComponents:components toDate:FinalDate options:0];
            //    [df setDateStyle:NSDateFormatterMediumStyle];
            //    [df setTimeStyle:NSDateFormatterMediumStyle];
            
            [df setDateFormat:@"dd/MM/yyyy ( HH:mm a )"];
            strNewDate = [df stringFromDate:newDate];
            NSLog(@"New Date and Time: %@",strNewDate);
			
			NSDate *mydate = [NSDate date];
            NSTimeInterval secondsInEightHours = 8 * 60 * 60;
            NSDate *currentDate = [mydate dateByAddingTimeInterval:secondsInEightHours];
            NSDate *expireDate = [newDate dateByAddingTimeInterval:secondsInEightHours];
            
            int countdown = -[currentDate timeIntervalSinceDate:expireDate];//pay attention here.
			int minutes = (countdown / 60) % 60;
            int hours = (countdown / 3600) % 24;
            int days = (countdown / 86400) % 30;
            NSLog(@"countdown %d %d %d",days,hours,minutes);
			
			NSString *DateRemaining =[NSString stringWithFormat:@"%d Days %d Hours\n %d Minutes",days,hours,minutes];
			
           
			CGRect frame6=CGRectMake(794,0, 186, 50);
			UILabel *label6=[[UILabel alloc]init];
			label6.frame=frame6;
			label6.textAlignment = UITextAlignmentCenter;
			label6.tag = 2006;
			label6.text= DateRemaining;
			[label6 setNumberOfLines:2];
			
			cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
			[cell.contentView addSubview:label6];
			
			cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
			[cell.contentView addSubview:label5];
			
			if (indexPath.row % 2 == 0) {
				label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
				label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
				label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
				label4.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
				label5.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
				label6.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
				
				label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
			}
			else {
				label1.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
				label2.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
				label3.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
				label4.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
				label5.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
				label6.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
				
				label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label5.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
				label6.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
			}
			
			
			// ADD HERE
			[spinner stopAnimating];
			spinner.hidden=YES;
			
//			cell.textLabel.text=nil;
			
//			UILabel* loadingLabel = [[UILabel alloc]init];
//			loadingLabel.font=[UIFont boldSystemFontOfSize:14.0f];
//			loadingLabel.textAlignment = UITextAlignmentLeft;
//			loadingLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
//			loadingLabel.numberOfLines = 0;
//			loadingLabel.text=@"No More data Available";
//			loadingLabel.frame=CGRectMake(85,20, 302,25);
//			[cell addSubview:loadingLabel];
			
			pp = Nil;

        }
        else{
            if (!self.noMoreResultsAvail) {
                spinner.hidden =NO;
                cell.textLabel.text=nil;
                
//				UILabel* loadingLabel = [[UILabel alloc]init];
//                loadingLabel.font=[UIFont boldSystemFontOfSize:14.0f];
//                loadingLabel.textAlignment = UITextAlignmentLeft;
//                loadingLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
//                loadingLabel.numberOfLines = 0;
//                loadingLabel.text=@"LOADING DATA";
//                loadingLabel.frame=CGRectMake(85,20, 302,25);
//                [cell addSubview:loadingLabel];
                
                spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                spinner.frame = CGRectMake(150, 10, 24, 50);
                [cell addSubview:spinner];
                if ([ProspectTableData count] >= 10) {
                    [spinner startAnimating];
                }
            }
            
            else{
				
                [spinner stopAnimating];
                spinner.hidden=YES;
                
                cell.textLabel.text=nil;
                
//                UILabel* loadingLabel = [[UILabel alloc]init];
//                loadingLabel.font=[UIFont boldSystemFontOfSize:14.0f];
//                loadingLabel.textAlignment = UITextAlignmentLeft;
//                loadingLabel.textColor = [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0];
//                loadingLabel.numberOfLines = 0;
//                loadingLabel.text=@"No More data Available";
//                loadingLabel.frame=CGRectMake(85,20, 302,25);
//                [cell addSubview:loadingLabel];
				
            }
            
        }
    }
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

#pragma UIScroll View Method::
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!self.loading) {
        float endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (endScrolling >= scrollView.contentSize.height)
        {
            [self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:1];
            
        }
    }
}

#pragma UserDefined Method for generating data which are show in Table :::
-(void)loadDataDelayed{
    
//	NSLog(@"totalview: %d, totaldata: %d", totalView, TotalData);
	if (totalView < TotalData) {
		totalView = totalView + 10;
		[self ReloadTableData];
	}
}


- (NSString*) getGroupName:(NSString*)groupid
{
    groupid = [groupid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *groupname = @"";
        FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
        [db open];
    
        FMResultSet *result = [db executeQuery:@"SELECT name from prospect_groups WHERE id = ?", groupid];
        while ([result next]) {
                groupname =  [result stringForColumn:@"name"];

        }
        [result close];
        [db close];
            
    return groupname;
	
	NSString *SqlCount = [NSString stringWithFormat:@"SELECT count(*) as count FROM prospect_profile WHERE QQFlag = 'false'  order by LOWER(ProspectName) ASC"];
}

- (NSString*) getGroupID:(NSString*)groupName
{
    groupName = [groupName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *groupID = @"";
	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	[db open];
    
	FMResultSet *result = [db executeQuery:@"SELECT id from prospect_groups WHERE name = ?", groupName];
	while ([result next]) {
		groupID =  [result stringForColumn:@"id"];
		
	}
	[result close];
	[db close];
	
    return groupID;
}

- (void) getTotal
{

	FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	if ([db close]) {
		[db open];
	}
    
	NSString *SqlCount = [NSString stringWithFormat:@"SELECT count(*) as count FROM prospect_profile WHERE QQFlag = 'false'  order by LOWER(ProspectName) ASC"];
	
	FMResultSet *result = [db executeQuery:SqlCount];
	while ([result next]) {
		TotalData =  [result intForColumn:@"count"];
		
	}
	[result close];
	[db close];
	
	
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecDelete = RecDelete+1;
      
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
            [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            deleteBtn.enabled = FALSE;
        }
        else {
            [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            deleteBtn.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
		NSLog(@"missing: %@", zzz);
        [ItemToBeDeleted addObject:zzz];
        [indexPaths addObject:indexPath];
    }
    else {
		NSUInteger row = [indexPath row];
		NSUInteger count = [ProspectTableData count];
		if (row == count) {
		}
		else {
			
			[self showDetailsForIndexPath:indexPath];
		}
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecDelete = RecDelete - 1;
    
   
    if ([self.myTableView isEditing] == TRUE ) {
        BOOL gotRowSelected = FALSE;
        
        for (UITableViewCell *zzz in [self.myTableView visibleCells])
        {
            if (zzz.selected  == TRUE) {
                gotRowSelected = TRUE;
                break;
            }
        }
       
        /*
        if (!gotRowSelected) {
            [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            deleteBtn.enabled = FALSE;
        }
        else {
                        [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            deleteBtn.enabled = TRUE;
        }
         */
        
        if (RecDelete < 1) {
            [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            deleteBtn.enabled = FALSE;
        }
        else {
            [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            deleteBtn.enabled = TRUE;
        }

        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted removeObject:zzz];
        [indexPaths removeObject:indexPath];
    }
}

-(void) eApp_SI: (NSNotification *)notification
{
    
    NSString  *ppindex = [notification object];
   //DB QUERY START
 
   
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    NSString *ProspectID = @"";
    NSString *NickName = @"";
    NSString *ProspectName = @"";
    NSString *ProspectDOB = @"" ;
    NSString *ProspectGender = @"";
    NSString *ResidenceAddress1 = @"";
    NSString *ResidenceAddress2 = @"";
    NSString *ResidenceAddress3 = @"";
    NSString *ResidenceAddressTown = @"";
    NSString *ResidenceAddressState = @"";
    NSString *ResidenceAddressPostCode = @"";
    NSString *ResidenceAddressCountry = @"";
    NSString *OfficeAddress1 = @"";
    NSString *OfficeAddress2 = @"";
    NSString *OfficeAddress3 = @"";
    NSString *OfficeAddressTown = @"";
    NSString *OfficeAddressState = @"";
    NSString *OfficeAddressPostCode = @"";
    NSString *OfficeAddressCountry = @"";
    NSString *ProspectEmail = @"";
    NSString *ProspectOccupationCode = @"";
    NSString *ExactDuties = @"";
    NSString *ProspectRemark = @"";
    
    //basvi added
    NSString *DateCreated = @"";
    NSString *CreatedBy = @"";
    NSString *DateModified = @"";
    NSString *ModifiedBy = @"";
    //

    NSString *ProspectGroup = @"";
    NSString *ProspectTitle = @"";
    NSString *IDTypeNo = @"";
    NSString *OtherIDType = @"";
    NSString *OtherIDTypeNo = @"";
    NSString *Smoker = @"";
    
    NSString *Race = @"";
    
    NSString *Nationality = @"";
    NSString *MaritalStatus = @"";
    NSString *Religion = @"";
    
    NSString *AnnIncome = @"";
    NSString *BussinessType = @"";
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE IndexNo = %@", ppindex];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            ProspectTableData = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                
                
                
                
                ProspectID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                const char *name = (const char*)sqlite3_column_text(statement, 1);
                NickName = name == NULL ? nil : [[NSString alloc] initWithUTF8String:name];
                
                ProspectName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                ProspectDOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                ProspectGender = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
                const char *Address1 = (const char*)sqlite3_column_text(statement, 5);
                ResidenceAddress1 = Address1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address1];
                
                const char *Address2 = (const char*)sqlite3_column_text(statement, 6);
                ResidenceAddress2 = Address2 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address2];
                
                const char *Address3 = (const char*)sqlite3_column_text(statement, 7);
                ResidenceAddress3 = Address3 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address3];
                
                const char *AddressTown = (const char*)sqlite3_column_text(statement, 8);
                ResidenceAddressTown = AddressTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressTown];
                
                const char *AddressState = (const char*)sqlite3_column_text(statement, 9);
                ResidenceAddressState = AddressState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressState];
                
                const char *AddressPostCode = (const char*)sqlite3_column_text(statement, 10);
                ResidenceAddressPostCode = AddressPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressPostCode];
                
                const char *AddressCountry = (const char*)sqlite3_column_text(statement, 11);
                ResidenceAddressCountry = AddressCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressCountry];
                
                const char *AddressOff1 = (const char*)sqlite3_column_text(statement, 12);
                OfficeAddress1 = AddressOff1 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff1];
                
                const char *AddressOff2 = (const char*)sqlite3_column_text(statement, 13);
                OfficeAddress2 = AddressOff2 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff2];
                
                const char *AddressOff3 = (const char*)sqlite3_column_text(statement, 14);
                OfficeAddress3 = AddressOff3 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff3];
                
                const char *AddressOffTown = (const char*)sqlite3_column_text(statement, 15);
                OfficeAddressTown = AddressOffTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffTown];
                
                const char *AddressOffState = (const char*)sqlite3_column_text(statement, 16);
                OfficeAddressState = AddressOffState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffState];
                
                const char *AddressOffPostCode = (const char*)sqlite3_column_text(statement, 17);
                OfficeAddressPostCode = AddressOffPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffPostCode];
                
                const char *AddressOffCountry = (const char*)sqlite3_column_text(statement, 18);
                OfficeAddressCountry = AddressOffCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffCountry];
                
                const char *Email = (const char*)sqlite3_column_text(statement, 19);
                ProspectEmail = Email == NULL ? nil : [[NSString alloc] initWithUTF8String:Email];
                
                ProspectOccupationCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 20)];
                
                const char *Duties = (const char*)sqlite3_column_text(statement, 21);
                ExactDuties = Duties == NULL ? nil : [[NSString alloc] initWithUTF8String:Duties];
                
                const char *Remark = (const char*)sqlite3_column_text(statement, 22);
                ProspectRemark = Remark == NULL ? nil : [[NSString alloc] initWithUTF8String:Remark];
                //basvi added
                const char *DateCr = (const char*)sqlite3_column_text(statement, 23);
                DateCreated = DateCr == NULL ? nil : [[NSString alloc] initWithUTF8String:DateCr];
                
                const char *CrBy = (const char*)sqlite3_column_text(statement, 24);
                CreatedBy = CrBy == NULL ? nil : [[NSString alloc] initWithUTF8String:CrBy];
                
                const char *DateMod = (const char*)sqlite3_column_text(statement, 25);
                DateModified = DateMod == NULL ? nil : [[NSString alloc] initWithUTF8String:DateMod];
                
                const char *ModBy = (const char*)sqlite3_column_text(statement, 26);
                ModifiedBy = ModBy == NULL ? nil : [[NSString alloc] initWithUTF8String:ModBy];
                //
                const char *Group = (const char*)sqlite3_column_text(statement, 27);
                ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                
                const char *Title = (const char*)sqlite3_column_text(statement, 28);
                ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                
                const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
                IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                
                const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
                OtherIDType = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
				if ([OtherIDType isEqualToString:@"(NULL)"] || [OtherIDType isEqualToString:@"(null)"])
					OtherIDType = @"";
                
                const char *OtherTypeNo = (const char*)sqlite3_column_text(statement, 31);
                OtherIDTypeNo = OtherTypeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherTypeNo];
                
                const char *smok = (const char*)sqlite3_column_text(statement, 32);
                Smoker = smok == NULL ? nil : [[NSString alloc] initWithUTF8String:smok];
                
                const char *ann = (const char*)sqlite3_column_text(statement, 33);
                AnnIncome = ann == NULL ? nil : [[NSString alloc] initWithUTF8String:ann];
                
                const char *buss = (const char*)sqlite3_column_text(statement, 34);
                BussinessType = buss == NULL ? nil : [[NSString alloc] initWithUTF8String:buss];
                
                const char *rac = (const char*)sqlite3_column_text(statement, 35);
                Race = rac == NULL ? nil : [[NSString alloc] initWithUTF8String:rac];
                
                const char *marstat = (const char*)sqlite3_column_text(statement, 36);
                MaritalStatus = marstat == NULL ? nil : [[NSString alloc] initWithUTF8String:marstat];
                
                const char *rel = (const char*)sqlite3_column_text(statement, 37);
                Religion = rel == NULL ? nil : [[NSString alloc] initWithUTF8String:rel];
                
                const char *nat = (const char*)sqlite3_column_text(statement, 38);
                Nationality = nat == NULL ? nil : [[NSString alloc] initWithUTF8String:nat];
                
                const char *reg = (const char*)sqlite3_column_text(statement, 41);
                NSString *registrationNo = reg == NULL ? nil : [[NSString alloc] initWithUTF8String:reg];
        

                const char *isreg = (const char*)sqlite3_column_text(statement, 40);
                NSString *registration = isreg == NULL ? nil : [[NSString alloc] initWithUTF8String:isreg];
                
                const char *regdate = (const char*)sqlite3_column_text(statement, 42);
                NSString *registrationDate = regdate == NULL ? nil : [[NSString alloc] initWithUTF8String:regdate];
                
                const char *exempted = (const char*)sqlite3_column_text(statement, 43);
                NSString *regExempted = exempted == NULL ? nil : [[NSString alloc] initWithUTF8String:exempted];
				
                const char *isG = (const char*)sqlite3_column_text(statement, 45);
                NSString *isGrouping = isG == NULL ? nil : [[NSString alloc] initWithUTF8String:isG];
				
				const char *CountryOfBirth = (const char*)sqlite3_column_text(statement, 46);
                NSString *COB = CountryOfBirth == NULL ? nil : [[NSString alloc] initWithUTF8String:CountryOfBirth];
                
                [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                                  AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                              AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3
                                                           AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                                       AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry
                                                                 AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown
                                                             AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                           AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndDateCreated:DateCreated AndDateModified:DateModified AndCreatedBy:CreatedBy AndModifiedBy:ModifiedBy
                                                         AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:registrationNo AndRegistration:registration AndRegistrationDate:registrationDate AndRegistrationExempted:regExempted AndProspect_IsGrouping:isGrouping AndCountryOfBirth:COB]];
                
            }
            sqlite3_finalize(statement);
            
        }
        sqlite3_close(contactDB);
        query_stmt = Nil, query_stmt = Nil;
    }
    
    dirPaths = Nil, docsDir = Nil, dbpath = Nil, statement = Nil, statement = Nil;
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
    //basvi
    DateCreated = Nil;
    CreatedBy = Nil;
    DateModified = Nil;
    ModifiedBy = Nil;
    //

    ProspectTitle = Nil, ProspectGroup = Nil, IDTypeNo = Nil, OtherIDType = Nil, OtherIDTypeNo = Nil, Smoker = Nil;
    Race = Nil, Religion = Nil, MaritalStatus = Nil, Nationality = Nil;

   
   //DB QUERY END
  //  EditProspect* zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProspect"];
    ProspectProfile* pp;
    
        
        pp = [ProspectTableData objectAtIndex:0];
    
    
   // zzz.pp = pp;
    
    //[self.navigationController pushViewController:zzz animated:true];
    
    if (_EditProspect == Nil) {
        self.EditProspect = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProspect"];
        _EditProspect.delegate = self;
    }
    
    _EditProspect.pp = pp;
    _EditProspect.navigationItem.hidesBackButton = YES;
    _EditProspect.navigationItem.leftBarButtonItem = nil;
    _EditProspect.navigationItem.backBarButtonItem=nil;
    
    
   
    self.view.frame = CGRectMake(0, 0, 1388, 1004);
    _EditProspect.view.superview.frame = CGRectMake(0, 0, 1388, 1004);
    _EditProspect.view.frame = CGRectMake(0, 0, 1388, 1004);
    [self.navigationController pushViewController:_EditProspect animated:YES];
    _EditProspect.navigationItem.title = @"Edit Client Profile";
    
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditProspect_Done" object:self];
    
  
    pp = Nil;

}
-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
     
    EditProspect* zzz = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProspect"];
    ProspectProfile* pp;
    
    if(isFiltered)
    {
    
        pp = [FilteredProspectTableData objectAtIndex:indexPath.row];
    }
    else
    {
    
        pp = [ProspectTableData objectAtIndex:indexPath.row];
    }
    
    zzz.pp = pp;

    //[self.navigationController pushViewController:zzz animated:true];    
    
    if (_EditProspect == Nil) {
        self.EditProspect = [self.storyboard instantiateViewControllerWithIdentifier:@"EditProspect"];
        _EditProspect.delegate = self;
    }
    
    _EditProspect.pp = pp;
	
	
//    [self.navigationController pushViewController:_EditProspect animated:YES];
//    _EditProspect.navigationItem.title = @"Edit Client Profile";
	
	@try {
		[self.navigationController pushViewController:_EditProspect animated:YES];
		_EditProspect.navigationItem.title = @"Edit Client Profile";
	} @catch (NSException * e) {
		NSLog(@"Exception: %@", e);
	} @finally {
		//NSLog(@"finally");
	}
	
//    _EditProspect.navigationItem.rightBarButtonItem = _EditProspect.outletDone;
    pp = Nil, zzz = Nil;

}

- (void)pushViewController:(UIViewController *)viewController {
	if (viewController) {
		@try {
			[self.navigationController pushViewController:_EditProspect animated:YES];
			_EditProspect.navigationItem.title = @"Edit Client Profile";
		} @catch (NSException * ex) {
			//“Pushing the same view controller instance more than once is not supported”
			//NSInvalidArgumentException
			NSLog(@"Exception: [%@]:%@",[ex  class], ex );
			NSLog(@"ex.name:'%@'", ex.name);
			NSLog(@"ex.reason:'%@'", ex.reason);
			//Full error includes class pointer address so only care if it starts with this error
			NSRange range = [ex.reason rangeOfString:@"Pushing the same view controller instance more than once is not supported"];
			
			if ([ex.name isEqualToString:@"NSInvalidArgumentException"] &&
				range.location != NSNotFound) {
				//view controller already exists in the stack - just pop back to it
				[self.navigationController pushViewController:_EditProspect animated:YES];
				_EditProspect.navigationItem.title = @"Edit Client Profile";
			} else {
				NSLog(@"ERROR:UNHANDLED EXCEPTION TYPE:%@", ex);
			}
		} @finally {
			//NSLog(@"finally");
		}
	} else {
		NSLog(@"ERROR:pushViewController: viewController is nil");
	}
}

#pragma mark - action

-(void)getMobileNo
{
    dataMobile = [[NSMutableArray alloc] init];
    dataPrefix = [[NSMutableArray alloc] init];
    
    for (int a=0; a<ProspectTableData.count; a++) {
        
        ProspectProfile *pp = [ProspectTableData objectAtIndex:a];
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            NSString *querySQL = [NSString stringWithFormat:@"SELECT ContactCode, ContactNo, Prefix FROM contact_input where indexNo = %@ AND ContactCode = 'CONT008'", pp.ProspectID];
        
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_ROW){
                    
//                    NSString *ContactCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *ContactNo = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    NSString *Prefix = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    
                    [dataMobile addObject:ContactNo];
                    [dataPrefix addObject:Prefix];
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }

    }
}

- (IBAction)btnAddNew:(id)sender//premnathvj
{
    
	UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
    CustomAlertBox * agree = (CustomAlertBox *)[storyboard instantiateViewControllerWithIdentifier:@"CustomAlertBox"];
    agree.AlertProspect=YES;
	
	agree.delegate=self;
    
    agree.modalPresentationStyle = UIModalPresentationFormSheet;
    agree.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentModalViewController:agree animated:NO];
    agree.view.superview.frame = CGRectMake(120, 200, 450, 600);
	
	
    self.ProspectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Prospect"];
    _ProspectViewController.delegate = self;
    [self.navigationController pushViewController:_ProspectViewController animated:YES];
    _ProspectViewController.navigationItem.title = @"Add Client Profile";
}

-(void) ReloadTableData
{

    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	int i = 0;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by LOWER(ProspectName) ASC LIMIT %d", totalView];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            ProspectTableData = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
            NSString *ProspectID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
            
            const char *name = (const char*)sqlite3_column_text(statement, 1);
            NSString *NickName = name == NULL ? nil : [[NSString alloc] initWithUTF8String:name];
                
            NSString *ProspectName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
            NSString *ProspectDOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
            NSString *ProspectGender = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
            const char *Address1 = (const char*)sqlite3_column_text(statement, 5);
            NSString *ResidenceAddress1 = Address1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address1];
                
            const char *Address2 = (const char*)sqlite3_column_text(statement, 6);
            NSString *ResidenceAddress2 = Address2 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address2];
                
            const char *Address3 = (const char*)sqlite3_column_text(statement, 7);
            NSString *ResidenceAddress3 = Address3 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address3];
                
            const char *AddressTown = (const char*)sqlite3_column_text(statement, 8);
            NSString *ResidenceAddressTown = AddressTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressTown];
                
            const char *AddressState = (const char*)sqlite3_column_text(statement, 9);
            NSString *ResidenceAddressState = AddressState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressState];
                
            const char *AddressPostCode = (const char*)sqlite3_column_text(statement, 10);
            NSString *ResidenceAddressPostCode = AddressPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressPostCode];
                
            const char *AddressCountry = (const char*)sqlite3_column_text(statement, 11);
            NSString *ResidenceAddressCountry = AddressCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressCountry];
                
            const char *AddressOff1 = (const char*)sqlite3_column_text(statement, 12);
            NSString *OfficeAddress1 = AddressOff1 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff1];
                
            const char *AddressOff2 = (const char*)sqlite3_column_text(statement, 13);
            NSString *OfficeAddress2 = AddressOff2 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff2];
                
            const char *AddressOff3 = (const char*)sqlite3_column_text(statement, 14);
            NSString *OfficeAddress3 = AddressOff3 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff3];
                
            const char *AddressOffTown = (const char*)sqlite3_column_text(statement, 15);
            NSString *OfficeAddressTown = AddressOffTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffTown];
                
            const char *AddressOffState = (const char*)sqlite3_column_text(statement, 16);
            NSString *OfficeAddressState = AddressOffState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffState];
                
            const char *AddressOffPostCode = (const char*)sqlite3_column_text(statement, 17);
            NSString *OfficeAddressPostCode = AddressOffPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffPostCode];
                
            const char *AddressOffCountry = (const char*)sqlite3_column_text(statement, 18);
            NSString *OfficeAddressCountry = AddressOffCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffCountry];
                
            const char *Email = (const char*)sqlite3_column_text(statement, 19);
            NSString *ProspectEmail = Email == NULL ? nil : [[NSString alloc] initWithUTF8String:Email];
                
            NSString *ProspectOccupationCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 20)];
                
            const char *Duties = (const char*)sqlite3_column_text(statement, 21);
            NSString *ExactDuties = Duties == NULL ? nil : [[NSString alloc] initWithUTF8String:Duties];
                
            const char *Remark = (const char*)sqlite3_column_text(statement, 22);
            NSString *ProspectRemark = Remark == NULL ? nil : [[NSString alloc] initWithUTF8String:Remark];
            //basvi added
            const char *DateCr = (const char*)sqlite3_column_text(statement, 23);
            NSString *DateCreated = DateCr == NULL ? nil : [[NSString alloc] initWithUTF8String:DateCr];
                
            const char *CrBy = (const char*)sqlite3_column_text(statement, 24);
            NSString *CreatedBy = CrBy == NULL ? nil : [[NSString alloc] initWithUTF8String:CrBy];
                
            const char *DateMod = (const char*)sqlite3_column_text(statement, 25);
            NSString *DateModified = DateMod == NULL ? nil : [[NSString alloc] initWithUTF8String:DateMod];
                
            const char *ModBy = (const char*)sqlite3_column_text(statement, 26);
            NSString *ModifiedBy = ModBy == NULL ? nil : [[NSString alloc] initWithUTF8String:ModBy];
                //
            const char *Group = (const char*)sqlite3_column_text(statement, 27);
            NSString *ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                
            const char *Title = (const char*)sqlite3_column_text(statement, 28);
            NSString *ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                
            const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
            NSString *IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                
            const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
            NSString *OtherIDType = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
			if ([OtherIDType isEqualToString:@"(NULL)"] || [OtherIDType isEqualToString:@"(null)"])
				OtherIDType = @"";
                
            const char *OtherTypeNo = (const char*)sqlite3_column_text(statement, 31);
            NSString *OtherIDTypeNo = OtherTypeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherTypeNo];
                
            const char *smok = (const char*)sqlite3_column_text(statement, 32);
            NSString *Smoker = smok == NULL ? nil : [[NSString alloc] initWithUTF8String:smok];
                
            const char *ann = (const char*)sqlite3_column_text(statement, 33);
            NSString *AnnIncome = ann == NULL ? nil : [[NSString alloc] initWithUTF8String:ann];
                
            const char *buss = (const char*)sqlite3_column_text(statement, 34);
            NSString *BussinessType = buss == NULL ? nil : [[NSString alloc] initWithUTF8String:buss];
                
                const char *rac = (const char*)sqlite3_column_text(statement, 35);
                NSString *Race = rac == NULL ? nil : [[NSString alloc] initWithUTF8String:rac];
                
                const char *marstat = (const char*)sqlite3_column_text(statement, 36);
                NSString *MaritalStatus = marstat == NULL ? nil : [[NSString alloc] initWithUTF8String:marstat];
                
                const char *rel = (const char*)sqlite3_column_text(statement, 37);
                NSString *Religion = rel == NULL ? nil : [[NSString alloc] initWithUTF8String:rel];
                
                const char *nat = (const char*)sqlite3_column_text(statement, 38);
                NSString *Nationality = nat == NULL ? nil : [[NSString alloc] initWithUTF8String:nat];
                
                const char *reg = (const char*)sqlite3_column_text(statement, 41);
                NSString *registrationNo = reg == NULL ? nil : [[NSString alloc] initWithUTF8String:reg];
                
                const char *isreg = (const char*)sqlite3_column_text(statement, 40);
                NSString *registration = isreg == NULL ? nil : [[NSString alloc] initWithUTF8String:isreg];
                
                const char *regdate = (const char*)sqlite3_column_text(statement, 42);
                NSString *registrationDate = regdate == NULL ? nil : [[NSString alloc] initWithUTF8String:regdate];
                
                const char *exempted = (const char*)sqlite3_column_text(statement, 43);
                NSString *regExempted = exempted == NULL ? nil : [[NSString alloc] initWithUTF8String:exempted];

                const char *isG = (const char*)sqlite3_column_text(statement, 45);
                NSString *isGrouping = isG == NULL ? nil : [[NSString alloc] initWithUTF8String:isG];
				
				const char *CountryOfBirth = (const char*)sqlite3_column_text(statement, 46);
                NSString *COB = CountryOfBirth == NULL ? nil : [[NSString alloc] initWithUTF8String:CountryOfBirth];
			
            [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                              AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                          AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3  
                                                       AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                                   AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry 
                                                             AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown 
                                                         AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                       AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndDateCreated:DateCreated AndDateModified:DateModified AndCreatedBy:CreatedBy AndModifiedBy:ModifiedBy
                                                     AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:registrationNo AndRegistration:registration AndRegistrationDate:registrationDate AndRegistrationExempted:regExempted AndProspect_IsGrouping:isGrouping AndCountryOfBirth:COB]];
                
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
                //basvi
                DateCreated = Nil;
                CreatedBy = Nil;
                DateModified = Nil;
                ModifiedBy = Nil;
                //

                ProspectTitle = Nil, ProspectGroup = Nil, IDTypeNo = Nil, OtherIDType = Nil, OtherIDTypeNo = Nil, Smoker = Nil;
			
            }
            sqlite3_finalize(statement);
        
        }
        sqlite3_close(contactDB);
        query_stmt = Nil, querySQL = Nil;
    }
	
    [self.myTableView reloadData];
	
	[self getTotal];
//	if ([ProspectTableData count] < totalView)
//		self.noMoreResultsAvail = YES;
	
    dirPaths = Nil;
    docsDir = Nil;
    dbpath = Nil;
    statement = Nil;
    
    [self getMobileNo];
    [HUD hide:YES];
}

-(void) FinishEdit
{
    
    isFiltered = FALSE;
	totalView = 20;
    [self ReloadTableData];
//    searchBar.text = @"";
    _EditProspect = Nil;
	[self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:1];
    
}

-(void) FinishInsert
{
    
    isFiltered = FALSE;
	totalView = 20;
    [self ReloadTableData];
//    searchBar.text = @"";
    _ProspectViewController = nil;
	[self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:1];
}

- (void) SortBySelected:(NSMutableArray *)SortBySelected{
    
    
    
     
    idTypeLabel.highlighted= false;
    groupLabel.highlighted = false;
   
    
    if (SortBySelected.count > 0) {
        _outletOrder.enabled = true;
        _outletOrder.selectedSegmentIndex = 0;
        
    }
    else {
        _outletOrder.enabled = false;
        _outletOrder.selected = false;
        _outletOrder.selectedSegmentIndex = -1;
    }
    
    
    for (NSString *zzz in SortBySelected ) {
         
        
      if ([zzz isEqualToString:@"Name"]) {
            idTypeLabel.highlightedTextColor = [UIColor blueColor];
            idTypeLabel.highlighted = TRUE;
            
        }
        
        
        if ([zzz isEqualToString:@"Group"]) {
            groupLabel.highlightedTextColor = [UIColor blueColor];
            groupLabel.highlighted = TRUE;
            
        }

        
        
               }
     
    
}


- (IBAction)segOrderBy:(id)sender
{
    if (_outletOrder.selectedSegmentIndex == 0) {
        OrderBy = @"ASC";
    }
    else {
        OrderBy = @"DESC";
    }
}
- (IBAction)btnSortBy:(id)sender
{
    if (_SortBy == nil) {
        self.SortBy = [[ClientProfileListingSortBy alloc] initWithStyle:UITableViewStylePlain];
        _SortBy.delegate = self;
        self.Popover = [[UIPopoverController alloc] initWithContentViewController:_SortBy];
    }
    [self.Popover setPopoverContentSize:CGSizeMake(200, 300)];
    [self.Popover presentPopoverFromRect:[sender frame ]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)searchPressed:(id)sender
{
   
    [self resignFirstResponder];
    [self.view endEditing:YES];
    NSString *querySQL = Nil;
    
    sqlite3_stmt *statement;
    
    NSString *trim_group = [btnGroup.titleLabel.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    
    if(nametxt.text.length ==0 && txtIDTypeNo.text.length ==0 &&  [trim_group isEqualToString:@"- SELECT -"])
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Search Criteria is required. Please key in one of the criteria." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        alert = nil;
    }
    else
    {
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        querySQL = @"SELECT * FROM prospect_profile";
	
			
			if (![txtIDTypeNo.text isEqualToString:@""] && ![nametxt.text isEqualToString:@""] && (![trim_group isEqualToString:@""] && ![trim_group isEqualToString:@"- SELECT -"])) {
				trim_group = [self getGroupID:trim_group];
                querySQL = [querySQL stringByAppendingFormat:@" WHERE ProspectName like \"%%%@%%\" and (IDTypeNo like \"%%%@%%\" OR OtherIDTypeNo like \"%%%@%%\") and QQFlag = 'false' and ProspectGroup like \"%%%@%%\"",nametxt.text, txtIDTypeNo.text, txtIDTypeNo.text, trim_group];
            }
			else if (![txtIDTypeNo.text isEqualToString:@""] && ![nametxt.text isEqualToString:@""]) {
                querySQL = [querySQL stringByAppendingFormat:@" WHERE ProspectName like \"%%%@%%\" and (IDTypeNo like \"%%%@%%\" OR OtherIDTypeNo like \"%%%@%%\") and QQFlag = 'false'",nametxt.text, txtIDTypeNo.text, txtIDTypeNo.text];
            }
			else  if (![nametxt.text isEqualToString:@""] && (![trim_group isEqualToString:@""] && ![trim_group isEqualToString:@"- SELECT -"])) {
				trim_group = [self getGroupID:trim_group];
				querySQL = [querySQL stringByAppendingFormat:@" WHERE ProspectName like \"%%%@%%\" and QQFlag = 'false' and ProspectGroup like \"%%%@%%\"", nametxt.text, trim_group];
			}
			else  if (![nametxt.text isEqualToString:@""]) {
				querySQL = [querySQL stringByAppendingFormat:@" WHERE ProspectName like \"%%%@%%\" and QQFlag = 'false'", nametxt.text ];
			}
			else if (![txtIDTypeNo.text isEqualToString:@""] && (![trim_group isEqualToString:@""] && ![trim_group isEqualToString:@"- SELECT -"])) {
				trim_group = [self getGroupID:trim_group];
				querySQL = [querySQL stringByAppendingFormat:@" WHERE (IDTypeNo like \"%%%@%%\" OR OtherIDTypeNo like \"%%%@%%\") and QQFlag = 'false' and ProspectGroup like \"%%%@%%\"",txtIDTypeNo.text, txtIDTypeNo.text, trim_group];
			}
			else if (![txtIDTypeNo.text isEqualToString:@""]) {
				querySQL = [querySQL stringByAppendingFormat:@" WHERE (IDTypeNo like \"%%%@%%\" OR OtherIDTypeNo like \"%%%@%%\") and QQFlag = 'false'",txtIDTypeNo.text, txtIDTypeNo.text ];
			}
			else if ((![trim_group isEqualToString:@""] && ![trim_group isEqualToString:@"- SELECT -"])) {
				trim_group = [self getGroupID:trim_group];
				querySQL = [querySQL stringByAppendingFormat:@" WHERE ProspectGroup like \"%%%@%%\" and QQFlag = 'false'", trim_group ];
			}
			else
			{
				querySQL = [querySQL stringByAppendingFormat:@" WHERE QQFlag = 'false'" ];
				
			}
        
        //SORTING START
        
        
        NSString *Sorting = [[NSString alloc] init ];
        Sorting = @"";
        NSString *group = @"";
        
        if (idTypeLabel.highlighted == TRUE) {
            Sorting = @"ProspectName";
        }
        
        
        if (groupLabel.highlighted == TRUE) {
            group = @"ProspectGroup";
        }
 
        if (![Sorting isEqualToString:@""] && ![group isEqualToString:@""]) {
            
            querySQL = [querySQL stringByAppendingFormat:@" order by %@, %@ %@ ", Sorting, group,  OrderBy ];
        }

        else if (![Sorting isEqualToString:@""]) {
        
            querySQL = [querySQL stringByAppendingFormat:@" order by %@ %@ ", Sorting, OrderBy ];
        }
        else if (![group isEqualToString:@""]) {
            
            querySQL = [querySQL stringByAppendingFormat:@" order by %@ %@ ", group, OrderBy ];
        }
        
        
        else
        {
              querySQL = [querySQL stringByAppendingFormat:@" order by LOWER(ProspectName) ASC"];
        }

      
       
        //SORTING END
           
      
       
   
         const char *SelectSI = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, SelectSI, -1, &statement, NULL) == SQLITE_OK)
        {
            ProspectTableData = [[NSMutableArray alloc] init];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSString *ProspectID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                    
                const char *name = (const char*)sqlite3_column_text(statement, 1);
                NSString *NickName = name == NULL ? nil : [[NSString alloc] initWithUTF8String:name];
                
                NSString *ProspectName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *ProspectDOB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *ProspectGender = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
                const char *Address1 = (const char*)sqlite3_column_text(statement, 5);
                NSString *ResidenceAddress1 = Address1 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address1];
                
                const char *Address2 = (const char*)sqlite3_column_text(statement, 6);
                NSString *ResidenceAddress2 = Address2 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address2];
                
                const char *Address3 = (const char*)sqlite3_column_text(statement, 7);
                NSString *ResidenceAddress3 = Address3 == NULL ? nil : [[NSString alloc] initWithUTF8String:Address3];
                
                const char *AddressTown = (const char*)sqlite3_column_text(statement, 8);
                NSString *ResidenceAddressTown = AddressTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressTown];
                
                const char *AddressState = (const char*)sqlite3_column_text(statement, 9);
                NSString *ResidenceAddressState = AddressState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressState];
                
                const char *AddressPostCode = (const char*)sqlite3_column_text(statement, 10);
                NSString *ResidenceAddressPostCode = AddressPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressPostCode];
                
                const char *AddressCountry = (const char*)sqlite3_column_text(statement, 11);
                NSString *ResidenceAddressCountry = AddressCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressCountry];
                
                const char *AddressOff1 = (const char*)sqlite3_column_text(statement, 12);
                NSString *OfficeAddress1 = AddressOff1 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff1];
                
                const char *AddressOff2 = (const char*)sqlite3_column_text(statement, 13);
                NSString *OfficeAddress2 = AddressOff2 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff2];
                
                const char *AddressOff3 = (const char*)sqlite3_column_text(statement, 14);
                NSString *OfficeAddress3 = AddressOff3 == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOff3];
                
                const char *AddressOffTown = (const char*)sqlite3_column_text(statement, 15);
                NSString *OfficeAddressTown = AddressOffTown == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffTown];
                
                const char *AddressOffState = (const char*)sqlite3_column_text(statement, 16);
                NSString *OfficeAddressState = AddressOffState == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffState];
                
                const char *AddressOffPostCode = (const char*)sqlite3_column_text(statement, 17);
                NSString *OfficeAddressPostCode = AddressOffPostCode == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffPostCode];
                
                const char *AddressOffCountry = (const char*)sqlite3_column_text(statement, 18);
                NSString *OfficeAddressCountry = AddressOffCountry == NULL ? nil : [[NSString alloc] initWithUTF8String:AddressOffCountry];
                
                const char *Email = (const char*)sqlite3_column_text(statement, 19);
                NSString *ProspectEmail = Email == NULL ? nil : [[NSString alloc] initWithUTF8String:Email];
                
                NSString *ProspectOccupationCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 20)];
                
                const char *Duties = (const char*)sqlite3_column_text(statement, 21);
                NSString *ExactDuties = Duties == NULL ? nil : [[NSString alloc] initWithUTF8String:Duties];
                
                const char *Remark = (const char*)sqlite3_column_text(statement, 22);
                NSString *ProspectRemark = Remark == NULL ? nil : [[NSString alloc] initWithUTF8String:Remark];
                //basvi added
                const char *DateCr = (const char*)sqlite3_column_text(statement, 23);
                NSString *DateCreated = DateCr == NULL ? nil : [[NSString alloc] initWithUTF8String:DateCr];
                
                const char *CrBy = (const char*)sqlite3_column_text(statement, 24);
                NSString *CreatedBy = CrBy == NULL ? nil : [[NSString alloc] initWithUTF8String:CrBy];
                
                const char *DateMod = (const char*)sqlite3_column_text(statement, 25);
                NSString *DateModified = DateMod == NULL ? nil : [[NSString alloc] initWithUTF8String:DateMod];
                
                const char *ModBy = (const char*)sqlite3_column_text(statement, 26);
                NSString *ModifiedBy = ModBy == NULL ? nil : [[NSString alloc] initWithUTF8String:ModBy];
                //

                    
                const char *Group = (const char*)sqlite3_column_text(statement, 27);
                NSString *ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                    
                const char *Title = (const char*)sqlite3_column_text(statement, 28);
                NSString *ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                    
                const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
                NSString *IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                    
                const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
                NSString *OtherIDType = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
				if ([OtherIDType isEqualToString:@"(NULL)"] || [OtherIDType isEqualToString:@"(null)"])
					OtherIDType = @"";
                    
                const char *OtherTypeNo = (const char*)sqlite3_column_text(statement, 31);
                NSString *OtherIDTypeNo = OtherTypeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherTypeNo];
                    
                const char *smok = (const char*)sqlite3_column_text(statement, 32);
                NSString *Smoker = smok == NULL ? nil : [[NSString alloc] initWithUTF8String:smok];
                    
                const char *ann = (const char*)sqlite3_column_text(statement, 33);
                NSString *AnnIncome = ann == NULL ? nil : [[NSString alloc] initWithUTF8String:ann];
                    
                const char *buss = (const char*)sqlite3_column_text(statement, 34);
                NSString *BussinessType = buss == NULL ? nil : [[NSString alloc] initWithUTF8String:buss];
                
                const char *rac = (const char*)sqlite3_column_text(statement, 35);
                NSString *Race = rac == NULL ? nil : [[NSString alloc] initWithUTF8String:rac];
                
                const char *marstat = (const char*)sqlite3_column_text(statement, 36);
                NSString *MaritalStatus = marstat == NULL ? nil : [[NSString alloc] initWithUTF8String:marstat];
                
                const char *rel = (const char*)sqlite3_column_text(statement, 37);
                NSString *Religion = rel == NULL ? nil : [[NSString alloc] initWithUTF8String:rel];
                
                const char *nat = (const char*)sqlite3_column_text(statement, 38);
                NSString *Nationality = nat == NULL ? nil : [[NSString alloc] initWithUTF8String:nat];
                
				const char *reg = (const char*)sqlite3_column_text(statement, 41);
                NSString *registrationNo = reg == NULL ? nil : [[NSString alloc] initWithUTF8String:reg];
                
                const char *isreg = (const char*)sqlite3_column_text(statement, 40);
                NSString *registration = isreg == NULL ? nil : [[NSString alloc] initWithUTF8String:isreg];
                
                const char *regdate = (const char*)sqlite3_column_text(statement, 42);
                NSString *registrationDate = regdate == NULL ? nil : [[NSString alloc] initWithUTF8String:regdate];
                
                const char *exempted = (const char*)sqlite3_column_text(statement, 43);
                NSString *regExempted = exempted == NULL ? nil : [[NSString alloc] initWithUTF8String:exempted];

                const char *isGrouping = (const char*)sqlite3_column_text(statement, 45);
                NSString *isGroup = isGrouping == NULL ? nil : [[NSString alloc] initWithUTF8String:isGrouping];
				
				const char *CountryOfBirth = (const char*)sqlite3_column_text(statement, 46);
                NSString *COB = CountryOfBirth == NULL ? nil : [[NSString alloc] initWithUTF8String:CountryOfBirth];
                    
                [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1 AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3 AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndDateCreated:DateCreated AndDateModified:DateModified AndCreatedBy:CreatedBy AndModifiedBy:ModifiedBy AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality AndRegistrationNo:registrationNo AndRegistration:registration AndRegistrationDate:registrationDate AndRegistrationExempted:regExempted AndProspect_IsGrouping:isGroup AndCountryOfBirth:COB]];
                
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
                ProspectRemark = Nil, querySQL = Nil;
                ProspectTitle = Nil, ProspectGroup = Nil, IDTypeNo = Nil, OtherIDType = Nil, OtherIDTypeNo = Nil, Smoker = Nil;
				
            }
            sqlite3_finalize(statement);
                
        }
        sqlite3_close(contactDB);
        querySQL = Nil;
        }
    }
    [self getMobileNo];
    
	TotalData = ProspectTableData.count;
    [self.myTableView reloadData];
    statement = Nil;
    
   if(ProspectTableData.count == 0)
   {
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"No record found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
       
       [alert show];
       alert = nil;
   }
	


}
-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (IBAction)resetPressed:(id)sender
{
    [self hideKeyboard];
    nametxt.text = @"";
    txtIDTypeNo.text = @"";
    idTypeLabel.highlighted= false;
    [btnGroup setTitle:@"- SELECT -" forState:UIControlStateNormal];
    btnGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
	
	
//	HUD = [[MBProgressHUD alloc] initWithView:self.view];
//	[self.view addSubview:HUD];
//	HUD.labelText = @"Please Wait";
//	[HUD show:YES];
	
	totalView = 20;
    [self ReloadTableData];
	[self performSelector:@selector(loadDataDelayed) withObject:nil afterDelay:2];
	
//	HUD.labelText = @"";
	
}

- (IBAction)editPressed:(id)sender
{
     
    [self resignFirstResponder];
    if ([self.myTableView isEditing]) {
        
        [self.myTableView setEditing:NO animated:TRUE];
        deleteBtn.hidden = true;
        deleteBtn.enabled = false;
        [editBtn setTitle:@"Delete" forState:UIControlStateNormal ];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
        
        RecDelete = 0;
    }
    else{
        
        [self.myTableView setEditing:YES animated:TRUE];
        deleteBtn.hidden = FALSE;
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        [editBtn setTitle:@"Cancel" forState:UIControlStateNormal ];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

- (IBAction)deletePressed:(id)sender
{
    BOOL status_delete;
    NSString *clientID;
    NSString *clt;
	sqlite3_stmt *statement;
	BOOL CanDelete = TRUE;
    int RecCount = 0;
    for (UITableViewCell *cell in [self.myTableView visibleCells])
    {
        
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [self.myTableView indexPathForCell:cell];
            
			ProspectProfile *pp = [ProspectTableData objectAtIndex:selectedIndexPath.row];
			clientID = pp.ProspectID;
            if (RecCount == 0) {
                clt = pp.ProspectName;
            }
			
			if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK) {
			 
                // For Trad product should check trad_lapayor and not ul_payor table.
                NSString *SQL = [NSString stringWithFormat:@"select * from trad_lapayor as A, clt_profile as B, prospect_profile as C where A.custcode = B.custcode AND B.indexno = c.indexno AND  C.indexNo = '%@' ", pp.ProspectID];
                
           
				if(sqlite3_prepare_v2(contactDB, [SQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
					if (sqlite3_step(statement) == SQLITE_ROW) {
						CanDelete = FALSE;
                        
                        NSLog(@" KY delete - got traditional");
					}
				
					sqlite3_finalize(statement);
				}
                
                //SI EVER SERIES
                SQL = [NSString stringWithFormat:@"select * from UL_LAPayor as A, clt_profile as B, prospect_profile as C where A.custcode = B.custcode AND B.indexno = c.indexno  AND C.indexNo = '%@' ", pp.ProspectID];
                
                
                if(sqlite3_prepare_v2(contactDB, [SQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
					if (sqlite3_step(statement) == SQLITE_ROW) {
						CanDelete = FALSE;
                        
                         NSLog(@" KY delete - got ever series");
					}
					 
					sqlite3_finalize(statement);
				}

				
                //CFF 
                SQL = [NSString stringWithFormat:@"SELECT *  FROM CFF_Master WHERE ClientProfileID = '%@' ", pp.ProspectID];
                
                if(sqlite3_prepare_v2(contactDB, [SQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
					if (sqlite3_step(statement) == SQLITE_ROW) {
						CanDelete = FALSE;
                        
                        NSLog(@" KY delete - got CFF");
					}
                    
					sqlite3_finalize(statement);
				}
                
                //eAPP
                SQL = [NSString stringWithFormat:@"SELECT *  FROM eApp_Listing WHERE ClientProfileID = '%@' ", pp.ProspectID];
                
                if(sqlite3_prepare_v2(contactDB, [SQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
					if (sqlite3_step(statement) == SQLITE_ROW) {
						CanDelete = FALSE;
                        
                        NSLog(@"KY delete - got eApp");
					}
                    
					sqlite3_finalize(statement);
				}


                sqlite3_close(contactDB);
			}
			
			if (CanDelete == FALSE) {
                
				break;
			}
			else{
				RecCount = RecCount + 1;
				 
				if (RecCount > 1) {
					break;
				}
			}
            
            
        }
    }
    
    //CHECK eProposal Status for pending case

    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    NSString *status;
    FMResultSet *results;
    
    results = [db executeQuery:@"SELECT A.Status  from eProposal AS A, eApp_Listing AS B where B.ClientProfileID  = ?  AND B.ProposalNo = A.eProposalNo", clientID];
    
	int ee = 0;
    while ([results next]) {
        status = [results objectForColumnName:@"Status"];
		ee = ee + 1;
    }
    [results close];
    [db close];
    
		if([status isEqualToString:@"2"] || [status isEqualToString:@"3"] || [status isEqualToString:@"6"])
			status_delete = TRUE;
		else
			status_delete = FALSE;
    
	
	
	if (CanDelete == FALSE && status_delete == TRUE) {
		NSString *msg = @"There are pending eApp cases for this client. Should you wish to proceed, system will auto delete all the pending eApp cases and you are required to recreate the necessary should you wish to resubmit the case.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert setTag:1002];
		[alert show];

	}
    else if(CanDelete == FALSE && status_delete == FALSE)
    {
        
        NSString *msg = @"There are existing records created (either SI, CFF or eApp cases) for this client.Should you wish to proceed, system will auto delete all the existing records and you are required to recreate the necessary should you wish to resubmit the case.";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        [alert setTag:1002];
		[alert show];
    }

	else{
		NSString *msg;
       
		if (RecDelete == 1) {
			//msg = [NSString stringWithFormat:@"Delete %@",clt];
            msg = @"Are you sure want to delete these Clients?";
		}
		else {
			msg = @"Are you sure want to delete these Clients?";
		}
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
		[alert setTag:1001];
		[alert show];
	}

	
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
   

    if (alertView.tag==1001 && buttonIndex == 0) //delete
    {
       
        
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
//        [self.myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
        sqlite3_stmt *statement;
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
			ProspectProfile *pp;
            NSString *DeleteSQL;
            int value;
            for(int a=0; a<sorted.count; a++) {
                value = [[sorted objectAtIndex:a] intValue] - a;
                
                pp = [ProspectTableData objectAtIndex:value];
                DeleteSQL = [NSString stringWithFormat:@"Delete from prospect_profile where indexNo = \"%@\"", pp.ProspectID];
               
                
                const char *Delete_stmt = [DeleteSQL UTF8String];
                if(sqlite3_prepare_v2(contactDB, Delete_stmt, -1, &statement, NULL) == SQLITE_OK)
                {
                    sqlite3_step(statement);
                    sqlite3_finalize(statement);
                }
                else {
                    
                    NSLog(@"Error in Delete Statement");
                }
                
                [ProspectTableData removeObjectAtIndex:value];
            }
            sqlite3_close(contactDB);
        }
        
        [ItemToBeDeleted removeAllObjects];
        [indexPaths removeAllObjects];
        deleteBtn.enabled = FALSE;
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        
        [self ReloadTableData];
        
        NSString *msg = @"Client Profile has been successfully deleted.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        alert = nil;
        
    }
    
    if (alertView.tag==1002 && buttonIndex == 0)
    {
        [self delete_prospect_eApp];
        
        NSString *msg = @"Client Profile has been successfully deleted.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
        alert = nil;

    }

}

- (void) delete_prospect_eApp
{    
    if (ItemToBeDeleted.count < 1) {
        return;
    }
    else{
        NSLog(@"AitemToBeDeleted:%d", ItemToBeDeleted.count);
    }
    NSArray *sorted = [[NSArray alloc] init ];
    sorted = [ItemToBeDeleted sortedArrayUsingComparator:^(id firstObject, id secondObject){
        return [((NSString *)firstObject) compare:((NSString *)secondObject) options:NSNumericSearch];
    }];
    
	NSMutableArray *EProArr = [NSMutableArray array];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    
    for(int a=0; a<sorted.count; a++) {
        int value = [[sorted objectAtIndex:a] intValue];
        value = value - a;
        
        ProspectProfile *pp = [ProspectTableData objectAtIndex:value];
        
        [db executeUpdate:@"Delete from prospect_profile where indexNo = ?", pp.ProspectID];
                
        //Get proposal No
        FMResultSet *results;
        NSString *proposal = @"";
        results = [db executeQuery:@"SELECT eProposalNo FROM eProposal_LA_Details where prospectProfileID = ?", pp.ProspectID];
        while ([results next]) {
            proposal = [results objectForColumnName:@"eProposalNo"];
			[EProArr addObject:proposal];
        }
        
		ClearData *ClData =[[ClearData alloc]init];
		
        //Delete eApp_Listing
		if (EProArr.count != 0) {
			for (int d=0; d<= EProArr.count-1; d++) {
				proposal = [EProArr objectAtIndex:d];
				
				[ClData deleteEApp:proposal database:db];
				[ClData deleteOldPdfs:proposal];
			}
		}
			
		Cleanup *DeleteSi =[[Cleanup alloc]init];
		[DeleteSi deleteAllSIUsingCustomerID: pp.ProspectID];
		
		[ClData deleteCFF:pp.ProspectID database:db];
			
        [ProspectTableData removeObjectAtIndex:value];
        
        [results close];
	
    }
    
    [db close];

    
//    [self.myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [ItemToBeDeleted removeAllObjects];
    [indexPaths removeAllObjects];
    deleteBtn.enabled = FALSE;
    [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
    
    [self ReloadTableData];
}

- (IBAction)ActionGroup:(id)sender
{
    _GroupList = nil;
    self.GroupList = [[GroupClass alloc] initWithStyle:UITableViewStylePlain];
    _GroupList.delegate = self;
    self.GroupPopover = [[UIPopoverController alloc] initWithContentViewController:_GroupList];
    
    [self.GroupPopover presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}

#pragma mark - memory management

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [self setIdTypeLabel:nil];
    [self setIdNoLabel:nil];
    [self setClientNameLabel:nil];
    [self setEditBtn:nil];
    [self setDeleteBtn:nil];
    [self setNametxt:nil];
    [self setBtnGroup:nil];
    [self setTxtIDTypeNo:nil];
    [self setGroupLabel:nil];
    [super viewDidUnload];
    FilteredProspectTableData = Nil;
    ProspectTableData = Nil;
}

-(void)Clear
{
	ProspectTableData = Nil;
	FilteredProspectTableData = Nil;
	databasePath = Nil;
}

-(void)selectedGroup:(NSString *)aaGroup
{
    if([aaGroup isEqualToString:@"- SELECT -"])
         btnGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else
         btnGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnGroup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",aaGroup]forState:UIControlStateNormal];
    [self.GroupPopover dismissPopoverAnimated:YES];
}

 

@end
