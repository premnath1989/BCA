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

- (void)viewDidLoad
{
    [super viewDidLoad];

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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by ProspectName ASC"];
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
                
                const char *Group = (const char*)sqlite3_column_text(statement, 27);
                ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                
                const char *Title = (const char*)sqlite3_column_text(statement, 28);
                ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                
                const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
                IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                
                const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
                OtherIDType = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
                
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
                

                
                
                
                [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName 
                                                                  AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                              AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3  
                                                           AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                                       AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry 
                                                                 AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown 
                                                             AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                           AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark 
                                                         AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality]];
                
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
    
    CGRect frame1=CGRectMake(0,169, 350, 50);
    idTypeLabel.frame = frame1;
    idTypeLabel.textAlignment = UITextAlignmentCenter;
    idTypeLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    idTypeLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    idTypeLabel.text = @"Name";
    
    CGRect frame2=CGRectMake(350,169, 200, 50);
    idNoLabel.frame = frame2;
    idNoLabel.textAlignment = UITextAlignmentCenter;
    idNoLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    idNoLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CGRect frame3=CGRectMake(550,169, 200, 50);
    clientNameLabel.frame = frame3;
    clientNameLabel.textAlignment = UITextAlignmentCenter;
    clientNameLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    clientNameLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    clientNameLabel.text = @"Mobile Number";
    
    CGRect frame4=CGRectMake(750,169, 220, 50);
    groupLabel.frame = frame4;
    groupLabel.textAlignment = UITextAlignmentCenter;
    groupLabel.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
    groupLabel.backgroundColor = [CustomColor colorWithHexString:@"4F81BD"];
    
    CustomColor = Nil;
    
    [self getMobileNo];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
    int rowCount;
    if(self.isFiltered)
        rowCount = FilteredProspectTableData.count;
    else
        rowCount = ProspectTableData.count;
    return rowCount;*/
   // return [ProspectTableData count];
    return [ProspectTableData count];
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
    
    ProspectProfile *pp = [ProspectTableData objectAtIndex:indexPath.row];
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    
    CGRect frame=CGRectMake(-30,0, 400, 50);
    UILabel *label1=[[UILabel alloc]init];
    label1.frame=frame;
    label1.text= [NSString stringWithFormat:@"        %@",pp.ProspectName];
    label1.textAlignment = UITextAlignmentLeft;
    label1.tag = 2001;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label1];
    
    CGRect frame2=CGRectMake(350,0, 200, 50);
    UILabel *label2=[[UILabel alloc]init];
    label2.frame=frame2;
    label2.text= pp.IDTypeNo;
    label2.textAlignment = UITextAlignmentCenter;
    label2.tag = 2002;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label2];
    
    CGRect frame3=CGRectMake(550,0, 200, 50);
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
    
    CGRect frame4=CGRectMake(750,0, 220, 50);
    UILabel *label4=[[UILabel alloc]init];
    label4.frame=frame4;
    NSString *gp = nil;
    if (!(pp.ProspectGroup == NULL || [pp.ProspectGroup isEqualToString:@"- Select -"])) {
        gp = pp.ProspectGroup;
    }
    else {
        gp = @"";
    }
    label4.text= gp;
    label4.textAlignment = UITextAlignmentCenter;
    label4.tag = 2004;
    cell.textLabel.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    [cell.contentView addSubview:label4];
    
    if (indexPath.row % 2 == 0) {
        label1.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        label4.backgroundColor = [CustomColor colorWithHexString:@"D0D8E8"];
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    else {
        label1.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label2.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label3.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        label4.backgroundColor = [CustomColor colorWithHexString:@"E9EDF4"];
        
        label1.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label2.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label3.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
        label4.font = [UIFont fontWithName:@"TreBuchet MS" size:16];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
    pp = Nil;
}

/*
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        FilteredProspectTableData = [[NSMutableArray alloc] init];
        
        ProspectProfile* pp;
        for (pp in ProspectTableData)
        {
            NSRange Fullname = [pp.ProspectName rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange PreferredName = [pp.NickName rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange ResidenceAddressState = [pp.ResidenceAddressState rangeOfString:text options:NSCaseInsensitiveSearch];
            
            
            if (Fullname.location != NSNotFound || PreferredName.location != NSNotFound || ResidenceAddressState.location != NSNotFound) {
                [FilteredProspectTableData addObject:pp];
            }
        }
        pp = Nil;
    }
    
    [self.myTableView reloadData];
}*/


#pragma mark - Table view delegate

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
            [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
            deleteBtn.enabled = FALSE;
        }
        else {
            [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            deleteBtn.enabled = TRUE;
        }
        
        NSString *zzz = [NSString stringWithFormat:@"%d", indexPath.row];
        [ItemToBeDeleted addObject:zzz];
        [indexPaths addObject:indexPath];
    }
    else {
        [self showDetailsForIndexPath:indexPath];
    }
    
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
   // NSLog(@"KKY - ProspectListing - PPIndexNo [notification object]- %@",[notification object]);
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
                
                const char *Group = (const char*)sqlite3_column_text(statement, 27);
                ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                
                const char *Title = (const char*)sqlite3_column_text(statement, 28);
                ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                
                const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
                IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                
                const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
                OtherIDType = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
                
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
                
                
                
                
                
                [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName
                                                                  AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                              AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3
                                                           AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                                       AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry
                                                                 AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown
                                                             AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                           AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark
                                                         AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality]];
                
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
    
    NSLog(@"KKY....PUSH EditProspect_Done");
  
    pp = Nil;

}
-(void) showDetailsForIndexPath:(NSIndexPath*)indexPath
{
    
    NSLog(@"kky show EditProspect");
    
 
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
    [self.navigationController pushViewController:_EditProspect animated:YES];
    _EditProspect.navigationItem.title = @"Edit Client Profile";
//    _EditProspect.navigationItem.rightBarButtonItem = _EditProspect.outletDone;
    pp = Nil, zzz = Nil;

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

- (IBAction)btnAddNew:(id)sender
{
    /*
    if (_ProspectViewController == Nil) {
        self.ProspectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Prospect"];
        _ProspectViewController.delegate = self;
    }*/
    
    self.ProspectViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Prospect"];
    _ProspectViewController.delegate = self;
    [self.navigationController pushViewController:_ProspectViewController animated:YES];
    _ProspectViewController.navigationItem.title = @"Add Client Profile";
}

-(void) ReloadTableData
{
    
    NSLog(@"ReloadTableData....");
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];

    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM prospect_profile WHERE QQFlag = 'false'  order by ProspectName ASC"];
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
            
            const char *Group = (const char*)sqlite3_column_text(statement, 27);
            NSString *ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                
            const char *Title = (const char*)sqlite3_column_text(statement, 28);
            NSString *ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                
            const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
            NSString *IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                
            const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
            NSString *OtherIDType = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
                
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
                
                
                
                               
            
            //NSString *ProspectContactType = @"2";
            //NSString *ProspectContactNo = @"0128765462";
            
            // NSLog(@"%@", ProspectRemark);
            [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName 
                                                              AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1
                                                          AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3  
                                                       AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState
                                                   AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry 
                                                             AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown 
                                                         AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode
                                                       AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark 
                                                     AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality]];
                
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
            sqlite3_finalize(statement);
        
        }
        sqlite3_close(contactDB);
        query_stmt = Nil, querySQL = Nil;
    }
    [self.myTableView reloadData];
    dirPaths = Nil;
    docsDir = Nil;
    dbpath = Nil;
    statement = Nil;
    
    [self getMobileNo];
    
}

