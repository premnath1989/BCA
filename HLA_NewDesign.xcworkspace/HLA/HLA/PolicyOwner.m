//
//  PolicyOwner.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/14/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PolicyOwner.h"
#import "ColorHexCode.h"
#import "SubDetailsData.h"
#import "DataClass.h"
#import "PolicyOwnerData.h"
#import "ListingTbViewController.h"
#import "ProspectProfile.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
#import "SubDetails.h"


@interface PolicyOwner (){
    DataClass *obj;
    NSMutableDictionary *laDetails;
    NSMutableDictionary *la2Details;
    NSMutableDictionary *payorDetails;
    NSMutableDictionary *ownerDetails;
}

@end

@implementation PolicyOwner
@synthesize prospectPopover = _prospectPopover;
@synthesize  lbl_1LA, lbl_1LAStatus,lbl_2LA,lbl_2LAStatus,lbl_NewPO,lbl_payor,lbl_PayorStatus,lbl_1LA_2,lbl_payor_2,lbl_2LA_2,lbl_POName, ProspectTableData,po1,po2,po3,po4;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    obj=[DataClass getInstance];
    
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Select Policy Owner";
    self.navigationItem.titleView = label;
    
    
    
    //CHECK THE PO / LA
    
    //  select * from trad_lapayor where SINO  = 'SI20130320-0002'
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    [self loadDBData];
    NSArray *LADetails = [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"];
    NSString *la1;
    NSString *la2;
    NSString *payor;
    
    NSString *la1_poflag;
    NSString *la2_poflag;
    NSString *po_poflag;
    
    po1.hidden = true;
    po2.hidden = true;
    po3.hidden = true;
    po4.hidden = true;

    
    for (NSDictionary *details in LADetails) {
        NSString *pTypeCode = [details objectForKey:@"PTypeCode"];
     
        if ([pTypeCode isEqualToString:@"LA1"]) {
            la1 = [details objectForKey:@"LAName"];
            la1_poflag = [details objectForKey:@"POFlag"];
            laDetails = [details mutableCopy];
            [laDetails setValue:[NSString stringWithFormat:@"%d", [LADetails indexOfObject:details]] forKey:@"index"];
        }
        else if ([pTypeCode isEqualToString:@"LA2"]) {
            la2 = [details objectForKey:@"LAName"];
             la2_poflag = [details objectForKey:@"POFlag"];
            la2Details = [details mutableCopy];
            [la2Details setValue:[NSString stringWithFormat:@"%d", [LADetails indexOfObject:details]] forKey:@"index"];
        }
        else if ([pTypeCode isEqualToString:@"PY1"]) {
            payor = [details objectForKey:@"LAName"];
            payorDetails = [details mutableCopy];
            [payorDetails setValue:[NSString stringWithFormat:@"%d", [LADetails indexOfObject:details]] forKey:@"index"];
        }
        else if ([pTypeCode isEqualToString:@"PO"]) {
            ownerDetails = [details mutableCopy];
             po_poflag = [details objectForKey:@"POFlag"];
            [ownerDetails setValue:[NSString stringWithFormat:@"%d", [LADetails indexOfObject:details]] forKey:@"index"];
            lbl_NewPO.text = [ownerDetails objectForKey:@"LAName"];
            lbl_POName.text = @"Policy Owner";
            po4.hidden = false;
        }
    }
    
 
    
    if(la1)
    {
        if([la1_poflag isEqualToString:@"Y" ])
            po1.hidden = false;
        hide_1LA = false;
        hide_2LA = true;
        hide_payor = true;
        hide_newPO = false;
        lbl_1LA.text = la1;
      
    }
    
    if(la2 && hide_payor)
    {
        
        if([la2_poflag isEqualToString:@"Y" ])
            po2.hidden = false;

        hide_1LA = false;
        hide_2LA = false;
        hide_payor = true;
        hide_newPO = true;
        lbl_2LA.text = la2;
    }
    else if(la2 && !hide_payor) {
        
        
        if([la2_poflag isEqualToString:@"Y" ])
            po2.hidden = false;
        
        hide_1LA = false;
        hide_2LA = false;
        hide_payor = false;
        hide_newPO = true;
        lbl_2LA.text = la2;
    }
    
    if(payor && hide_2LA)
    {
        
        po3.hidden = false;
        
        hide_1LA = false;
        hide_2LA = true;
        hide_payor = false;
        hide_newPO = true;
        lbl_payor.text = payor;
    }
    else if (payor && !hide_2LA) {
        
        po3.hidden = false;
        
        hide_1LA = false;
        hide_2LA = false;
        hide_payor = false;
        hide_newPO = true;
        lbl_payor.text = payor;
    }
    
    
    //hide 'Policy Owner' label
     
       
 

}
/*
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0) {
 return 0;
 } else {
 return 50.0f;
 // whatever height you'd want for a real section header
 }
 }
 */


