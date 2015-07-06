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
    
    results = Nil;
    
    results = [database executeQuery:@"select * from prospect_profile where IDTypeNo = ?",clientID];
    while([results next]) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectTitle"] forKey:@"PartnerTitle"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectName"] forKey:@"PartnerName"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"IDTypeNo"] forKey:@"PartnerNRIC"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@" " forKey:@"PartnerOtherIDType"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:@" " forKey:@"PartnerOtherID"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"CHINESE" forKey:@"PartnerRace"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"Non Muslim" forKey:@"PartnerReligion"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"MALAYSIA" forKey:@"PartnerNationality"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectGender"] forKey:@"PartnerSex"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"Smoker"] forKey:@"PartnerSmoker"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ProspectDOB"] forKey:@"PartnerDOB"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerAge"]; //auto calculate
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"Married" forKey:@"PartnerMaritalStatus"]; //not yet
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerMailingAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"PartnerMailingAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress2"] forKey:@"PartnerMailingAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddress1"] forKey:@"PartnerMailingAddress3"];
        
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"53300" forKey:@"PartnerMailingPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"KUALA LUMPUR" forKey:@"PartnerMailingAddressTown"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressState"] forKey:@"PartnerMailingAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:[results stringForColumn:@"ResidenceAddressCountry"] forKey:@"PartnerMailingAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerPermanentAddressForeign"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress1"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress2"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddress3"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentPostcode"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressTown"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressState"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerPermanentAddressCountry"];
        
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"03" forKey:@"PartnerResidenceTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"40231538" forKey:@"PartnerResidenceTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"mengcheo@yahoo.com" forKey:@"PartnerEmail"];
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
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"03" forKey:@"PartnerResidenceTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"40231538" forKey:@"PartnerResidenceTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerOfficeTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerFaxTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"mengcheo@yahoo.com" forKey:@"PartnerEmail"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:@"" forKey:@"PartnerProfileID"];
    
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



@end