-(void) FinishEdit
{
    isFiltered = FALSE;
    [self ReloadTableData];
//    searchBar.text = @"";
    _EditProspect = Nil;
    
}

-(void) FinishInsert
{
    isFiltered = FALSE;
    [self ReloadTableData];
//    searchBar.text = @"";
    _ProspectViewController = nil;
}

- (IBAction)searchPressed:(id)sender
{
    //KY START
   /*
    [self.view endEditing:YES];

    if ([nametxt.text length] == 0 && [txtIDTypeNo.text length] == 0){
        
    //    if ([_btnStatus.titleLabel.text isEqualToString:@"-- Select Status --"]){
            
            
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
       // }
        
        
        
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;

    
    results= [database executeQuery:@"SELECT * FROM prospect_profile where ProspectName like ? and IDTypeNo like ?",[NSString stringWithFormat:@"%%%@%%", nametxt.text],[NSString stringWithFormat:@"%%%@%%", txtIDTypeNo.text]];
    
    ProspectTableData = [[NSMutableArray alloc] init];
    
    while([results next])
	{
        
        NSLog(@"KY result  - name %@  || id = %@", [results stringForColumn:@"ProspectName"], [results stringForColumn:@"IDTypeNo"]);
       
         NSString *ProspectName = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(results, 2)];
     
        
      	}
    //KY END
    
    */
    
    
    
    [self resignFirstResponder];
    [self.view endEditing:YES];
    NSString *querySQL = Nil;
    
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
      //  querySQL = @"SELECT * FROM prospect_profile WHERE QQFlag = 'false'";
        querySQL = @"SELECT * FROM prospect_profile";
            
        if (![nametxt.text isEqualToString:@""]) {
            querySQL = [querySQL stringByAppendingFormat:@" WHERE ProspectName like \"%%%@%%\" and QQFlag = 'false'", nametxt.text ];
        }
        else if (![txtIDTypeNo.text isEqualToString:@""]) {
            querySQL = [querySQL stringByAppendingFormat:@" WHERE IDTypeNo like \"%%%@%%\" and QQFlag = 'false'", txtIDTypeNo.text ];
        }
        else if (!([btnGroup.titleLabel.text isEqualToString:@""]||[btnGroup.titleLabel.text isEqualToString:@"- Select -"])) {
            querySQL = [querySQL stringByAppendingFormat:@" WHERE ProspectGroup like \"%%%@%%\" and QQFlag = 'false'", btnGroup.titleLabel.text ];
        }
        
        querySQL = [querySQL stringByAppendingFormat:@" order by ProspectName ASC"];
        
      //  NSLog(@"KY - querySQL - %@", querySQL);
        //   if(sqlite3_prepare_v2(contactDB, SelectSI, -1, &statement, NULL) == SQLITE_OK)
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
                    
                const char *Group = (const char*)sqlite3_column_text(statement, 27);
                NSString *ProspectGroup = Group == NULL ? nil : [[NSString alloc] initWithUTF8String:Group];
                    
                const char *Title = (const char*)sqlite3_column_text(statement, 28);
                NSString *ProspectTitle = Title == NULL ? nil : [[NSString alloc] initWithUTF8String:Title];
                    
                const char *typeNo = (const char*)sqlite3_column_text(statement, 29);
                NSString *IDTypeNo = typeNo == NULL ? nil : [[NSString alloc] initWithUTF8String:typeNo];
                    
                const char *OtherType = (const char*)sqlite3_column_text(statement, 30);
                NSString *OtherIDType = OtherType == NULL ? nil : [[NSString alloc] initWithUTF8String:OtherType];
                    
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
                
               
                    
                [ProspectTableData addObject:[[ProspectProfile alloc] initWithName:NickName AndProspectID:ProspectID AndProspectName:ProspectName AndProspecGender:ProspectGender AndResidenceAddress1:ResidenceAddress1 AndResidenceAddress2:ResidenceAddress2 AndResidenceAddress3:ResidenceAddress3 AndResidenceAddressTown:ResidenceAddressTown AndResidenceAddressState:ResidenceAddressState AndResidenceAddressPostCode:ResidenceAddressPostCode AndResidenceAddressCountry:ResidenceAddressCountry AndOfficeAddress1:OfficeAddress1 AndOfficeAddress2:OfficeAddress2 AndOfficeAddress3:OfficeAddress3 AndOfficeAddressTown:OfficeAddressTown AndOfficeAddressState:OfficeAddressState AndOfficeAddressPostCode:OfficeAddressPostCode AndOfficeAddressCountry:OfficeAddressCountry AndProspectEmail:ProspectEmail AndProspectRemark:ProspectRemark AndProspectOccupationCode:ProspectOccupationCode AndProspectDOB:ProspectDOB AndExactDuties:ExactDuties AndGroup:ProspectGroup AndTitle:ProspectTitle AndIDTypeNo:IDTypeNo AndOtherIDType:OtherIDType AndOtherIDTypeNo:OtherIDTypeNo AndSmoker:Smoker AndAnnIncome:AnnIncome AndBussType:BussinessType AndRace:Race AndMaritalStatus:MaritalStatus AndReligion:Religion AndNationality:Nationality]];
                
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
    
    [self getMobileNo];
    
    [self.myTableView reloadData];
    statement = Nil;
    
}

