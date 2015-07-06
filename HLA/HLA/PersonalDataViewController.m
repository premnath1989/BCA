//
//  PersonalDataViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "PersonalDetialsViewController.h"
#import "CustomerViewController.h"
//#import "ChildrenViewController.h"
#import "ChildrenandDependents.h"
#import "SpouseViewController.h"
#import "ColorHexCode.h"
#import "SelectPartner.h"
#import "PartnerViewController.h"
#import "PartnerClientProfile.h"


#import "CustomerClientProfile.h"
#import "DataClass.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "ChildrenDependents.h"
#import "textFields.h"
#import "MasterMenuCFF.h"

@interface PersonalDataViewController (){
     DataClass *obj;
}

@end

@implementation PersonalDataViewController

//@synthesize aa = _aa;

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
    
   
    //PersonalDetialsViewController *aa;
    //aa.delegate = self;
    [super viewDidLoad];
    //NSLog(@"cascascas");
    //tableView.delegate = self;
    //tableView.dataSource = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Customer Fact Find";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];

    showCustomer = 0;
    showSpouse = 0;
    showChildren = 0;
    
    //_addCustomerView.hidden = TRUE;
    //_addedCustomerView.hidden = TRUE;
    //_addedSpouseView.hidden = TRUE;
    //_addedChildrenView.hidden = TRUE;
    
    obj=[DataClass getInstance];
    _addCustomerTitle.text = [NSString stringWithFormat:@"Customer Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"]];
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
        _addSpouseTitle.text = [NSString stringWithFormat:@"Partner/Spouse Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"]){
        _child1.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen1Name"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]){
        _child2.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen2Name"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]){
        _child3.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen3Name"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]){
        _child4.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen4Name"]];
    }
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden5"] isEqualToString:@"1"]){
        _child5.text = [NSString stringWithFormat:@"Name: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Childen5Name"]];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    if (indexPath.section == 0){
        
        if (indexPath.row == 0){
            CustomerClientProfile *customerClientProfile = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerClientProfile"];
            [self presentViewController:customerClientProfile animated:YES completion:nil];
            
        }
        else if (indexPath.row == 1){
            
            //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"]);
            
            if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"0"]){
                SelectPartner *selectPartner = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectPartner"];
                selectPartner.delegate = self;
                [self presentViewController:selectPartner animated:YES completion:nil];
            }
            else{
                PartnerClientProfile *partnerClientProfile = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PartnerClientProfile"];
                partnerClientProfile.delegate = self;
                [self presentViewController:partnerClientProfile animated:YES completion:Nil];
            }
            
        }
    }
    else if (indexPath.section == 1){
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
        
        ChildrenDependents *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ChildrenDependents"];
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        vc.rowToUpdate = indexPath.row;
        vc.delegate = self;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Children and Dependents’ Details in sequence." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        if (indexPath.row == 1) {
            if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"] && ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
        }
        else if (indexPath.row == 2) {
            if ((![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
        }
        else if (indexPath.row == 3) {
            if ((![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
            
        }
        else if (indexPath.row == 4) {
            if ((![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden5"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
        }
        [self presentViewController:vc animated:YES completion:NULL];
        //[[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ProtectionNeedValidation"];
        
    }
    /*
    UIStoryboard *storyboard = self.storyboard;
    if (indexPath.section == 0){
        
        if (indexPath.row == 0){
                PersonalDetialsViewController *personalDetialsView = [storyboard instantiateViewControllerWithIdentifier:@"PersonalDetialsViewController"];
                [self presentViewController:personalDetialsView animated:YES completion:nil];
                personalDetialsView.delegate = self;

        }
        else if (indexPath.row == 1){
                PersonalDetialsViewController *personalDetialsView = [storyboard instantiateViewControllerWithIdentifier:@"PersonalDetialsViewController"];
                [self presentViewController:personalDetialsView animated:YES completion:nil];
                personalDetialsView.delegate = self;

        }
    }
    
    else if (indexPath.section == 1){
        if (indexPath.row == 0){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
        else if (indexPath.row == 1){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
        else if (indexPath.row == 2){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
        else if (indexPath.row == 3){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
        else if (indexPath.row == 4){
            ChildrenandDependents *childrenView = [storyboard instantiateViewControllerWithIdentifier:@"ChildrenViewController"];
            [self presentViewController:childrenView animated:YES completion:nil];
        }
    }
     */
    
}


- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    if (indexPath.section == 0){
        
        if (indexPath.row == 0){
            CustomerClientProfile *customerClientProfile = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerClientProfile"];
            [self presentViewController:customerClientProfile animated:YES completion:nil];
            
        }
        else if (indexPath.row == 1){
            
            //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"]);
            
            if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"0"]){
                SelectPartner *selectPartner = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectPartner"];
                selectPartner.delegate = self;
                [self presentViewController:selectPartner animated:YES completion:nil];
            }
            else{
                PartnerClientProfile *partnerClientProfile = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PartnerClientProfile"];
                partnerClientProfile.delegate = self;
                [self presentViewController:partnerClientProfile animated:YES completion:Nil];
            }
            
        }
    }
    else if (indexPath.section == 1){
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
        
        ChildrenDependents *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"ChildrenDependents"];
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        vc.rowToUpdate = indexPath.row;
        vc.delegate = self;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please add Children and Dependents’ Details in sequence." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        if (indexPath.row == 1) {
            if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"] && ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
        }
        else if (indexPath.row == 2) {
            if ((![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
        }
        else if (indexPath.row == 3) {
            if ((![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
            
        }
        else if (indexPath.row == 4) {
            if ((![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden1"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden2"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden3"] isEqualToString:@"1"] || ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden4"] isEqualToString:@"1"]) && ![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingChilden5"] isEqualToString:@"1"]) {
                [alert show];
                alert = nil;
                return;
            }
        }
        [self presentViewController:vc animated:YES completion:NULL];
        //[[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFValidate"];
        //[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"ProtectionNeedValidation"];
        
    }
}



- (void)viewDidUnload {
    [self setAddCustomer:nil];
    [self setAddPartner:nil];
    [self setAddChildren1:nil];
    //[self setAddChildren2:nil];
    //[self setAddChildren3:nil];
    //[self setAddChildren4:nil];
    //[self setAddChildren5:nil];
    [self setAddCustomerView:nil];
    [self setAddedCustomerView:nil];
    [self setAddSpouseView:nil];
    [self setAddedSpouseView:nil];
    [self setAddChildrenView:nil];
    [self setAddedChildrenView:nil];
    //[self setCustomerName:nil];
    //[self setSpouseName:nil];
    [self setAddSpouseTitle:nil];
    [self setAddCustomerTitle:nil];
    [self setChild1:nil];
    [self setChild2:nil];
    [self setChild3:nil];
    [self setChild4:nil];
    [self setChild5:nil];
    [super viewDidUnload];
}

#pragma mark - ChildrenViewControllerDelegate
-(void)ChildrenViewDisplay{
    NSLog(@"aaaaa");
}

-(void)addedChildren
{
    NSLog(@"1111");
}

#pragma mark - PlayerDetailsViewControllerDelegate

-(void)CustomerViewDisplay:(NSString *)type{
    [self dismissViewControllerAnimated:TRUE completion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard CFF" bundle:nil];
        if ([type isEqualToString:@"customer"]){
            CustomerViewController *customerViewController = [storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
            [self presentViewController:customerViewController animated:YES completion:nil];
            //showCustomer = 1;
            [self.tableView reloadData];
        }
        else if ([type isEqualToString:@"spouse"]){
            SpouseViewController *spouseViewController = [storyboard instantiateViewControllerWithIdentifier:@"SpouseViewController"];
            [self presentViewController:spouseViewController animated:YES completion:nil];
            //showSpouse = 1;
            [self.tableView reloadData];
        }
    }];
}

-(void)DisplayPartnerCFF:(int)indexNo clientName:(NSString *)clientName clientID:(NSString *)clientID{
    
    
    //NSLog(@"aaaaaa%d",indexNo);
    
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:[NSString stringWithFormat:@"%d",indexNo] forKey:@"PartnerProfileID"];
    
    NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]);
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%d",indexNo]];
    bool company = FALSE;
    while ([results next]) {
        NSString *otherIDType = [results objectForColumnName:@"OtherIDType"];
        if ([[textFields trimWhiteSpaces:otherIDType] isEqualToString:@"CR"]) {
            company = TRUE;
        }
    }
    if (company) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Company cannot be the spouse for a CFF's payor." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
    
    results = Nil;
    
    results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%d",indexNo]];
    
    
    FMResultSet *cont6 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT006"];
	FMResultSet *cont7 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT007"];
	FMResultSet *cont8 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT008"];
	FMResultSet *cont9 = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%d", indexNo], @"CONT009"];
    
    while([results next]) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectTitle"] forKey:@"PartnerTitle"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectName"] forKey:@"PartnerName"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"IDTypeNo"] forKey:@"PartnerNRIC"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDType"] forKey:@"PartnerOtherIDType"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"OtherIDTypeNo"] forKey:@"PartnerOtherID"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Race"] forKey:@"PartnerRace"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Religion"] forKey:@"PartnerReligion"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Nationality"] forKey:@"PartnerNationality"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectGender"] forKey:@"PartnerSex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Smoker"] forKey:@"PartnerSmoker"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectDOB"] forKey:@"PartnerDOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerAge"]; //auto calculate
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"MaritalStatus"] forKey:@"PartnerMaritalStatus"]; //not yet
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectOccupationCode"] forKey:@"PartnerOccupationCode"];
		FMResultSet *results2 = [database executeQuery:@"SELECT * from Adm_Occp WHERE OccpCode = ?", [results stringForColumn:@"ProspectOccupationCode"], nil];
        while ([results2 next]) {
            NSLog(@"desc: %@", [results2 stringForColumn:@"OccpDesc"]);
            [[obj.CFFData objectForKey:@"SecC"] setValue:[results2 stringForColumn:@"OccpDesc"] forKey:@"PartnerOccupation"];
        }
                
        if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
			[[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerMailingAddressForeign"];
		}
		else {
			[[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerMailingAddressForeign"];
		}
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"PartnerMailingAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"PartnerMailingAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress3"] forKey:@"PartnerMailingAddress3"];
        
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressPostCode"] forKey:@"PartnerMailingPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressTown"] forKey:@"PartnerMailingAddressTown"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"PartnerMailingAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[self getCountryDesc:[results stringForColumn:@"ResidenceAddressCountry"]  passdb:database] forKey:@"PartnerMailingAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerPermanentAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressCountry"];

        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectEmail"] forKey:@"PartnerEmail"];
    }
    
    while ([cont6 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"Prefix"] forKey:@"PartnerResidenceTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont6 stringForColumn:@"ContactNo"] forKey:@"PartnerResidenceTel"];
	}
	
	while ([cont7 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"Prefix"] forKey:@"PartnerOfficeTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont7 stringForColumn:@"ContactNo"] forKey:@"PartnerOfficeTel"];
	}
	//fix for bug 2646 start
	while ([cont8 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"Prefix"] forKey:@"PartnerMobileTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont8 stringForColumn:@"ContactNo"] forKey:@"PartnerMobileTel"];
	}
	//fix for bug 2646 end
	while ([cont9 next]) {
		[[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"Prefix"] forKey:@"PartnerFaxTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[cont9 stringForColumn:@"ContactNo"] forKey:@"PartnerFaxTel"];
	}
    
    //NSLog(@"TTTT%@",[[obj.CFFData objectForKey:@"ProspectTitle"] objectForKey:@"PartnerTitle"]);
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    [self dismissViewControllerAnimated:TRUE completion:^{
        PartnerClientProfile *partnerClientProfile = [storyboard instantiateViewControllerWithIdentifier:@"PartnerClientProfile"];
        partnerClientProfile.delegate = self;
        [self presentViewController:partnerClientProfile animated:YES completion:^{
        }];
    }];
    

}

-(void)partnerUpdate{
    [self dismissViewControllerAnimated:TRUE completion:nil];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingPartner"];
    _addSpouseTitle.text = [NSString stringWithFormat:@"Partner/Spouse Name: %@",[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerName"]];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
	
	
	//clear FNA value
	UIImageView *imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3002];
    imageView = nil;
	imageView=(UIImageView *)[self.parentViewController.view viewWithTag:3005];
	imageView.hidden = TRUE;
	imageView = nil;
	
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"0" forKey:@"Completed"];
	[[obj.CFFData objectForKey:@"SecF"] setValue:@"1" forKey:@"Validate"];
	[[obj.CFFData objectForKey:@"SecFProtection"] setValue:@"0" forKey:@"Completed"];
	[[obj.CFFData objectForKey:@"SecFRetirement"] setValue:@"0" forKey:@"Completed"];
	[[obj.CFFData objectForKey:@"SecFEducation"] setValue:@"0" forKey:@"Completed"];
	[[obj.CFFData objectForKey:@"SecFSavings"] setValue:@"0" forKey:@"Completed"];
    
}
-(void)partnerDelete{
    [self dismissViewControllerAnimated:TRUE completion:nil];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingPartner"];
    _addSpouseTitle.text = [NSString stringWithFormat:@"Add Partner/Spouse"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerTitle"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerName"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerNRIC"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherIDType"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOtherID"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerRace"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerReligion"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerNationality"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerSex"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerSmoker"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerDOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerAge"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMaritalStatus"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressForeign"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddress3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingPostcode"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressTown"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressState"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerMailingAddressCountry"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressForeign"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentPostcode"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressTown"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressState"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressCountry"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerResidenceTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerResidenceTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerEmail"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerProfileID"];
    
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"ProtectionPartnerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerAlloc"];
    [[obj.CFFData objectForKey:@"SecF"] setValue:@"" forKey:@"RetirementPartnerRely"];
    
    MasterMenuCFF *parent = (MasterMenuCFF *) self.parentViewController;
    parent.FNARetirementVC.partnerAlloc.text = @"";
    parent.FNARetirementVC.partnerRely.text = @"";
    parent.FNAProtectionVC.partnerAlloc.text = @"";
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    
}


