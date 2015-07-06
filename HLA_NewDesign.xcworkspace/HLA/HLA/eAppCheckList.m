//
//  eAppCheckList.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/14/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eAppCheckList.h"

#import "SICell.h"
#import "PolicyOwnerCell.h"
#import "CFFCell.h"
#import "eAppCell.h"
#import "eSignCell.h"
#import "eSubCell.h"

#import "eAppsListing.h"
#import "PolicyOwner.h"
#import "SelectCFF.h"
#import "eSignVC.h"
#import "COAPDF.h"

#import "DataClass.h"

#import "SIMenuViewController.h"


@interface eAppCheckList (){
    NSMutableArray *items;
    
    SICell *siCell;
    PolicyOwnerCell *poCell;
    CFFCell *cffCell;
    eAppCell *eappCell;
    eSignCell *esignCell;
    eSubCell *esubcell;
    
    int updateSICell;
    int updateCFFCell;
    
    DataClass *obj;
}

@end

@implementation eAppCheckList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    NSLog(@"eAppChecklist..!!");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    items = [[NSMutableArray alloc] initWithObjects:@"Select SI", @"Select Policy Owner", @"Select eCFF",@"e-Application",@"e-Signature",nil];
    updateSICell = 0;
    updateCFFCell = 0;
    obj=[DataClass getInstance];
    
   // [[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"SISelected2"];
    
    
    
    //NSLog(@"TTTT%@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected"]);
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"eApp check list view will appear");

    //NSLog(@"TTTT%@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
    //obj=[DataClass getInstance];
