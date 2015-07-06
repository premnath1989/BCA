//
//  Summary.m
//  iMobile Planner
//
//  Created by Erza on 6/18/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Summary.h"
#import "ColorHexCode.h"
#import "eAppMenu.h"
#import "DataClass.h"
#import "MasterMenuEApp.h"

@interface Summary (){
    DataClass *obj;
     PolicyDetails *_PolicyVC;
}

@end

@implementation Summary
@synthesize delegate = _delegate;

@synthesize tickCCOTPForm;
@synthesize tickECFFForm;
@synthesize tickEPP;
@synthesize TickGST;
@synthesize tableHeader;
@synthesize tableHeaderCheckMark;
- (void)viewDidLoad
{
    
       
    [super viewDidLoad];
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"e-Application";
    self.navigationItem.titleView = label;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(btnDone:)];
    
    obj=[DataClass getInstance];
    
 
    //Display the saved data
 	NSLog(@"summary a: %@", [[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"]);
//    if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"Y"])
//        _tickPersonalDetails.text = @"✓";
//    
//    if([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"])
//        _tickPolicyDetails.text = @"✓";
//    
//   // if([[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"])
//     //   _tickeCFF.text = @"✓";
//    
//    if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"SecD_Saved"] isEqualToString:@"Y"])
//        _tickNominees.text = @"✓";
//    
//    if([[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"])
//        _tickHealthQuestions.text = @"✓";
//    
//    if([[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"SecF_Saved"] isEqualToString:@"Y"])
//        _tickAdditionalQuestions.text = @"✓";
//    
//     if([[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"SecG_Saved"] isEqualToString:@"Y"])
//         _tickDeclaration.text = @"✓";
  
//    
    NSString *str= [[NSUserDefaults standardUserDefaults]objectForKey:@"tickmark"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if ([str isEqualToString:@"YES"])
    {
//        tickCCOTPForm.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
      //  tickCCOTPForm.text =  @"✓";
        
    }
    else
    {
        NSLog(@"the empty place ");
    }
    
    
    //changed by basvi from lno 89 to 116 for comapnycase dont need CA,CFF Forms
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    NSString *POOtherIDType;
    NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
    
    FMResultSet *results;
    results = [db executeQuery:selectPO];
    while ([results next]) {
        POOtherIDType = [results objectForColumnName:@"LAOtherIDType"];
    }
    
    if ([POOtherIDType isEqualToString:@"CR"])
    {
        NSLog(@"dont generate PDF in this case");
    }
    else
    {
 //       tickECFFForm.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
//        tickECFFForm.text =  @"✓";
  
    }
    //EPP
    if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"Yes"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"Y"]) {
        self.tickEPP.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
        self.tickEPP.text = @"✓";
	}
	else if ([[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"N"] || [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"EPP"] isEqualToString:@"No"]) {
		
	}
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];

 //    NSString *poname =   [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"];

  //  NSString *querySQL = [NSString stringWithFormat:@"select GST_exempted from prospect_profile where ProspectName = '%@'", poname];
    
    NSString *propectname = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectName"];
    NSString *querySQL = [NSString stringWithFormat:@"select GST_exempted from prospect_profile where ProspectName = '%@'", propectname];

    NSString *GSTExemptedTick = @"";
    
    FMResultSet *results1 =  [database executeQuery:querySQL];
    
    while ([results1 next])
    {
        
//        GSTExemptedTick = [results1 objectForColumnIndex:0];
        
        GSTExemptedTick =[results1 objectForColumnName:@"GST_exempted"];
        
        if((NSNull *)GSTExemptedTick ==[NSNull null])
        {
            GSTExemptedTick = @"";
        }
        
        if ([GSTExemptedTick isEqualToString:Nil]||(NSNull *)GSTExemptedTick ==[NSNull null])
        {
            GSTExemptedTick = @"";
        }
        
        if ([GSTExemptedTick isEqualToString:@"Y"])
        {
            self.TickGST.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
            self.TickGST.text = @"✓";
        }
        
    }

    tableHeaderCheckMark =[[UILabel alloc]initWithFrame:CGRectMake(225,15, 100, 40)];
    tableHeaderCheckMark.backgroundColor =[UIColor clearColor];
    tableHeaderCheckMark.font =[UIFont boldSystemFontOfSize:24];
    tableHeaderCheckMark.textColor =[UIColor darkGrayColor];
    tableHeaderCheckMark.text =@"✓";
    tableHeaderCheckMark.hidden =NO;
    [self.view addSubview:self.tableHeaderCheckMark];

    tableHeader =[[UILabel alloc]initWithFrame:CGRectMake(55,15, 800, 40)];
    tableHeader.backgroundColor =[UIColor clearColor];
    tableHeader.font =[UIFont boldSystemFontOfSize:17];
    tableHeader.textColor =[UIColor darkGrayColor];
    tableHeader.text =@"Section Summary          -  Completed     X - Incomplete     N / A - Not Applicable";
    tableHeader.hidden =NO;
    [self.view addSubview:self.tableHeader];

}
- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)btnDone:(id)sender
{
    UIStoryboard *nextStoryboard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:Nil];
    eAppMenu *main = [nextStoryboard instantiateViewControllerWithIdentifier:@"eAppMenuScreen"];
    main.getEAPP = @"YES";
    main.modalPresentationStyle = UIModalPresentationFullScreen;
    main.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentModalViewController:main animated:NO];
    
    nextStoryboard = nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"click sec:%d path:%d",indexPath.section, indexPath.row);
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            NSString *aa = @"1";
            [_delegate selectedMenu:aa];
            NSLog(@"go sub1");
        }
        if (indexPath.row == 1) {
            [_delegate selectedMenu:@"2"];
        }
        if (indexPath.row == 2) {
            [_delegate selectedMenu:@"3"];
        }
        if (indexPath.row == 4) {
            [_delegate selectedMenu:@"4"];
        }
        if (indexPath.row == 5) {
            [_delegate selectedMenu:@"5"];
        }
        if (indexPath.row == 6) {
            [_delegate selectedMenu:@"6"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
  

    [self setTickGST:nil];
    [super viewDidUnload];
}

- (IBAction)confirmBtn:(id)sender {
    
    /*
    [[obj.eAppData objectForKey:@"Proposal"] setValue:@"Confirmed" forKey:@"Confirmation"];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@" ",nil)
                          message: NSLocalizedString(@"No amendment is allowd after confirmation. Confirmation process will take a while. Do you want to continue?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    [alert setTag:1002];
    [alert show];
    alert = Nil;
     */
    

    
    if ([[obj.eAppData objectForKey:@"Proposal"] objectForKey:@"Complete"] != Nil){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: NSLocalizedString(@" ",nil)
                              message: NSLocalizedString(@"No amendment is allowd after confirmation. Confirmation process will take a while. Do you want to continue?",nil)
                              delegate: self
                              cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                              otherButtonTitles: NSLocalizedString(@"No",nil), nil];
        [alert setTag:1002];
        [alert show];
        alert = Nil;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message: @"Please complete all section before confirmation."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1003];
        [alert show];
        alert = Nil;
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1002 && buttonIndex == 0)
    {

        //[[obj.eAppData objectForKey:@"eSign"] setValue:@"Completed" forKey:@"Complete"];
        [[obj.eAppData objectForKey:@"Proposal"] setValue:@"Confirmed" forKey:@"Confirmation"];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message: @"Proposal Confirmed. Please proceed to eSignature."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1001];
        [alert show];
        alert = Nil;
        
        
    }
    
    else if (alertView.tag == 1002 && buttonIndex == 1)
    {
        
        //--edited by bob
        //clickIndex = _selectedIndex;
        //[self updateTabBar2];
    }
}

@end