- (IBAction)resetPressed:(id)sender
{
    nametxt.text = @"";
    txtIDTypeNo.text = @"";
    [btnGroup setTitle:@"- Select -" forState:UIControlStateNormal];
    btnGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self ReloadTableData];
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
   
    NSString *clt;
	sqlite3_stmt *statement;
	BOOL CanDelete;
    int RecCount = 0;
    for (UITableViewCell *cell in [self.myTableView visibleCells])
    {
        if (cell.selected == TRUE) {
            NSIndexPath *selectedIndexPath = [self.myTableView indexPathForCell:cell];
			ProspectProfile *pp = [ProspectTableData objectAtIndex:selectedIndexPath.row];
            if (RecCount == 0) {
                clt = pp.ProspectName;
            }
			
			if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK) {
				/*NSString *SQL = [NSString stringWithFormat:@"select * from ul_lapayor as A, clt_profile as B, prospect_profile as C where A.custcode = B.custcode "
								 "and B.indexno = c.indexno AND C.indexNo = '%@' ", pp.ProspectID];*/
                // Changes made by Benjamin in 14/10/2013 to fix bug 2461
                // For Trad product should check trad_lapayor and not ul_payor table.
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
    
	if (CanDelete == FALSE) {
		NSString *msg = @"Error, there is SI tie to the prospect";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mobile Planner" message:msg delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
		[alert show];

	}
	else{
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
	}

	
    
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
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
			
            for(int a=0; a<sorted.count; a++) {
                int value = [[sorted objectAtIndex:a] intValue];
                value = value - a;
                
                ProspectProfile *pp = [ProspectTableData objectAtIndex:value];
                NSString *DeleteSQL = [NSString stringWithFormat:@"Delete from prospect_profile where indexNo = \"%@\"", pp.ProspectID];
                //NSLog(@"%@",DeleteSQL);
                
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
        [self.myTableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self ReloadTableData];
        
        ItemToBeDeleted = [[NSMutableArray alloc] init];
        indexPaths = [[NSMutableArray alloc] init];
        deleteBtn.enabled = FALSE;
        [deleteBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal ];
        
    }
}

- (IBAction)ActionGroup:(id)sender
{
    if (_GroupList == nil) {
        self.GroupList = [[GroupClass alloc] initWithStyle:UITableViewStylePlain];
        _GroupList.delegate = self;
        self.GroupPopover = [[UIPopoverController alloc] initWithContentViewController:_GroupList];
    }
    
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
    btnGroup.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnGroup setTitle:[[NSString stringWithFormat:@" "] stringByAppendingFormat:@"%@",aaGroup]forState:UIControlStateNormal];
    [self.GroupPopover dismissPopoverAnimated:YES];
}

 

@end