//NSLog(@"XXX%@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]);
    
    
    if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected"] != Nil){
        NSString *aa;
        aa = [NSString stringWithFormat:@"Selected SI No: %@   Client Name: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
        siCell.descriptionLabel1.text = aa;
        UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
        [siCell.statusImage1 setImage:doneImage];
        
        
        
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doEAppListing:(id)sender {
    
    //NSLog(@"xxxx");
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 6;//[self.players count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SICellIdentifier = @"SICell";
    static NSString *PolicyOwnerCellIdentifier = @"PolicyOwnerCell";
    static NSString *CFFCellIdentifier = @"CFFCell";
    static NSString *eAppCellIdentifier = @"eAppCell";
    static NSString *eSignCellIdentifier = @"eSignCell";
    //static NSString *eSubCellIdentifier = @"eSubCell";
    
    UITableViewCell *cell;
    
    
    
    
    
    /*
    PlayerCell *cell = (PlayerCell *)[tableView dequeueReusableCellWithIdentifier:@"PlayerCell"];
	Player *player = [self.players objectAtIndex:indexPath.row];
	cell.nameLabel.text = player.name;
	cell.gameLabel.text = player.game;
	cell.ratingImageView.image = [self imageForRating:player.rating];
    */
    
    if (indexPath.row == 0){
        siCell = [tableView dequeueReusableCellWithIdentifier:SICellIdentifier];
        return siCell;
    }
    else if (indexPath.row == 1){
        poCell = [tableView dequeueReusableCellWithIdentifier:PolicyOwnerCellIdentifier];
        //cell = [tableView dequeueReusableCellWithIdentifier:PolicyOwnerCellIdentifier forIndexPath:indexPath];
        return poCell;
    }
    else if (indexPath.row == 2){
        cffCell = [tableView dequeueReusableCellWithIdentifier:CFFCellIdentifier];
        //cell = [tableView dequeueReusableCellWithIdentifier:CFFCellIdentifier forIndexPath:indexPath];
        return cffCell;
    }
    else if (indexPath.row == 3){
        eappCell = [tableView dequeueReusableCellWithIdentifier:eAppCellIdentifier];
        //cell = [tableView dequeueReusableCellWithIdentifier:eAppCellIdentifier forIndexPath:indexPath];
        return eappCell;
    }
    else if (indexPath.row == 4){
        esignCell = [tableView dequeueReusableCellWithIdentifier:eSignCellIdentifier];
        //cell = [tableView dequeueReusableCellWithIdentifier:eSignCellIdentifier forIndexPath:indexPath];
        return esignCell;
    }
    /*
    else if (indexPath.row == 5){
        //eSubCell *cell = [tableView dequeueReusableCellWithIdentifier:eSubCellIdentifier forIndexPath:indexPath];
        cell = [tableView dequeueReusableCellWithIdentifier:eSubCellIdentifier forIndexPath:indexPath];
        //return cell;
    }
     */
    else if (indexPath.row == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"eConfirmationCell"];
        return cell;
    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (indexPath.row == 0) {
        return 100;
    } else {
        return 60;
    }
     */
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {   //go SI listing
        
        
        if([[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"SISelected2"] isEqualToString:@"1"])
        {
        if ([[obj.eAppData objectForKey:@"SI"] objectForKey:@"SINumber"] == Nil || [[[obj.eAppData objectForKey:@"SI"] objectForKey:@"SINumber"] isEqualToString:@"Not Set"])
        {
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
            eAppsListing *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"eAppList"];
            vc.delegate = self;
            vc.modalTransitionStyle = UIModalPresentationFormSheet;
            [self presentViewController:vc animated:YES completion:Nil];
        }
        else{
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
            SIMenuViewController *main = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIPageView"];
            main.requestSINo = [[obj.eAppData objectForKey:@"SI"] objectForKey:@"SINumber"];
//			main.NameLA = [[obj.eAppData objectForKey:@"SI"] objectForKey:@"NameLA"];
            main.EAPPorSI = @"eAPP";
            [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
//			[[obj.eAppData objectForKey:@"SI"] setValue:main.NameLA forKey:@"NameLA"];
            main.modalTransitionStyle = UIModalPresentationFormSheet;
            [self presentViewController:main animated:YES completion:nil];
            
        }
        }
    }
    else if (indexPath.row == 1) {
     //   if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] != Nil){
            
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
            PolicyOwner *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PolicyOwner"];
            //vc.delegate = self;
            vc.modalTransitionStyle = UIModalPresentationFormSheet;
            [self presentViewController:vc animated:YES completion:^{
            }];
     /*   }
        else{
            
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message: @"Please confirm Sales Illustration before Policy Owner/Life Assured."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;

            
        }
       */         
    }
    
    else if (indexPath.row == 2) {
        
       // if([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CompleteCustomerCFF"] != Nil){
        if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] == Nil){
        
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
            SelectCFF *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectCFFeApp"];
            vc.delegate = self;
            vc.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:vc animated:YES completion:^{
            }];
        }
        else{
            //NSLog(@"sss");
            UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
            MasterMenuCFF *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"CustomerFactFind"];
            vc.modalTransitionStyle = UIModalPresentationFormSheet;
            vc.eApp = true;
            vc.fLoad = @"1";
            vc.name = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFName"];
            [self presentViewController:vc animated:YES completion:NULL];
        }
       /* }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message: @"Please confirm Policy Owner before CustomerFactFind."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;

        }
        */
    }
    
    else if (indexPath.row == 3) {
  NSLog(@"data after select incomplete proposal: sinumber - %@, proposalNO - %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]);
//          if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
              UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
              UIViewController *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"eAppMaster"];
              vc.modalTransitionStyle = UIModalPresentationFormSheet;
              [self presentViewController:vc animated:YES completion:NULL];
		
		
//          }
//          else{
//              
//              UIAlertView *alert = [[UIAlertView alloc]
//                                    initWithTitle: @"iMobile Planner"
//                                    message: @"Please confirm CustomerCFF before Proposal form."
//                                    delegate: self
//                                    cancelButtonTitle:@"OK"
//                                    otherButtonTitles:nil];
//              [alert setTag:1003];
//              [alert show];
//              alert = Nil;
//
//          }
      
    
    }
    
    else if (indexPath.row == 4) {
        if ([[obj.eAppData objectForKey:@"Proposal"] objectForKey:@"Confirmation"] != Nil){
            UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
            //UIViewController *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"eSign"];
            //vc.modalTransitionStyle = UIModalPresentationPageSheet;
            //[self presentViewController:vc animated:YES completion:NULL];
            
            
            eSignVC *esign = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"eSign"];
            esign.delegate = self;
            [self presentViewController:esign animated:YES completion:nil];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message: @"Please confirm proposal form before e-Signature"
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
        }
        

    
    
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Please complete the following items before submission";
}

-(void)displayPDF:(NSString *)formType{
    //NSLog(@"%@",formType);
    [self dismissViewControllerAnimated:TRUE completion:^{

        UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
        COAPDF *coaPDF = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"COA"];
        coaPDF.delegate = self;
        [self presentViewController:coaPDF animated:YES completion:nil];
        
    }];
    



}