-(void)listing:(ListingTbViewController *)inController didSelectIndex:(NSString *)aaIndex andName:(NSString *)aaName andDOB:(NSString *)aaDOB andGender:(NSString *)aaGender andOccpCode:(NSString *)aaCode andSmoker:(NSString *)aaSmoker
{
    [self loadNewPO:@"PO" index:aaIndex POFlag:@"Y"];
    NSArray *LADetails = [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"];
    bool la1, la2, payor;
    for (NSDictionary *details in LADetails) {
        NSString *pTypeCode = [details objectForKey:@"PTypeCode"];
        if ([pTypeCode isEqualToString:@"LA1"]) {
            la1 = true;
            laDetails = [details mutableCopy];
            [laDetails setValue:[NSString stringWithFormat:@"%d", [LADetails indexOfObject:details]] forKey:@"index"];
        }
        else if ([pTypeCode isEqualToString:@"LA2"]) {
            la2 = true;
            la2Details = [details mutableCopy];
            [la2Details setValue:[NSString stringWithFormat:@"%d", [LADetails indexOfObject:details]] forKey:@"index"];
        }
        else if ([pTypeCode isEqualToString:@"PY1"]) {
            payor = true;
            payorDetails = [details mutableCopy];
            [payorDetails setValue:[NSString stringWithFormat:@"%d", [LADetails indexOfObject:details]] forKey:@"index"];
        }
        else if ([pTypeCode isEqualToString:@"PO"]) {
            ownerDetails = [details mutableCopy];
            [ownerDetails setValue:[NSString stringWithFormat:@"%d", [LADetails indexOfObject:details]] forKey:@"index"];
        }
    }
    lbl_NewPO.text = aaName;
    lbl_POName.text = @"Policy Owner";
    [self.prospectPopover dismissPopoverAnimated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 )
    {
        if(indexPath.row == 0 && hide_1LA == true)
        {
            lbl_1LA.hidden = true;
            lbl_1LAStatus.hidden = true;
            lbl_1LA_2.hidden = true;
            // lbl_POName.hidden = true;
            
            return 0;
            
        }
        if(indexPath.row == 1 && hide_2LA == true)
        {
            lbl_2LA.hidden = true;
            lbl_2LAStatus.hidden = true;
            lbl_2LA_2.hidden = true;
            // lbl_POName.hidden = true;
            return 0;
            
        }
        if(indexPath.row == 2 && hide_payor == true)
        {
            lbl_payor.hidden = true;
            lbl_PayorStatus.hidden = true;
            lbl_payor_2.hidden = true;
            //  lbl_POName.hidden = true;
            return 0;
            
        }
        
        else
            
            return 50.0f;
    }
    
    if (indexPath.section == 1 )
    {
        if(indexPath.row == 0 && hide_newPO == true)
        {
            lbl_NewPO.hidden = true;
            lbl_POName.hidden = true;
            
            
            return 0;
            
        }
        else
        {
            lbl_NewPO.hidden = false;
            lbl_POName.hidden = false;
            return 50.0f;
            
        }
    }
    else
        return 50.0f;
}


/*
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 
 
 if ( section == 1 )
 return 0;
 if ( section == 2 )
 return 0;
 if ( section == 3 )
 return 0;
 else
 
 return [super tableView:self.tableView numberOfRowsInSection:section];
 
 
 }
 */
-(void)updatePOLabel:(NSNotification *)notification

{
      NSString  *ptype = [notification object];
   
    
 
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* si = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    if(si.length != 0 && si != NULL){
        
        
        UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"MengCheong_Storyboard_eApp" bundle:Nil];
        if (indexPath.section == 0){
            if (indexPath.row == 0){
            
                
                obj=[DataClass getInstance];
                [[obj.eAppData objectForKey:@"PolicyOwner"] setValue:@"e-Application (1st Life Assured)" forKey:@"Title"];
                
                [[obj.eAppData objectForKey:@"SecPO"] setValue:@"Y" forKey:@"SecPO_1LA"];
                
                
                
                PolicyOwnerData *PolicyOwnerDataVC = [secondStoryboard instantiateViewControllerWithIdentifier:@"PolicyOwnerData"];
                PolicyOwnerDataVC.modalPresentationStyle = UIModalPresentationPageSheet;
                
                PolicyOwnerDataVC.LADetails = laDetails;
                PolicyOwnerDataVC.delegate = self;
                [self presentViewController:PolicyOwnerDataVC animated:YES completion:^{
                    PolicyOwnerDataVC.titleLabel.text = @"e-Application (1st Life Assured)";
                }];
                /*[self presentViewController:PolicyOwnerDataVC animated:YES completion:^{
                 _lifeAssuredStatus.hidden = FALSE;
                 _lifeAssuredStatus.text = @"Complete";
                 _lifeAssuredPO.hidden = FALSE;
                 
                 _POStatus.hidden = TRUE;
                 _POStatus.text = @"Incomplete";
                 _POStatus.hidden = TRUE;
                 _PO.hidden = TRUE;
                 
                 }];
                 */
                
            }
            else if (indexPath.row == 1)
            {
                
                
                
                // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doMyLayoutStuff:) name: object:self];
                
                obj=[DataClass getInstance];
                [[obj.eAppData objectForKey:@"PolicyOwner"] setValue:@"e-Application (2nd Life Assured)" forKey:@"Title"];
                
                PolicyOwnerData *PolicyOwnerDataVC = [secondStoryboard instantiateViewControllerWithIdentifier:@"PolicyOwnerData"];
                PolicyOwnerDataVC.modalPresentationStyle = UIModalPresentationPageSheet;
                
                PolicyOwnerDataVC.LADetails = la2Details;
                PolicyOwnerDataVC.delegate = self;
                [self presentViewController:PolicyOwnerDataVC animated:YES completion:^{
                    PolicyOwnerDataVC.titleLabel.text = @"e-Application (2nd Life Assured)";
                }];
                /*[self presentViewController:PolicyOwnerDataVC animated:YES completion:^{
                 _lifeAssuredStatus.hidden = FALSE;
                 _lifeAssuredStatus.text = @"Complete";
                 _lifeAssuredPO.hidden = FALSE;
                 
                 _POStatus.hidden = TRUE;
                 _POStatus.text = @"Incomplete";
                 _POStatus.hidden = TRUE;
                 _PO.hidden = TRUE;
                 
                 }];
                 */
                
            }
            
            
            else if (indexPath.row == 2)
            {
                
                
                
                // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doMyLayoutStuff:) name: object:self];
                obj=[DataClass getInstance];
                [[obj.eAppData objectForKey:@"PolicyOwner"] setValue:@"e-Application (2nd Life Assured)" forKey:@"Title"];
                
                PolicyOwnerData *PolicyOwnerDataVC = [secondStoryboard instantiateViewControllerWithIdentifier:@"PolicyOwnerData"];
                PolicyOwnerDataVC.modalPresentationStyle = UIModalPresentationPageSheet;
                PolicyOwnerDataVC.titleLabel.text = @"e-Application (Payor)";
                PolicyOwnerDataVC.LADetails = payorDetails;
                PolicyOwnerDataVC.delegate = self;
                [self presentViewController:PolicyOwnerDataVC animated:YES completion:^{
                    PolicyOwnerDataVC.titleLabel.text = @"e-Application (Payor)";
                }];
                /*[self presentViewController:PolicyOwnerDataVC animated:YES completion:^{
                 _lifeAssuredStatus.hidden = FALSE;
                 _lifeAssuredStatus.text = @"Complete";
                 _lifeAssuredPO.hidden = FALSE;
                 
                 _POStatus.hidden = TRUE;
                 _POStatus.text = @"Incomplete";
                 _POStatus.hidden = TRUE;
                 _PO.hidden = TRUE;
                 
                 }];
                 */
                
            }
            
            
        }
        else if (indexPath.section == 1){
            if (indexPath.row == 0){
                
                CGRect frame = CGRectMake(400, 80, 400, 100);
                
                
                if([lbl_POName.text  isEqualToString:@"Policy Owner Name"])
                {
                    if (_ProspectList == nil) {
                        self.ProspectList = [[ListingTbViewController alloc] initWithStyle:UITableViewStylePlain];
                        _ProspectList.delegate = self;
                        self.prospectPopover = [[UIPopoverController alloc] initWithContentViewController:_ProspectList];
                    }
                    
                    [self.prospectPopover presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
                    
                }
                else{
                    
                    obj=[DataClass getInstance];
                    [[obj.eAppData objectForKey:@"PolicyOwner"] setValue:@"e-Application (New Policy Owner)" forKey:@"Title"];
                    
                    PolicyOwnerData *PolicyOwnerDataVC = [secondStoryboard instantiateViewControllerWithIdentifier:@"PolicyOwnerData"];
                    PolicyOwnerDataVC.modalPresentationStyle = UIModalPresentationPageSheet;
                    
                    PolicyOwnerDataVC.LADetails = ownerDetails;
                    PolicyOwnerDataVC.delegate = self;
                    [self presentViewController:PolicyOwnerDataVC animated:YES completion:^{
                        PolicyOwnerDataVC.titleLabel.text = @"e-Application (New Policy Owner)";
                    }];
                    
                }
                
                
            }
        }
        
        
        else if (indexPath.section == 2){
            if (indexPath.row == 0){

                
                obj=[DataClass getInstance];
                [[obj.eAppData objectForKey:@"PolicyOwner"] setValue:@"e-Application (New Policy Owner)" forKey:@"Title"];
                
                SubDetailsData *subDetailsData = [secondStoryboard instantiateViewControllerWithIdentifier:@"subDataScreenPolicyOwnerNew"];
                subDetailsData.modalPresentationStyle = UIModalPresentationPageSheet;
                [self presentViewController:subDetailsData animated:YES completion:^{
                    _lifeAssuredStatus.hidden = TRUE;
                    _lifeAssuredStatus.text = @"Complete";
                    _lifeAssuredPO.hidden = TRUE;
                    
                    _POStatus.hidden = FALSE;
                    _POStatus.text = @"Incomplete";
                    _POStatus.hidden = FALSE;
                    _PO.hidden = FALSE;
                    _POName.text = @"Meng Cheong";
                }];
            }
        }
    }
}
- (void)viewDidAppear:(BOOL)animated
{
        [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
     }

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doClose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setLifeAssuredStatus:nil];
    [self setLifeAssuredPO:nil];
    [self setPO:nil];
    [self setPOStatus:nil];
    [self setPOName:nil];
    [self setLbl_1LA:nil];
    [self setLbl_2LA:nil];
    [self setLbl_payor:nil];
    [self setLbl_NewPO:nil];
    [self setLbl_1LAStatus:nil];
    [self setLbl_2LAStatus:nil];
    [self setLbl_PayorStatus:nil];
    [self setLbl_2LA_2:nil];
    [self setLbl_1LA_2:nil];
    [self setLbl_payor_2:nil];
    [self setLbl_POName:nil];
    [super viewDidUnload];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

-(void) loadNewPO:(NSString*)FinalPTypeCode index:(NSString*)indexNo POFlag:(NSString*)poflag
{
    NSMutableDictionary *SecPo_LADetails_Client = [NSMutableDictionary dictionary];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    
    NSString *querySQL3 = [NSString stringWithFormat:@"SELECT * from prospect_profile where IndexNo = '%@'",indexNo];
        
    results = [database executeQuery:querySQL3];
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
        
        FMResultSet *results;
        results = [database executeQuery:@"SELECT * FROM CONTACT_INPUT WHERE IndexNo = ?", indexNo];
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
        
        
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString *currentdate = [dateFormatter2 stringFromDate:[NSDate date]];
        
        
        
        NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
        
        results = nil;
        results = [database executeQuery:[NSString stringWithFormat:@"SELECT GuardianName, CONewICNo FROM eProposal WHERE eProposalNo = %@", eProposalNo]];
        while ([results next]) {
            guardianName = [results objectForColumnName:@"GuardianName"];
            guardianNRIC = [results objectForColumnName:@"CONewICNo"];
        }
        
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
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(contactDB, [query UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            if ((sqlite3_step(statement)) == SQLITE_DONE) {
                const char *occp = (const char*)sqlite3_column_text(statement, 0);
                [SecPo_LADetails_Client setValue:[[NSString alloc] initWithUTF8String:occp] forKey:@"LAOccupationCode"];
            }
        }
        
        [SecPo_LADetails_Client setValue:Nationality forKey:@"LANationality"];
        [SecPo_LADetails_Client setValue:ExactDuties forKey:@"LAExactDuties"];
        [SecPo_LADetails_Client setValue:BussinessType forKey:@"LATypeOfBusiness"];
        
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
        
        if ([FinalPTypeCode isEqualToString:@"PO"]) {
            [[[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"LADetails"] addObject:[SecPo_LADetails_Client mutableCopy]];
        }
        
    }
    [results close];
    [database close];
}

-(void)loadDBData {
    
    NSMutableArray *LADetails = [NSMutableArray array];
    NSMutableDictionary *clientDetails = [NSMutableDictionary dictionary];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * from eProposal_LA_Details where eProposalNo = '%@'",eProposalNo];
    results = [database executeQuery:sqlQuery];
    while ([results next]) {
        NSString *ProspectName = [results objectForColumnName:@"LAName"];
     
        NSString *ProspectDOB = [results objectForColumnName:@"LADOB"];
        if  ((NSNull *) ProspectDOB == [NSNull null])
            ProspectDOB = @"";
        
        
        NSString *ProspectGender = [results objectForColumnName:@"LASex"];
        
        NSString *ResidenceAddress1 = [results objectForColumnName:@"ResidenceAddress1"];
        
        
        NSString *ResidenceAddress2 = [results objectForColumnName:@"ResidenceAddress2"];
        
        
        NSString *ResidenceAddress3 = [results objectForColumnName:@"ResidenceAddress3"];
        
        
        NSString *ResidenceAddressTown = [results objectForColumnName:@"ResidenceTown"];
        
        
        NSString *ResidenceAddressState = [results objectForColumnName:@"ResidenceState"];
        
        
        NSString *ResidenceAddressPostCode = [results objectForColumnName:@"ResidencePostcode"];
        
        
        NSString *ResidenceAddressCountry = [results objectForColumnName:@"ResidenceCountry"];
        
        
        NSString *OfficeAddress1 = [results objectForColumnName:@"OfficeAddress1"];
        
        
        NSString *OfficeAddress2 = [results objectForColumnName:@"OfficeAddress2"];
        
        
        NSString *OfficeAddress3 = [results objectForColumnName:@"OfficeAddress2"];
        
        
        NSString *OfficeAddressTown = [results objectForColumnName:@"OfficeTown"];
        
        
        NSString *OfficeAddressState = [results objectForColumnName:@"OfficeState"];
        
        
        NSString *OfficeAddressPostCode = [results objectForColumnName:@"OfficePostcode"];
        
        
        NSString *OfficeAddressCountry = [results objectForColumnName:@"OfficeCountry"];
        
        
        NSString *ProspectEmail = [results objectForColumnName:@"EmailAddress"];
        
        NSString *ProspectOccupationCode = [results objectForColumnName:@"LAOccupationCode"];
        
        if  ((NSNull *) ProspectOccupationCode == [NSNull null])
            ProspectOccupationCode = @"";
        
        
        NSString *ExactDuties = [results objectForColumnName:@"LAExactDuties"];
        if  ((NSNull *) ExactDuties == [NSNull null])
            ExactDuties = @"";
        
        
        NSString *ProspectRemark = @"";
        
        
        NSString *ProspectGroup = @"";
        
        
        NSString *ProspectTitle = [results objectForColumnName:@"LATitle"];
        
        
        NSString *IDTypeNo = [results objectForColumnName:@"LANewICNo"];
        
        NSString *OtherIDType = [results objectForColumnName:@"LAOtherIDType"];
        if([OtherIDType isEqualToString:@"(null)"])
            OtherIDType = @"";

        OtherIDType =  [OtherIDType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
               
        
        NSString *OtherIDTypeNo = [results objectForColumnName:@"LAOtherID"];
        if([OtherIDTypeNo isEqualToString:@"(null)"])
            OtherIDTypeNo = @"";
        OtherIDTypeNo = [OtherIDTypeNo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       
        
        
        NSString *Smoker = @"";
        
        
        NSString *AnnIncome = [results objectForColumnName:@"LAYearlyIncome"];
        
        
        NSString *BussinessType = [results objectForColumnName:@"LATypeOfBusiness"];
        
        
        NSString *Race = [results objectForColumnName:@"LARace"];
        if  ((NSNull *) Race == [NSNull null])
            Race = @"";
        
        NSString *MaritalStatus = [results objectForColumnName:@"LAMaritalStatus"];
        if  ((NSNull *) MaritalStatus == [NSNull null])
            MaritalStatus = @"";
        
        
        
        NSString *Religion = [results objectForColumnName:@"LAReligion"];
        if  ((NSNull *) Religion == [NSNull null])
            Religion = @"";
        
        
        NSString *Nationality =[results objectForColumnName:@"LANationality"];
        
        if  ((NSNull *) Nationality == [NSNull null])
            Nationality = @"";
        
        NSString *homeNo = [results objectForColumnName:@"ResidencePhoneNo"];
        NSString *officeNo = [results objectForColumnName:@"OfficePhoneNo"];;
        NSString *mobileNo = [results objectForColumnName:@"MobilePhoneNo"];;
        NSString *faxNo = [results objectForColumnName:@"FaxPhoneNo"];;
        
        
        NSString *homeNoPrefix = @"";
        NSString *officeNoPrefix = @"";
        NSString *mobileNoPrefix = @"";
        NSString *faxNoPrefix = @"";
        
        NSString *guardianName = @"";
        NSString *guardianNRIC = @"";
        
        
        
        /*results = [database executeQuery:@"SELECT * FROM CONTACT_INPUT WHERE IndexNo = ?", indexNo];
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
        }*/
        
        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
        NSString *currentdate = [dateFormatter2 stringFromDate:[NSDate date]];
        NSString *q = [NSString stringWithFormat:@"SELECT GuardianName, GuardianNewICNo FROM eProposal WHERE eProposalNo = '%@'", eProposalNo];

        FMResultSet *results2 = [database executeQuery:q];
        while ([results2 next]) {
            guardianName = [results2 objectForColumnName:@"GuardianName"];
            guardianNRIC = [results2 objectForColumnName:@"GuardianNewICNo"];
        }
        if  ((NSNull *) guardianName == [NSNull null])
            guardianName = @"";
        if  ((NSNull *) guardianNRIC == [NSNull null])
            guardianNRIC = @"";
        
        [results2 close];
        [clientDetails setValue:eProposalNo forKey:@"eProposalNo"];
        [clientDetails setValue:[results objectForColumnName:@"PTypeCode"] forKey:@"PTypeCode"];
        [clientDetails setValue:ProspectTitle forKey:@"LATitle"];
        [clientDetails setValue:ProspectName forKey:@"LAName"];
        
        [clientDetails setValue:ProspectGender forKey:@"LASex"];
        [clientDetails setValue:ProspectDOB forKey:@"LADOB"];
        [clientDetails setValue:IDTypeNo forKey:@"LANewICNO"];
        [clientDetails setValue:OtherIDType forKey:@"LAOtherIDType"];
        
        [clientDetails setValue:OtherIDTypeNo forKey:@"LAOtherID"];
        [clientDetails setValue:MaritalStatus forKey:@"LAMaritalStatus"];
        [clientDetails setValue:Race forKey:@"LARace"];
        [clientDetails setValue:Religion forKey:@"LAReligion"];
        
        [clientDetails setValue:ProspectOccupationCode forKey:@"LAOccupationCode"];
        
        NSString *occupation =  [NSString stringWithFormat:@"SELECT OccpDesc FROM Adm_Occp WHERE OccpCode = '%@'",ProspectOccupationCode];
        FMResultSet *results3 = [database executeQuery:occupation];
        while ([results3 next]) {
            NSString *occpDesc = [results3 objectForColumnName:@"OccpDesc"];
            [clientDetails setValue:occpDesc forKey:@"LAOccupationCode"];
        }
        [results3 close];
        results3 = nil;
        
        NSString *POFlag = [results objectForColumnName:@"POFlag"];;
        /*NSString *getpoflag =  [NSString stringWithFormat:@"SELECT POFlag FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND PTypeCode = '%@'", eProposalNo,FinalPTypeCode];
        
        FMResultSet *results3 = [database executeQuery:getpoflag];
        while ([results3 next]) {
            POFlag = [results3 objectForColumnName:@"POFlag"];
            
            
        }
        results3 = nil;
        */
        
        
        [clientDetails setValue:POFlag forKey:@"POFlag"];
        [clientDetails setValue:Nationality forKey:@"LANationality"];
        [clientDetails setValue:ExactDuties forKey:@"LAExactDuties"];
        [clientDetails setValue:BussinessType forKey:@"LATypeOfBusiness"];
        
        [clientDetails setValue:@"" forKey:@"LAEmployerName"];
        [clientDetails setValue:AnnIncome forKey:@"LAYearlyIncome"];
        [clientDetails setValue:@"" forKey:@"LARelationship"];
        //[clientDetails setValue:FinalPTypeCode forKey:@"POFlag"]; //POFLAG
        
        [clientDetails setValue:@"" forKey:@"CorrespondenceAddress"];
        [clientDetails setValue:@"" forKey:@"ResidenceOwnRented"];
        [clientDetails setValue:ResidenceAddress1 forKey:@"ResidenceAddress1"];
        [clientDetails setValue:ResidenceAddress2 forKey:@"ResidenceAddress2"];
        
        [clientDetails setValue:ResidenceAddress3 forKey:@"ResidenceAddress3"];
        [clientDetails setValue:ResidenceAddressTown forKey:@"ResidenceTown"];
        [clientDetails setValue:ResidenceAddressState forKey:@"ResidenceState"];
        [clientDetails setValue:ResidenceAddressPostCode forKey:@"ResidencePostcode"];
        
        [clientDetails setValue:ResidenceAddressCountry forKey:@"ResidenceCountry"];
        [clientDetails setValue:OfficeAddress1 forKey:@"OfficeAddress1"];
        [clientDetails setValue:OfficeAddress2 forKey:@"OfficeAddress2"];
        [clientDetails setValue:OfficeAddress3 forKey:@"OfficeAddress3"];
        
        [clientDetails setValue:OfficeAddressTown forKey:@"OfficeTown"];
        [clientDetails setValue:OfficeAddressState forKey:@"OfficeState"];
        [clientDetails setValue:OfficeAddressPostCode forKey:@"OfficePostcode"];
        [clientDetails setValue:OfficeAddressCountry forKey:@"OfficeCountry"];
        
        [clientDetails setValue:homeNoPrefix forKey:@"ResidencePhoneNoPrefix"];
        [clientDetails setValue:homeNo forKey:@"ResidencePhoneNo"];
        [clientDetails setValue:officeNoPrefix forKey:@"OfficePhoneNoPrefix"];
        [clientDetails setValue:officeNo forKey:@"OfficePhoneNo"];
        [clientDetails setValue:faxNoPrefix forKey:@"FaxPhoneNoPrefix"];
        [clientDetails setValue:faxNo forKey:@"FaxPhoneNo"];
        [clientDetails setValue:mobileNoPrefix forKey:@"MobilePhoneNoPrefix"];
        [clientDetails setValue:mobileNo forKey:@"MobilePhoneNo"];
        
        [clientDetails setValue:ProspectEmail forKey:@"EmailAddress"];
        [clientDetails setValue:@"" forKey:@"PentalHealthStatus"];
        [clientDetails setValue:@"" forKey:@"PentalFemaleStatus"];
        [clientDetails setValue:@"" forKey:@"PentalDeclarationStatus"];
        
        [clientDetails setValue:guardianName forKey:@"GuardianName"];
        [clientDetails setValue:guardianNRIC forKey:@"GuardianNRIC"];
        
        
        [clientDetails setValue:@"" forKey:@"LACompleteFlag"];
        [clientDetails setValue:@"" forKey:@"AddPO"];
        [clientDetails setValue:currentdate forKey:@"CreatedAt"];
        [clientDetails setValue:@"" forKey:@"UpdatedAt"];
        
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
        
        [LADetails addObject:[clientDetails mutableCopy]];
        clientDetails = nil;
        clientDetails = [NSMutableDictionary dictionary];
    }
    
    [results close];
    results = nil;
    [database close];
    if (![obj.eAppData objectForKey:@"SecPO"]) {
        [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"SecPO"];
    }
    [[obj.eAppData objectForKey:@"SecPO"] setValue:[LADetails mutableCopy] forKey:@"LADetails"];
}

#pragma mark delegate
-(void)updatePO
{
    
   NSString *potype =  [[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"];
    
    if([potype isEqualToString:@"LA1"])
        po1.hidden = false;
    else if([potype isEqualToString:@"LA2"])
        po2.hidden = false;
    else if([potype isEqualToString:@"PY1"])
        po3.hidden = false;
    else if([potype isEqualToString:@"PO"])
        po4.hidden = false;
    
    else
    {
        po1.hidden = true;
        po2.hidden = true;
        po3.hidden = true;
        po4.hidden = true;
    }
    
}
-(void)doneDelete {
    [self loadDBData];
    [self.tableView reloadData];
    lbl_NewPO.text = @"Add New Policy Owner";
    lbl_POName.text = @"Policy Owner Name";
    po4.hidden = true;
}
@end