-(void)ChildrenDependentsUpdate:(ChildrenandDependents *)controller rowToUpdate:(int)rowToUpdate{
    
    if (rowToUpdate == 0){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden1"];
        _child1.text = [NSString stringWithFormat:@"Name: %@",controller.childName.text];
    }
    else if (rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden2"];
        _child2.text = [NSString stringWithFormat:@"Name: %@",controller.childName.text];
    }
    else if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden3"];
        _child3.text = [NSString stringWithFormat:@"Name: %@",controller.childName.text];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden4"];
        _child4.text = [NSString stringWithFormat:@"Name: %@",controller.childName.text];
    }
    else if (rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"ExistingChilden5"];
        _child5.text = [NSString stringWithFormat:@"Name: %@",controller.childName.text];
    }
    [self dismissViewControllerAnimated:TRUE completion:nil];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
}

-(void)ChildrenDependentsDelete:(ChildrenandDependents *)controller rowToUpdate:(int)rowToUpdate{
    
    if (rowToUpdate == 0){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden1"];
        _child1.text = [NSString stringWithFormat:@"Add Children and Dependents (1)"];
    }
    else if (rowToUpdate == 1){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden2"];
        _child2.text = [NSString stringWithFormat:@"Add Children and Dependents (2)"];
    }
    else if (rowToUpdate == 2){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden3"];
        _child3.text = [NSString stringWithFormat:@"Add Children and Dependents (3)"];
    }
    else if (rowToUpdate == 3){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden4"];
        _child4.text = [NSString stringWithFormat:@"Add Children and Dependents (4)"];
    }
    else if (rowToUpdate == 4){
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"ExistingChilden5"];
        _child5.text = [NSString stringWithFormat:@"Add Children and Dependents (5)"];
    }
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - CustomerViewControllerDelegate
-(void)addedCustomerDisplay:(NSString *)type{
    NSLog(@"%@",type);
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

@end