-(void)updateChecklistSI{
    NSLog(@"!!!!!!!!!! eAppCheckList - updateChecklistSI   !!!!!!!!!!");
    updateSICell = 1;
    //[_checklistTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:NO];
    //[_checklistTable reloadData];
    //[_checklistTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    //[_checklistTable.ce];
	//[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //[];
    //siCell.titleLabel.text = @"qqqqq";
    //_SILabel.text = @"safasf";
}

-(void)updateChecklistCFF {
    updateCFFCell = 1;
    NSLog(@"eAppData CFF = %@", [obj.eAppData objectForKey:@"CFF"]);
    if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
        NSLog(@"Hello updateCFF");
        NSString *aa;
        aa = [NSString stringWithFormat:@"Customer Fact Find: %@  Updated On:%@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFDate"]];
        cffCell.descriptionLabel1.text = aa;
        if ([[[obj.eAppData objectForKey:@"CFF"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [cffCell.statusLabel1 setImage:doneImage];
        }
        //NSLog(@)
    }
}

-(void)displayCFF{
    [self dismissViewControllerAnimated:TRUE completion:^{
    
    
        UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard CFF" bundle:nil];
        UIViewController *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"CustomerFactFindeApp"];
        //vc.modalTransitionStyle = UIModalPresentationPageSheet;//UIModalTransitionStyleFlipHorizontal;
        vc.modalTransitionStyle = UIModalPresentationFormSheet;
        [self presentViewController:vc animated:YES completion:NULL];
    
    
    }];
}

-(void)displayESignForms{
    //NSLog(@"cafasfsdfvad");
    
    [self dismissViewControllerAnimated:TRUE completion:^{
        [[obj.eAppData objectForKey:@"eSign"] setValue:@"1" forKey:@"COA"];
        
        UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
        eSignVC *esign = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"eSign"];
        esign.delegate = self;
        [self presentViewController:esign animated:YES completion:nil];
        
        
        
    
    }];
}

-(void)updateeSignCell{
    //NSLog(@"TTTT%@",[[obj.eAppData objectForKey:@"eSign"] objectForKey:@"COA"]);
    [self dismissViewControllerAnimated:TRUE completion:^{
        
        if ([[obj.eAppData objectForKey:@"eSign"] objectForKey:@"COA"] != Nil){
            NSString *aa;
            aa = [NSString stringWithFormat:@"Forms signed. You may proceed to e-Submission"];
            esignCell.descriptionLabel1.text = aa;
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [esignCell.statusLabel1 setImage:doneImage];
            //[[obj.eAppData objectForKey:@"Proposal"] setValue:@"Confirmed" forKey:@"Confirmation"];
        }
        

    }];
}

- (void)edit_eApp
{
    
    obj=[DataClass getInstance];
    
    NSString *SIVersion =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected_SIVersion"];
    NSString *SYS_SIVersion =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sys_SIVersion"];
    NSString *UL_Trad_SIVersion =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"UL_Trad_SIVersion"];
    NSString *sino = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    if (![database open]) {
        NSLog(@"Could not open db.");
    }
    
    [database open];
    
    
    
    
    if([UL_Trad_SIVersion isEqualToString:SYS_SIVersion])
    {
        if([UL_Trad_SIVersion isEqualToString:SIVersion])
        {
            //UPDATE THE CHECKLIST FOR ALL  - START
            NSString *aa;
            aa = [NSString stringWithFormat:@"Selected SI No: %@   Client Name: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
            siCell.descriptionLabel1.text = aa;
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [siCell.statusImage1 setImage:doneImage];
            
            
            
            
            //*************POLICY OWNER SECTION
            NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
            
            
            //  executeQuery
            NSString *name;
            NSString *potype;
            NSString *po_msg;
            NSString *selectPO = [NSString stringWithFormat:@"SELECT * FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo ];
            FMResultSet *results;
            results = [database executeQuery:selectPO];
            while ([results next]) {
                
                name = [results objectForColumnName:@"LAName"];
                potype = [results objectForColumnName:@"PTypeCode"];
                
            }
            
            
            //[database close];
            
            [[obj.eAppData objectForKey:@"SecPO"] setValue:name forKey:@"Confirm_POName"];
            
            if(name!= NULL || name!= nil)
            {
                if([potype isEqualToString:@"LA1"])
                    po_msg = @"1st Life Assured";
                else if([potype isEqualToString:@"LA2"])
                    po_msg = @"2nd Life Assured";
                else if([potype isEqualToString:@"PY1"])
                    po_msg = @"Payor";
                else if([potype isEqualToString:@"PO"])
                    po_msg = @"Policy Owner";
                
                aa = [NSString stringWithFormat:@"Policy Owner: %@   Type: %@",name,po_msg];
                
                
                poCell.descriptionLabel1.text = aa;
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [poCell.statusImage1 setImage:doneImage];
                
                
                
            }
            else
            {
             
                 
                aa = [NSString stringWithFormat:@"Determine Policy Owner or create new Policy Owner"];
                
                poCell.descriptionLabel1.text = aa;
                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                [poCell.statusImage1 setImage:doneImage];

            }
            
            
            //*************CFF  SECTION
            NSString *status;
            NSString *CFFName;
            NSString *dateModified;
            
            NSString *cffID;
            
            NSString *selectCFF = [NSString stringWithFormat:@"SELECT A.ID, A.Status, B.ProspectName, A.LastUpdatedAt FROM eProposal_CFF_Master AS A, prospect_profile AS B WHERE A.eProposalNo = '%@'  AND A.ClientProfileID = B.IndexNo",eProposalNo ];
            
            results = [database executeQuery:selectCFF];
            while ([results next]) {
                
                status = [results objectForColumnName:@"Status"];
                
                CFFName = [results objectForColumnName:@"ProspectName"];
                
                
                dateModified = [results objectForColumnName:@"LastUpdatedAt"];
                
                cffID = [results objectForColumnName:@"ID"];
                
            }
            
            
            if([status isEqualToString:@"1"])
            {
                
                NSString  *cff = [NSString stringWithFormat:@"Customer Fact Find: %@  Updated On:%@",  CFFName,dateModified ];
                cffCell.descriptionLabel1.text = cff;
                NSLog(@"CFF - %@", cff);
                doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [cffCell.statusLabel1 setImage:doneImage];
                
            }   
            
            if (![obj.eAppData objectForKey:@"CFF"]) {
                [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"CFF"];
            }
            [[obj.eAppData objectForKey:@"CFF"] setValue:cffID forKey:@"CustomerCFF"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:CFFName forKey:@"CFFName"];
             //UPDATE THE CHECKLIST FOR ALL  - END
        }
        else
        {
            NSString *update_SIVersion_eproposal = [NSString stringWithFormat:@"Update eProposal SET SIVersion = '%@' where SINo = '%@' ",UL_Trad_SIVersion, sino];
        
            [database executeUpdate:update_SIVersion_eproposal];
            
            NSLog(@"UPDATE update_SIVersion_eproposal - %@", update_SIVersion_eproposal);
            
             NSString *saved = [NSString stringWithFormat:@"Updated this SI Version from %@ to %@ successfully.",SIVersion,UL_Trad_SIVersion];
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"iMobile Planner"
                                  message:saved
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
            
            //UPDATE CHECKLIST FOR ALL - START
            NSString *aa;
            aa = [NSString stringWithFormat:@"Selected SI No: %@   Client Name: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
            siCell.descriptionLabel1.text = aa;
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [siCell.statusImage1 setImage:doneImage];
            
            
            
            
            //*************POLICY OWNER SECTION
            NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
            
            
            //  executeQuery
            NSString *name;
            NSString *potype;
            NSString *po_msg;
            NSString *selectPO = [NSString stringWithFormat:@"SELECT * FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo ];
            FMResultSet *results;
            results = [database executeQuery:selectPO];
            while ([results next]) {
                
                name = [results objectForColumnName:@"LAName"];
                potype = [results objectForColumnName:@"PTypeCode"];
                
            }
            
            
            //[database close];
            
            [[obj.eAppData objectForKey:@"SecPO"] setValue:name forKey:@"Confirm_POName"];
            
            if(name!= NULL || name!= nil)
            {
                if([potype isEqualToString:@"LA1"])
                    po_msg = @"1st Life Assured";
                else if([potype isEqualToString:@"LA2"])
                    po_msg = @"2nd Life Assured";
                else if([potype isEqualToString:@"PY1"])
                    po_msg = @"Payor";
                else if([potype isEqualToString:@"PO"])
                    po_msg = @"Policy Owner";
                
                aa = [NSString stringWithFormat:@"Policy Owner: %@   Type: %@",name,po_msg];
                
                
                
                poCell.descriptionLabel1.text = aa;
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [poCell.statusImage1 setImage:doneImage];
                
                
                
            }
            
            
            //*************CFF  SECTION
            NSString *status;
            NSString *CFFName;
            NSString *dateModified;
            
            NSString *cffID;
            
            NSString *selectCFF = [NSString stringWithFormat:@"SELECT A.ID, A.Status, B.ProspectName, A.LastUpdatedAt FROM eProposal_CFF_Master AS A, prospect_profile AS B WHERE A.eProposalNo = '%@'  AND A.ClientProfileID = B.IndexNo",eProposalNo ];
            
            results = [database executeQuery:selectCFF];
            while ([results next]) {
                
                status = [results objectForColumnName:@"Status"];
                
                CFFName = [results objectForColumnName:@"ProspectName"];
                
                
                dateModified = [results objectForColumnName:@"LastUpdatedAt"];
                
                cffID = [results objectForColumnName:@"ID"];
                
            }
            
            
            if([status isEqualToString:@"1"])
            {
                
                NSString  *cff = [NSString stringWithFormat:@"Customer Fact Find: %@  Updated On:%@",  CFFName,dateModified ];
                cffCell.descriptionLabel1.text = cff;
                NSLog(@"CFF - %@", cff);
                doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [cffCell.statusLabel1 setImage:doneImage];
                
            }
            
            if (![obj.eAppData objectForKey:@"CFF"]) {
                [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"CFF"];
            }
            [[obj.eAppData objectForKey:@"CFF"] setValue:cffID forKey:@"CustomerCFF"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:CFFName forKey:@"CFFName"];
            
            //UPDATE CHECKLIST FOR ALL - END


        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"iMobile Planner"
                              message: @"Please save again this SI for the latest SI version in SI module"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1003];
        [alert show];
        alert = Nil;
        
      NSString  *SIchecklist = [NSString stringWithFormat:@"Selected SI No: %@   Client Name: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
        siCell.descriptionLabel1.text = SIchecklist;


    }
    
        //************SI SECTION
 /*
        NSString *aa;
        aa = [NSString stringWithFormat:@"Selected SI No: %@   Client Name: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
        siCell.descriptionLabel1.text = aa;
        UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
        [siCell.statusImage1 setImage:doneImage];
        
        
        
        
        *************POLICY OWNER SECTION
        NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
        
        
        //  executeQuery
        NSString *name;
        NSString *potype;
        NSString *po_msg;
        NSString *selectPO = [NSString stringWithFormat:@"SELECT * FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo ];
        FMResultSet *results;
        results = [database executeQuery:selectPO];
        while ([results next]) {
            
             name = [results objectForColumnName:@"LAName"];
             potype = [results objectForColumnName:@"PTypeCode"];

        }
    
        
        //[database close];
        
         [[obj.eAppData objectForKey:@"SecPO"] setValue:name forKey:@"Confirm_POName"];
        
        if(name!= NULL || name!= nil)
        {
            if([potype isEqualToString:@"LA1"])
                po_msg = @"1st Life Assured";
            else if([potype isEqualToString:@"LA2"])
                po_msg = @"2nd Life Assured";
            else if([potype isEqualToString:@"PY1"])
                po_msg = @"Payor";
            else if([potype isEqualToString:@"PO"])
                po_msg = @"Policy Owner";
            
            aa = [NSString stringWithFormat:@"Policy Owner: %@   Type: %@",name,po_msg];
            
            poCell.descriptionLabel1.text = aa;
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [poCell.statusImage1 setImage:doneImage];

            

        }
        
        //NSLog(@"eApp check list SI - PPNO - %@ || name - %@ || ic -%@", eProposalNo, name,ptype);
        
       *************CFF  SECTION
        NSString *status;
        NSString *CFFName;
        NSString *dateModified;
        
        NSString *cffID;

        NSString *selectCFF = [NSString stringWithFormat:@"SELECT A.ID, A.Status, B.ProspectName, A.LastUpdatedAt FROM eProposal_CFF_Master AS A, prospect_profile AS B WHERE A.eProposalNo = '%@'  AND A.ClientProfileID = B.IndexNo",eProposalNo ];
       
        results = [database executeQuery:selectCFF];
        while ([results next]) {
            
            status = [results objectForColumnName:@"Status"];
                        
            CFFName = [results objectForColumnName:@"ProspectName"];
      
            
            dateModified = [results objectForColumnName:@"LastUpdatedAt"];
            
            cffID = [results objectForColumnName:@"ID"];
            
        }
        
      
        if([status isEqualToString:@"1"])
        {
            
            NSString  *cff = [NSString stringWithFormat:@"Customer Fact Find: %@  Updated On:%@",  CFFName,dateModified ];
            cffCell.descriptionLabel1.text = cff;
            NSLog(@"CFF - %@", cff);
            doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [cffCell.statusLabel1 setImage:doneImage];

        }   
        
        if (![obj.eAppData objectForKey:@"CFF"]) {
            [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"CFF"];
        }
        [[obj.eAppData objectForKey:@"CFF"] setValue:cffID forKey:@"CustomerCFF"];
        [[obj.eAppData objectForKey:@"EAPP"] setValue:CFFName forKey:@"CFFName"];
    */
        
        [database close];
      

}

- (void)viewDidAppear:(BOOL)animated
{
   
    obj=[DataClass getInstance];
    
    //Edit eApp SECTION
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected"] isEqualToString:@"YES" ])
    {
          [self edit_eApp];
    }
    
    else
    {
        
   //Create eApp section
  //POLICY OWNER 
    
    if ([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"POCompleted"] != Nil ){
        
         NSLog(@"eApp check list PO");
        
        
        NSString *aa;
      //  aa = [NSString stringWithFormat:@"Policy Owner: Santhiya Sree   Type:1st Life Assured"];
        
        NSString *potype = [[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"];
        NSString *po_msg;
        
        if([potype isEqualToString:@"LA1"])
            po_msg = @"1st Life Assured";
        else if([potype isEqualToString:@"LA2"])
            po_msg = @"2nd Life Assured";
        else if([potype isEqualToString:@"PY1"])
            po_msg = @"Payor";
        else if([potype isEqualToString:@"PO"])
            po_msg = @"Policy Owner";
            
        aa = [NSString stringWithFormat:@"Policy Owner: %@   Type: %@",[[obj.eAppData objectForKey:@"SecPO"]   objectForKey:@"Confirm_POName"],po_msg];
       
      
        //UPDATE eApp_Listing table - START
        
       NSString *name =   [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"];
       NSString *ic =   [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POIC"];
        NSString *proposalno =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        
        
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        if (![database open]) {
            NSLog(@"Could not open db.");
        }
        
        [database open];
        
      //  executeQuery
        
            NSString *update_eApp_Listing = [NSString stringWithFormat:@"Update eApp_Listing SET POName = '%@', IDNumber = '%@'  WHERE ProposalNo = '%@' ",name, ic,proposalno];
        
        
        
        [database executeUpdate:update_eApp_Listing];
        
        [database close];
        
        //UPDATE eApp_Listing table - END
        
        poCell.descriptionLabel1.text = aa;
        UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
        [poCell.statusImage1 setImage:doneImage];
    }
    
    if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
        if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
            NSLog(@"Hello updateCFF");
            NSString *aa;
            aa = [NSString stringWithFormat:@"Customer Fact Find: %@  Updated On:%@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFDate"]];
            cffCell.descriptionLabel1.text = aa;
            if ([[[obj.eAppData objectForKey:@"CFF"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [cffCell.statusLabel1 setImage:doneImage];
            }
            //NSLog(@)
        }
    }
    
    if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFSelected"] != Nil) {
        NSLog(@"CFF is selected");
    }

    
    if ([[obj.eAppData objectForKey:@"Proposal"] objectForKey:@"Confirmation"] != Nil){
        NSString *aa;
        aa = [NSString stringWithFormat:@"Proposal form confirmed"];
		
        eappCell.descriptionLabel1.text = aa;
        UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
        [eappCell.statusLabel1 setImage:doneImage];
        //NSLog(@)
    }
    
    
}



    
//[[obj.eAppData objectForKey:@"Proposal"] setValue:@"Confirmed" forKey:@"Confirmation"];
//NSLog()(@"%@",[[obj.eAppData objectForKey:@"PolicyOwner"] setValue:Nil forKey:@"PolicyOwner"]);
//NSLog(@"TTTT%@",[[obj.eAppData objectForKey:@"Proposal"] objectForKey:@"Complete"]);
}



- (void)viewDidUnload {
    //[self setSILabel:nil];
    //[self setSIDec:nil];
    //[self setSIStatus:nil];
    //[self setChecklistTable:nil];
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
- (IBAction)confirmBtnClicked:(id)sender {
}

- (IBAction)unconfirmBtnClicked:(id)sender {
}
@end
