//
//  eAppCheckList.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/14/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eAppCheckList.h"
#include "test.h"
#import "SICell.h"
#import "PolicyOwnerCell.h"
#import "CFFCell.h"
#import "eAppCell.h"
#import "eSignCell.h"
#import "eSubCell.h"
#import "ReportCell.h"
#import "SupportingDocCell.h"
#import "eAppsListing.h"
#import "PolicyOwner.h"
#import "SelectCFF.h"
#import "eSignVC.h"
#import "COAPDF.h"
#import "MasterMenuEApp.h"
#import "DataClass.h"

#import "SIMenuViewController.h"
#import "eBrochureListingViewController.h"
#import "eAppReport.h"
#import "eConfirmationCell.h"
#import "EverSeriesMasterViewController.h"

#import "textFields.h"
#import "XMLDictionary.h"


@interface eAppCheckList (){
    NSMutableArray *items;
    NSString *CompanyCase;
    
    SICell *siCell;
    PolicyOwnerCell *poCell;
    CFFCell *cffCell;
    eAppCell *eappCell;
    eSignCell *esignCell;
    eSubCell *esubcell;
    ReportCell *reportCell;
    eConfirmationCell *confirmCell;
    SupportingDocCell *supportingcell;
    
    int updateSICell;
    int updateCFFCell;
    BOOL updateAllTaleCells;
    DataClass *obj;
    NSString *str_plan;
    NSString *name;
    
    int partyID;
    NSMutableArray *FundAllocation;
    BOOL alert_resave;
	BOOL PO_DONE; //ADD by EMI
    
    BOOL siCellCompletebool;
    BOOL poCellCompletebool;
    BOOL cffCellCompletebool;
    BOOL eappCellCompletebool;
    BOOL esubCellCompletebool;
    BOOL esignCellCompletebool;
    BOOL reportCellCompletebool;
    BOOL supportingCompletebool;
}

@end

@implementation eAppCheckList

@synthesize proposalNo_display,CaseTimelineLabel,POSignedLabel,DateSignedLabel,TimeRemaining,labelbg,underline,ImportantNotice,refreshDate;
@synthesize SavingValue,TickYES;

//@synthesize delegate;


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
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    items = [[NSMutableArray alloc] initWithObjects:@"Select SI", @"Select Policy Owner", @"Select eCFF",@"e-Application",@"e-Signature",nil];
    updateSICell = 0;
    updateCFFCell = 0;
    obj=[DataClass getInstance];
    
	eAppsListing *eAppList = [[eAppsListing alloc]init];
	str_plan = [eAppList GetPlanData:1 :[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
	
//	NSLog(@"strPlan: %@", str_plan);
    
    self.checklistTable.scrollEnabled = NO;
    
    appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(edit_eApp) name:@"edit_eApp" object:nil];
    
    //    [self storeXMLData_AssuredInfo];
    
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    
    [self StoreXMLdata_AgentProfile];
    NSString *displayThis = nil;
    displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    if (displayThis ==nil) {
        displayThis = @"";
    }
    
    
    /////////////////////////////////Timeline for Comfirm Button//////////////////////////////Basvi
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
	
    
    //	FMDatabase *db = [FMDatabase databaseWithPath:path];
    //	if (![db open]) {
    //        NSLog(@"Could not open db.");
    //        db = [FMDatabase databaseWithPath:path];
    //
    //        [db open];
    //    }
    //
    //    NSString *isPOSign;
    //    NSString *DatePOSign;
    //
    //	FMResultSet *result_eSign = [db executeQuery:@"SELECT * from eProposal_Signature WHERE eProposalNo = ? ",displayThis];
    //
    //	while ([result_eSign next])
    //    {
    //        //      NSString *isCustSign = [result_eSign stringForColumn:@"isCustSign"];
    //        //		NSString *DateCustSign = [result_eSign stringForColumn:@"DateCustSign"];
    //		isPOSign = [result_eSign stringForColumn:@"isPOSign"];
    //		DatePOSign = [result_eSign stringForColumn:@"DatePOSign"];
    //
    //
    //        if  ((NSNull *) isPOSign == [NSNull null]||[isPOSign isEqualToString:@""])
    //        {
    //			isPOSign =@"";
    //        }
    //
    //        if  ((NSNull *) DatePOSign == [NSNull null]||[DatePOSign isEqualToString:@""])
    //        {
    //			DatePOSign =@"";
    //        }
    //
    //
    //       // NSString *dateString1 = @"13/11/2014 12:37:31";
    //        NSString *dateString1 = DatePOSign;
    //
    //        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    //        // this is imporant - we set our input date format to match our input string
    //        // if format doesn't match you'll get nil from your string, so be careful
    //        [dateFormatter1 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    //        NSDate *dateFromString1 = [[NSDate alloc] init];
    //        // voila!
    //        dateFromString1 = [dateFormatter1 dateFromString:dateString1];
    //
    //
    //        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    //        [dateFormatter2 setDateFormat:@"dd/MM/YYYY ( HH:mm a)"];
    //        NSString *dateString2 = [dateFormatter2 stringFromDate:dateFromString1];
    //        NSLog(@"%@",dateString2);
    //
    //        NSDate *FinalDate = [dateFromString1 dateByAddingTimeInterval:-3600*16];
    //        NSLog(@"dttt %@",dateFromString1);
    //        NSLog(@"dyyy %@",FinalDate);
    //
    //        NSString *strNewDate;
    //        NSString *strCurrentDate;
    //        NSDateFormatter *df =[[NSDateFormatter alloc]init];
    //        [df setDateStyle:NSDateFormatterMediumStyle];
    //        [df setTimeStyle:NSDateFormatterMediumStyle];
    //        strCurrentDate = [df stringFromDate:FinalDate];
    //        NSLog(@"Current Date and Time: %@",strCurrentDate);
    //        int hoursToAdd = 136;
    //        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //        NSDateComponents *components = [[NSDateComponents alloc] init];
    //        [components setHour:hoursToAdd];
    //        NSDate *newDate= [calendar dateByAddingComponents:components toDate:FinalDate options:0];
    //        //    [df setDateStyle:NSDateFormatterMediumStyle];
    //        //    [df setTimeStyle:NSDateFormatterMediumStyle];
    //
    //        [df setDateFormat:@"dd/MM/YYYY ( HH:mm a )"];
    //        strNewDate = [df stringFromDate:newDate];
    //        NSLog(@"New Date and Time: %@",strNewDate);
    //
    //
    //       //for Time Remaining
    //        NSDate *mydate = [NSDate date];
    //        NSTimeInterval secondsInEightHours = 8 * 60 * 60;
    //        NSDate *currentDate = [mydate dateByAddingTimeInterval:secondsInEightHours];
    //        NSDate *expireDate = [newDate dateByAddingTimeInterval:secondsInEightHours];
    //
    //        int countdown = -[currentDate timeIntervalSinceDate:expireDate];//pay attention here.
    ////        int hh = (countdown/3600);
    ////        NSLog(@"%d",hh);
    ////        int mm = ((countdown-(hh*3600))/60);
    ////        int ss = countdown-(hh*3600+mm*60);
    ////        NSLog(@"%02d:%02d:%02d",hh,mm,ss);
    //
    //
    ////        NSTimeInterval timeElapsed = [[NSDate date] timeIntervalSinceDate:expireDate];
    ////        NSInteger ti = (NSInteger)timeElapsed;
    //
    ////        int seconds = countdown % 60;
    //        int minutes = (countdown / 60) % 60;
    //        int hours = (countdown / 3600) % 24;
    //        int days = (countdown / 86400) % 30;
    ////        int months = (countdown / 2592000) % 12;
    ////        int years = (countdown / 31104000);
    //
    ////        unsigned flags = NSDayCalendarUnit;
    ////        NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:currentDate toDate:expireDate options:0];
    ////
    ////        int dayDiff = [difference day];
    //
    //        UILabel  * labelbg = [[UILabel alloc] initWithFrame:CGRectMake(42, 560, 940, 140)];
    //        labelbg.backgroundColor = [UIColor grayColor];
    //        // label1.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
    //        labelbg.alpha =0.3;
    //        labelbg.numberOfLines=0;
    //        labelbg.lineBreakMode=UILineBreakModeWordWrap;
    //        [self.view addSubview:labelbg];
    //
    //        UILabel *underline =[[UILabel alloc]initWithFrame:CGRectMake(60, 588 , 160, 1)];
    //        underline.backgroundColor =[UIColor blackColor];
    //        underline.font =[UIFont boldSystemFontOfSize:13];
    //        underline.text =@"";
    //        underline.textColor =[UIColor blackColor];
    //        [self.view addSubview:underline];
    //
    //
    //        UILabel *ImportantNotice =[[UILabel alloc]initWithFrame:CGRectMake(60, 570 , 200, 20)];
    //        ImportantNotice.backgroundColor =[UIColor clearColor];
    //        ImportantNotice.font =[UIFont boldSystemFontOfSize:15];
    //        ImportantNotice.text =@"Important Information";
    //        ImportantNotice.textColor =[UIColor blackColor];
    //        [self.view addSubview:ImportantNotice];
    //
    //
    //        POSignedLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 590 , 400, 20)];
    //        POSignedLabel.backgroundColor =[UIColor clearColor];
    //        POSignedLabel.font =[UIFont systemFontOfSize:13];
    //        if([isPOSign isEqualToString:@"YES"])
    //        {
    //            POSignedLabel.text =[NSString stringWithFormat:@"Policy Owner signature                          : Captured"];
    //        }
    //        else
    //        {
    //            POSignedLabel.text =[NSString stringWithFormat:@"Policy Owner signature                          : "];
    //        }
    //
    //        POSignedLabel.textColor =[UIColor blackColor];
    //        [self.view addSubview:POSignedLabel];
    //
    //        DateSignedLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 610 , 400, 20)];
    //        DateSignedLabel.backgroundColor =[UIColor clearColor];
    //        DateSignedLabel.font =[UIFont systemFontOfSize:13];
    //        DateSignedLabel.text =[NSString stringWithFormat:@"Policy Owner signature date & time       : %@",dateString2];
    //        DateSignedLabel.textColor =[UIColor blackColor];
    //        [self.view addSubview:DateSignedLabel];
    //
    //        CaseTimelineLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 630 , 400, 20)];
    //        CaseTimelineLabel.backgroundColor =[UIColor clearColor];
    //        CaseTimelineLabel.font =[UIFont systemFontOfSize:13];
    //        CaseTimelineLabel.text =[NSString stringWithFormat:@"Proposal/Quotation Expiry date & time  : %@",strNewDate];//@"This Case Valid for :";
    //        CaseTimelineLabel.textColor =[UIColor blackColor];
    //        [self.view addSubview:CaseTimelineLabel];
    //
    //        NSDate *currDate = [NSDate date];
    //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //        [dateFormatter setDateFormat:@"dd/MM/YYYY ( HH:mm a)"];
    //        NSString *dateString = [dateFormatter stringFromDate:currDate];
    //        NSLog(@"%@",dateString);
    //
    //        UILabel *refreshDate =[[UILabel alloc]initWithFrame:CGRectMake(60, 650 , 400, 20)];
    //        refreshDate.backgroundColor =[UIColor clearColor];
    //        refreshDate.font =[UIFont systemFontOfSize:13];
    //        refreshDate.text =[NSString stringWithFormat:@"Last Update/viewing date & time           : %@",dateString];
    //        refreshDate.textColor =[UIColor blackColor];
    //        [self.view addSubview:refreshDate];
    //
    //        TimeRemaining =[[UILabel alloc]initWithFrame:CGRectMake(60, 670 , 510, 20)];
    //        TimeRemaining.backgroundColor =[UIColor clearColor];
    //        TimeRemaining.font =[UIFont systemFontOfSize:13];
    //       // TimeRemaining.text =[NSString stringWithFormat:@"Time Remaining : %d Days",dayDiff];
    //
    //        //compare two dates
    //        NSComparisonResult result;
    //        //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    //
    //        result = [currentDate compare:expireDate]; // comparing two dates
    //
    //        if(result==NSOrderedAscending)
    //        {
    //            NSLog(@"today is less");
    //            TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : %d days %d hours %d mins ",days,hours,minutes];
    //            TimeRemaining.textColor =[UIColor blackColor];
    //        }
    //        else if(result==NSOrderedDescending)
    //        {
    //
    //            NSLog(@"newDate is less");
    //            TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : Expired                                       "];
    //            TimeRemaining.textColor =[UIColor redColor];
    //        }
    //        else
    //        {
    //            NSLog(@"Both dates are same");
    //            TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : %d hours %d mins ",hours,minutes];
    //            TimeRemaining.textColor =[UIColor redColor];
    //            NSLog(@"Both dates are same");
    //        }
    //
    //
    ////        if(days <=0)
    ////        {
    ////            self.TimeRemaining.alpha = 0;
    ////            [UIView animateWithDuration:1.5 delay:0.5 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
    ////                self.TimeRemaining.alpha = 1;
    ////            } completion:nil];
    ////
    ////            TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : %d hours %d mins ",hours,minutes];
    ////            TimeRemaining.textColor =[UIColor redColor];
    ////
    ////        }
    ////        else
    ////        {
    //////            self.TimeRemaining.alpha = 0;
    //////            [UIView animateWithDuration:1.0 delay:0.1 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
    //////                self.TimeRemaining.alpha = 1;
    //////            } completion:nil];
    ////
    ////
    ////            TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : %d days %d hours %d mins ",days,hours,minutes];
    ////             TimeRemaining.textColor =[UIColor blackColor];
    ////
    ////        }
    //
    //
    //        [self.view addSubview:TimeRemaining];
    //
    //
    //    }
    //
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    [self RefreshInformationData];
    
    proposalNo_display =[[UILabel alloc]initWithFrame:CGRectMake(700,70, 930, 20)];
    proposalNo_display.backgroundColor =[UIColor clearColor];
    proposalNo_display.font =[UIFont systemFontOfSize:15];
    proposalNo_display.textColor =[UIColor darkGrayColor];
    proposalNo_display.text =[NSString stringWithFormat:@"Proposal Number: %@",displayThis];
    proposalNo_display.hidden =NO;
    [self.view addSubview:self.proposalNo_display];
    alert_resave = FALSE;
    [super viewWillAppear:animated];
    obj = [DataClass getInstance];
	
	eAppsListing *getPlan = [[eAppsListing alloc]init];
	str_plan = [getPlan GetPlanData:1 :[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
    
    
    
    if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected"] != Nil){
        NSString *aa;
        aa = [NSString stringWithFormat:@"SI No: %@   Life Assured: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"], str_plan];
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] isEqualToString:@"(null)"] || ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] == NULL)) {
			siCell.descriptionLabel1.text =@"";// @"Select Sales Illsutration from Listing and check Sales Illustration version";
		}
		else {
			siCell.descriptionLabel1.text = aa;
		}
        
        
        NSString *SIVersion =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected_SIVersion"];
        
        
        
        NSDictionary *clientDetails = [[NSDictionary alloc] init];
        
        
        //KY GET THE LATEST SYS VERSION NO
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        NSString *querySQL = [NSString stringWithFormat:@"select SIVersion, MAX(SILastUpdated) from  Trad_Sys_SI_Version_Details" ];
        FMResultSet *results =  [database executeQuery:querySQL];
        
        NSString *result_sysVersion=@"";
        while ([results next]) {
            
            result_sysVersion = [results objectForColumnIndex:0];
            
            
        }
        
        
        [[obj.eAppData objectForKey:@"EAPP"]  setValue:result_sysVersion forKey:@"Sys_SIVersion"];
        
        
        //GET eProposal SI Version
        
        results =  [database executeQuery:@"SELECT SIVersion from eProposal where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]];
        
        
        while ([results next]) {
            
            SIVersion = [results objectForColumnIndex:0];
            
            
        }
        
        
        
        
        if([result_sysVersion isEqualToString:SIVersion])
        {
            
            NSString *SIclientName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"];
            NSString *SIclientSmoker = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientSmoker"];
            NSString *SIclientMarital = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientMarital"];
            NSString *SIclientOccup = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientOccup"];
            
            
            NSString *ProspectName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectName"];
            NSString *ProspectSmoker = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectSmoker"];
            NSString *ProspectMarital = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectMarital"];
            NSString *ProspectOccup = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectOccup"];
            
            if([ProspectMarital isEqualToString:@"SINGLE"])
                ProspectMarital = @"S";
            else if([ProspectMarital isEqualToString:@"MARRIED"])
                ProspectMarital = @"M";
            else if([ProspectMarital isEqualToString:@"DIVORCED"])
                ProspectMarital = @"D";
            else
                ProspectMarital = @"W";
            
            
            if(SIclientName==NULL)
                SIclientName = @"";
            
            if(ProspectName==NULL)
                ProspectName = @"";
            
            
            // NSLog(@"ENS3: SIclientName: %@, ProspectName: %@ SINAME: %@", SIclientName, ProspectName, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"]);
            if(![SIclientName isEqualToString:@""] || ![ProspectName isEqualToString:@""])
                
            {
                
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [siCell.statusImage1 setImage:doneImage];
                
                siCellCompletebool=NO;
            }
            
            //WAITING FOR HENG TO SYNC THE MARITAL STATUS IN SI
            // else if([SIclientName isEqualToString:ProspectName] && ([SIclientSmoker isEqualToString:ProspectSmoker]) && ([SIclientMarital isEqualToString:ProspectMarital]) && ([SIclientOccup isEqualToString:ProspectOccup]))
            else if([SIclientName isEqualToString:ProspectName] && ([SIclientSmoker isEqualToString:ProspectSmoker]) && ([SIclientOccup isEqualToString:ProspectOccup]))
            {
                
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [siCell.statusImage1 setImage:doneImage];
                siCellCompletebool=YES;
                
            }
			else if (![[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"] isEqualToString:@""]){
				UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [siCell.statusImage1 setImage:doneImage];
                siCellCompletebool=YES;
			}
            else
            {
				
				alert_resave = TRUE;
				
				//test only..
				//UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                //[siCell.statusImage1 setImage:doneImage];
            }
            
            
            
        }
        
        
        //preparation of data during edit
        
        FMResultSet *results2;
        
        results2= [database executeQuery:@"SELECT * FROM eProposal AS A WHERE eProposalNo =?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
        
        while([results2 next])
        {
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] forKey:@"eProposalNo"];
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:[results2 stringForColumn:@"SINo"] forKey:@"SINo"];
            
            
        }
        
        
        [results2 close];
        [database close];
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:clientDetails forKey:@"SIDetails"];
        
        //        if([[NSUserDefaults standardUserDefaults] valueForKey:@"data"]==nil)
        //        {
        //            [self deletePDFs];
        //        }
        
        
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
    //if (updateAllTaleCells)
	return 8;//[self.players count];
    //    else
    //        return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SICellIdentifier = @"SICell";
    static NSString *PolicyOwnerCellIdentifier = @"PolicyOwnerCell";
    static NSString *CFFCellIdentifier = @"CFFCell";
    static NSString *eAppCellIdentifier = @"eAppCell";
    static NSString *ReportCellIdentifier = @"ReportCell";
    static NSString *eSignCellIdentifier = @"eSignCell";
    //static NSString *eSubCellIdentifier = @"eSubCell";
    static NSString *eConfirmationCell = @"eConfirmCell";
    static NSString *esupporting = @"SupportingDocCell";
    UITableViewCell *cell;
    
    NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
    // [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"]
	NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath1 = [paths1 objectAtIndex:0];
	NSString *path1 = [docsPath1 stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db1 = [FMDatabase databaseWithPath:path1];
	[db1 open];
	
    NSString *eProposalNo1 = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    NSString *selectPO1 = [NSString stringWithFormat:@"SELECT isPOSign FROM eProposal_Signature WHERE eProposalNo = '%@'",eProposalNo1];
	NSString *POOtherIDType1;
    //	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
	
	FMResultSet *results1;
	results1 = [db1 executeQuery:selectPO1];
	while ([results1 next])
    {
		POOtherIDType1 = [results1 objectForColumnName:@"isPOSign"];
        if  ((NSNull *) POOtherIDType1 == [NSNull null])
			POOtherIDType1 = @"";
        if ([POOtherIDType1 isEqualToString:@"YES"])
            if ([POOtherIDType1 isEqualToString:@"YES"])
            {
                siCell.textLabel.textColor = [UIColor grayColor];
                siCell.userInteractionEnabled = NO;
                siCell.titleLabel1.textColor = [UIColor grayColor];
                
                poCell.textLabel.textColor = [UIColor grayColor];
                poCell.userInteractionEnabled = NO;
                poCell.titleLabel1.textColor = [UIColor grayColor];
                
                cffCell.textLabel.textColor = [UIColor grayColor];
                cffCell.userInteractionEnabled = NO;
                cffCell.titleLabel1.textColor = [UIColor grayColor];
                
                eappCell.textLabel.textColor = [UIColor grayColor];
                eappCell.userInteractionEnabled = NO;
                eappCell.titleLabel1.textColor = [UIColor grayColor];
                
            }
        
            else
            {
                siCell.textLabel.textColor = [UIColor blackColor];
                siCell.userInteractionEnabled = YES;
                siCell.titleLabel1.textColor = [UIColor blackColor];
                
                poCell.textLabel.textColor = [UIColor blackColor];
                poCell.userInteractionEnabled = YES;
                poCell.titleLabel1.textColor = [UIColor blackColor];
                
                cffCell.textLabel.textColor = [UIColor blackColor];
                cffCell.userInteractionEnabled = YES;
                cffCell.titleLabel1.textColor = [UIColor blackColor];
                
                eappCell.textLabel.textColor = [UIColor blackColor];
                eappCell.userInteractionEnabled = YES;
                eappCell.titleLabel1.textColor = [UIColor blackColor];
                
            }
        
	}
    
    
    
    
    
    
    
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
        reportCell = [tableView dequeueReusableCellWithIdentifier:ReportCellIdentifier];
        //cell = [tableView dequeueReusableCellWithIdentifier:eSignCellIdentifier forIndexPath:indexPath];
        return reportCell;
    }
    else if (indexPath.row == 6){
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
        supportingcell = [tableView dequeueReusableCellWithIdentifier:esupporting];
        return supportingcell;
        
    }
    else if (indexPath.row == 7) {
        
        confirmCell = [tableView dequeueReusableCellWithIdentifier:eConfirmationCell];
        //        if (updateAllTaleCells) {
        //            confirmCell.confirmBtn.enabled=YES;
        //            confirmCell.confirmBtn.backgroundColor=[UIColor greenColor];
        //        }
        //        else{
        //            confirmCell.confirmBtn.enabled=NO;
        //            confirmCell.confirmBtn.backgroundColor=[UIColor grayColor];
        //        }
        
        
        if (updateAllTaleCells) {
            confirmCell.confirmBtn.enabled=YES;
            UIImage *buttonImage = [UIImage imageNamed:@"greenBtn.png"];
            [ confirmCell.confirmBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
            //confirmCell.confirmBtn.titleLabel.textColor=[UIColor blueColor];
            [confirmCell.confirmBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            //[UIColor colorWithRed:68/255.0f green:142/255.0f blue:211/255.0f alpha:1.0f]
        }
        else{
            confirmCell.confirmBtn.enabled=NO;
            UIImage *buttonImage = [UIImage imageNamed:@"button_hover.png"];
            [ confirmCell.confirmBtn setBackgroundImage:buttonImage forState:UIControlStateNormal];
            confirmCell.confirmBtn.titleLabel.textColor=[UIColor grayColor];
            [confirmCell.confirmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
        }
        
        return confirmCell;
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
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
    // [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"]
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
		//cffCell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
		cffCell.textLabel.textColor = [UIColor grayColor];
		cffCell.userInteractionEnabled = NO;
		cffCell.titleLabel1.textColor = [UIColor grayColor];
		cffCell.descriptionLabel1.text = @"";
        CompanyCase = @"Yes";
        
        
	}
    
    
    //    if([self checkrefresheSigndata])
    //    {
    //
    //        //cffCell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    //		cffCell.textLabel.textColor = [UIColor grayColor];
    //		cffCell.userInteractionEnabled = NO;
    //		cffCell.titleLabel1.textColor = [UIColor grayColor];
    //
    //    }
    
    
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
                main.EAPPorSI = @"eAPP";
                [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
                main.modalTransitionStyle = UIModalPresentationFormSheet;
                [self presentViewController:main animated:YES completion:nil];
                
            }
        }
        else{
            //AFTER SI SELECTED, CLICK AGAIN WILL SHOW SI DETAILS
            obj = [DataClass getInstance];
            NSString *plan = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
            
//			eAppsListing *eAppList = [[eAppsListing alloc]init];
//			NSString *SIType = [eAppList GetPlanData:3 :plan];
			NSString *SIType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
			
            if([SIType isEqualToString:@"TRAD"])
            {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
                SIMenuViewController *main = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIPageView"];
                
                main.requestSINo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
                main.EAPPorSI = @"eAPP";
                [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
                
                main.modalTransitionStyle = UIModalPresentationFormSheet;
                [self presentViewController:main animated:YES completion:nil];
                
                
                
                mainStoryboard = Nil, main = Nil;
            }
            else if([SIType isEqualToString:@"ES"])
            {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
                EverSeriesMasterViewController *main = [mainStoryboard instantiateViewControllerWithIdentifier:@"EverSeriesMaster"];
                
                main.requestSINo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
                
                main.EAPPorSI = @"eAPP";
                [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
                
                
                
                main.modalTransitionStyle = UIModalPresentationFormSheet;
                [self presentViewController:main animated:YES completion:nil];
                
                mainStoryboard = Nil, main = Nil;
                
            }
            
        }
    }
    else if (indexPath.row == 1) {
        if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] != Nil){
            
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
            PolicyOwner *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PolicyOwner"];
            //vc.delegate = self;
            vc.modalTransitionStyle = UIModalPresentationFormSheet;
            [self presentViewController:vc animated:YES completion:^{
            }];
        }
        else{
            
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please select Sales Illustration in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
            
        }
        
    }
    
    else if (indexPath.row == 2) {
        //  NSLog(@"name -%@ Confirm_PONAME: %@", name, [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"]);
        
        //if ([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"] != Nil || ![name isEqualToString:@""]){
		[self CheckPO];
		if (PO_DONE){
            if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] == Nil){
                
                UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
                SelectCFF *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectCFFeApp"];
                vc.delegate = self;
                vc.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:vc animated:YES completion:^{
                }];
            }
            else{
                UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
                MasterMenuCFF *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"CustomerFactFind"];
                vc.modalTransitionStyle = UIModalPresentationFormSheet;
                vc.eApp = true;
                vc.fLoad = @"1";
                vc.name = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFName"];
                [self presentViewController:vc animated:YES completion:NULL];
            }
        }
        else{
            
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please determine Policy Owner/Life Assured in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
            
            
        }
    }
    
    else if (indexPath.row == 3) {
		if ([POOtherIDType isEqualToString:@"CR"]) {
			UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
			UIViewController *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"eAppMaster"];
			vc.modalTransitionStyle = UIModalPresentationFormSheet;
			[self presentViewController:vc animated:YES completion:NULL];
		}
		else {
			if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
				
				UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
				UIViewController *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"eAppMaster"];
				vc.modalTransitionStyle = UIModalPresentationFormSheet;
				[self presentViewController:vc animated:YES completion:NULL];
				
			}
			else
			{
				UIAlertView *alert = [[UIAlertView alloc]
									  initWithTitle: @" "
									  message: @"Please select Customer Fact Find in order to proceed."
									  delegate: self
									  cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
				[alert setTag:1003];
				[alert show];
				alert = Nil;
				
			}
		}
    }
    
    else if (indexPath.row == 4) {
        if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] != Nil || [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] isEqualToString:@"Y"]){
            
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
            
            eAppReport *report =  [main instantiateViewControllerWithIdentifier:@"eAppReport"];
            
            report.modalPresentationStyle = UIModalPresentationFullScreen;
            report.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:report animated:YES completion:NULL];
            report = Nil;
            
            
            
            //START.......STORE XML DATA - SIDETAILS
            
            [self storeXMLData_eApps];
            
            
            //END.........STORE XML DATA - SIDETAILS
            
            
        }
        
        else
        {
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please complete the Proposal details in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
        }
        
        
    }
    else if (indexPath.row == 7) {
        
        if ([array containsObject:proposalform12] && reportCellCompletebool)
        {
            
			//            HUD = [[MBProgressHUD alloc] initWithView:self.view];
			//            [self.view addSubview:HUD];
			//            HUD.labelText = @"Please Wait";
			//            [HUD show:YES];
			//            [HUD showWhileExecuting:@selector(refreshPDFData) onTarget:self withObject:nil animated:YES];
			//
            
			//            HUD = [[MBProgressHUD alloc] initWithView:self.view];
			//            [self.view addSubview:HUD];
			//            HUD.labelText = @"Please Wait";
			//            [HUD show:YES];
			//            [HUD showWhileExecuting:@selector(refreshPDFData) onTarget:self withObject:nil animated:YES];
			//            [HUD hide:YES afterDelay:10];
			//            HUD.removeFromSuperViewOnHide=YES;
			//            HUD = nil;
            
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.labelText = @"Please Wait";
            [HUD show:YES];
            [self performSelector:@selector(EsignrefreshPDFData) withObject:nil afterDelay:1];
            
            
			
			//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			//
			//        NSString *documentsDirectory = [paths objectAtIndex:0];
			//
			//        NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
			//
			//        // NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"xml"];
			//
			//        NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
			//
			//        NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];
			//
			//
			//
			//        _signController = [[eSignController alloc]init];
			//        _signController.delegate=self;
			//
			//        [_signController eApplicationForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
			//
			//        [self.view addSubview:_signController.view];
			
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please generate and verify the forms in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
        }
        
    }
    
    else if (indexPath.row == 6) {
        
        if ([array containsObject:proposalform12] && reportCellCompletebool) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            // NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"xml"];
            
            NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
            
            NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];
            _cardSnap = [[CardSnap alloc]init];
            _cardSnap.delegate=self;
            [_cardSnap supportDocForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
            
            [self.view addSubview:_cardSnap.view];
            
            //[self presentViewController:_cardSnap animated:YES completion:NULL];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please generate and verify the forms in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
        }
        
    }
	
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
    // NSString *formsGenerate=[[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
    // [[NSUserDefaults standardUserDefaults]synchronize];
    // [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"]
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
	
	if ([POOtherIDType isEqualToString:@"CR"]) {
		//cffCell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
		cffCell.textLabel.textColor = [UIColor grayColor];
		cffCell.userInteractionEnabled = NO;
		cffCell.titleLabel1.textColor = [UIColor grayColor];
		cffCell.descriptionLabel1.text = @"";
        UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
        [cffCell.statusLabel1 setImage:doneImage];
	}
    
    //    if([self checkrefresheSigndata])
    //    {
    //
    //        //cffCell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    //		cffCell.textLabel.textColor = [UIColor grayColor];
    //		cffCell.userInteractionEnabled = NO;
    //		cffCell.titleLabel1.textColor = [UIColor grayColor];
    //
    //    }
    
    
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
                main.EAPPorSI = @"eAPP";
                [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
                main.modalTransitionStyle = UIModalPresentationFormSheet;
                [self presentViewController:main animated:YES completion:nil];
                
            }
        }
        else{
            //AFTER SI SELECTED, CLICK AGAIN WILL SHOW SI DETAILS
            obj = [DataClass getInstance];
            NSString *plan = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
            
//			eAppsListing *eAppList = [[eAppsListing alloc]init];
//			NSString *SIType = [eAppList GetPlanData:3 :plan];
			NSString *SIType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
			
            if([SIType isEqualToString:@"TRAD"])
            {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
                SIMenuViewController *main = [mainStoryboard instantiateViewControllerWithIdentifier:@"SIPageView"];
                
                main.requestSINo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
                main.EAPPorSI = @"eAPP";
                [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
                
                main.modalTransitionStyle = UIModalPresentationFormSheet;
                [self presentViewController:main animated:YES completion:nil];
                
                
                
                mainStoryboard = Nil, main = Nil;
            }
            else if([SIType isEqualToString:@"ES"])
            {
                
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:Nil];
                EverSeriesMasterViewController *main = [mainStoryboard instantiateViewControllerWithIdentifier:@"EverSeriesMaster"];
                
                main.requestSINo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
                
                main.EAPPorSI = @"eAPP";
                [[obj.eAppData objectForKey:@"SI"] setValue:main.requestSINo forKey:@"SINumber"];
                
                
                
                main.modalTransitionStyle = UIModalPresentationFormSheet;
                [self presentViewController:main animated:YES completion:nil];
                
                mainStoryboard = Nil, main = Nil;
                
            }
            
        }
    }
    else if (indexPath.row == 1) {
        if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] != Nil){
            
            UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
            PolicyOwner *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PolicyOwner"];
            //vc.delegate = self;
            vc.modalTransitionStyle = UIModalPresentationFormSheet;
            [self presentViewController:vc animated:YES completion:^{
            }];
        }
        else{
            
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please select Sales Illustration in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
            
        }
        
    }
    
    else if (indexPath.row == 2) {
        //NSLog(@"name -%@ Confirm_PONAME: %@", name, [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"]);
        
        //if ([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"] != Nil || ![name isEqualToString:@""]){
		[self CheckPO];
		if (PO_DONE){
            if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] == Nil){
                
                UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
                SelectCFF *vc = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SelectCFFeApp"];
                vc.delegate = self;
                vc.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:vc animated:YES completion:^{
                }];
            }
            else{
                UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
                MasterMenuCFF *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"CustomerFactFind"];
                vc.modalTransitionStyle = UIModalPresentationFormSheet;
                vc.eApp = true;
                vc.fLoad = @"1";
                vc.name = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFName"];
                [self presentViewController:vc animated:YES completion:NULL];
            }
        }
        else{
            
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please determine Policy Owner/Life Assured in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
            
            
        }
    }
    
    else if (indexPath.row == 3) {
		if ([POOtherIDType isEqualToString:@"CR"]) {
			UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
			UIViewController *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"eAppMaster"];
			vc.modalTransitionStyle = UIModalPresentationFormSheet;
			[self presentViewController:vc animated:YES completion:NULL];
		}
		else {
			if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
				
				UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
				UIViewController *vc = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"eAppMaster"];
				vc.modalTransitionStyle = UIModalPresentationFormSheet;
				[self presentViewController:vc animated:YES completion:NULL];
				
			}
			else
			{
				UIAlertView *alert = [[UIAlertView alloc]
									  initWithTitle: @" "
									  message: @"Please select Customer Fact Find in order to proceed."
									  delegate: self
									  cancelButtonTitle:@"OK"
									  otherButtonTitles:nil];
				[alert setTag:1003];
				[alert show];
				alert = Nil;
				
			}
		}
    }
    
    else if (indexPath.row == 4) {
        
		
		UIStoryboard *main = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
		appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
		appobject.ViewFromPendingBool=NO;
		appobject.ViewFromSubmissionBool =NO;
		//	appobject.ViewDeleteSubmissionBool=NO;
		appobject.ViewFromEappBool =YES;
		eAppReport *report =  [main instantiateViewControllerWithIdentifier:@"eAppReport"];
		
        AppDelegate *appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        appobj.AUBackButtonHandling=NO;
        if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] != Nil && [[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] isEqualToString:@"Y"])
            
        {
            
            NSString *displayThis = nil;
            displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            if (displayThis ==nil) {
                displayThis = @"";
            }
            [self viewDidAppear:YES];
            
            
            NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
            // [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"]
            NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath1 = [paths1 objectAtIndex:0];
            NSString *path1 = [docsPath1 stringByAppendingPathComponent:@"hladb.sqlite"];
            
            FMDatabase *db1 = [FMDatabase databaseWithPath:path1];
            [db1 open];
            
            NSString *eProposalNo1 = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
            NSString *selectPO1 = [NSString stringWithFormat:@"SELECT isPOSign FROM eProposal_Signature WHERE eProposalNo = '%@'",eProposalNo1];
            NSString *POOtherIDType1;
            //	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
            
            FMResultSet *results1;
            results1 = [db1 executeQuery:selectPO1];
            while ([results1 next])
            {
                POOtherIDType1 = [results1 objectForColumnName:@"isPOSign"];
                if  ((NSNull *) POOtherIDType1 == [NSNull null])
					POOtherIDType1 = @"";
				
                if ([POOtherIDType1 isEqualToString:@"YES"])
                {
                    UIStoryboard *main = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
 //                   AppDelegate*  appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
 //                   appobject.ViewFromPendingBool=YES;
 //                   appobject.ViewDeleteSubmissionBool=YES;
                    eAppReport *report =  [main instantiateViewControllerWithIdentifier:@"eAppReport"];
                    
                    report.modalPresentationStyle = UIModalPresentationFullScreen;
                    report.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:report animated:YES completion:NULL];
                    report = Nil;
                    
                    
                }
                
                else
                {
                    UIStoryboard *main = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
                    
                    eAppReport *report =  [main instantiateViewControllerWithIdentifier:@"eAppReport"];
                    
                    report.modalPresentationStyle = UIModalPresentationFullScreen;
                    report.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    [self presentViewController:report animated:YES completion:NULL];
                    report = Nil;
                    
                    
                }
                
            }
            
            UIStoryboard *main = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:nil];
            
            eAppReport *report =  [main instantiateViewControllerWithIdentifier:@"eAppReport"];
            
            report.modalPresentationStyle = UIModalPresentationFullScreen;
            report.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:report animated:YES completion:NULL];
            report = Nil;
            
            
            //START.......STORE XML DATA - SIDETAILS
            
            [self storeXMLData_eApps];
            
            
            //END.........STORE XML DATA - SIDETAILS
            
            
        }
        
        else
        {
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please complete the Proposal details in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
        }
        
        
    }
    else if (indexPath.row == 6) {
        
        
        AppDelegate *appobj=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        appobj.AUBackButtonHandling=YES;
        if ([array containsObject:proposalform12] && reportCellCompletebool)
        {
            
            //            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            //            [self.view addSubview:HUD];
            //            HUD.labelText = @"Please Wait";
            //            [HUD show:YES];
            //            [HUD showWhileExecuting:@selector(refreshPDFData) onTarget:self withObject:nil animated:YES];
            //
            
            //            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            //            [self.view addSubview:HUD];
            //            HUD.labelText = @"Please Wait";
            //            [HUD show:YES];
            //            [HUD showWhileExecuting:@selector(refreshPDFData) onTarget:self withObject:nil animated:YES];
            //            [HUD hide:YES afterDelay:10];
            //            HUD.removeFromSuperViewOnHide=YES;
            //            HUD = nil;
            
            
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.labelText = @"Please Wait";
            [HUD show:YES];
            [self performSelector:@selector(EsignrefreshPDFData) withObject:nil afterDelay:1];
            
            
            
            
            
            //        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            //
            //        NSString *documentsDirectory = [paths objectAtIndex:0];
            //
            //        NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            //
            //        // NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"xml"];
            //
            //        NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
            //
            //        NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];
            //
            //
            //
            //        _signController = [[eSignController alloc]init];
            //        _signController.delegate=self;
            //
            //        [_signController eApplicationForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
            //
            //        [self.view addSubview:_signController.view];
            
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please generate and verify the forms in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
            
        }
        
        
    }
    
    else if (indexPath.row == 5) {
        
        
        if ([array containsObject:proposalform12] && reportCellCompletebool) {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
            
            // NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"xml"];
            
            NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
            
            NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];
            _cardSnap = [[CardSnap alloc]init];
            _cardSnap.delegate=self;
            [_cardSnap supportDocForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
            
            [self.view addSubview:_cardSnap.view];
            
            //[self presentViewController:_cardSnap animated:YES completion:NULL];
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @" "
                                  message: @"Please generate and verify the forms in order to proceed."
                                  delegate: self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert setTag:1003];
            [alert show];
            alert = Nil;
        }
        
    }
    
}


-(void)EsignrefreshPDFData
{
    
    CaseTimelineLabel.hidden =YES;
    POSignedLabel.hidden =YES;
    DateSignedLabel.hidden =YES;
    TimeRemaining.hidden =YES;
    labelbg.hidden =YES;
    underline.hidden =YES;
    ImportantNotice.hidden =YES;
    refreshDate.hidden =YES;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
    
    // NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"xml"];
    
    NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];
    
    
    
    _signController  = [[eSignController alloc]init];
    _signController.delegate=self;
    
    [_signController eApplicationForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
    
    
    [self.view addSubview:_signController.view];
    //   [self presentViewController:_signController animated:YES completion:nil];
    // [self.navigationController popViewControllerAnimated:YES];
    
    // HUD.removeFromSuperViewOnHide=YES;
    [HUD hide:YES];
    
    
    
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Please complete the following items before submission";
}

#pragma mark - Function Delete from SI
-(void) deleteEAppCase: (NSString *)SINO {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
	
	if (![db open])
		[db open];
	
	FMResultSet *result;
	FMResultSet *result2;
	
	NSString *ProposalNo_to_delete;
	
	NSString *query = [NSString stringWithFormat:@"SELECT eProposalNo FROM eProposal WHERE SINO = '%@'", SINO];
    result = [db executeQuery:query];
	
	while ([result next]) {
		//ONLY DELETE DATA WITH STATUS CREATED AND CONFIRMED
		NSString *query2 = [NSString stringWithFormat:@"SELECT ProposalNo FROM eApp_listing WHERE ProposalNo = '%@' AND status in (2,3)", [result objectForColumnName:@"eProposalNo"]];
		result2 = [db executeQuery:query2];
		
		while ([result2 next]) {
			ProposalNo_to_delete =  [result2 objectForColumnName:@"ProposalNo"];
//			[self deleteOldPdfs:ProposalNo_to_delete];
			ClearData *ClData =[[ClearData alloc]init];
			[ClData deleteOldPdfs:ProposalNo_to_delete];
			[self RemoveFlag:ProposalNo_to_delete database:db];
		}
	}
	
	[db close];
}



-(void) RemoveFlag:(NSString *)ProposalNo database:(FMDatabase *)db
{
    
	[db executeUpdate:@"UPDATE eProposal SET ProposalCompleted = 'N', PolicyDetailsMandatoryFlag = 'N', QuestionnaireMandatoryFlag = 'N' WHERE eProposalNo = ?",ProposalNo];
	
	[db executeUpdate:@"DELETE FROM eProposal_QuestionAns WHERE eProposalNo = ?", ProposalNo];
	
}



-(void)displayPDF:(NSString *)formType{
    //NSLog(@"%@",formType);
    //[self dismissViewControllerAnimated:TRUE completion:^{
    
    UIStoryboard *thirdStoryBoard = [UIStoryboard storyboardWithName:@"LynnStoryboard" bundle:nil];
    COAPDF *coaPDF = [thirdStoryBoard instantiateViewControllerWithIdentifier:@"COA"];
    coaPDF.delegate = self;
    [self presentViewController:coaPDF animated:YES completion:nil];
    
    //}];
    
    
    
    
}

-(void)updateChecklistSI{
    //NSLog(@"!!!!!!!!!! eAppCheckList - updateChecklistSI   !!!!!!!!!!");
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

-(void)updateCffForCompany {
    
    
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
	
	if ([POOtherIDType isEqualToString:@"CR"]) {
		//cffCell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
		cffCell.textLabel.textColor = [UIColor grayColor];
		cffCell.userInteractionEnabled = NO;
		cffCell.titleLabel1.textColor = [UIColor grayColor];
		cffCell.descriptionLabel1.text = @"";
        UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
        [cffCell.statusLabel1 setImage:doneImage];
	}
}

-(void)updateChecklistCFF {
    updateCFFCell = 1;
    
    NSLog(@"amiupdating");
    
    if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
        //NSLog(@"Hello updateCFF");
        NSString *aa;
        aa = [NSString stringWithFormat:@"Customer: %@  CFF Updated: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFDate"]];
        cffCell.descriptionLabel1.text = aa;
        cffCell.textLabel.textColor = [UIColor grayColor];
        cffCell.userInteractionEnabled = NO;
        cffCell.titleLabel1.textColor = [UIColor grayColor];
        cffCell.descriptionLabel1.text = @"";
        if ([[[obj.eAppData objectForKey:@"CFF"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [cffCell.statusLabel1 setImage:doneImage];
            cffCellCompletebool=YES;
        }
		else {
			UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
            [cffCell.statusLabel1 setImage:doneImage];
            cffCellCompletebool=NO;
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
            esignCellCompletebool=YES;
            //[[obj.eAppData objectForKey:@"Proposal"] setValue:@"Confirmed" forKey:@"Confirmation"];
        }
        
        
    }];
}

- (void)edit_eApp
{
    alert_resave = FALSE;
    obj=[DataClass getInstance];
    
    NSString *SIVersion =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SISelected_SIVersion"];
    NSString *SYS_SIVersion =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Sys_SIVersion"];
    NSString *UL_Trad_SIVersion =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"UL_Trad_SIVersion"];
    NSString *sino = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    
    if  ((NSNull *) SYS_SIVersion == [NSNull null])
        SYS_SIVersion = @"";
    
    if  ((NSNull *) UL_Trad_SIVersion == [NSNull null])
        UL_Trad_SIVersion = @"";
    
    if  ((NSNull *) SIVersion == [NSNull null])
        SIVersion = @"";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    if (![database open]) {
        NSLog(@"Could not open db.");
    }
    
    [database open];
    
    //GET THE TRAD/UL SI VERSION START
    
	
    
    NSString *siplan =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Plan"];
    NSString *updated_SIVersion =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"UL_Trad_SIVersion"];
    NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    
    //KY UPDATE THE SI VERSION FROM SI (STAND ALONE) TO SI (eApp)
    /*
     NSString *update = [NSString stringWithFormat:@"Update eProposal SET SIVersion = %@ WHERE eProposalNo = %@",updated_SIVersion, eProposalNo];
     
     NSLog(@"KY update - %@",update);
     [database executeUpdate: update];
     */
    UL_Trad_SIVersion  = updated_SIVersion;
    //  SIVersion = updated_SIVersion;
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:SIVersion forKey:@"SISelected_SIVersion"];
    
    
    
    NSString *SIclientName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"];
    
    
    NSString *ProspectName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectName"];
    
    if(SIclientName==NULL)
        SIclientName = @"";
    
    if(ProspectName==NULL)
        ProspectName = @"";
    
    
    
    //GET THE TRAD/UL SI VERSION END
    NSLog(@"%@, %@", UL_Trad_SIVersion, SYS_SIVersion);
    if([UL_Trad_SIVersion isEqualToString:SYS_SIVersion])
    {
        
        NSLog(@"KY UL_Trad_SIVersion - %@ | SIVersion - %@ ", UL_Trad_SIVersion, SIVersion);
        if([UL_Trad_SIVersion isEqualToString:SIVersion])
        {
            //UPDATE THE CHECKLIST FOR ALL  - START
            
            NSString *aa;
            NSString *SIclientName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"];
			if (SIclientName == nil)
				SIclientName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"]; //EMI Test
			
			//NSLog(@"name1 %@, name2 %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"]);
			
            NSString *SIclientSmoker = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientSmoker"];
            NSString *SIclientMarital = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientMarital"];
            NSString *SIclientOccup = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientOccup"];
            
            
            NSString *ProspectName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectName"];
            NSString *ProspectSmoker = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectSmoker"];
            NSString *ProspectMarital = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectMarital"];
            NSString *ProspectOccup = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ProspectOccup"];
            
            if([ProspectMarital isEqualToString:@"SINGLE"])
                ProspectMarital = @"S";
            else if([ProspectMarital isEqualToString:@"MARRIED"])
                ProspectMarital = @"M";
            else if([ProspectMarital isEqualToString:@"DIVORCED"])
                ProspectMarital = @"D";
            else
                ProspectMarital = @"W";
            
            
            if(SIclientName==NULL)
                SIclientName = @"";
            
            if(ProspectName==NULL)
                ProspectName = @"";
            
            
            //NSLog(@"SIClientName: %@", SIclientName);
            
            aa = [NSString stringWithFormat:@"SI No: %@   Life Assured: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], SIclientName, str_plan];
            if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] isEqualToString:@"(null)"] || ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] == NULL))
            {
				siCell.descriptionLabel1.text = @"";// @"Select Sales Illsutration from Listing and check Sales Illustration version";
			}
			else {
				siCell.descriptionLabel1.text = aa;
			}
            
            
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
			
            //NSLog(@"ENS1: SIclientName: %@, ProspectName: %@", SIclientName, ProspectName);
            if(![SIclientName isEqualToString:@""] || ![ProspectName isEqualToString:@""])
                
            {
                
                [siCell.statusImage1 setImage:doneImage];
                siCellCompletebool=YES;
            }
            
            
            // WAITING FOR HENG TO SYN THE MARITAL STATUS IN SI
            //  else if([SIclientName isEqualToString:ProspectName] && ([SIclientSmoker isEqualToString:SIclientSmoker]) && ([SIclientMarital isEqualToString:ProspectMarital]) && ([SIclientOccup isEqualToString:ProspectOccup]))
            else if([SIclientName isEqualToString:ProspectName] && ([SIclientSmoker isEqualToString:SIclientSmoker]) && ([SIclientOccup isEqualToString:ProspectOccup]))
            {
                
                [siCell.statusImage1 setImage:doneImage];
                siCellCompletebool=YES;
            }
            else
            {
                alert_resave = TRUE;
                
            }
            
            
            
            //*************POLICY OWNER SECTION
            NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
            
            //NSLog(@"eproposalNo: %@",eProposalNo);
            //  executeQuery
            
            NSString *potype;
            NSString *po_msg;
			NSString *ic;
			NSString *POOtherID;
			
            NSString *selectPO = [NSString stringWithFormat:@"SELECT * FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo ];
            FMResultSet *results;
            results = [database executeQuery:selectPO];
			int countPO = 0;
            while ([results next]) {
                countPO = 1;
                name = [results objectForColumnName:@"LAName"];
                potype = [results objectForColumnName:@"PTypeCode"];
                NSString *otherIDNO = [results objectForColumnName:@"LAOtherID"];
                [[obj.eAppData objectForKey:@"EAPP"] setValue:[results objectForColumnName:@"LANewICNo"] forKey:@"POIDTypeNo"];
                //[[obj.eAppData objectForKey:@"EAPP"] setValue:[results objectForColumnName:@"LAOtherId"] forKey:@"POOtherIDTypeNo"];
                [[obj.eAppData objectForKey:@"EAPP"] setValue:otherIDNO forKey:@"POOtherIDTypeNo"];
                //NSLog(@"idtype ashd: %@", [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"POOtherIDTypeNo"]);
				
				ic = [results objectForColumnName:@"LANewICNo"];
				POOtherID = [results objectForColumnName:@"LAOtherID"];
				[[obj.eAppData objectForKey:@"EAPP"] setValue:[results objectForColumnName:@"ProspectProfileID"] forKey:@"POProspectID"];
				[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"POFlag"];
            }
            if (countPO == 0) {
				[[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"POFlag"];
			}
            
            //[database close];
            
            
            
            if(name!= NULL || name!= nil)
            {
                
                if([potype isEqualToString:@"LA1"])
                {
                    po_msg = @"1st Life Assured";
                    aa = [NSString stringWithFormat:@"Policy Owner/Life Assured: %@",name];
                    
                }
                
                else if([potype isEqualToString:@"LA2"])
                {
                    po_msg = @"2nd Life Assured";
                    aa = [NSString stringWithFormat:@"Policy Owner: %@   Life Assured: %@",name,SIclientName];
                    
                }
                else if([potype isEqualToString:@"PY1"])
                {
                    po_msg = @"Payor";
                    aa = [NSString stringWithFormat:@"Policy Owner: %@   Life Assured: %@",name,SIclientName];
                    
                }
                
                else if([potype isEqualToString:@"nil"])
                {
                    // po_msg = @"Policy Owner";
                    aa = [NSString stringWithFormat:@""];
                    
                }
                
                else if([potype isEqualToString:NULL])
                {
                    //po_msg = @"Policy Owner";
                    aa = [NSString stringWithFormat:@""];
                    
                }
                
                
                else if([potype isEqualToString:@"PO"])
                {
                    po_msg = @"Policy Owner";
                    aa = [NSString stringWithFormat:@"Policy Owner: %@   Life Assured: %@",name,SIclientName];
                }
                
                else
                {
                    aa = [NSString stringWithFormat:@""];
                    
                    // poCell.descriptionLabel1.text = aa;
                    UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                    [poCell.statusImage1 setImage:doneImage];
                    poCellCompletebool=NO;
                    
                }
                
                
                if (![obj.eAppData objectForKey:@"SecPO"]) {
                    [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"SecPO"];
                }
				
                //[[obj.eAppData objectForKey:@"SecPO"] setValue:name forKey:@"Confirm_POName"];
                
				[[obj.eAppData objectForKey:@"SecPO"] setValue:potype forKey:@"Confirm_POType"];
				
				//CHANGE BY ENS, test when save new poname, save for other id and IC also ####
				[[obj.eAppData objectForKey:@"SecPO"] setValue:ic forKey:@"Confirm_POIC"];
				[[obj.eAppData objectForKey:@"SecPO"] setValue:POOtherID forKey:@"Confirm_POOtherID"];
                
                
                NSString *poname =   [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"];
                NSString *proposalno =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
				
				ic =       [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POIC"];
				POOtherID =   [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POOtherID"];
                
                
                
                NSString *querySQL = [NSString stringWithFormat:@"select IndexNo from prospect_profile where ProspectName = '%@'", poname];
                
                
                
                NSString *ProspectID = @"";
                
                FMResultSet *results =  [database executeQuery:querySQL];
                
                while ([results next]) {
                    
                    ProspectID = [results objectForColumnIndex:0];
                }
                
				
                //NSLog(@"idtype2: %@", [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"POOtherIDTypeNo"]);
				
				//ProspectID = [[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"POProspectID"];
                //if([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POIC"] != Nil)
                //				if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"POFlag"] isEqualToString:@"Y"]) {
                //                    [database executeUpdate:@"Update eApp_Listing SET  ClientProfileID = ?, POName = ? , IDNumber = ?, OtherIDNo = ?  WHERE ProposalNo = ? ",ProspectID, poname, ic, POOtherID, proposalno];
                //                }
				NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
				NSDate *currDate = [NSDate date];
				[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
				NSString *dateString = [dateFormatter2 stringFromDate:currDate];
				
				if ([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"] != Nil) {
                    [database executeUpdate:@"Update eApp_Listing SET ClientProfileID = ?, POName = ? , IDNumber = ?, OtherIDNo = ?  , DateUpdated = ? WHERE ProposalNo = ? ",ProspectID, poname, ic, POOtherID, dateString ,proposalno];
                }
                
                poCell.descriptionLabel1.text = aa;
                //UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                
                //GET PP  CHANGES COUNTER
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *docsPath = [paths objectAtIndex:0];
                NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
                
                int counter = 0;
                int pp_counter = 0;
                NSString *ppID = @"";
                NSString *ptype = @"";
                BOOL complete;
                FMDatabase *db = [FMDatabase databaseWithPath:path];
                [db open];
				
				FMResultSet *result2;
				
				
				
                //				int count1 = 0;
                //				int count2 = 0;
                //				FMResultSet *result2 = [db executeQuery:@"SELECT LARelationship from eProposal_LA_Details WHERE eProposalNo = ?", eProposalNo];
                //				while ([result2 next]) {
                //					count1 = count1 + 1;
                //					NSString *LARelationship = [result2 objectForColumnName:@"LARelationship"];
                //					if (![LARelationship isEqualToString:@""]){
                //						count2 = count2 + 1;
                //					}
                //				}
				
				//Check eProposal_LA_details got all data to consider Policy Owner as complete.
				[self CheckPO];
				
				UIImage *doneImage;
				if (PO_DONE){
					complete = YES;
                    doneImage = [UIImage imageNamed: @"iconComplete.png"];
				}
				else {
					complete = NO;
                    doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
				}
				
				//Checking PO update for all PType end ## Edit by Emi
				//LArelationship is mandatory for all ptype, if still empty then still not update
				
				
                result2 = nil;
                result2 = [db executeQuery:@"SELECT ProspectProfileChangesCounter, ProspectProfileID, PTypeCode from eProposal_LA_Details WHERE eProposalNo = ? AND POFlag = 'Y'", eProposalNo];
                
                
                while ([result2 next]) {
                    counter =  [result2 intForColumn:@"ProspectProfileChangesCounter"];
                    
                    ppID =  [result2 objectForColumnName:@"ProspectProfileID"];
                    
                    ptype = [result2 objectForColumnName:@"PTypeCode"];
                    
                    if  ((NSNull *) ppID == [NSNull null])
                        ppID = @"";
                    
                    if  ((NSNull *) ptype == [NSNull null])
                        ptype = @"";
                    
                    
                    if(![ppID isEqualToString:@""])
                    {
                        
                        FMResultSet *result = [db executeQuery:@"SELECT ProspectProfileChangesCounter from prospect_profile WHERE indexNo = ?",ppID];
                        
                        while ([result next]) {
                            pp_counter =  [result intForColumn:@"ProspectProfileChangesCounter"];
                            
                        }
                        [obj.eAppData setValue:[NSString stringWithFormat:@"%d", pp_counter] forKey:@"prospectProfileChangesCounter"];
                        
                        if(counter != pp_counter && [ptype isEqualToString:@"LA1"])
                        {
                            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"LA1_ClientProfileUpdated"];
                            
                            complete = NO;
                            alert_resave = TRUE;
                            //NSLog(@"LA1");
                        }
                        else if(counter == pp_counter && [ptype isEqualToString:@"LA1"])
                        {
                            
                            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"LA1_ClientProfileUpdated"];
                            
                        }
                        
                        if(counter != pp_counter && [ptype isEqualToString:@"LA2"])
                        {
                            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"LA2_ClientProfileUpdated"];
                            complete = NO;
                            alert_resave = TRUE;
                            //NSLog(@"LA2");
                            
                        }
                        else if(counter == pp_counter && [ptype isEqualToString:@"LA2"])
                        {
                            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"LA2_ClientProfileUpdated"];
                            
                        }
                        
                        
                        if(counter != pp_counter && [ptype isEqualToString:@"PY1"])
                        {
                            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"PY1_ClientProfileUpdated"];
                            complete = NO;
                            alert_resave = TRUE;
                            //NSLog(@"PY1");
                            
                        }
                        else if(counter == pp_counter && [ptype isEqualToString:@"PY1"])
                        {
                            [[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"PY1_ClientProfileUpdated"];
                            
                        }
                        
                        
                        [result close];
                    }
                    
                    
                    
                }
                
                
                [result2 close];
                [db close];
                
                
                //If user did changes in Client Profile, in eApp PO will display the latest Client Profile info, and user need to save
                //manually for PO, then store the latest Client profile details into eProposal_LA_Details table.
                if(complete == YES)
                {
                    
                    [poCell.statusImage1 setImage:doneImage];
                    poCellCompletebool=YES;
                    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"CompletePO"];
                    
                }
                else
                {
                    [[obj.eAppData objectForKey:@"EAPP"] setValue:@"N" forKey:@"CompletePO"];
					aa = [NSString stringWithFormat:@"Determine Policy Owner or create new Policy Owner"];
                    // poCell.descriptionLabel1.text = aa;
					UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
					[poCell.statusImage1 setImage:doneImage];
					poCellCompletebool=NO;
					//Add by Emi: Remove policy Owner when PO Checkbox uncheck or policy owner deleted
					if ([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"] == Nil) {
						[database executeUpdate:@"Update eApp_Listing SET POName = '' , IDNumber = '', OtherIDNo = ''  WHERE ProposalNo = ? ",proposalno];
					}
					
                }
                
                
            }
            else
            {
                
                
                aa = [NSString stringWithFormat:@"Determine Policy Owner or create new Policy Owner"];
                
                // poCell.descriptionLabel1.text = aa;
                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                [poCell.statusImage1 setImage:doneImage];
                poCellCompletebool=NO;
                
            }
            
            
            //*************CFF  SECTION
            NSString *status;
            NSString *CFFName;
            NSString *dateModified;
            
            NSString *cffID;
            
            int eProposalCFFCounter;
            int CFFCounter;
            int CFFProspectCounter;
            int prospectCounter = [[obj.eAppData objectForKey:@"prospectProfileChangesCounter"] intValue];
            
            NSString *selectCFF = [NSString stringWithFormat:@"SELECT A.ID, A.Status, B.Name, A.LastUpdatedAt, A.CFFChangesCounter FROM eProposal_CFF_Master AS A, CFF_Personal_Details AS B WHERE A.eProposalNo = '%@'  AND A.ID = B.CFFID AND B.PTypeCode = '1' and A.status='1'",eProposalNo ];
            
            results = [database executeQuery:selectCFF];
			
			int CffCount = 0;
			
            while ([results next]) {
                CffCount = CffCount + 1;
                status = [results objectForColumnName:@"Status"];
                
                CFFName = [results objectForColumnName:@"Name"];
                dateModified = [results objectForColumnName:@"LastUpdatedAt"];
                
                cffID = [results objectForColumnName:@"ID"];
                
                eProposalCFFCounter = [results intForColumn:@"CFFChangesCounter"];
                
            }
            
            results = nil;
			//NSLog(@"ID %@", cffID);
            results = [database executeQuery:@"select CFFChangesCounter, ProspectProfileChangesCounter from CFF_Master where ID = ?", cffID];
            while ([results next]) {
                CFFCounter = [results intForColumn:@"CFFChangesCounter"];
                CFFProspectCounter = [results intForColumn:@"ProspectProfileChangesCounter"];
            }
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath = [paths objectAtIndex:0];
            NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
            
            FMDatabase *db = [FMDatabase databaseWithPath:path];
            [db open];
            
            NSString *eProposalNo1 = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
            NSString *POOtherIDType;
            NSString *selectPO1 = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo1];
            
            FMResultSet *results1;
            results1 = [db executeQuery:selectPO1];
            while ([results1 next]) {
                POOtherIDType = [results1 objectForColumnName:@"LAOtherIDType"];
            }
            
			//NSLog(@"CFFCounter %d, eProposalCFFCounter %d, CFFProspectCounter %d, prospectCounter %d", CFFCounter, eProposalCFFCounter , CFFProspectCounter , prospectCounter);
            
            if([status isEqualToString:@"1"] && ![POOtherIDType isEqualToString:@"CR"])
            {
                
				//#### Please recheck Here Disable temp ENS (14/04/2014) Bug ID: 3297
				//Disable by Emi - 04/06/2014
				
                //                if (CFFCounter != eProposalCFFCounter) {
                //					alert_resave = TRUE;
                //                }
                
                NSString  *cff = [NSString stringWithFormat:@"Customer: %@  CFF Updated: %@",  CFFName,dateModified ];
                cffCell.descriptionLabel1.text = cff;
				
				
                
                if (CFFCounter == eProposalCFFCounter) {
                    doneImage = [UIImage imageNamed: @"iconComplete.png"];
                    [cffCell.statusLabel1 setImage:doneImage];
                    cffCellCompletebool=YES;
                    
                }
                
            }
			
			NSString *CheckStatus = [NSString stringWithFormat:@"SELECT status from eApp_Listing WHERE ProposalNo = '%@'",eProposalNo ];
            
            results = [database executeQuery:CheckStatus];
            while ([results next]) {
				
                NSString *statusP = [results objectForColumnName:@"Status"];
				
                if(([status isEqualToString:@"1"]) && ([statusP isEqualToString:@"6"] || [statusP isEqualToString:@"2"] ) && ![POOtherIDType isEqualToString:@"CR"] )
                {
                    doneImage = [UIImage imageNamed: @"iconComplete.png"];
                    [cffCell.statusLabel1 setImage:doneImage];
                    cffCellCompletebool=YES;
                }
			}
			
			if (CffCount == 0) {
				UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
				[cffCell.statusLabel1 setImage:doneImage];
				cffCellCompletebool=NO;
				cffCell.descriptionLabel1.text = @"";
			}
            
            if (![obj.eAppData objectForKey:@"CFF"]) {
                [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"CFF"];
            }
            [[obj.eAppData objectForKey:@"CFF"] setValue:cffID forKey:@"CustomerCFF"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:CFFName forKey:@"CFFName"];
            [self storeCFFXMLData:cffID];
            
            
            
            
            //*************Proposal  SECTION START
            
            
            
            NSString *proposal_confirm;
            results = [database executeQuery:@"SELECT ProposalCompleted from eProposal WHERE eProposalNo = ?", eProposalNo];
            while ([results next]) {
                proposal_confirm = [results objectForColumnName:@"ProposalCompleted"];
            }
            
            
            if( [proposal_confirm isEqualToString:@"Y"] )
            {
                NSString *aa;
                aa = [NSString stringWithFormat:@"Proposal form confirmed"];
                
                eappCell.descriptionLabel1.text = aa;
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [eappCell.statusLabel1 setImage:doneImage];
                eappCellCompletebool=YES;
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                [prefs setObject:@"ticker" forKey:@"keyString"];
                
                [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"Proposal_Confirmation"];
                [self storeProposalXML];
				[[NSNotificationCenter defaultCenter] postNotificationName:@"StoreXMLData" object:nil];
                //				[self storeXMLData_AssuredInfo];
            }
			else {
				UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                [eappCell.statusLabel1 setImage:doneImage];
                eappCellCompletebool=NO;
				eappCell.descriptionLabel1.text = @"";
			}
            
            //*************Proposal  SECTION END
            
            
            
            
            
            ///// modified method for tick mark
            
            
            
            appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            
            NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"] isKindOfClass:[NSString class]])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"compareString"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            
            NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
            //            if ([array containsObject:proposalform12])
            //            {
            //                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            //
            //                [reportCell.statusLabel1 setImage:doneImage];
            //                reportCellCompletebool=YES;
            //            }
            //            else{
            //                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
            //
            //                [reportCell.statusLabel1 setImage:doneImage];
            //                reportCellCompletebool=NO;
            //            }
            
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
            
            //dataItems = [[NSMutableArray alloc] initWithObjects:@"Brochure_MajorMedi", @"Brochure_Cashpromise_ENGBM", @"Brochure_MajorMediPlus",@"Brochure_MedGlobalIVP",nil];
            
            //prepare array to store forms path
            
            
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                [reportCell.statusLabel1 setImage:doneImage];
                reportCellCompletebool=YES;
                
            }
            else
            {
                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                
                [reportCell.statusLabel1 setImage:doneImage];
                reportCellCompletebool=NO;
                
            }
            
            
            
            
            NSString *proposalform =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *supplementaryaform =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *salesillustarionform = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *customerfactform = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *confirmationofadviceform =[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *eauthorozationform =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            
            
            if([proposalform isEqualToString:@"Y"] || [supplementaryaform isEqualToString:@"N"] || [salesillustarionform isEqualToString:@"Y"] || [customerfactform isEqualToString:@"Y"] ||[confirmationofadviceform isEqualToString:@"Y"] || [eauthorozationform isEqualToString:@"Y"] )
                
            {
                
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                [reportCell.statusLabel1 setImage:doneImage];
                reportCellCompletebool=YES;
            }
            else
            {
                
                
                
                
            }
            
            appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            NSString *proposalform122 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"] isKindOfClass:[NSString class]])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CompareSign"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSArray *array1=[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"];
            
            
            
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] && [array1 containsObject:proposalform122])
            {
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                [esignCell.statusLabel1 setImage:doneImage];
                esignCellCompletebool=YES;
            }
            else{
                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                
                [esignCell.statusLabel1 setImage:doneImage];
                esignCellCompletebool=NO;
            }
            //for Capture image tick mark
            appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            NSString *proposalform222 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"] isKindOfClass:[NSString class]])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ComparePhoto"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSArray *array12=[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"];
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] && [array12 containsObject:proposalform222])
            {
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                [supportingcell.statusLabel1 setImage:doneImage];
                supportingCompletebool=YES;
				TickYES=YES;
            }
            else
			{
                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                
                [supportingcell.statusLabel1 setImage:doneImage];
                supportingCompletebool=NO;
				TickYES=NO;
            }
            
            
            
            
        }
        else
        {
            NSString *update_SIVersion_eproposal = [NSString stringWithFormat:@"Update eProposal SET SIVersion = '%@' where eProposalNo = '%@' ",UL_Trad_SIVersion, eProposalNo];
            
            
            [database executeUpdate:update_SIVersion_eproposal];
            
            //NSLog(@"UPDATE update_SIVersion_eproposal - %@", update_SIVersion_eproposal);
            
            //            NSString *saved = [NSString stringWithFormat:@"Updated this SI Version from %@ to %@ successfully.",SIVersion,UL_Trad_SIVersion];
            //
            //            UIAlertView *alert = [[UIAlertView alloc]
            //                                  initWithTitle: @"iMobile Planner"
            //                                  message:saved
            //                                  delegate: self
            //                                  cancelButtonTitle:@"OK"
            //                                  otherButtonTitles:nil];
            //            [alert setTag:1003];
            //            [alert show];
            //            alert = Nil;
            
            //After update the SIVersion to eProposal table, syn the SIVersion
            [[obj.eAppData objectForKey:@"EAPP"] setValue:UL_Trad_SIVersion forKey:@"SISelected_SIVersion"];
            // SIVersion = UL_Trad_SIVersion;
            
            
            //UPDATE CHECKLIST FOR ALL - START
			NSString *SIclientName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"];
			if (SIclientName == nil)
				SIclientName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIName"]; //EMI Test
            NSString *aa;
            aa = [NSString stringWithFormat:@"SI No: %@   Life Assured: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], SIclientName, str_plan];
			
            if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] isEqualToString:@"(null)"] || ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] == NULL)) {
				siCell.descriptionLabel1.text = @"";// @"Select Sales Illsutration from Listing and check Sales Illustration version";
			}
			else {
				siCell.descriptionLabel1.text = aa;
			}
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            //NSLog(@"ENS2: SIclientName: %@, ProspectName: %@", SIclientName, ProspectName);
			
            if(![SIclientName isEqualToString:@""] || ![ProspectName isEqualToString:@""])
                
            {
                
                [siCell.statusImage1 setImage:doneImage];
                siCellCompletebool=YES;
            }
            
            else if([SIclientName isEqualToString:ProspectName])
            {
                
                [siCell.statusImage1 setImage:doneImage];
                siCellCompletebool=YES;
                
            }
            else
            {
                alert_resave = TRUE;
                siCellCompletebool=NO;
            }
            
            
            
            
            
            
            //*************POLICY OWNER SECTION
            NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
            
            
            //  executeQuery
            //  NSString *name;
            NSString *potype;
            NSString *po_msg;
            NSString *selectPO = [NSString stringWithFormat:@"SELECT * FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo ];
            FMResultSet *results;
            results = [database executeQuery:selectPO];
            while ([results next]) {
                
                name = [results objectForColumnName:@"LAName"];
                potype = [results objectForColumnName:@"PTypeCode"];
                
            }
            
			NSString *POname;
			NSString *POListing = [NSString stringWithFormat:@"SELECT * FROM eApp_Listing WHERE ProposalNo = '%@'" ,eProposalNo];
			FMResultSet *results2;
			results2 = nil;
            results2 = [database executeQuery:POListing];
            while([results2 next]) {
                POname = [results2 objectForColumnName:@"POName"];
            }
            
			
			NSLog(@"poname: %@", POname);
			
			if ((NSNull *) POname == [NSNull null])
				POname = @"";
			
            //[database close];
            
			//Emi - temp remove
            //[[obj.eAppData objectForKey:@"SecPO"] setValue:name forKey:@"Confirm_POName"];
            
            if(name!= NULL || name!= nil)
            {
                if([potype isEqualToString:@"LA1"])
                {
                    po_msg = @"1st Life Assured";
                    aa = [NSString stringWithFormat:@"Policy Owner/Life Assured: %@",name];
                    
                }
                
                else if([potype isEqualToString:@"LA2"])
                {
                    po_msg = @"2nd Life Assured";
                    aa = [NSString stringWithFormat:@"Policy Owner: %@   Life Assured: %@",name,SIclientName];
                    
                }
                else if([potype isEqualToString:@"PY1"])
                {
                    po_msg = @"Payor";
                    aa = [NSString stringWithFormat:@"Policy Owner: %@   Life Assured: %@",name,SIclientName];
                    
                }
                else if([potype isEqualToString:@"PO"])
                {
                    po_msg = @"Policy Owner";
                    aa = [NSString stringWithFormat:@"Policy Owner: %@   Life Assured: %@",name,SIclientName];
                }
                
                
                //				if ([POname isEqualToString:@""]){
                //					aa = [NSString stringWithFormat:@"Determine Policy Owner or create new Policy Owner"];
                //				}
                //				else {
                //                    aa = [NSString stringWithFormat:@"Policy Owner: %@   Type: %@",name,po_msg];
                //				}
                poCell.descriptionLabel1.text = aa;
				
				BOOL complete;
				//			FMDatabase *db = [FMDatabase databaseWithPath:path];
				//			[db open];
				
				//Check eProposal_LA_details got all data to consider Policy Owner as complete.
				
                //				int count1 = 0;
                //				int count2 = 0;
                //				FMResultSet *result2 = [database executeQuery:@"SELECT LARelationship from eProposal_LA_Details WHERE eProposalNo = ?", eProposalNo];
                //
                //				while ([result2 next]) {
                //					count1 = count1 + 1;
                //					NSString *LARelationship = [result2 objectForColumnName:@"LARelationship"];
                //					if (![LARelationship isEqualToString:@""]){
                //						count2 = count2 + 1;
                //					}
                //				}
				
				
				[self CheckPO];
				
				UIImage *doneImage;
				if (PO_DONE){
					complete = YES;
					doneImage = [UIImage imageNamed: @"iconComplete.png"];
                    poCellCompletebool=YES;
				}
				else {
					complete = NO;
					doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                    poCellCompletebool=NO;
				}
				
                //UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [poCell.statusImage1 setImage:doneImage];
				
                
                
            }
            
            
            //*************CFF  SECTION
            NSString *status;
            NSString *CFFName;
            NSString *dateModified;
            
            NSString *cffID;
            
            NSString *selectCFF = [NSString stringWithFormat:@"SELECT A.ID, A.Status, B.Name, A.LastUpdatedAt FROM eProposal_CFF_Master AS A, CFF_Personal_Details AS B WHERE A.eProposalNo = '%@'  AND A.ID = B.CFFID AND B.PTypeCode = '1'",eProposalNo ];
            
            results = [database executeQuery:selectCFF];
            while ([results next]) {
                
                status = [results objectForColumnName:@"Status"];
                
                CFFName = [results objectForColumnName:@"Name"];
                
                
                dateModified = [results objectForColumnName:@"LastUpdatedAt"];
                
                cffID = [results objectForColumnName:@"ID"];
                
            }
            
            
            if([status isEqualToString:@"1"])
            {
                
                NSString  *cff = [NSString stringWithFormat:@"Customer: %@  CFF Updated: %@",  CFFName,dateModified ];
                cffCell.descriptionLabel1.text = cff;
                //NSLog(@"CFF - %@", cff);
                doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [cffCell.statusLabel1 setImage:doneImage];
                cffCellCompletebool=YES;
            }
            
            if (![obj.eAppData objectForKey:@"CFF"]) {
                [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"CFF"];
            }
            [[obj.eAppData objectForKey:@"CFF"] setValue:cffID forKey:@"CustomerCFF"];
            [[obj.eAppData objectForKey:@"EAPP"] setValue:CFFName forKey:@"CFFName"];
            
            
            
			//*************Proposal  SECTION START
            
            
            
            NSString *proposal_confirm;
            results = [database executeQuery:@"SELECT ProposalCompleted from eProposal WHERE eProposalNo = ?", eProposalNo];
            while ([results next]) {
                proposal_confirm = [results objectForColumnName:@"ProposalCompleted"];
            }
            
            
            if( [proposal_confirm isEqualToString:@"Y"] )
            {
                NSString *aa;
                aa = [NSString stringWithFormat:@"Proposal form confirmed"];
                
                eappCell.descriptionLabel1.text = aa;
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [eappCell.statusLabel1 setImage:doneImage];
                eappCellCompletebool=YES;
                
                [[obj.eAppData objectForKey:@"EAPP"] setValue:@"Y" forKey:@"Proposal_Confirmation"];
                [self storeProposalXML];
            }
            
            //*************Proposal  SECTION END
            
            
            
            
            
            ///// modified method for tick mark
            
            
            
            appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            
            NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
			
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"] isKindOfClass:[NSString class]])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"compareString"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            
            NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
            //            if ([array containsObject:proposalform12])
            //            {
            //                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            //
            //                [reportCell.statusLabel1 setImage:doneImage];
            //                reportCellCompletebool=YES;
            //            }
            //            else{
            //                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
            //
            //                [reportCell.statusLabel1 setImage:doneImage];
            //                reportCellCompletebool=NO;
            //            }
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
            
            //dataItems = [[NSMutableArray alloc] initWithObjects:@"Brochure_MajorMedi", @"Brochure_Cashpromise_ENGBM", @"Brochure_MajorMediPlus",@"Brochure_MedGlobalIVP",nil];
            
            //prepare array to store forms path
            
            
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                [reportCell.statusLabel1 setImage:doneImage];
                reportCellCompletebool=YES;
                
            }
            else
            {
                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                
                [reportCell.statusLabel1 setImage:doneImage];
                reportCellCompletebool=NO;
                
            }
            
            
            NSString *proposalform =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *supplementaryaform =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *salesillustarionform = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *customerfactform = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *confirmationofadviceform =[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            NSString *eauthorozationform =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            
            
            if([proposalform isEqualToString:@"Y"] || [supplementaryaform isEqualToString:@"N"] || [salesillustarionform isEqualToString:@"Y"] || [customerfactform isEqualToString:@"Y"] ||[confirmationofadviceform isEqualToString:@"Y"] || [eauthorozationform isEqualToString:@"Y"] )
                
            {
                
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                [reportCell.statusLabel1 setImage:doneImage];
                reportCellCompletebool=YES;
            }
			
			//UPDATE CHECKLIST FOR ALL - END
            
            appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            NSString *proposalform122 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"] isKindOfClass:[NSString class]])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CompareSign"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            
            NSArray *array1=[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"];
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] && [array1 containsObject:proposalform122])
            {
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                [esignCell.statusLabel1 setImage:doneImage];
                esignCellCompletebool=YES;
            }
            else{
                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                
                [esignCell.statusLabel1 setImage:doneImage];
                esignCellCompletebool=NO;
            }
            
            //for Capture image tick mark
            appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            NSString *proposalform222 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"] isKindOfClass:[NSString class]])
            {
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ComparePhoto"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            NSArray *array12=[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"];
            
            
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] && [array12 containsObject:proposalform222])
            {
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                
                [supportingcell.statusLabel1 setImage:doneImage];
                supportingCompletebool=YES;
				TickYES=YES;
            }
            else{
                UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                
                [supportingcell.statusLabel1 setImage:doneImage];
                supportingCompletebool=NO;
				TickYES=NO;
            }
            
            
            
        }
    }
    else
    {
        
        //KY
        
        
        // siCell.textLabel.textColor = [UIColor grayColor];
        siCell.userInteractionEnabled = NO;
        // siCell.titleLabel1.textColor = [UIColor grayColor];
        
        //  poCell.textLabel.textColor = [UIColor grayColor];
        poCell.userInteractionEnabled = NO;
        //  poCell.titleLabel1.textColor = [UIColor grayColor];
        
        //  cffCell.textLabel.textColor = [UIColor grayColor];
        cffCell.userInteractionEnabled = NO;
        // cffCell.titleLabel1.textColor = [UIColor grayColor];
        
        //  eappCell.textLabel.textColor = [UIColor grayColor];
        eappCell.userInteractionEnabled = NO;
        // eappCell.titleLabel1.textColor = [UIColor grayColor];
        
        esignCell.userInteractionEnabled =NO;
        reportCell.userInteractionEnabled =NO;
        supportingcell.userInteractionEnabled =NO;
        //        eSignCell.textLabel.textColor = [UIColor grayColor];
        //        eSignCell.userInteractionEnabled = NO;
        //        eSignCell.titleLabel1.textColor = [UIColor grayColor];
        //
        //
        //
        //
        //        SICell *siCell;
        //        PolicyOwnerCell *poCell;
        //        CFFCell *cffCell;
        //        eAppCell *eappCell;
        //        eSignCell *esignCell;
        //        eSubCell *esubcell;
        //        ReportCell *reportCell;
        //        eConfirmationCell *confirmCell;
        //        SupportingDocCell *supportingcell;
        
        
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message: @"Please save again this SI for the latest SI version in SI module"
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert setTag:1003];
        [alert show];
        alert = Nil;
        
        NSString  *SIchecklist = [NSString stringWithFormat:@"SI No: %@   Life Assured: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"], str_plan];
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] isEqualToString:@"(null)"] || ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] == NULL)) {
			siCell.descriptionLabel1.text = @"";// @"Select Sales Illsutration from Listing and check Sales Illustration version";
		}
		else {
			siCell.descriptionLabel1.text = SIchecklist;
		}
        
        
    }
    
    //************SI SECTION
	
    [database close];
    
	[self confirmUnconfirmBtnView];
    
    if(alert_resave)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @" "
                              message:@"Changes have been done. Please revisit and resave the eApp case."
                              delegate: self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        // [alert setTag:1003];
        [alert show];
        alert = Nil;
        
        
    }
    
    
}
-(BOOL)checkforSnapData{
    NSString *proposalform222 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSArray *array12=[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"];
	if (([array12 containsObject:proposalform222])&&(TickYES ==YES))
		
    {
	  return YES;
    }
    else
        return NO;
    
    
}
-(BOOL)checkrefresheSigndata{
    NSString *proposalform122 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    
    
    
    
    NSArray *array1=[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"];
    if ([array1 containsObject:proposalform122])
    {
        return YES;
    }
    else
        return NO;
    
    
}
-(void)refreshCardsanpdata{
    //for Capture image tick mark
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    
    NSString *proposalform222 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"] isKindOfClass:[NSString class]])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ComparePhoto"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
	NSString *potype = [[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"];
	NSLog(@"type %@", potype);
    
    
    if ([potype isEqualToString:@"PY1"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            
            [supportingcell.statusLabel1 setImage:doneImage];
            supportingCompletebool=YES;
			TickYES=YES;
            [self reloadTableData];
            
        }
        
    }
	
	if (potype == NULL || potype == nil)
		potype = @"";
	
	if ([potype isEqualToString:@"LA1"]) {
		if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] || [[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] )
		{
			UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
			
			[supportingcell.statusLabel1 setImage:doneImage];
			TickYES=YES;
			supportingCompletebool=YES;
            [self reloadTableData];
		}
	}
	else {
		if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] && [[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] )
		{
			UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
			
			[supportingcell.statusLabel1 setImage:doneImage];
			supportingCompletebool=YES;
			TickYES=YES;
            [self reloadTableData];
		}
    }
    
    
    
    //     NSArray *array12=[[NSUserDefaults standardUserDefaults] objectForKey:@"ComparePhoto"];
    //    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] && [array12 containsObject:proposalform222])
    //    {
    //        UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
    //
    //        [supportingcell.statusLabel1 setImage:doneImage];
    //
    //        supportingCompletebool=YES;
    //         [self reloadTableData];
    //    }
    //    else{
    //        UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
    //
    //        [supportingcell.statusLabel1 setImage:doneImage];
    //        supportingCompletebool=NO;
    //    }
    
    //[self reloadTableData];
    
}

-(void)refresheSigndata{
    
    
    //appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    
    NSString *proposalform122 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"] isKindOfClass:[NSString class]])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CompareSign"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    NSArray *array1=[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] && [array1 containsObject:proposalform122])
    {
        UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
        
        [esignCell.statusLabel1 setImage:doneImage];
        esignCellCompletebool=YES;
        
        
        [self reloadTableData];
        //[self RefreshInformationData];
    }
    else{
        UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
        
        [esignCell.statusLabel1 setImage:doneImage];
        esignCellCompletebool=NO;
        
        [self reloadTableData];
        [self RefreshInformationData];
    }
    
    
    
}

-(void)RefreshInformationData
{
    /////////////////////////////////Timeline for Comfirm Button//////////////////////////////Basvi
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
	
    
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:path];
        
        [db open];
    }
	
    NSString *isPOSign;
    NSString *DatePOSign;
    
    NSString *displayThis = nil;
    displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    if (displayThis ==nil) {
        displayThis = @"";
    }
    
    
	FMResultSet *result_eSign = [db executeQuery:@"SELECT * from eProposal_Signature WHERE eProposalNo = ? ",displayThis];
	
	while ([result_eSign next])
    {
        //      NSString *isCustSign = [result_eSign stringForColumn:@"isCustSign"];
        //		NSString *DateCustSign = [result_eSign stringForColumn:@"DateCustSign"];
		isPOSign = [result_eSign stringForColumn:@"isPOSign"];
		DatePOSign = [result_eSign stringForColumn:@"DatePOSign"];
        
        
		
        
        if  ((NSNull *) isPOSign == [NSNull null]||[isPOSign isEqualToString:@""]||isPOSign ==Nil)
        {
			isPOSign =@"";
        }
        
        if  ((NSNull *) DatePOSign == [NSNull null]||[DatePOSign isEqualToString:@""]||DatePOSign ==Nil)
        {
			DatePOSign =@"";
        }
        
        if ([isPOSign isEqualToString:@""])
        {
            
        }
        else
        {
            // NSString *dateString1 = @"13/11/2014 12:37:31";
            NSString *dateString1 = DatePOSign;
            
            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
            // this is imporant - we set our input date format to match our input string
            // if format doesn't match you'll get nil from your string, so be careful
            [dateFormatter1 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
            NSDate *dateFromString1 = [[NSDate alloc] init];
            // voila!
            dateFromString1 = [dateFormatter1 dateFromString:dateString1];
            
            
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
            [dateFormatter2 setDateFormat:@"dd/MM/yyyy ( HH:mm a)"];
            NSString *dateString2 = [dateFormatter2 stringFromDate:dateFromString1];
            NSLog(@"%@",dateString2);
            
            NSDate *FinalDate = [dateFromString1 dateByAddingTimeInterval:-3600*16];
            NSLog(@"dttt %@",dateFromString1);
            NSLog(@"dyyy %@",FinalDate);
            
            NSString *strNewDate;
            NSString *strCurrentDate;
            NSDateFormatter *df =[[NSDateFormatter alloc]init];
            [df setDateStyle:NSDateFormatterMediumStyle];
            [df setTimeStyle:NSDateFormatterMediumStyle];
            strCurrentDate = [df stringFromDate:FinalDate];
            NSLog(@"Current Date and Time: %@",strCurrentDate);
            int hoursToAdd = 136;
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [[NSDateComponents alloc] init];
            [components setHour:hoursToAdd];
            NSDate *newDate= [calendar dateByAddingComponents:components toDate:FinalDate options:0];
            //    [df setDateStyle:NSDateFormatterMediumStyle];
            //    [df setTimeStyle:NSDateFormatterMediumStyle];
            
            [df setDateFormat:@"dd/MM/yyyy ( HH:mm a )"];
            strNewDate = [df stringFromDate:newDate];
            NSLog(@"New Date and Time: %@",strNewDate);
            
            
            //for Time Remaining
            NSDate *mydate = [NSDate date];
            NSTimeInterval secondsInEightHours = 8 * 60 * 60;
            NSDate *currentDate = [mydate dateByAddingTimeInterval:secondsInEightHours];
            NSDate *expireDate = [newDate dateByAddingTimeInterval:secondsInEightHours];
            
            int countdown = -[currentDate timeIntervalSinceDate:expireDate];//pay attention here.
            //        int hh = (countdown/3600);
            //        NSLog(@"%d",hh);
            //        int mm = ((countdown-(hh*3600))/60);
            //        int ss = countdown-(hh*3600+mm*60);
            //        NSLog(@"%02d:%02d:%02d",hh,mm,ss);
            
            
            //        NSTimeInterval timeElapsed = [[NSDate date] timeIntervalSinceDate:expireDate];
            //        NSInteger ti = (NSInteger)timeElapsed;
            
            //        int seconds = countdown % 60;
            int minutes = (countdown / 60) % 60;
            int hours = (countdown / 3600) % 24;
            int days = (countdown / 86400) % 30;
            //        int months = (countdown / 2592000) % 12;
            //        int years = (countdown / 31104000);
            
            //        unsigned flags = NSDayCalendarUnit;
            //        NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:currentDate toDate:expireDate options:0];
            //
            //        int dayDiff = [difference day];
            
            labelbg = [[UILabel alloc] initWithFrame:CGRectMake(42, 560, 940, 140)];
            labelbg.backgroundColor = [UIColor grayColor];
            // label1.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
            labelbg.alpha =0.3;
            labelbg.numberOfLines=0;
            labelbg.lineBreakMode=UILineBreakModeWordWrap;
            [self.view addSubview:labelbg];
            
            underline =[[UILabel alloc]initWithFrame:CGRectMake(60, 588 , 160, 1)];
            underline.backgroundColor =[UIColor blackColor];
            underline.font =[UIFont boldSystemFontOfSize:13];
            underline.text =@"";
            underline.textColor =[UIColor blackColor];
            [self.view addSubview:underline];
            
            
            ImportantNotice =[[UILabel alloc]initWithFrame:CGRectMake(60, 570 , 200, 20)];
            ImportantNotice.backgroundColor =[UIColor clearColor];
            ImportantNotice.font =[UIFont boldSystemFontOfSize:15];
            ImportantNotice.text =@"Important Information";
            ImportantNotice.textColor =[UIColor blackColor];
            [self.view addSubview:ImportantNotice];
            
            
            POSignedLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 590 , 400, 20)];
            POSignedLabel.backgroundColor =[UIColor clearColor];
            POSignedLabel.font =[UIFont systemFontOfSize:13];
            if([isPOSign isEqualToString:@"YES"])
            {
                POSignedLabel.text =[NSString stringWithFormat:@"Policy Owner signature                          : Captured"];
            }
            else
            {
                POSignedLabel.text =[NSString stringWithFormat:@"Policy Owner signature                          : "];
            }
            
            POSignedLabel.textColor =[UIColor blackColor];
            [self.view addSubview:POSignedLabel];
            
            DateSignedLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 610 , 400, 20)];
            DateSignedLabel.backgroundColor =[UIColor clearColor];
            DateSignedLabel.font =[UIFont systemFontOfSize:13];
            DateSignedLabel.text =[NSString stringWithFormat:@"Policy Owner signature date & time       : %@",dateString2];
            DateSignedLabel.textColor =[UIColor blackColor];
            [self.view addSubview:DateSignedLabel];
            
            CaseTimelineLabel =[[UILabel alloc]initWithFrame:CGRectMake(60, 630 , 400, 20)];
            CaseTimelineLabel.backgroundColor =[UIColor clearColor];
            CaseTimelineLabel.font =[UIFont systemFontOfSize:13];
            CaseTimelineLabel.text =[NSString stringWithFormat:@"Proposal/Quotation Expiry date & time  : %@",strNewDate];//@"This Case Valid for :";
            CaseTimelineLabel.textColor =[UIColor blackColor];
            [self.view addSubview:CaseTimelineLabel];
            
            NSDate *currDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"dd/MM/yyyy ( HH:mm a)"];
            NSString *dateString = [dateFormatter stringFromDate:currDate];
            NSLog(@"%@",dateString);
            
            refreshDate =[[UILabel alloc]initWithFrame:CGRectMake(60, 650 , 400, 20)];
            refreshDate.backgroundColor =[UIColor clearColor];
            refreshDate.font =[UIFont systemFontOfSize:13];
            refreshDate.text =[NSString stringWithFormat:@"Last Update/viewing date & time           : %@",dateString];
            refreshDate.textColor =[UIColor blackColor];
            [self.view addSubview:refreshDate];
            
            TimeRemaining =[[UILabel alloc]initWithFrame:CGRectMake(60, 670 , 510, 20)];
            TimeRemaining.backgroundColor =[UIColor clearColor];
            TimeRemaining.font =[UIFont systemFontOfSize:13];
            // TimeRemaining.text =[NSString stringWithFormat:@"Time Remaining : %d Days",dayDiff];
            
            //compare two dates
            NSComparisonResult result;
            //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
            
            result = [currentDate compare:expireDate]; // comparing two dates
            
            if(result==NSOrderedAscending)
            {
                NSLog(@"today is less");
                TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : %d days %d hours %d mins ",days,hours,minutes];
                TimeRemaining.textColor =[UIColor blackColor];
            }
            else if(result==NSOrderedDescending)
            {
                
                NSLog(@"newDate is less");
                TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : Expired                                       "];
                TimeRemaining.textColor =[UIColor redColor];
            }
            else
            {
                NSLog(@"Both dates are same");
                TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : %d hours %d mins ",hours,minutes];
                TimeRemaining.textColor =[UIColor redColor];
                NSLog(@"Both dates are same");
            }
            
            
            //        if(days <=0)
            //        {
            //            self.TimeRemaining.alpha = 0;
            //            [UIView animateWithDuration:1.5 delay:0.5 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            //                self.TimeRemaining.alpha = 1;
            //            } completion:nil];
            //
            //            TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : %d hours %d mins ",hours,minutes];
            //            TimeRemaining.textColor =[UIColor redColor];
            //
            //        }
            //        else
            //        {
            //            //            self.TimeRemaining.alpha = 0;
            //            //            [UIView animateWithDuration:1.0 delay:0.1 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            //            //                self.TimeRemaining.alpha = 1;
            //            //            } completion:nil];
            //
            //
            //            TimeRemaining.text =[NSString stringWithFormat:@"Time remaining                                       : %d days %d hours %d mins ",days,hours,minutes];
            //            TimeRemaining.textColor =[UIColor blackColor];
            //
            //        }
            
            
            [self.view addSubview:TimeRemaining];
            
        }
        
        
        
        
    }
    
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
}
-(void)reloadTableData{
    [self showConfromButton];
    //if (![self showConfromButton])
    [_checklistTable reloadData];
    [HUD hide:YES];
}
-(void)resetImageBool{
    siCellCompletebool=NO;
    poCellCompletebool=NO;
    cffCellCompletebool=NO;
    reportCellCompletebool=NO;
    esignCellCompletebool=NO;
    esubCellCompletebool=NO;
    eappCellCompletebool=NO;
    supportingCompletebool=NO;
}
- (void)viewDidAppear:(BOOL)animated
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
	
	NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
	NSString *POOtherIDType;
	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
	
	FMResultSet *results;
	results = nil;
	results = [db executeQuery:selectPO];
	while ([results next]) {
		POOtherIDType = [results objectForColumnName:@"LAOtherIDType"];
	}
	
	if ([POOtherIDType isEqualToString:@"CR"]) {
		//cffCell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
		cffCell.textLabel.textColor = [UIColor grayColor];
		cffCell.userInteractionEnabled = NO;
		cffCell.titleLabel1.textColor = [UIColor grayColor];
		cffCell.descriptionLabel1.text = @"";
        CompanyCase = @"Yes";
        UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
        [cffCell.statusLabel1 setImage:doneImage];
	}
	else {
		cffCell.textLabel.textColor = [UIColor blackColor];
		cffCell.userInteractionEnabled = YES;
		cffCell.titleLabel1.textColor = [UIColor blackColor];
		//cffCell.descriptionLabel1.text = [NSString stringWithFormat:@"Determine Policy Owner or create new Policy Owner"];
	}
    
    //    if([self checkrefresheSigndata])
    //    {
    //
    //        //cffCell = [parent.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    //		siCell.textLabel.textColor = [UIColor grayColor];
    //		siCell.userInteractionEnabled = NO;
    //		siCell.titleLabel1.textColor = [UIColor grayColor];
    //
    //        poCell.textLabel.textColor = [UIColor grayColor];
    //		poCell.userInteractionEnabled = NO;
    //		poCell.titleLabel1.textColor = [UIColor grayColor];
    //
    //        cffCell.textLabel.textColor = [UIColor grayColor];
    //		cffCell.userInteractionEnabled = NO;
    //		cffCell.titleLabel1.textColor = [UIColor grayColor];
    //
    //        eappCell.textLabel.textColor = [UIColor grayColor];
    //		eappCell.userInteractionEnabled = NO;
    //		eappCell.titleLabel1.textColor = [UIColor grayColor];
    //
    //
    //
    //    }
    
    NSString *displayThis = nil;
    displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    if (displayThis ==nil) {
        displayThis = @"";
    }
    //    proposalNo_display =[[UILabel alloc]initWithFrame:CGRectMake(700,70, 930, 20)];
    //    proposalNo_display.backgroundColor =[UIColor clearColor];
    //    proposalNo_display.font =[UIFont systemFontOfSize:15];
    //    proposalNo_display.textColor =[UIColor darkGrayColor];
    //    proposalNo_display.text =[NSString stringWithFormat:@"Proposal Number: %@",displayThis];
    //    proposalNo_display.hidden =NO;
    //    [self.view addSubview:self.proposalNo_display];
    
    NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
    // [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"]
	NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath1 = [paths1 objectAtIndex:0];
	NSString *path1 = [docsPath1 stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db1 = [FMDatabase databaseWithPath:path1];
	[db1 open];
	
    NSString *eProposalNo1 = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    NSString *selectPO1 = [NSString stringWithFormat:@"SELECT isPOSign FROM eProposal_Signature WHERE eProposalNo = '%@'",eProposalNo1];
	NSString *POOtherIDType1;
    //	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
	
	FMResultSet *results1;
	results1 = [db1 executeQuery:selectPO1];
	while ([results1 next])
    {
		POOtherIDType1 = [results1 objectForColumnName:@"isPOSign"];
        if  ((NSNull *) POOtherIDType1 == [NSNull null])
            POOtherIDType1 = @"";
		
        if ([POOtherIDType1 isEqualToString:@"YES"])
        {
            siCell.textLabel.textColor = [UIColor grayColor];
            siCell.userInteractionEnabled = NO;
            siCell.titleLabel1.textColor = [UIColor grayColor];
            
            poCell.textLabel.textColor = [UIColor grayColor];
            poCell.userInteractionEnabled = NO;
            poCell.titleLabel1.textColor = [UIColor grayColor];
            
            cffCell.textLabel.textColor = [UIColor grayColor];
            cffCell.userInteractionEnabled = NO;
            cffCell.titleLabel1.textColor = [UIColor grayColor];
            
            eappCell.textLabel.textColor = [UIColor grayColor];
            eappCell.userInteractionEnabled = NO;
            eappCell.titleLabel1.textColor = [UIColor grayColor];
            
        }
        
        else
        {
            siCell.textLabel.textColor = [UIColor blackColor];
            siCell.userInteractionEnabled = YES;
            siCell.titleLabel1.textColor = [UIColor blackColor];
            
            poCell.textLabel.textColor = [UIColor blackColor];
            poCell.userInteractionEnabled = YES;
            poCell.titleLabel1.textColor = [UIColor blackColor];
            
            cffCell.textLabel.textColor = [UIColor blackColor];
            cffCell.userInteractionEnabled = YES;
            cffCell.titleLabel1.textColor = [UIColor blackColor];
            
            eappCell.textLabel.textColor = [UIColor blackColor];
            eappCell.userInteractionEnabled = YES;
            eappCell.titleLabel1.textColor = [UIColor blackColor];
            
        }
        
	}
    
    
    
    
    
    
    
    obj=[DataClass getInstance];
    [self getSys_SIVersio_AND_Trad_UL_Details];
	
	eAppsListing *eAppList = [[eAppsListing alloc]init];
	str_plan = [eAppList GetPlanData:1 :[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
    
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
            
            NSString *aa;
            //  aa = [NSString stringWithFormat:@"Policy Owner: Santhiya Sree   Type:1st Life Assured"];
            
            NSString *potype = [[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"];
            NSString *po_msg;
            NSString *SIclientName = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"];
			
			//NSLog(@"POName: %@, poType: %@", [[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POName"], potype);
            
            if([potype isEqualToString:@"LA1"])
                po_msg = @"1st Life Assured";
            else if([potype isEqualToString:@"LA2"])
                po_msg = @"2nd Life Assured";
            else if([potype isEqualToString:@"PY1"])
                po_msg = @"Payor";
            else if([potype isEqualToString:@"PO"])
                po_msg = @"Policy Owner";
            
			if ([[obj.eAppData objectForKey:@"SecPO"]   objectForKey:@"Confirm_POName"] != nil) {
				aa = [NSString stringWithFormat:@"Policy Owner: %@   Type: %@",[[obj.eAppData objectForKey:@"SecPO"]   objectForKey:@"Confirm_POName"],SIclientName];
			}
			else {
				aa = @"";
			}
            
            
            //UPDATE eApp_Listing table - START
            
            NSString *poname =   [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"];
			NSString *POOtherID =   [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POOtherID"];
            NSString *ic =   [[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POIC"];
            NSString *proposalno =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
			NSString *ProspectID = @"";
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath = [paths objectAtIndex:0];
            NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
            
            
            
            FMDatabase *database = [FMDatabase databaseWithPath:path];
            if (![database open]) {
                NSLog(@"Could not open db.");
            }
            
            [database open];
            
            //  executeQuery
            
            NSString *querySQL = [NSString stringWithFormat:@"select IndexNo from prospect_profile where ProspectName = '%@'", poname];
            
            FMResultSet *results =  [database executeQuery:querySQL];
            
            while ([results next]) {
                
                ProspectID = [results objectForColumnIndex:0];
                
                
            }
            //NSLog(@"idtype: %@", [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"POOtherIDTypeNo"]);
			
            //			if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"POFlag"] isEqualToString:@"Y"]) {
            //            [database executeUpdate:@"Update eApp_Listing SET ClientProfileID = ?, POName = ? , IDNumber = ?, OtherIDNo = ?  WHERE ProposalNo = ? ",ProspectID, poname, ic, POOtherID, proposalno];
            //			}
			
			NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
			NSDate *currDate = [NSDate date];
			[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
			NSString *dateString = [dateFormatter2 stringFromDate:currDate];
			
			if ([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POName"] != Nil) {
				[database executeUpdate:@"Update eApp_Listing SET ClientProfileID = ?, POName = ? , IDNumber = ?, OtherIDNo = ? , DateUpdated = ? WHERE ProposalNo = ? ",ProspectID, poname, ic, POOtherID, dateString, proposalno];
			}
            
            
            
            //UPDATE eApp_Listing table - END
            
            poCell.descriptionLabel1.text = aa;
			
			BOOL complete;
            //			FMDatabase *db = [FMDatabase databaseWithPath:path];
            //			[db open];
			
			//Check eProposal_LA_details got all data to consider Policy Owner as complete.
			
            //			int count1 = 0;
            //			int count2 = 0;
            //			FMResultSet *result2 = [database executeQuery:@"SELECT LARelationship from eProposal_LA_Details WHERE eProposalNo = ?", proposalno];
            //
            //			while ([result2 next]) {
            //				count1 = count1 + 1;
            //				NSString *LARelationship = [result2 objectForColumnName:@"LARelationship"];
            //				if (![LARelationship isEqualToString:@""]){
            //					count2 = count2 + 1;
            //				}
            //			}
			[self CheckPO];
			
			UIImage *doneImage;
			if (PO_DONE){
				complete = YES;
				doneImage = [UIImage imageNamed: @"iconComplete.png"];
                poCellCompletebool=YES;
			}
			else {
				complete = NO;
				doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
                poCellCompletebool=NO;
			}
			
            // UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [poCell.statusImage1 setImage:doneImage];
            
            
            [database close];
            
            //********************START XML
            SecPo_LADetails_ClientNew_Array = [[NSMutableArray alloc]init]; //for XML DATA
            
            NSDictionary *eAppNo = [[NSDictionary alloc]init];
            eAppNo = @{@"eProposalNo":proposalno};
            
            [SecPo_LADetails_ClientNew_Array addObject:eAppNo];
            
            
            [self storeXMLData_AssuredInfo];
            
            [self storeProposalXML];
            [self StoreXMLdata_AgentProfile];
            // [self storeCFFXMLData:cffID];
            
            [self edit_eApp];
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:SecPo_LADetails_ClientNew_Array forKey:@"AssuredInfo"];
            
            
            
            
            //*********************END XML
            
        }
        
        
        
        if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
            if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] != Nil){
                
                NSString *aa;
                aa = [NSString stringWithFormat:@"Customer: %@  CFF Updated: %@", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFDate"]];
                cffCell.descriptionLabel1.text = aa;
                // if ([[[obj.eAppData objectForKey:@"CFF"] objectForKey:@"Completed"] isEqualToString:@"1"]) {
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [cffCell.statusLabel1 setImage:doneImage];
                cffCellCompletebool=YES;
                // }
                //NSLog(@)
            }
        }
        
        if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"CFFSelected"] != Nil) {
            // NSLog(@"CFF is selected - %@", [[obj.eAppData objectForKey:@"CFF"] objectForKey:@"Completed"]);
            
        }
        
        // NSLog(@"secA:%@, secB: %@, secC: %@, secE: %@, secF: %@, secG: %@",[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"], [[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"], [[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"], [[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"], [[obj.eAppData objectForKey:@"SecF"] objectForKey:@"SecF_Saved"], [[obj.eAppData objectForKey:@"SecG"] objectForKey:@"SecG_Saved"]);
        if([[[obj.eAppData objectForKey:@"SecA"] objectForKey:@"SecA_Saved"] isEqualToString:@"Y"] &&
           [[[obj.eAppData objectForKey:@"SecB"] objectForKey:@"SecB_Saved"] isEqualToString:@"Y"] &&
           [[[obj.eAppData objectForKey:@"SecC"] objectForKey:@"SecC_Saved"] isEqualToString:@"Y"] &&
           [[[obj.eAppData objectForKey:@"SecE"] objectForKey:@"SecE_Saved"] isEqualToString:@"Y"] &&
           [[[obj.eAppData objectForKey:@"SecF"] objectForKey:@"SecF_Saved"] isEqualToString:@"Y"] &&
           [[[obj.eAppData objectForKey:@"SecG"] objectForKey:@"SecG_Saved"] isEqualToString:@"Y"])
        {
            [[obj.eAppData objectForKey:@"EAPP"]  setValue:@"Y" forKey:@"Proposal_Confirmation"];
            
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
            FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
            if (![db open]) {
                NSLog(@"Could not open db.");
            }
            
            [db open];
            
            [db executeUpdate:@"UPDATE eProposal SET ProposalCompleted = ? WHERE eProposalNo = ?",
             [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"Proposal_Confirmation"],
             [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
            
            
            
            [db close];
        }
        
        
        if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] != Nil && ![[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] isEqualToString:@"N"]){
            NSString *aa;
            aa = [NSString stringWithFormat:@"Proposal form confirmed"];
            
            eappCell.descriptionLabel1.text = aa;
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [eappCell.statusLabel1 setImage:doneImage];
            //NSLog(@)
            eappCellCompletebool=YES;
        }
        
        
        
        
        
        //        // to check if everyone have signed.
        //        BOOL allSigned=YES;
        //        for (NSString *key in [GetProposalObject(proposalNumber)allKeys]) {
        //            if ([[GetProposalObject(proposalNumber)objectForKey:key]boolValue]==NO) {
        //                allSigned = NO;
        //            }
        //        }
        //        if (allSigned) {
        //
        //            NSString *aa;
        //            aa = [NSString stringWithFormat:@"Proposal form confirmed"];
        //
        //            eappCell.descriptionLabel1.text = aa;
        //            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
        //            [eappCell.statusLabel1 setImage:doneImage];
        //
        //        }
        
        
    }
    
    //    appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //
    //    NSString *proposalform122 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    //
    //    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"] isKindOfClass:[NSString class]])
    //    {
    //        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CompareSign"];
    //        [[NSUserDefaults standardUserDefaults] synchronize];
    //    }
    //    //
    //
    //    NSArray *array1=[[NSUserDefaults standardUserDefaults] objectForKey:@"CompareSign"];
    //    if ([array1 containsObject:proposalform122])
    //    {
    //        UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
    //
    //        [esignCell.statusLabel1 setImage:doneImage];
    //    }
    //    else{
    //        UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
    //
    //        [esignCell.statusLabel1 setImage:doneImage];
    //    }
    
    NSArray *paths11 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths11 objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    NSMutableArray *dataItems;
    
	NSString *potype = [[obj.eAppData objectForKey:@"SecPO"]  objectForKey:@"Confirm_POType"];
	NSLog(@"type %@", potype);
    
    
    
	
	if (potype == NULL || potype == nil)
		potype = @"";
    
    if ([potype isEqualToString:@"PY1"])
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]])
        {
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            
            [supportingcell.statusLabel1 setImage:doneImage];
			TickYES=YES;
            supportingCompletebool=YES;
            [self reloadTableData];
            
        }
        
        
    }
    
	
	if ([potype isEqualToString:@"LA1"]) {
		if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] || [[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] )
		{
			UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
			
			[supportingcell.statusLabel1 setImage:doneImage];
			TickYES=YES;
			supportingCompletebool=YES;
		}
	}
	else {
		if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_LA1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] && [[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_ID_PO.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]] )
		{
			UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
			
			[supportingcell.statusLabel1 setImage:doneImage];
			TickYES=YES;
			supportingCompletebool=YES;
		}
    }
    
    
    
    [self reloadTableData];
    //	[self storeXMLData_AssuredInfo];
    
}

-(void)testingAttack
{
    
    
    NSString *displayThis = nil;
    displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    if (displayThis ==nil) {
        displayThis = @"";
    }
    [self viewDidAppear:YES];
    
    //    proposalNo_display =[[UILabel alloc]initWithFrame:CGRectMake(700,70, 930, 20)];
    //    proposalNo_display.backgroundColor =[UIColor clearColor];
    //    proposalNo_display.font =[UIFont systemFontOfSize:15];
    //    proposalNo_display.textColor =[UIColor darkGrayColor];
    //    proposalNo_display.text =[NSString stringWithFormat:@"Proposal Number: %@",displayThis];
    //    proposalNo_display.hidden =NO;
    //    [self.view addSubview:self.proposalNo_display];
    
    NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
    // [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"]
	NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath1 = [paths1 objectAtIndex:0];
	NSString *path1 = [docsPath1 stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db1 = [FMDatabase databaseWithPath:path1];
	[db1 open];
	
    NSString *eProposalNo1 = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
    NSString *selectPO1 = [NSString stringWithFormat:@"SELECT isPOSign FROM eProposal_Signature WHERE eProposalNo = '%@'",eProposalNo1];
	NSString *POOtherIDType1;
    //	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
	
	FMResultSet *results1;
	results1 = [db1 executeQuery:selectPO1];
	while ([results1 next])
    {
		POOtherIDType1 = [results1 objectForColumnName:@"isPOSign"];
        if  ((NSNull *) POOtherIDType1 == [NSNull null])
            POOtherIDType1 = @"";
		
        if ([POOtherIDType1 isEqualToString:@"YES"])
            if ([POOtherIDType1 isEqualToString:@"YES"])
            {
                siCell.textLabel.textColor = [UIColor grayColor];
                siCell.userInteractionEnabled = NO;
                siCell.titleLabel1.textColor = [UIColor grayColor];
                
                poCell.textLabel.textColor = [UIColor grayColor];
                poCell.userInteractionEnabled = NO;
                poCell.titleLabel1.textColor = [UIColor grayColor];
                
                cffCell.textLabel.textColor = [UIColor grayColor];
                cffCell.userInteractionEnabled = NO;
                cffCell.titleLabel1.textColor = [UIColor grayColor];
                
                eappCell.textLabel.textColor = [UIColor grayColor];
                eappCell.userInteractionEnabled = NO;
                eappCell.titleLabel1.textColor = [UIColor grayColor];
                
            }
        
            else
            {
                siCell.textLabel.textColor = [UIColor blackColor];
                siCell.userInteractionEnabled = YES;
                siCell.titleLabel1.textColor = [UIColor blackColor];
                
                poCell.textLabel.textColor = [UIColor blackColor];
                poCell.userInteractionEnabled = YES;
                poCell.titleLabel1.textColor = [UIColor blackColor];
                
                cffCell.textLabel.textColor = [UIColor blackColor];
                cffCell.userInteractionEnabled = YES;
                cffCell.titleLabel1.textColor = [UIColor blackColor];
                
                eappCell.textLabel.textColor = [UIColor blackColor];
                eappCell.userInteractionEnabled = YES;
                eappCell.titleLabel1.textColor = [UIColor blackColor];
                
            }
        
	}
    
}

- (void) confirmUnconfirmBtnView {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
	
	NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
	
	NSString *CheckProposal = [NSString stringWithFormat:@"SELECT status from eApp_Listing WHERE ProposalNo = '%@'",eProposalNo];
	
	FMResultSet *results;
	results = nil;
	results = [db executeQuery:CheckProposal];
	NSString *status;
	
	while ([results next]) {
		status = [results objectForColumnName:@"status"];
	}
	
	//Status Note: 2 = Created, 3 = confirmed, 4 = Submitted, 7 = Received, 6 = Failed
	
	if( [status isEqualToString:@"2"])
	{
		//confirmCell.unconfirmBtn.hidden = TRUE;
		//confirmCell.unconfirmBtn.enabled = FALSE;
		confirmCell.confirmBtn.hidden = FALSE;
		confirmCell.confirmBtn.enabled = TRUE;
		
		//[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Created" forKey:@"ProposalStatus"];
		
	}
	else {
		//confirmCell.unconfirmBtn.hidden = TRUE;
		//confirmCell.unconfirmBtn.enabled = FALSE;
		confirmCell.confirmBtn.hidden = TRUE;
		confirmCell.confirmBtn.enabled = FALSE;
		
		//[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Confirmed" forKey:@"ProposalStatus"];
	}
	
	[results close];
	[db close];
}

- (void)CheckPO {
	
	PO_DONE = FALSE;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
	
	NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
	NSString *LARelationship;
	NSString *PTypeCode;
	NSString *POFlag;
	
	int countRel1 = 0;
	int countRel2 = 0;
	int countPoFlag = 0;
	NSString *selectPO = [NSString stringWithFormat:@"SELECT LARelationship, POFlag, PTypeCode FROM eProposal_LA_Details WHERE eProposalNo = '%@'",eProposalNo];
	
	FMResultSet *results;
	results = nil;
	results = [db executeQuery:selectPO];
	while ([results next]) {
		countRel1 = countRel1 + 1;
		LARelationship = [results objectForColumnName:@"LARelationship"];
		PTypeCode = [results objectForColumnName:@"PTypeCode"];
		POFlag = [results objectForColumnName:@"POFlag"];
		if (![LARelationship isEqualToString:@""]){
			countRel2 = countRel2 + 1;
		}
		if ([POFlag isEqualToString:@"Y"]){
			countPoFlag = countPoFlag + 1;
		}
	}
	if ((countRel1 == countRel2) && countPoFlag != 0) {
		PO_DONE = TRUE;
	}
	else
		PO_DONE = FALSE;
	
	[db close];
}

-(NSString*) getTitleCode : (NSString*)title passdb:(FMDatabase*)db
{
	if ([title isEqualToString:@""] || (title == NULL) || ([title isEqualToString:@"(NULL)"])) {
		return @"";
	}
    NSString *code;
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
    FMResultSet *result = [db executeQuery:@"SELECT TitleCode FROM eProposal_Title WHERE TitleDesc = ?", title];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code = [result objectForColumnName:@"TitleCode"];
    }
    
    [result close];
	// [db close];
	
	if (count == 0) {
		code = title;
	}
    
    return code;
    
}

-(NSString*) getIdTypeCode : (NSString*)idtype passdb:(FMDatabase*)db
{
	if ([idtype isEqualToString:@""] || (idtype == NULL) || ([idtype isEqualToString:@"(NULL)"]) || ([idtype isEqualToString:@"- SELECT -"]) || ([idtype isEqualToString:@"- Select -"])) {
		return @"";
	}
    NSString *code;
    idtype = [idtype stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
    FMResultSet *result = [db executeQuery:@"SELECT IdentityCode FROM eProposal_identification WHERE IdentityDesc = ?", idtype];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code = [result objectForColumnName:@"IdentityCode"];
    }
    
    [result close];
	// [db close];
	
	if (count == 0) {
		code = idtype;
	}
    
    return code;
    
}

-(NSString*) getStateCode : (NSString*)state passdb:(FMDatabase*)db
{
	if ([state isEqualToString:@""] || (state == NULL) || ([state isEqualToString:@"(NULL)"]) || ([state isEqualToString:@"- SELECT -"]) || ([state isEqualToString:@"- Select -"])) {
		return @"";
	}
    NSString *code;
    state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
    FMResultSet *result = [db executeQuery:@"SELECT StateCode FROM eProposal_State WHERE StateDesc = ?", state];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code = [result objectForColumnName:@"StateCode"];
    }
    
    [result close];
	// [db close];
	
	if (count == 0) {
		code = state;
	}
    
    return code;
    
}

-(NSString*) getCountryCode : (NSString*)country passdb:(FMDatabase*)db
{
	if ([country isEqualToString:@""] || (country == NULL) || ([country isEqualToString:@"(NULL)"]) || ([country isEqualToString:@"- SELECT -"]) || ([country isEqualToString:@"- Select -"])) {
		return @"";
	}
    NSString *code;
    country = [country stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
	if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
    FMResultSet *result = [db executeQuery:@"SELECT CountryCode FROM eProposal_Country WHERE CountryDesc = ?", country];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code = [result objectForColumnName:@"CountryCode"];
    }
    
    [result close];
	// [db close];
	
	if (count == 0) {
		code = country;
	}
    
    return code;
    
}

-(NSString*) getNationalityCode : (NSString*)nationality passdb:(FMDatabase*)db
{
	
	if ([nationality isEqualToString:@""] || (nationality == NULL) || ([nationality isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    nationality = [nationality stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
    FMResultSet *result = [db executeQuery:@"SELECT NationCode FROM eProposal_Nationality WHERE NationDesc = ?", nationality];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"NationCode"];
    }
    
    [result close];
    //    [db close];
    
	if (count == 0) {
		code = nationality;
	}
	
    return code;
    
}

-(NSString*) getMaritalStatusCode : (NSString*)Marital passdb:(FMDatabase*)db
{
	
	if ([Marital isEqualToString:@""] || (Marital == NULL) || ([Marital isEqualToString:@"(NULL)"])) {
		return @"";
	}
	
    NSString *code;
    Marital = [Marital stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
    
    if (![db open]) {
        NSLog(@"Could not open db.");
        db = [FMDatabase databaseWithPath:databasePath];
        
        [db open];
    }
	
    FMResultSet *result = [db executeQuery:@"SELECT MSCode FROM eProposal_Marital_Status WHERE MSDesc = ?", Marital];
    
	NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        code =[result objectForColumnName:@"MSCode"];
    }
    
    [result close];
	//    [db close];
    
	if (count == 0) {
		code = Marital;
	}
	
    return code;
    
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

-(BOOL)showConfromButton{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
	
	NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
	NSString *POOtherIDType;
	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
	
	FMResultSet *results;
	results = nil;
	results = [db executeQuery:selectPO];
	while ([results next]) {
		POOtherIDType = [results objectForColumnName:@"LAOtherIDType"];
	}
    
    NSString *formsGenerate=[[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    updateAllTaleCells=NO;
    if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] == NULL)
    {
        updateAllTaleCells=NO;
    }
    
    //else if ([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POType"] == NULL)
	else if (!PO_DONE)
    {
        updateAllTaleCells=NO;
    }
    else if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] == NULL && ![POOtherIDType isEqualToString:@"CR"])
    {
        updateAllTaleCells=NO;
    }
    
    else if([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] == NULL || ![[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] isEqualToString:@"Y"]) {
        
        updateAllTaleCells=NO;
    }
    
    else if(![[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
        
        UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
        
        
        
        [reportCell.statusLabel1 setImage:doneImage];
        reportCellCompletebool=NO;
        
        updateAllTaleCells=NO;
        
        
    }
    
    else if(![self checkrefresheSigndata]){
        
        
        updateAllTaleCells=NO;
        
    }
    else if(![self checkforSnapData]){
        
        
        updateAllTaleCells=NO;
        
    }
    else{
        updateAllTaleCells=YES;
    }
    return updateAllTaleCells;
}

- (IBAction)confirmBtnClicked:(id)sender {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
	
	FMDatabase *db = [FMDatabase databaseWithPath:path];
	[db open];
	
	NSString *eProposalNo = [[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"];
	NSString *POOtherIDType;
	NSString *selectPO = [NSString stringWithFormat:@"SELECT LAOtherIDType FROM eProposal_LA_Details WHERE eProposalNo = '%@' AND POFlag = 'Y'",eProposalNo];
	
	FMResultSet *results;
	results = nil;
	results = [db executeQuery:selectPO];
	while ([results next]) {
		POOtherIDType = [results objectForColumnName:@"LAOtherIDType"];
	}
    
    NSString *formsGenerate=[[NSUserDefaults standardUserDefaults]objectForKey:@"data"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    if ([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"] == NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Sales Illustration." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
    
    //else if ([[obj.eAppData objectForKey:@"SecPO"] objectForKey:@"Confirm_POType"] == NULL)
	else if (!PO_DONE)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Policy Owner." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
    else if ([[obj.eAppData objectForKey:@"CFF"] objectForKey:@"CustomerCFF"] == NULL && ![POOtherIDType isEqualToString:@"CR"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please select Customer Fact Find." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
    
    else if([[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] == NULL || ![[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Proposal_Confirmation"] isEqualToString:@"Y"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please complete Proposal Form." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
    else if(![[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please generate Forms." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    }
    
    else {
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"No amendment is allowed after confirmation. Do you want to continue?" delegate:(id)self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        //		NSLog(@"no title");
        alert.tag = 11;
        [alert show];
        
    }
    NSString *eAppVersion;
	results2 = Nil;
    results2 = [db executeQuery:@"select * from eProposal_Version_Details", Nil];
    while ([results2 next]) {
        eAppVersion = [results2 stringForColumn:@"eAppVersion"];
    }
	
	NSString *queryA = @"";
	queryA = [NSString stringWithFormat:@"UPDATE eProposal SET eAppVersion = '%@' WHERE eProposalNo = '%@'", eAppVersion, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalID"]];
	[db executeUpdate:queryA];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        if (buttonIndex==0)
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Proposal had been confirmed." delegate:(id)self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //		NSLog(@"no title");
            alert.tag = 12;
            [alert show];
            //alert = nil;
            
            confirmStatus=YES;
            
            [[NSUserDefaults standardUserDefaults]setBool:confirmStatus forKey:@"confirmed"];
            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"data"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            
            // confirmCell.unconfirmBtn.hidden = FALSE;
            // confirmCell.unconfirmBtn.enabled = TRUE;
            //confirmCell.confirmBtn.hidden = TRUE;
            //confirmCell.confirmBtn.enabled = FALSE;
            confirmCell.hidden=TRUE;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath = [paths objectAtIndex:0];
            NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
            
            FMDatabase *database = [FMDatabase databaseWithPath:path];
            if (![database open]) {
                NSLog(@"Could not open db.");
            }
            
			NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
			NSDate *currDate = [NSDate date];
			[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
			NSString *dateString = [dateFormatter2 stringFromDate:currDate];
			
            [database open];
            bool done = [database executeUpdate:@"Update eApp_Listing SET Status = 3, DateUpdated = ? Where ProposalNo = ?", dateString, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
            if (!done) {
                NSLog(@"Error: %@", [database lastErrorMessage]);
            }
            else if (done)
            {
                if (![obj.eAppData objectForKey:@"Proposal"])
                {
                    [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"Proposal"];
					[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Confirmed" forKey:@"ProposalStatus"];
                    
                }
                NSLog(@"Update Confirmed Success");
            }
            
            
        }
        else
        {
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docsPath = [paths objectAtIndex:0];
            NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
            
            FMDatabase *database = [FMDatabase databaseWithPath:path];
            if (![database open]) {
                NSLog(@"Could not open db.");
            }
            
            [database open];
			
			NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
			NSDate *currDate = [NSDate date];
			[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
			NSString *dateString = [dateFormatter2 stringFromDate:currDate];
            
            bool done = [database executeUpdate:@"Update eApp_Listing SET Status = 2, DateUpdated = ? Where ProposalNo = ?", dateString, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
            if (!done) {
                NSLog(@"Error: %@", [database lastErrorMessage]);
            }
            else if (done) {
                if (![obj.eAppData objectForKey:@"Proposal"]) {
                    [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"Proposal"];
                }
                [[obj.eAppData objectForKey:@"Proposal"] setValue:@"N" forKey:@"Confirmation"];
                NSLog(@"Update Unconfirmed Success");
            }
            
        }
    }
    if (alertView.tag==12)
    {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }
}
- (IBAction)unconfirmBtnClicked:(id)sender {
    // confirmCell.unconfirmBtn.hidden = TRUE;
    //confirmCell.unconfirmBtn.enabled = FALSE;
    confirmCell.confirmBtn.hidden = FALSE;
    confirmCell.confirmBtn.enabled = TRUE;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    if (![database open]) {
        NSLog(@"Could not open db.");
    }
    
	NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
	NSDate *currDate = [NSDate date];
	[dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
	NSString *dateString = [dateFormatter2 stringFromDate:currDate];
	
    [database open];
    bool done = [database executeUpdate:@"Update eApp_Listing SET Status = 2, DateUpdated = ? Where ProposalNo = ?", dateString, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
    if (!done) {
        NSLog(@"Error: %@", [database lastErrorMessage]);
    }
    else if (done) {
        if (![obj.eAppData objectForKey:@"Proposal"]) {
            [obj.eAppData setValue:[NSMutableDictionary dictionary] forKey:@"Proposal"];
        }
        [[obj.eAppData objectForKey:@"Proposal"] setValue:@"N" forKey:@"Confirmation"];
		[[obj.eAppData objectForKey:@"EAPP"] setValue:@"Created" forKey:@"ProposalStatus"];
        NSLog(@"Update Unconfirmed Success");
    }
}

- (NSDictionary *) populateSIXMLData
{
    
    obj = [DataClass getInstance];
    
    
    NSString *SIVersion =@"";
    
    NSString *sino = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    NSString *eproposalNo =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    
    NSString *eAppVersion = @"";
    
    NSString *SystemName = @"";
    
    NSString *SIType = @"";
    
    NSString *CommencementDate = @"";
    
    NSString *PaymentMode_Trad = @"";
    
    NSString *GYIOption = @"";
    NSString *BasicPlanCode = @"";
    
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	FMResultSet *results;
    
    
    
    results = [database executeQuery:@"SELECT SIType, SIVersion,BasicPlanCode, eAppVersion, CreatedAt, PaymentMode, SystemName from eProposal WHERE eProposalNo = ?",eproposalNo];
    
	while ([results next]) {
        
        SIType = [results stringForColumn:@"SIType"];
        
        BasicPlanCode = [results stringForColumn:@"BasicPlanCode"];
        
        SIVersion = [results stringForColumn:@"SIVersion"];
        
        eAppVersion = [results stringForColumn:@"eAppVersion"];
        
        SystemName = [results stringForColumn:@"SystemName"];
        
        CommencementDate = [results stringForColumn:@"CreatedAt"];
        
        PaymentMode_Trad  = [results stringForColumn:@"PaymentMode"];
        
        
        if  ((NSNull *) CommencementDate == [NSNull null])
            CommencementDate = @"";
        
        if  ((NSNull *) eproposalNo == [NSNull null])
            eproposalNo = @"";
        if  ((NSNull *) sino == [NSNull null])
            sino = @"";
        
        if  ((NSNull *) eAppVersion == [NSNull null])
            eAppVersion = @"";
        if  ((NSNull *) PaymentMode_Trad == [NSNull null])
            PaymentMode_Trad = @"";
        
        
    }
    
    
    //********************** GET AGENT CODE ***********************
    
    FMResultSet *result_agent;
    
    
    result_agent = [database executeQuery:@"SELECT AgentCode, AgentName, AgentContactNumber from Agent_profile WHERE IndexNo = 1"];
    NSString *AgentCode   = @"";
    NSString *AgentName   = @"";
    NSString *AgentContactNo   = @"";
    
    while ([result_agent next]) {
        AgentCode  = [result_agent stringForColumn:@"AgentCode"];
        AgentName  = [result_agent stringForColumn:@"AgentName"];
        AgentContactNo  = [result_agent stringForColumn:@"AgentContactNumber"];
        
        if  ((NSNull *) AgentContactNo == [NSNull null])
            AgentContactNo = @"";
        if ([AgentContactNo isEqualToString:@"nil"]){
            AgentContactNo = @"";
        }
    }
    
    
    
    //*********************** START  GET SI Basic Plan   **************************
    
    
    NSString *PTypeCode;
    NSString *Seq;
    NSString *PlanCode;
    NSString *PlanOption;
    NSString *SumAssured;
    NSString *CoverageUnit;
    NSString *CoverageTerm;
    NSString *PayingTerm;
    NSString *PaymentMode;
    NSString *PaymentAmount;
    NSString *Deductible;
    NSString *WOP =@"";
    NSString *PaidUpOption = @"";
    NSString *PaidUpTerm = @"";
    
    FMResultSet *result2;
    
    FMResultSet *result_paymentAmount;
    
    NSString *mode = @"";
    
    
    if([SIType isEqualToString:@"TRAD"])
    {
        PlanCode = BasicPlanCode;
        PlanOption = @"";
        CoverageUnit = @"";
        Deductible = @"0";
        result2 = [database executeQuery:@"SELECT PTypeCode, BasicSA, PolicyTerm, PremiumPaymentOption, Deductible from Trad_Details WHERE SINo = ?",sino];
        
        while ([result2 next]) {
            PTypeCode  = [result2 stringForColumn:@"PTypeCode"];
            CoverageTerm  = [result2 stringForColumn:@"PolicyTerm"];
            SumAssured  = [result2 stringForColumn:@"BasicSA"];
            CoverageTerm  = [result2 stringForColumn:@"PolicyTerm"];
            PayingTerm  = [result2 stringForColumn:@"PremiumPaymentOption"];
            
            if([result2 stringForColumn:@"PremiumPaymentOption"] == NULL || [result2 stringForColumn:@"PremiumPaymentOption"] == nil || [[result2 stringForColumn:@"PremiumPaymentOption"] isEqualToString:@"(null)" ])
                Deductible = @"0";
            
            
        }
        
        
        //PaymentMode_Trad = @"Annual";
        
        if([PaymentMode_Trad isEqualToString:@"Annual"])
        {
            
            result_paymentAmount =  [database executeQuery:@"SELECT  Annually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B' and SemiAnnually IS NOT NULL",sino];
            mode = @"Annually";
            PaymentMode = @"12";
        }
        
        else if([PaymentMode_Trad isEqualToString:@"SemiAnnual"])
        {
            
            result_paymentAmount =  [database executeQuery:@"SELECT  SemiAnnually FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B' and SemiAnnually IS NOT NULL",sino];
            mode = @"SemiAnnually";
            PaymentMode = @"06";
        }
        
        else if([PaymentMode_Trad isEqualToString:@"Quarterly"])
        {
            
            result_paymentAmount =  [database executeQuery:@"SELECT  Quarterly FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B' and SemiAnnually IS NOT NULL",sino];
            mode = @"Quarterly";
            PaymentMode = @"03";
        }
        
        else if([PaymentMode_Trad isEqualToString:@"Monthly"])
        {
            
            result_paymentAmount =  [database executeQuery:@"SELECT  Monthly FROM SI_Store_premium WHERE SiNo = ? AND Type = 'B' and SemiAnnually IS NOT NULL",sino];
            mode = @"Monthly";
            PaymentMode = @"01";
            
        }
        
        while ([result_paymentAmount next]) {
            
            PaymentAmount = [result_paymentAmount stringForColumn:mode];
        }
        
        
        
    }
    else if([SIType isEqualToString:@"ES"])
    {
        
        PlanCode = @"UV";
        PlanOption = @"";
        CoverageUnit = @"";
        PTypeCode  = @"LA"; //MUST BE LA1
        Deductible = @"0";
        CoverageUnit = @"";
        result2 = [database executeQuery:@"SELECT CovPeriod, BasicSA, ATPrem, BUMPMode from UL_Details WHERE SINo = ?",sino];
        
        while ([result2 next]) {
            
            
            SumAssured  = [result2 stringForColumn:@"BasicSA"];
            CoverageTerm  = [result2 stringForColumn:@"CovPeriod"];
            PayingTerm  = [result2 stringForColumn:@"CovPeriod"];
            PaymentAmount = [result2 stringForColumn:@"ATPrem"];
            PaymentMode = [result2 stringForColumn:@"BUMPMode"];
            
            if([result2 stringForColumn:@"BUMPMode"] == NULL || [result2 stringForColumn:@"BUMPMode"] == nil || [[result2 stringForColumn:@"BUMPMode"] isEqualToString:@"(null)" ])
                PaymentMode = @"";
            
            if([result2 stringForColumn:@"ATPrem"] == NULL || [result2 stringForColumn:@"ATPrem"] == nil || [[result2 stringForColumn:@"ATPrem"] isEqualToString:@"(null)" ])
                PaymentAmount = @"";
            
        }
        
        
        
    }
    
    if (((NSNull *)PaymentAmount == [NSNull null]) || (PaymentAmount == nil) || ([PaymentAmount isEqualToString:@"nil"]))
    {
        PaymentAmount = @"";
    }
    if (((NSNull *)PaymentMode == [NSNull null]) || (PaymentMode == nil) || ([PaymentMode isEqualToString:@"nil"]))
    {
        PaymentMode = @"";
    }
    
    NSDictionary *SIbasicPlan;
    SIbasicPlan = [[NSDictionary alloc] init];
    PaymentAmount = [PaymentAmount stringByReplacingOccurrencesOfString:@"," withString:@""];
    SIbasicPlan = @{    @"PlanType" : @"B",
                        @"PTypeCode" : PTypeCode,
                        @"Seq" : @"1",
                        @"PlanCode" : PlanCode,
                        @"PlanOption" : PlanOption,
                        @"SumAssured" : SumAssured,
                        @"CoverageUnit" : CoverageUnit,
                        @"CoverageTerm" : CoverageTerm,
                        @"PayingTerm" : PayingTerm,
                        @"PaymentMode" : PaymentMode,
                        @"PaymentAmount" : PaymentAmount,
                        @"Deductible" : Deductible
                        };
    
    
    
    //*********************** END    GET SI Basic Plan  **************************
    
    
    
    //*********************** START  GET SI Parties  **************************
    
    NSDictionary  *party_LA1 = [[NSDictionary alloc]init];
    NSDictionary  *party_LA2 = [[NSDictionary alloc]init];
    NSDictionary  *party_PY1 = [[NSDictionary alloc]init];
    
    int count_LA1 = 0;
    
    int count_LA2 = 0;
    
    int count_PY1 = 0;
    
    //*********************** END    GET SI Parties **************************
    
    
    //*********************** START   GET PARTIES RIDERS INFO   **************************
    int riders_count=0;
    int riders_count2=0;
    int riders_count3=0;
    
    NSMutableArray *riders_LA1 = [[NSMutableArray alloc] init];
    NSDictionary *rider_LA1 = [[NSDictionary alloc] init];
    
    
    NSMutableArray *riders_LA2 = [[NSMutableArray alloc] init];
    NSDictionary *rider_LA2 = [[NSDictionary alloc] init];
    
    
    NSMutableArray *riders_PY1 = [[NSMutableArray alloc] init];
    NSDictionary *rider_PY1 = [[NSDictionary alloc] init];
    
    
    
    FMResultSet *results3;
    
    if([SIType isEqualToString:@"TRAD"])
        
        results3 = [database executeQuery:@"SELECT PTypeCode, Seq, RiderCode, PlanOption, SumAssured, Units, RiderTerm, Deductible, PayingTerm from Trad_Rider_Details WHERE SINO = ?",sino];
    
    else if([SIType isEqualToString:@"ES"])
        
        results3 = [database executeQuery:@"SELECT A.PTypeCode, A.Seq, A.RiderCode, A.PlanOption, A.SumAssured, A.Units, A.RiderTerm, A.Deductible, A.Premium, A.GYIYear,  B.BumpMode from UL_Rider_Details AS A , UL_Details AS B WHERE A.SINO = ? and A.SINO = B.SINO",sino];
    
    
    
	while ([results3 next]) {
        
        Seq = [results3 stringForColumn:@"Seq"];
        
        PTypeCode = [results3 stringForColumn:@"PTypeCode"];
        
        
        
        if([PTypeCode isEqualToString:@"LA"] && [Seq isEqualToString:@"1"])
        {
            count_LA1 = count_LA1+1;
            
            riders_count = riders_count+1;
            NSString *count = [NSString stringWithFormat:@"%i", riders_count];
            
            NSString *ridercode = [results3 stringForColumn:@"RiderCode"];
            
            
            NSString *SumAssured = [results3 stringForColumn:@"SumAssured"];
            SumAssured = [SumAssured stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
            PlanOption = [results3 stringForColumn:@"PlanOption"];
            
            if([PlanOption isEqualToString:@"(null)"] || PlanOption==NULL)
                PlanOption = @"";
            
            
            
            NSString *unit = [results3 stringForColumn:@"Units"];
            
            if([unit isEqualToString:@"0"] || unit==NULL)
                unit = @"";
            
            CoverageTerm = [results3 stringForColumn:@"RiderTerm"];
            
            PayingTerm = [results3 stringForColumn:@"PayingTerm"];
            if (((NSNull *)PayingTerm == [NSNull null]) || (PayingTerm == nil))
            {
                PayingTerm = @"0";
            }
            
            if([PlanCode isEqualToString:@"ETPDB"] || [PlanCode isEqualToString:@"EDB"])
                PayingTerm = @"6";
            
            
            
            Deductible = [results3 stringForColumn:@"Deductible"];
            
            if([Deductible isEqualToString:@"(null)"] || Deductible==NULL)
                Deductible = @"0";
            
            if([SIType isEqualToString:@"ES"])
            {
                NSString *bumpmode   = [results3 stringForColumn:@"BumpMode"];
                
                GYIOption   = [results3 stringForColumn:@"GYIYear"];
                if(GYIOption==NULL)
                    GYIOption = @"";
                
                if([bumpmode isEqualToString:@"A"])
                    PaymentMode = @"12";
                else if([bumpmode isEqualToString:@"S"])
                    PaymentMode = @"06";
                else if([bumpmode isEqualToString:@"Q"])
                    PaymentMode = @"03";
                else if([bumpmode isEqualToString:@"M"])
                    PaymentMode = @"01";
                
                WOP = SumAssured;
                
                
                if([ridercode isEqualToString:@"ECAR"] || [ridercode isEqualToString:@"ECAR6"] || [ridercode isEqualToString:@"ECAR60"])
                {
                    
                    
                    NSString *query = [NSString stringWithFormat:@"SELECT PaidUp, Years from eProposal_Riders WHERE eProposalNo = '%@' AND RiderCode = '%@' ",eproposalNo, ridercode];
                    
                    FMResultSet *results_PaidUp = [database executeQuery:query];
                    
                    while ([results_PaidUp next]) {
                        PaidUpOption = [results_PaidUp stringForColumn:@"PaidUp"];
                        PaidUpTerm  = [results_PaidUp stringForColumn:@"Years"];
                        
                    }
                    
                }
                
            }
            else if([SIType isEqualToString:@"TRAD"])
            {
                
                NSString *waiver = @"";
                
                if([mode isEqualToString:@"Annually"])
                    waiver = @"WaiverSAAnnual";
                else if([mode isEqualToString:@"SemiAnnually"])
                    waiver = @"WaiverSASemi";
                else if([mode isEqualToString:@"Quarterly"])
                    waiver = @"WaiverSAQuarter";
                else if([mode isEqualToString:@"Monthly"])
                    waiver = @"WaiverSAMonth";
                
                
                
                NSString *query = [NSString stringWithFormat:@"SELECT %@, %@ from SI_Store_premium WHERE Type = '%@' AND SINO = '%@'",mode,waiver,ridercode,sino];
                
                FMResultSet *results_rider = [database executeQuery:query];
                
                while ([results_rider next]) {
                    PaymentAmount = [results_rider stringForColumn:mode];
                    WOP = [results_rider stringForColumn:waiver];
                    if([WOP isEqualToString:@"(null)"] || (WOP ==NULL))
                        WOP = @"0.00";
                }
                
                
                
            }
            
            //****************START GET RIDERS INFO
            
            //            // NSLog(@"1 %@ - %@ - %@ - %@ - %@ - %@ - %@ - %@ - %@ - %@",count,ridercode,PlanOption,SumAssured,unit,CoverageTerm,PayingTerm,PaymentMode,PaymentAmount,Deductible);
            if([ridercode isEqualToString:@"ETPDB"] || [ridercode isEqualToString:@"EDB"])
                PayingTerm = @"6";
            
            PaymentAmount = [PaymentAmount stringByReplacingOccurrencesOfString:@"," withString:@""];
            rider_LA1 = @{@"Rider ID" : count,
                          @"PlanType" : @"R",
                          @"PlanCode" : ridercode,
                          @"PlanOption" : PlanOption,
                          @"SumAssured" : SumAssured,
                          @"CoverageUnit" : unit,
                          @"CoverageTerm" : CoverageTerm,
                          @"PayingTerm" : PayingTerm,
                          @"PaymentMode" : PaymentMode,
                          @"PaymentAmount" : PaymentAmount,
                          @"WOPAmount" : WOP,
                          @"Deductible" : Deductible,
                          @"PaidUpOption" : @"",
                          @"PaidUpTerm" : @"",
                          @"GYIOption":GYIOption};
            
            
            //****************END GET RIDERS INFO
            
            
            [riders_LA1 addObject:rider_LA1];
            
        }
        else if([PTypeCode isEqualToString:@"LA"] && [Seq isEqualToString:@"2"])
        {
            
            count_LA2 = count_LA2+1;
            
            riders_count2 = riders_count2 +1;
            NSString *count2 = [NSString stringWithFormat:@"%i", riders_count2];
            
            
            NSString *ridercode = [results3 stringForColumn:@"RiderCode"];
            
            
            NSString *SumAssured = [results3 stringForColumn:@"SumAssured"];
            
            SumAssured = [SumAssured stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
            PlanOption = [results3 stringForColumn:@"PlanOption"];
            
            if([PlanOption isEqualToString:@"(null)"] || PlanOption==NULL)
                PlanOption = @"";
            
            //SumAssured = [results3 stringForColumn:@"SumAssured"];
            
            NSString *unit = [results3 stringForColumn:@"Units"];
            if([unit isEqualToString:@"0"] || unit==NULL)
                unit = @"";
            
            CoverageTerm = [results3 stringForColumn:@"RiderTerm"];
            
            PayingTerm = [results3 stringForColumn:@"PayingTerm"];
            if (((NSNull *)PayingTerm == [NSNull null]) || (PayingTerm == nil))
            {
                PayingTerm = @"0";
            }
            if([ridercode isEqualToString:@"ETPDB"] || [ridercode isEqualToString:@"EDB"])
                PayingTerm = @"6";
            
            
            Deductible = [results3 stringForColumn:@"Deductible"];
            
            if([Deductible isEqualToString:@"(null)"] || Deductible==NULL)
                Deductible = @"0";
            
            
            if([SIType isEqualToString:@"ES"])
            {
                NSString *bumpmode   = [results3 stringForColumn:@"BumpMode"];
                
                if([bumpmode isEqualToString:@"A"])
                    PaymentMode = @"12";
                else if([bumpmode isEqualToString:@"S"])
                    PaymentMode = @"06";
                else if([bumpmode isEqualToString:@"Q"])
                    PaymentMode = @"03";
                else if([bumpmode isEqualToString:@"M"])
                    PaymentMode = @"01";
                
                WOP = SumAssured;
                
                if([ridercode isEqualToString:@"ECAR"] || [ridercode isEqualToString:@"ECAR6"] || [ridercode isEqualToString:@"ECAR60"])
                {
                    
                    
                    NSString *query = [NSString stringWithFormat:@"SELECT PaidUp, Years from eProposal_Riders WHERE eProposalNo = '%@' AND RiderCode = '%@' ",eproposalNo, ridercode];
                    
                    FMResultSet *results_PaidUp = [database executeQuery:query];
                    
                    while ([results_PaidUp next]) {
                        PaidUpOption = [results_PaidUp stringForColumn:@"PaidUp"];
                        PaidUpTerm  = [results_PaidUp stringForColumn:@"Years"];
                        
                    }
                    
                }
            }
            else if([SIType isEqualToString:@"TRAD"])
            {
                
                
                
                NSString *waiver = @"";
                
                if([mode isEqualToString:@"Annually"])
                    waiver = @"WaiverSAAnnual";
                else if([mode isEqualToString:@"SemiAnnually"])
                    waiver = @"WaiverSASemi";
                else if([mode isEqualToString:@"Quarterly"])
                    waiver = @"WaiverSAQuarter";
                else if([mode isEqualToString:@"Monthly"])
                    waiver = @"WaiverSAMonth";
                
                
                
                NSString *query = [NSString stringWithFormat:@"SELECT %@, %@ from SI_Store_premium WHERE Type = '%@' AND SINO = '%@'",mode,waiver,ridercode,sino];
                
                FMResultSet *results_rider = [database executeQuery:query];
                
                while ([results_rider next]) {
                    PaymentAmount = [results_rider stringForColumn:mode];
                    WOP = [results_rider stringForColumn:waiver];
                    if([WOP isEqualToString:@"(null)"] || (WOP ==NULL))
                        WOP = @"0.00";
                }
                
                
            }
            
            //  NSLog(@"2 %@ - %@ - %@ - %@ - %@ - %@ - %@ - %@ - %@ - %@",count2,ridercode,PlanOption,SumAssured,unit,CoverageTerm,PayingTerm,PaymentMode,PaymentAmount,Deductible);
            
            
            //****************START GET RIDERS INFO
            if([ridercode isEqualToString:@"ETPDB"] || [ridercode isEqualToString:@"EDB"])
                PayingTerm = @"6";
            PaymentAmount = [PaymentAmount stringByReplacingOccurrencesOfString:@"," withString:@""];
            rider_LA2 = @{@"Rider ID" : count2,
                          @"PlanType" : @"R",
                          @"PlanCode" : ridercode,
                          @"PlanOption" : PlanOption,
                          @"SumAssured" : SumAssured,
                          @"CoverageUnit" : unit,
                          @"CoverageTerm" : CoverageTerm,
                          @"PayingTerm" : PayingTerm,
                          @"PaymentMode" : PaymentMode,
                          @"PaymentAmount" : PaymentAmount,
                          @"WOPAmount" : WOP,
                          @"Deductible" : Deductible,
                          @"PaidUpOption" : @"",
                          @"PaidUpTerm" : @"",
                          @"GYIOption":GYIOption
                          };
            
            
            
            //****************END GET RIDERS INFO
            
            
            [riders_LA2 addObject:rider_LA2];
        }
        else if([PTypeCode isEqualToString:@"PY"] && [Seq isEqualToString:@"1"])
        {
            
            count_PY1 = count_PY1+1;
            
            riders_count3 = riders_count3 +1;
            NSString *count3 = [NSString stringWithFormat:@"%i", riders_count3];
            
            NSString *ridercode = [results3 stringForColumn:@"RiderCode"];
            
            NSString *SumAssured = [results3 stringForColumn:@"SumAssured"];
            
            SumAssured = [SumAssured stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
            
            PlanOption = [results3 stringForColumn:@"PlanOption"];
            
            if([PlanOption isEqualToString:@"(null)"] || PlanOption==NULL)
                PlanOption = @"";
            
            //SumAssured = [results3 stringForColumn:@"SumAssured"];
            
            NSString *unit = [results3 stringForColumn:@"Units"];
            if([unit isEqualToString:@"0"] || unit==NULL)
                unit = @"";
            
            CoverageTerm = [results3 stringForColumn:@"RiderTerm"];
            
            PayingTerm = [results3 stringForColumn:@"PayingTerm"];
            if (((NSNull *)PayingTerm == [NSNull null]) || (PayingTerm == nil))
            {
                PayingTerm = @"0";
            }
            if([ridercode isEqualToString:@"ETPDB"] || [ridercode isEqualToString:@"EDB"])
                PayingTerm = @"6";
            
            
            Deductible = [results3 stringForColumn:@"Deductible"];
            
            if([Deductible isEqualToString:@"(null)"] || Deductible==NULL)
                Deductible = @"0";
            
            if([SIType isEqualToString:@"ES"])
            {
                NSString *bumpmode   = [results3 stringForColumn:@"BumpMode"];
                GYIOption   = [results3 stringForColumn:@"GYIYear"];
                if(GYIOption==NULL)
                    GYIOption =@"";
                
                
                if([bumpmode isEqualToString:@"A"])
                    PaymentMode = @"12";
                else if([bumpmode isEqualToString:@"S"])
                    PaymentMode = @"06";
                else if([bumpmode isEqualToString:@"Q"])
                    PaymentMode = @"03";
                else if([bumpmode isEqualToString:@"M"])
                    PaymentMode = @"01";
                WOP = SumAssured;
                
                
                if([ridercode isEqualToString:@"ECAR"] || [ridercode isEqualToString:@"ECAR6"] || [ridercode isEqualToString:@"ECAR60"])
                {
                    
                    
                    NSString *query = [NSString stringWithFormat:@"SELECT PaidUp, Years from eProposal_Riders WHERE eProposalNo = '%@' AND RiderCode = '%@' ",eproposalNo, ridercode];
                    
                    FMResultSet *results_PaidUp = [database executeQuery:query];
                    
                    while ([results_PaidUp next]) {
                        PaidUpOption = [results_PaidUp stringForColumn:@"PaidUp"];
                        PaidUpTerm  = [results_PaidUp stringForColumn:@"Years"];
                        
                    }
                    
                }
            }
            else if([SIType isEqualToString:@"TRAD"])
            {
                
                NSString *waiver = @"";
                
                if([mode isEqualToString:@"Annually"])
                    waiver = @"WaiverSAAnnual";
                else if([mode isEqualToString:@"SemiAnnually"])
                    waiver = @"WaiverSASemi";
                else if([mode isEqualToString:@"Quarterly"])
                    waiver = @"WaiverSAQuarter";
                else if([mode isEqualToString:@"Monthly"])
                    waiver = @"WaiverSAMonth";
                
                
                
                NSString *query = [NSString stringWithFormat:@"SELECT %@, %@ from SI_Store_premium WHERE Type = '%@' AND SINO = '%@'",mode,waiver,ridercode,sino];
                
                FMResultSet *results_rider = [database executeQuery:query];
                
                while ([results_rider next]) {
                    PaymentAmount = [results_rider stringForColumn:mode];
                    WOP = [results_rider stringForColumn:waiver];
                    
                    if([WOP isEqualToString:@"(null)"] || (WOP ==NULL))
                        WOP = @"0.00";
                }
                
            }
            
            
            //****************START GET RIDERS INFO
            if([ridercode isEqualToString:@"ETPDB"] || [ridercode isEqualToString:@"EDB"])
                PayingTerm = @"6";
            PaymentAmount = [PaymentAmount stringByReplacingOccurrencesOfString:@"," withString:@""];
            rider_PY1 = @{@"Rider ID" : count3,
                          @"PlanType" : @"R",
                          @"PlanCode" : ridercode,
                          @"PlanOption" : PlanOption,
                          @"SumAssured" : SumAssured,
                          @"CoverageUnit" : unit,
                          @"CoverageTerm" : CoverageTerm,
                          @"PayingTerm" : PayingTerm,
                          @"PaymentMode" : PaymentMode,
                          @"PaymentAmount" : PaymentAmount,
                          @"WOPAmount" : WOP,
                          @"Deductible" : Deductible,
                          @"PaidUpOption" : @"",
                          @"PaidUpTerm" : @"",
                          @"GYIOption":GYIOption
                          };
            
            
            //****************END GET RIDERS INFO
            
            //  NSLog(@"count - %@  %@  %@ %@ %@ %@ %@ %@",count2,ridercode,PlanOption,SumAssured,unit,CoverageTerm,PayingTerm,Deductible);
            [riders_PY1 addObject:rider_PY1];
        }
        
        
    }
    
    
    NSString *parties_count = @"";
    FMResultSet *results4;
    
    if([SIType isEqualToString:@"TRAD"])
    {
        
        results4 = [database executeQuery:@"SELECT COUNT(*) FROM(SELECT PTypecode from  Trad_Rider_Details where SINO = ?  GROUP BY PTypecode, Seq)",sino];
    }
    else if([SIType isEqualToString:@"ES"])
    {
        results4 = [database executeQuery:@"SELECT COUNT(*) FROM(SELECT PTypecode from  UL_LAPayor where SINO = ?  GROUP BY PTypecode, Seq)",sino];
        
    }
    
    while ([results4 next]) {
        parties_count = [results4 stringForColumn:@"COUNT(*)"];
        
    }
    
    NSDictionary *PartyCount = [[NSDictionary alloc] init];
    NSDictionary *riders_LA1_count = [[NSDictionary alloc] init];
    NSDictionary *riders_LA2_count = [[NSDictionary alloc] init];
    NSDictionary *riders_PY1_count = [[NSDictionary alloc] init];
    
    if(count_LA1!=0)
    {
        NSString *count_LA1_str = [NSString stringWithFormat:@"%i", count_LA1];
        
        riders_LA1_count = @{@"RiderCount":count_LA1_str};
        
        [riders_LA1 addObject:riders_LA1_count];
        
    }
    
    if(count_LA2!=0)
    {
        NSString *count_LA2_str = [NSString stringWithFormat:@"%i", count_LA2];
        
        riders_LA2_count = @{@"RiderCount":count_LA2_str};
        
        [riders_LA2 addObject:riders_LA2_count];
    }
    
    if(count_PY1!=0)
    {
        NSString *count_PY1_str = [NSString stringWithFormat:@"%i", count_PY1];
        
        riders_PY1_count = @{@"RiderCount":count_PY1_str};
        
        [riders_PY1 addObject:riders_PY1_count];
    }
    
    PartyCount = @{@"PartyCount": parties_count};
    
    
    if(riders_LA1 != NULL)
    {
        
        party_LA1 = @{ @"Party PTypeCode":PTypeCode,
                       @"Seq" : @"1",
                       @"Riders" : riders_LA1
                       };
        
        
    }
    
    if(riders_LA2 != NULL)
    {
        
        party_LA2 = @{ @"Party PTypeCode":PTypeCode,
                       @"Seq" : @"2",
                       @"Riders" : riders_LA2
                       };
        
        
    }
    
    if(riders_PY1 != NULL)
    {
        
        party_PY1 = @{ @"Party PTypeCode":PTypeCode,
                       @"Seq" : @"2",
                       @"Riders" : riders_PY1
                       };
        
        
    }
    
    
    [results close];
    [result2 close];
    [results3 close];
    [results4 close];
    [result_agent close];
    [result_paymentAmount close];
    
    [database close];
    
    NSMutableArray *parties = [[NSMutableArray alloc]init];
    
    
    [parties addObject:PartyCount];
    
    
    if(riders_LA1.count != 0 )
        [parties addObject:party_LA1];
    if(riders_LA2.count != 0)
        [parties addObject:party_LA2];
    if(riders_PY1.count != 0)
        [parties addObject:party_PY1];
    
    
    
    //*********************** END   GET PARTIES RIDERS INFO   **************************
    
    
    
    
    //*********************** START   FundAllocation   **************************
    FundAllocation = [[NSMutableArray alloc] init];
    if([SIType isEqualToString:@"ES"])
    {
        
        
        
        [self XML_FundAllocation:sino];
        
    }
    
    
    //*********************** END   FundAllocation     **************************
    
    
    if (((NSNull *)AgentContactNo == [NSNull null]) || (AgentContactNo == nil) || ([AgentContactNo isEqualToString:@"nil"]))
    {
        AgentContactNo = @"";
    }
    
    NSDictionary *SIeApps=
    
    @{
      @"eSystemInfo":
          @{@"SystemName" : SystemName,
            @"eSystemVersion" : eAppVersion,
            
            },
      @"SIDetails":
          @{  @"eProposalNo":eproposalNo,
              @"CommencementDate":CommencementDate,
              @"SINo":sino,
              @"SIVersion":SIVersion,
              @"SIType":SIType,
              @"AgentInfo":
                  @{@"FirstAgentCode" : AgentCode,
                    @"FirstAgentName" : AgentName,
                    @"FirstAgentContact" : AgentContactNo,
                    },
              @"BasicPlan":SIbasicPlan,
              @"Parties" :parties,
              @"FundAllocation": FundAllocation
              },
      
      
      
      };
    
    
    
    
    
    return SIeApps;
    
}


-(void)XML_FundAllocation : (NSString*)SINO{
	
	NSString *query = [NSString stringWithFormat:@"Select VU2023,VU2025,VU2028,VU2030,VU2035,VUCash,VUDana,VURet,VURetOpt, VUCashOpt,VUDanaOpt From UL_Details "
                       " WHERE sino = '%@'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"]];
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	FMResultSet *results;
	NSString *F2025, *F2028, *F2030, *F2035, *FDana, *FRet, *FCash, *FDanaOpt, *FRetOpt, *FCashOpt;
	
	
    results = [database executeQuery:query];
    //if (results != Nil){
    while ([results next]) {
        F2025 =  [results stringForColumn:@"VU2025"];
        F2028 =  [results stringForColumn:@"VU2028"];
        F2030 = [results stringForColumn:@"VU2030"];
		F2035 =  [results stringForColumn:@"VU2035"];
		FDana =  [results stringForColumn:@"VUDana"];
        FRet =  [results stringForColumn:@"VURet"];
		FCash =  [results stringForColumn:@"VUCash"];
		FDanaOpt = [results stringForColumn:@"VUDanaOpt"];
        FRetOpt =  [results stringForColumn:@"VURetOpt"];
		FCashOpt = [results stringForColumn:@"VUCashOpt"];
    }
    //}
	
	NSMutableArray *aDesc = [[NSMutableArray alloc] init];
    NSMutableArray *aDesc2 = [[NSMutableArray alloc] init];
	NSMutableArray *a2025 = [[NSMutableArray alloc] init];
	NSMutableArray *a2028 = [[NSMutableArray alloc] init];
	NSMutableArray *a2030 = [[NSMutableArray alloc] init];
	NSMutableArray *a2035 = [[NSMutableArray alloc] init];
    NSMutableArray *aCash = [[NSMutableArray alloc] init]; //HLCF
    NSMutableArray *aRet = [[NSMutableArray alloc] init]; //HLSF
	NSMutableArray *aDana = [[NSMutableArray alloc] init]; //HLDS
	
    
	
	if( [F2025 intValue] != 0){
		
        
		[aDesc addObject:@"CD"];
        [aDesc2 addObject:@"25/11/2025"];
		[a2025 addObject:F2025];
		[a2028 addObject:F2028];
		[a2030 addObject:F2030];
		[a2035 addObject:F2035];
		[aDana addObject:FDana];
		[aRet addObject:FRet];
		[aCash addObject:FCash];
		
		
	}
	
	if( [F2028 intValue] != 0){
		if([F2025 intValue] == 0 ){
			
			[aDesc addObject:@"CD"];
            [aDesc2 addObject:@"25/11/2028"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:F2028];
			[a2030 addObject:F2030];
			[a2035 addObject:F2035];
			[aDana addObject:FDana];
			[aRet addObject:FRet];
			[aCash addObject:FCash];
            
		}
		else {
			
			double tempTotal = [F2028 intValue] + [F2030 intValue] + [F2035 intValue] + [FRet intValue] + [FDana intValue];
			
			double tempA = [F2028 intValue] + ([F2028 intValue]/tempTotal * [F2025 intValue]);
			double tempB = [F2030 intValue] + ([F2030 intValue]/tempTotal * [F2025 intValue]);
			double tempC = [F2035 intValue] + ([F2035 intValue]/tempTotal * [F2025 intValue]);
			double tempD = [FDana intValue] + ([FDana intValue]/tempTotal * [F2025 intValue]);
			double tempE = [FRet intValue] + ([FRet intValue]/tempTotal * [F2025 intValue]);
			double tempF = [FCash intValue];
			
			
			if(tempA + tempB + tempC + tempD + tempE + tempF != 100) {
				tempC = 100 - tempA - tempB - tempD - tempE - tempF;
				//tempC = round2Decimal(tempC);
			}
			
			[aDesc addObject:@"26/11/2025"];
            [aDesc2 addObject:@"25/11/2028"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:[NSString stringWithFormat:@"%f", tempA]];
			[a2030 addObject:[NSString stringWithFormat:@"%f", tempB]];
			[a2035 addObject:[NSString stringWithFormat:@"%f", tempC]];
			[aDana addObject:[NSString stringWithFormat:@"%f", tempD]];
			[aRet addObject:[NSString stringWithFormat:@"%f", tempE]];
			[aCash addObject:[NSString stringWithFormat:@"%f", tempF]];
			
            
		}
	}
	
	if([F2030 intValue] != 0){
		if([F2025 intValue] == 0 && [F2028 intValue] == 0 ){
			
			[aDesc addObject:@"CD"];
            [aDesc2 addObject:@"25/11/2030"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:@"0.00"];
			[a2030 addObject:F2030];
			[a2035 addObject:F2035];
			[aDana addObject:FDana];
			[aRet addObject:FRet];
			[aCash addObject:FCash];
            
		}
		else {
			double tempTotal = [F2030 intValue] + [F2035 intValue] + [FRet intValue] + [FDana intValue];
			
			double tempA = [F2030 intValue] + ([F2030 intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue]);
			double tempB = [F2035 intValue] + ([F2035 intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue]);
			double tempC = [FDana intValue] + ([FDana intValue]/tempTotal *	 [F2025 intValue] + [F2028 intValue]);
			double tempD = [FRet intValue] + ([FRet intValue]/tempTotal * [F2025 intValue] + [F2028 intValue]);
			double tempE = [FCash intValue];
			
			
			
			if(tempA + tempB + tempC + tempD + tempE != 100) {
				tempB = 100 - tempA - tempC - tempD - tempE;
				//tempB = round2Decimal(tempB);
			}
			
			[aDesc addObject:@"26/11/2028"];
            [aDesc2 addObject:@"25/11/2030"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:@"0.00"];
			[a2030 addObject:[NSString stringWithFormat:@"%f", tempA]];
			[a2035 addObject:[NSString stringWithFormat:@"%f", tempB]];
			[aDana addObject:[NSString stringWithFormat:@"%f", tempC]];
			[aRet addObject:[NSString stringWithFormat:@"%f", tempD]];
			[aCash addObject:[NSString stringWithFormat:@"%f", tempE]];
			
            
		}
	}
	
	if( [F2035 intValue] != 0){
		if([F2025 intValue] == 0 && [F2028 intValue] == 0 && [F2030 intValue] == 0 ){
			
			[aDesc addObject:@"CD"];
            [aDesc2 addObject:@"25/11/2035"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:@"0.00"];
			[a2030 addObject:@"0.00"];
			[a2035 addObject:F2035];
			[aDana addObject:FDana];
			[aRet addObject:FRet];
			[aCash addObject:FCash];
            
            
		}
		else {
			double tempTotal = [F2035 intValue] + [FRet intValue] + [FDana intValue];
			
			double tempA = [F2035 intValue] + ([F2035 intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue]+ [F2030 intValue]);
			double tempB = [FDana intValue] + ([FDana intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue]+ [F2030 intValue]);
			double tempC = [FRet intValue] + ([FRet intValue]/tempTotal * [F2025 intValue] + [F2028 intValue]+ [F2030 intValue]);
			double tempD = [FCash intValue];
			
			if(tempA + tempB + tempC + tempD != 100) {
				tempA = 100 - tempB - tempC - tempD;
				//tempA = round2Decimal(tempA);
			}
			
			[aDesc addObject:@"26/11/2030"];
            [aDesc2 addObject:@"25/11/2035"];
			[a2025 addObject:@"0.00"];
			[a2028 addObject:@"0.00"];
			[a2030 addObject:@"0.00"];
			[a2035 addObject:[NSString stringWithFormat:@"%f", tempA]];
			[aDana addObject:[NSString stringWithFormat:@"%f", tempB]];
			[aRet addObject:[NSString stringWithFormat:@"%f", tempC]];
			[aCash addObject:[NSString stringWithFormat:@"%f", tempD]];
            
            
		}
	}
	
	if([FCashOpt intValue] != 0){
		NSString *tempFund;
		NSString *tempFund2;
		if([F2035 intValue] != 0){
			tempFund = @"26/11/2035";
            tempFund2 = @"MD";
		}
		else if([F2030 intValue] != 0){
			tempFund = @"26/11/2030";
            tempFund2 = @"MD";
		}
		else if([F2028 intValue] != 0){
			tempFund = @"26/11/2028";
            tempFund2 = @"MD";
		}
		else if([F2025 intValue] != 0){
			tempFund = @"26/11/2025";
            tempFund2 = @"MD";
		}
		
		
		
		[aDesc addObject:tempFund];
        [aDesc2 addObject:tempFund2];
		[a2025 addObject:@"0.00"];
		[a2028 addObject:@"0.00"];
		[a2030 addObject:@"0.00"];
		[a2035 addObject:@"0.00"];
		[aDana addObject:FDanaOpt];
		[aRet addObject:FRetOpt];
		[aCash addObject:FCashOpt];
        
	}
	else{
		double tempTotal = [FRet intValue] + [FDana intValue];
        
		[aDesc addObject:@"26/11/2035"];
        [aDesc2 addObject:@"MD"];
		[a2025 addObject:@"0.00"];
		[a2028 addObject:@"0.00"];
		[a2030 addObject:@"0.00"];
		[a2035 addObject:@"0.00"];
		[aDana addObject:[NSString stringWithFormat:@"%f", [FDana intValue] + ([FDana intValue]/tempTotal *  [F2025 intValue] + [F2028 intValue] + [F2030 intValue] + [F2035 intValue]) ]];
		[aRet addObject:[NSString stringWithFormat:@"%f", [FRet intValue] + ([FRet intValue]/tempTotal * [F2025 intValue] + [F2028 intValue]+ [F2030 intValue] + [F2035 intValue])]];
		[aCash addObject:FCash];
	}
    
    
    NSDictionary *FundDateRange = [[NSDictionary alloc] init];
    
    NSDictionary *FundMaturity = [[NSDictionary alloc] init];
    
    
    
    for(int count=0; count < aDesc.count ; count++)
    {
        
        NSString *count_str = [NSString stringWithFormat:@"FundDateRange ID : %i", count+1];
        
        
        
        FundDateRange =
        @{count_str :
              
              @{@"FundFrom": aDesc[count],
                @"FundTo": aDesc2[count],
                @"FundStrategy ID=1":@{@"FundStraType": @"F",
                                       @"FundStraCode": @"HEG2023",
                                       @"NPercent": @"0"
                                       },
                @"FundStrategy ID=2":@{@"FundStraType": @"F",
                                       @"FundStraCode": @"HEG2025",
                                       @"NPercent": a2025[count]
                                       },
                @"FundStrategy ID=3":@{@"FundStraType": @"F",
                                       @"FundStraCode": @"HEG2028",
                                       @"NPercent": a2028[count]
                                       },
                @"FundStrategy ID=4":@{@"FundStraType": @"F",
                                       @"FundStraCode": @"HEG2030",
                                       @"NPercent": a2030[count]
                                       },
                @"FundStrategy ID=5":@{@"FundStraType": @"F",
                                       @"FundStraCode": @"HEG2035",
                                       @"NPercent": a2035[count]
                                       },
                @"FundStrategy ID=6":@{@"FundStraType": @"F",
                                       @"FundStraCode": @"HLCF",
                                       @"NPercent": aCash[count]
                                       },
                @"FundStrategy ID=7":@{@"FundStraType": @"F",
                                       @"FundStraCode": @"HLSF",
                                       @"NPercent": aRet[count]
                                       },
                @"FundStrategy ID=8":@{@"FundStraType": @"F",
                                       @"FundStraCode": @"HLDS",
                                       @"NPercent": aDana[count]
                                       }
                
                }
          
          
          };
        
        [FundAllocation addObject:FundDateRange];
        
    }
    // NSLog(@"FundAllocation  - %@",FundAllocation);
    
    
    
    //START  GET FUND MATURITY
    
    FMResultSet *results5 = [database executeQuery:@"SELECT * FROM UL_Fund_Maturity_Option WHERE SINO = ?",SINO];
    
    int count = 0;
    while([results5 next])
    {
        
        NSString *MaturityFundOption = [NSString stringWithFormat:@"MaturityFundOption : %i", count+1];
        
        NSString *FundCode = [results5 stringForColumn:@"Fund"];
        NSString *FundOption = [results5 stringForColumn:@"Option"];
        
        NSString *WithdrawPercent = [results5 stringForColumn:@"Partial_withd_Pct"];
        
        
        NSString *EverGreen2025 = [results5 stringForColumn:@"EverGreen2025"];
        
        NSString *EverGreen2028 = [results5 stringForColumn:@"EverGreen2028"];
        
        NSString *EverGreen2030 = [results5 stringForColumn:@"EverGreen2030"];
        
        NSString *EverGreen2035 = [results5 stringForColumn:@"EverGreen2035"];
        
        NSString *CashFund = [results5 stringForColumn:@"CashFund"];
        
        NSString *RetireFund = [results5 stringForColumn:@"RetireFund"];
        
        NSString *DanaFund = [results5 stringForColumn:@"DanaFund"];
        
        
        NSMutableArray *list = [[NSMutableArray alloc] init];
        
        for(int i = 0; i < FundCode.length ; i++)
        {
            [list addObject:[FundCode substringWithRange:NSMakeRange(i,1)]];
        }
        
        NSString *new_FundCode = [NSString stringWithFormat:@"HEG%@%@%@%@", list[list.count-4], list[list.count-3],list[list.count-2],list[list.count-1]];
        
        
        
        
        if([FundOption isEqualToString:@"ReInvest"])
            FundOption = @"FR";
        else if([FundOption isEqualToString:@"Withdraw"])
            FundOption = @"FW";
        else if([FundOption isEqualToString:@"Partial"])
            FundOption = @"PRW";
        
        int ReinvestPercent = 0;
        int withdraw = [WithdrawPercent intValue];
        
        if(withdraw ==0)
            ReinvestPercent = 100;
        else{
            
            ReinvestPercent = 100 - withdraw;
        }
        
        NSString *str_ReinvestPercent = [NSString stringWithFormat:@"%i", ReinvestPercent];
        NSString *str_withdraw = [NSString stringWithFormat:@"%i", withdraw];
        
        FundMaturity=  @{  MaturityFundOption :
                               
                               @{@"FundCode": new_FundCode,
                                 @"FundOption": FundOption,
                                 @"ReinvestPercent": str_ReinvestPercent,
                                 @"WithdrawPercent": str_withdraw,
                                 @"ReinvestInfo ID=1":@{@"FundCode": @"HEG2025",
                                                        @"ReinvestPercent": EverGreen2025,
                                                        },
                                 @"ReinvestInfo ID=2":@{@"FundCode": @"HEG2028",
                                                        @"ReinvestPercent": EverGreen2028,
                                                        },
                                 @"ReinvestInfo ID=3":@{@"FundCode": @"HEG2030",
                                                        @"ReinvestPercent": EverGreen2030,
                                                        },
                                 @"ReinvestInfo ID=4":@{@"FundCode": @"HEG2035",
                                                        @"ReinvestPercent": EverGreen2035,
                                                        },
                                 @"ReinvestInfo ID=5":@{@"FundCode": @"HLCF",
                                                        @"ReinvestPercent": CashFund,
                                                        },
                                 @"ReinvestInfo ID=6":@{@"FundCode": @"HLSF",
                                                        @"ReinvestPercent": RetireFund,
                                                        },
                                 @"ReinvestInfo ID=7":@{@"FundCode": @"HLDS",
                                                        @"ReinvestPercent": DanaFund,
                                                        },
                                 }
                           };
        
        
    }
    [database close];
    [FundAllocation addObject:FundMaturity];
    
    
    
}

-(void)storeXMLData_eApps
{
    
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:[self populateSIXMLData] forKey:@"SIDetails"];
    
    //   NSLog(@"populateSIXMLData - %@" , [[obj.eAppData objectForKey:@"EAPPDataSet"]  objectForKey:@"SIDetails"]);
}

-(void) storeXMLData_AssuredInfo
{
    partyID = 0;
    obj = [DataClass getInstance];
	
    NSMutableDictionary  *LA1 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary  *PO = [[NSMutableDictionary alloc] init];
    NSMutableDictionary  *PY = [[NSMutableDictionary alloc] init];
    NSMutableDictionary  *LArelation = [[NSMutableDictionary alloc] init];
    
	NSString *ResidenceOwnRented = @"";
	NSString *ResidenceAddress1 = @"";
	NSString *ResidenceAddress2 = @"";
	NSString *ResidenceAddress3 = @"";
	NSString *ResidenceAddressTown = @"";
	NSString *ResidenceAddressState = @"";
	NSString *ResidenceAddressPostCode = @"";
	NSString *ResidenceAddressCountry = @"";
	NSString *ResidencePoBox = @"";
	
	NSString *OfficeAddress1 = @"";
	NSString *OfficeAddress2 = @"";
	NSString *OfficeAddress3 = @"";
	NSString *OfficeAddressTown = @"";
	NSString *OfficeAddressState = @"";
	NSString *OfficeAddressPostCode = @"";
	NSString *OfficeAddressCountry = @"";
	NSString *OfficePoBox = @"";
	
	NSString *foreign_home_country;
	NSString *foreign_office_country;
	
    NSString *ChildFlag = @"N";
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
	
	FMResultSet *results;
    FMResultSet *resultsforEDD;
    
    NSString *pentalhealth1 = @"";
    NSString *pentalhealth2 = @"";
    NSString *pentalhealth3 = @"";
    
	results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
    
    
	while ([results next]) {
        
        
        
		NSString *FinalPTypeCode = [results stringForColumn:@"PTypeCode"];
        NSString *ProspectTitle = [results stringForColumn:@"LATitle"];
        NSString *ProspectName = [results stringForColumn:@"LAName"];
        NSString *ProspectGender = [results stringForColumn:@"LASex"];
        NSString *ProspectDOB = [results stringForColumn:@"LADOB"];
        NSString *IDTypeNo = [results stringForColumn:@"LANewICNO"];
        NSString *OtherIDType = [results stringForColumn:@"LAOtherIDType"];
        NSString *OtherIDTypeNo = [results stringForColumn:@"LAOtherID"];
        NSString *MaritalStatus = [results stringForColumn:@"LAMaritalStatus"];
        ChildFlag = [results stringForColumn:@"HaveChildren"];
        
        pentalhealth1 =  [results stringForColumn:@"PentalHealthStatus"];
        pentalhealth2 =  [results stringForColumn:@"PentalFemaleStatus"];
        pentalhealth3 =  [results stringForColumn:@"PentalDeclarationStatus"];
        
		NSString *ProspectPlaceOfBirth = [results stringForColumn:@"LABirthCountry"];
		
		if ([ProspectPlaceOfBirth isEqualToString:@""] || (ProspectPlaceOfBirth == NULL) || ([ProspectPlaceOfBirth isEqualToString:@"(null)"]) || ([ProspectPlaceOfBirth isEqualToString:@"(NULL)"]) || ([ProspectPlaceOfBirth isEqualToString:@"- SELECT -"]) || ([ProspectPlaceOfBirth isEqualToString:@"- Select -"]))
		{
			ProspectPlaceOfBirth =@"";
		}
        
		NSString *PoBox = [results stringForColumn:@"MalaysianWithPOBox"];
		if ([PoBox isEqualToString:@""] || (PoBox == NULL) || ([PoBox isEqualToString:@"(null)"]) || ([PoBox isEqualToString:@"(NULL)"]) || ([PoBox isEqualToString:@"- SELECT -"]) || ([PoBox isEqualToString:@"- Select -"]))
		{
			PoBox =@"N";
		}
        
        if(ChildFlag==NULL || [ChildFlag isEqualToString:@""])
            ChildFlag = @"N";
        
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
        if([Race isEqualToString:@"CHINESE"])
            Race = @"C";
        else if([Race isEqualToString:@"INDIAN"])
            Race = @"I";
        else if([Race isEqualToString:@"MALAY"])
            Race = @"M";
        else if([Race isEqualToString:@"OTHERS"])
            Race = @"O";
        
        
        //        while ([results1 next]) {
        //            POOtherIDType = [results1 objectForColumnName:@"LAOtherIDType"];
        
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
        
        
        NSString *Nationality = [self getNationalityCode:[results stringForColumn:@"LANationality"] passdb:database];
        
        
        //  eProposal_Nationality
        FMResultSet  *resultNation = [database executeQuery:@"select NationCode from eProposal_Nationality where NationDesc = ?",Nationality, Nil];
        
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
        NSString *CorrespondenceAddress = [results stringForColumn:@"CorrespondenceAddress"];
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
        while ([resultRelationship next])
        {
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
            //            FinalPTypeCode = @"PY";
            FinalPTypeCode = @"LA";
        
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
        
        
        
        [result_DeclarationAuth close];
        
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
        
        SecPo_LADetails_ClientNew = [[NSDictionary alloc] init];
        NSString *LATitle1 = ProspectTitle;
        NSString *LASex1 = ProspectGender;
        if ([LATitle1 isEqualToString:@"DT"] && [LASex1 isEqualToString:@"F"]) {
            LATitle1 = @"DT (FEMALE)";
        }
		
		if([PTypeCode isEqualToString:@"LA2"] || ([partyid isEqualToString:@"2"] && [FinalPTypeCode isEqualToString:@"LA"]))
		{
			BOOL LA2HasRider = FALSE;
			FMResultSet  *resultCheckRider = [database executeQuery:@"select PTypeCode, Seq from Trad_Rider_Details where SINO = ? ",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
			
			while ([resultCheckRider next]) {
				
				NSString * PTypeCode = [resultCheckRider stringForColumn:@"PTypeCode"];
				NSString *Seq = [resultCheckRider stringForColumn:@"Seq"];
				if (([PTypeCode isEqualToString:@"LA"] && [Seq isEqualToString:@"2"]) || [PTypeCode isEqualToString:@"PY"])
					LA2HasRider = TRUE;
			}
			[resultCheckRider close];
			
			if (!LA2HasRider){
				NSLog(@"LA2 no coverage, skip");
				goto skip_LA2;
			}
		}
        if([GST_exempted isEqualToString:@""] || (GST_exempted.length==0))
        {
            GST_exempted = @"N";
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
		
        // PTypeCode = LA/PO
        // Check for company case
        if (![OtherIDType isEqualToString:@"CR"]) {
            
            SecPo_LADetails_ClientNew = @{@"Party ID":partyid,
                                          @"PTypeCode":FinalPTypeCode,
                                          @"Seq":partyid,
                                          @"DeclarationAuth":[DeclarationAuth isEqualToString:@"Y"] ? @"True" : @"False",
                                          @"ClientChoice":ClientChoice,
                                          @"LATitle":LATitle1,
                                          @"LAName":ProspectName,
                                          @"LASex":LASex1,
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
            
            // NSLog(ProspectTitle);
            
            // Added by Andy Phan for retrieving Title Code - END
            
            SecPo_LADetails_ClientNew = [[NSDictionary alloc] init];
            NSString *LATitle1 = ProspectTitle;
            NSString *LASex1 = ProspectGender;
            if ([LATitle1 isEqualToString:@"DT"] && [LASex1 isEqualToString:@"F"]) {
                LATitle1 = @"DT (FEMALE)";
            }
            
            // Check is company case
            if ([OtherIDType isEqualToString:@"CR"]) {
                Religion = @"";
                pentalhealth1 = @"False";
                pentalhealth2 = @"False";
                pentalhealth3 = @"True";
                
            }
            if([GST_exempted isEqualToString:@""] || (GST_exempted.length==0))
            {
                GST_exempted = @"N";
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
                                          @"LASex":LASex1,
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
    
    NSString *DeclarationAuth=@"";
    
    NSString *ClientChoice = @"";
	
	NSString *ProspectPlaceOfBirth = @"";
    
    
    partyID = partyID+1;
    partyid = [NSString stringWithFormat:@"%i", partyID];
    while ([results next]) {
        
        RecurringPayment = [results stringForColumn:@"RecurringPayment"];
        ProspectName = [results stringForColumn:@"CardMemberName"];
        ProspectGender = [results stringForColumn:@"CardMemberSex"];
        
        ProspectDOB = [results stringForColumn:@"CardMemberDOB"];
		
		ProspectPlaceOfBirth = [results stringForColumn:@"LABirthCountry"];
		
		if ([ProspectPlaceOfBirth isEqualToString:@""] || (ProspectPlaceOfBirth == NULL) || ([ProspectPlaceOfBirth isEqualToString:@"(null)"]) || ([ProspectPlaceOfBirth isEqualToString:@"(NULL)"]) || ([ProspectPlaceOfBirth isEqualToString:@"- SELECT -"]) || ([ProspectPlaceOfBirth isEqualToString:@"- Select -"]))
		{
			ProspectPlaceOfBirth =@"";
		}
		
		NSString *PoBox = [results stringForColumn:@"MalaysianWithPOBox"];
		
		if ([PoBox isEqualToString:@""] || (PoBox == NULL) || ([PoBox isEqualToString:@"(null)"]) || ([PoBox isEqualToString:@"(NULL)"]) || ([PoBox isEqualToString:@"- SELECT -"]) || ([PoBox isEqualToString:@"- Select -"]))
		{
			PoBox =@"N";
		}
        
        IC = [results stringForColumn:@"CardMemberNewICNo"];
        
        OtherIDType = [results stringForColumn:@"CardMemberOtherIDType"];
        
        OtherIDTypeNo = [results stringForColumn:@"CardMemberOtherID"];
        
        MOBILE = [results stringForColumn:@"CardMemberContactNo"];
        MOBILE = [MOBILE stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *contactcodeMobile =@"";
        if (![MOBILE isEqualToString:@""]) {
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
        
        DeclarationAuth = [results stringForColumn:@"DeclarationAuthorization"];
        
        ClientChoice = [results stringForColumn:@"ClientChoice"];
        
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
                
				//POPULATE ADDRESS START HERE
				NSString *CorrespondenceAddress;
				results = nil;
				results = [database executeQuery:@"select * from eProposal_LA_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
				
				while ([results next]) {
					
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
						
						NSString *ProspectPlaceOfBirth = [results stringForColumn:@"LABirthCountry"];
						
						if ([ProspectPlaceOfBirth isEqualToString:@""] || (ProspectPlaceOfBirth == NULL) || ([ProspectPlaceOfBirth isEqualToString:@"(null)"]) || ([ProspectPlaceOfBirth isEqualToString:@"(NULL)"]) || ([ProspectPlaceOfBirth isEqualToString:@"- SELECT -"]) || ([ProspectPlaceOfBirth isEqualToString:@"- Select -"]))
						{
							ProspectPlaceOfBirth =@"";
						}
						
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
					
					if([OfficeAddressCountry isEqualToString:@"MAL"] || [OfficeAddressCountry isEqualToString:@""])
						foreign_office_country = @"N";
					else
						foreign_office_country = @"Y";
					
					
					if([ResidenceAddressCountry isEqualToString:@"MAL"] || [ResidenceAddressCountry isEqualToString:@""])
						foreign_home_country = @"N";
					else
						foreign_home_country = @"Y";
					
					//POPULATE ADDRESS END HERE
				}
				[results close];
				
                //NSLog(ProspectTitle);
                
                // Added by Andy Phan for retrieving Title Code - END
                
                SecPo_LADetails_ClientNew = [[NSDictionary alloc] init];
                NSString *LATitle1 = ProspectTitle;
                NSString *LASex1 = ProspectGender;
                if ([LATitle1 isEqualToString:@"DT"] && [LASex1 isEqualToString:@"F"]) {
                    LATitle1 = @"DT (FEMALE)";
                }
                
                if  ((NSNull *) GST_registered == [NSNull null])
                    GST_registered = @"";
                if  ((NSNull *) GST_registrationNo == [NSNull null])
                    GST_registrationNo = @"";
                
                if  ((NSNull *) GST_registrationDate == [NSNull null])
                    GST_registrationDate = @"";
                
                if  ((NSNull *) GST_exempted == [NSNull null])
                    GST_exempted = @"";
                
                if([GST_exempted isEqualToString:@""] || (GST_exempted.length==0))
                {
                    GST_exempted = @"N";
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
                                              @"PTypeCode":@"PY",
                                              @"Seq":@"1",
                                              @"DeclarationAuth":[DeclarationAuth isEqualToString:@"Y"] ? @"True" : @"False",
                                              @"ClientChoice":ClientChoice,
                                              @"LATitle":LATitle1,
                                              @"LAName":ProspectName,
                                              @"LASex":LASex1,
                                              @"LADOB":ProspectDOB,
											  @"LABirthCountry":ProspectPlaceOfBirth,
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
											  @"MalaysianWithPOBox":PoBox,
                                              @"CorrespondenceAddress":CorrespondenceAddress,
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
            
            [PY setValue:@"" forKey:@"LARelationship"];
            [PY setValue:@"PY" forKey:@"PTypeCode"];
            
            [SecPo_LADetails_ClientNew_Array addObject:PY];
        }
        
        
    }
    
    
    [results close];
    
    [database close];
    
}

#pragma mark - CFF XML Data

-(void) storeCFFXMLData:(NSString *) cffId {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    FMResultSet *results;
    
    //    results= [database executeQuery:@"SELECT * FROM CFF_Master WHERE ID=?",cffId];
    results= [database executeQuery:@"SELECT * FROM eProposal_CFF_Master WHERE ID=? AND eProposalNo = ?",cffId,[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    FMResultSet *eAppResults = [database executeQuery:@"SELECT * FROM eProposal_CFF_MASTER WHERE ID=? AND eProposalNo = ?", cffId, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    
    bool eAppIsUpdate = false;
    int indexNo;
    int partner_indexNo;
    while([results next])
	{
        indexNo = [results intForColumn:@"ClientProfileID"];
        partner_indexNo = [results intForColumn:@"PartnerClientProfileID"];
        
        bool eApp1 = [eAppResults next];
        if (eApp1) {
            //NSLog(@"eApp available");
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"dd/MM/yyyy"];
            NSDate *standalone = [format dateFromString:[results stringForColumn:@"lastUpdatedAt"]];
            NSDate *eAppDate = [format dateFromString:[eAppResults stringForColumn:@"lastUpdatedAt"]];
            if (![eAppDate laterDate:standalone]) {
                eAppIsUpdate = TRUE;
            }
            
        }
        
        //cff info
        if (eAppIsUpdate) {
            results = [database executeQuery:@"SELECT * FROM eProposal_CFF_MASTER WHERE ID=? AND eProposalNo = ?", cffId];
        }
        else {
            results= [database executeQuery:@"SELECT * FROM CFF_Master WHERE ID=?",cffId];
        }
        
        NSString *createdAt;
        NSString *lastUpdatedAt;
        NSString *intermediaryStatus;
        NSString *brokerName;
        NSString *clientChoice;
        NSString *riskReturnProfile;
        NSString *q1ans1;
        NSString *q1ans2;
        NSString *q1priority;
        NSString *q2ans1;
        NSString *q2ans2;
        NSString *q2priority;
        NSString *q3ans1;
        NSString *q3ans2;
        NSString *q3priority;
        NSString *q4ans1;
        NSString *q4ans2;
        NSString *q4priority;
        NSString *q5ans1;
        NSString *q5ans2;
        NSString *q5priority;
        NSString *intermediaryCode;
        NSString *intermediaryName;
        NSString *intermediaryNRIC;
        NSString *intermediaryContractDate;
        NSString *intermediaryAddress1;
        NSString *intermediaryAddress2;
        NSString *intermediaryAddress3;
        NSString *intermediaryAddress4;
        NSString *intermediaryPostcode;
        NSString *intermediaryTown;
        NSString *intermediaryState;
        NSString *intermediaryCountry;
        NSString *intermediaryManagerName;
        NSString *clientAck;
        NSString *clientComments;
        
        while ([results next]) {
            createdAt = [results stringForColumn:@"createdAt"];
            lastUpdatedAt = [results stringForColumn:@"LastUpdatedAt"];
            intermediaryStatus = [results stringForColumn:@"IntermediaryStatus"];
            brokerName = [results stringForColumn:@"BrokerName"];
            clientChoice = [results stringForColumn:@"ClientChoice"];
            riskReturnProfile = [results stringForColumn:@"RiskReturnProfile"];
            
            q1ans1 = [results stringForColumn:@"NeedsQ1_Ans1"];
            q1ans2 = [results stringForColumn:@"NeedsQ1_Ans2"];
            q1priority = [results stringForColumn:@"NeedsQ1_Priority"];
            q2ans1 = [results stringForColumn:@"NeedsQ2_Ans1"];
            q2ans2 = [results stringForColumn:@"NeedsQ2_Ans2"];
            q2priority = [results stringForColumn:@"NeedsQ2_Priority"];
            q3ans1 = [results stringForColumn:@"NeedsQ3_Ans1"];
            q3ans2 = [results stringForColumn:@"NeedsQ3_Ans2"];
            q3priority = [results stringForColumn:@"NeedsQ3_Priority"];
            q4ans1 = [results stringForColumn:@"NeedsQ4_Ans1"];
            q4ans2 = [results stringForColumn:@"NeedsQ4_Ans2"];
            q4priority = [results stringForColumn:@"NeedsQ4_Priority"];
            q5ans1 = [results stringForColumn:@"NeedsQ5_Ans1"];
            q5ans2 = [results stringForColumn:@"NeedsQ5_Ans2"];
            q5priority = [results stringForColumn:@"NeedsQ5_Priority"];
            
            intermediaryCode = [results stringForColumn:@"IntermediaryCode"];
            intermediaryName = [results stringForColumn:@"IntermediaryName"];
            intermediaryNRIC = [results stringForColumn:@"IntermediaryNRIC"];
            intermediaryContractDate = [results stringForColumn:@"IntermediaryContractDate"];
            intermediaryAddress1 = [results stringForColumn:@"IntermediaryAddress1"];
            intermediaryAddress2 = [results stringForColumn:@"IntermediaryAddress2"];
            intermediaryAddress3 = [results stringForColumn:@"IntermediaryAddress3"];
            intermediaryAddress4 = [results stringForColumn:@"IntermediaryAddress4"];
            intermediaryPostcode = [results stringForColumn:@"IntermediaryAddrPostcode"];
            intermediaryTown = [results stringForColumn:@"IntermediaryAddrTown"];
            intermediaryState = [self getStateCode:[results stringForColumn:@"IntermediaryAddrState"] passdb:database];
            intermediaryCountry = [self getCountryCode:[results stringForColumn:@"IntermediaryAddrCountry"] passdb:database];
            intermediaryManagerName = [results stringForColumn:@"IntermediaryManagerName"];
            clientAck = [results stringForColumn:@"ClientAck"];
            clientComments = [results stringForColumn:@"ClientComments"];
        }
        
        //to avoid crash if any data is nil
		if (createdAt == nil)
			createdAt = @"";
		if (lastUpdatedAt == nil)
			lastUpdatedAt = @"";
		if (intermediaryStatus == nil)
			intermediaryStatus = @"";
		if (brokerName == nil)
			brokerName = @"";
		if (clientChoice == nil)
			clientChoice = @"";
		if (riskReturnProfile == nil)
			riskReturnProfile = @"";
		if (q1ans1 == nil)
			q1ans1 = @"";
		if (q1ans2 == nil)
			q1ans2 = @"";
		if (q1priority == nil)
			q1priority = @"";
		if (q2ans1 == nil)
			q2ans1 = @"";
		if (q2ans2 == nil)
			q2ans2 = @"";
		if (q2priority == nil)
			q2priority = @"";
		if (q3ans1 == nil)
			q3ans1 = @"";
		if (q3ans2 == nil)
			q3ans2 = @"";
		if (q3priority == nil)
			q3priority = @"";
		if (q4ans1 == nil)
			q4ans1 = @"";
		if (q4ans2 == nil)
			q4ans2 = @"";
		if (q4priority == nil)
			q4priority = @"";
		if (q5ans1 == nil)
			q5ans1 = @"";
		if (q5ans2 == nil)
			q5ans2 = @"";
		if (q5priority == nil)
			q5priority = @"";
		if (intermediaryCode == nil)
			intermediaryCode = @"";
		if (intermediaryName == nil)
			intermediaryName = @"";
		if (intermediaryNRIC == nil)
			intermediaryNRIC = @"";
		if (intermediaryContractDate == nil)
			intermediaryContractDate = @"";
		if (intermediaryAddress1 == nil)
			intermediaryAddress1 = @"";
		if (intermediaryAddress2 == nil)
			intermediaryAddress2 = @"";
		if (intermediaryAddress3 == nil)
			intermediaryAddress3 = @"";
		if (intermediaryAddress4 == nil)
			intermediaryAddress4 = @"";
		if (intermediaryPostcode == nil)
			intermediaryPostcode = @"";
		if (intermediaryTown == nil)
			intermediaryTown = @"";
		if (intermediaryState == nil)
			intermediaryState = @"";
		if (intermediaryCountry == nil)
			intermediaryCountry = @"";
		if (intermediaryManagerName == nil)
			intermediaryManagerName = @"";
		if (clientAck == nil)
			clientAck = @"";
		if (clientComments == nil)
			clientComments = @"";
		
        NSDictionary *eCFFInfo = @{@"CreatedAt" : createdAt,
                                   @"LastUpdatedAt" : lastUpdatedAt,
                                   @"IntermediaryStatus" : intermediaryStatus,
                                   @"BrokerName" : brokerName,
                                   @"ClientChoice" : clientChoice,
                                   @"RiskReturnProfile" : riskReturnProfile,
                                   @"NeedsQ1_Ans1" : q1ans1,
                                   @"NeedsQ1_Ans2" : q1ans2,
                                   @"NeedsQ1_Priority" : q1priority,
                                   @"NeedsQ2_Ans1" : q2ans1,
                                   @"NeedsQ2_Ans2" : q2ans2,
                                   @"NeedsQ2_Priority" : q2priority,
                                   @"NeedsQ3_Ans1" : q3ans1,
                                   @"NeedsQ3_Ans2" : q3ans2,
                                   @"NeedsQ3_Priority" : q3priority,
                                   @"NeedsQ4_Ans1" : q4ans1,
                                   @"NeedsQ4_Ans2" : q4ans2,
                                   @"NeedsQ4_Priority" : q4priority,
                                   @"NeedsQ5_Ans1" : q5ans1,
                                   @"NeedsQ5_Ans2" : q5ans2,
                                   @"NeedsQ5_Priority" : q5priority,
                                   @"IntermediaryCode" : intermediaryCode,
                                   @"IntermediaryName" : intermediaryName,
                                   @"IntermediaryNRIC" : intermediaryNRIC,
                                   @"IntermediaryContractDate" : intermediaryContractDate,
                                   @"IntermediaryAddress1" : intermediaryAddress1,
                                   @"IntermediaryAddress2" : intermediaryAddress2,
                                   @"IntermediaryAddress3" : intermediaryAddress3,
                                   @"IntermediaryAddress4" : intermediaryAddress4,
                                   @"IntermediaryPostcode" : intermediaryPostcode,
                                   @"IntermediaryTown" : intermediaryTown,
                                   @"IntermediaryState" : intermediaryState,
                                   @"IntermediaryCountry" : intermediaryCountry,
                                   @"IntermediaryManagerName" : intermediaryManagerName,
                                   @"ClientAck" : clientAck,
                                   @"ClientComments" : clientComments,
                                   };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:eCFFInfo forKey:@"eCFFInfo"];
        
        //personal info for cff payor
        NSString *addFromCFF = @"";
        NSString *addNewPayor = @"";
        NSString *sameAsPO = @"";
        NSString *PTypeCode = @"";
        NSString *PYFlag = @"";
        NSString *title = @"";
        NSString *prospectName = @"";
        NSString *newICNo = @"";
        NSString *otherIDType = @"";
        NSString *otherID = @"";
        NSString *nationality = @"";
        NSString *race = @"";
        NSString *religion = @"";
        NSString *sex = @"";
        NSString *smoker = @"";
        NSString *dob = @"";
        NSString *age = @"";
        NSString *maritalStatus = @"";
        NSString *occupation = @"";
        NSString *residenceNo = @"";
        NSString *officePhoneNo = @"";
        NSString *mobilePhoneNo = @"";
        NSString *faxPhoneNo = @"";
        NSString *emailAddress = @"";
        NSString *addressSameAsPO = @"";
        NSString *address1 = @"";
        NSString *address2 = @"";
        NSString *address3 = @"";
        NSString *town = @"";
        NSString *state = @"";
        NSString *postcode = @"";
        NSString *country = @"";
        NSString *foreignAddress = @"";
        NSString *permanentAddressSameAsPO = @"";
        NSString *permanentAddress1 = @"";
        NSString *permanentAddress2 = @"";
        NSString *permanentAddress3 = @"";
        NSString *permanentTown = @"";
        NSString *permanentState = @"";
        NSString *permanentPostcode = @"";
        NSString *permanentCountry = @"";
        NSString *permanentForeignAddress = @"";
        
        results = nil;
        results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%d", indexNo]];
        NSDate *prospectProfileDate;
        
        while ([results next]) {
            
            
            
            NSString *cff_indexNo = [results stringForColumn:@"IndexNo"];
            title = [results stringForColumn:@"ProspectTitle"];
            prospectName = [results stringForColumn:@"ProspectName"];
            newICNo = [results stringForColumn:@"IDTypeNo"];
            if (newICNo == NULL) {
                newICNo = @"";
            }
            otherIDType = [self getIdTypeCode:[results stringForColumn:@"OtherIDType"] passdb:database];
            if (otherIDType == NULL) {
                otherIDType = @"";
            }
            
            otherID = [results stringForColumn:@"OtherIDTypeNo"];
            if (otherID == NULL) {
                otherID = @"";
            }
            nationality = [self getNationalityCode:[results stringForColumn:@"Nationality"] passdb:database];
            race = [results stringForColumn:@"Race"];
            religion = [results stringForColumn:@"Religion"];
            sex = [results stringForColumn:@"ProspectGender"];
            smoker = [results stringForColumn:@"Smoker"];
            dob = [results stringForColumn:@"ProspectDOB"];
            
            NSDate *todayDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:dob]];
            int allDays = (((time/60)/60)/24);
            int days = allDays%365;
            int years = (allDays-days)/365;
            age = [NSString stringWithFormat:@"%d",years];
            
            maritalStatus = [results stringForColumn:@"MaritalStatus"];
			
			
			
			if([maritalStatus isEqualToString:@"DIVORCED"])
				maritalStatus = @"D";
			else if([maritalStatus isEqualToString:@"MARRIED"])
				maritalStatus = @"M";
			else if([maritalStatus isEqualToString:@"WIDOWER"])
				maritalStatus = @"R";
			else if([maritalStatus isEqualToString:@"SINGLE"])
				maritalStatus = @"S";
			else if([maritalStatus isEqualToString:@"WINDOW"])
				maritalStatus = @"W";
			
			
            
            //            FMResultSet *results2 = [database executeQuery:@"SELECT * from Adm_Occp WHERE OccpCode = ?", [results stringForColumn:@"ProspectOccupationCode"], nil];
            //            while ([results2 next]) {
            occupation = [results stringForColumn:@"ProspectOccupationCode"];
            //            }
            
            emailAddress = [results stringForColumn:@"ProspectEmail"];
            
            if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
                foreignAddress = @"0";
            }
            else {
                foreignAddress = @"1";
            }
            
            address1 = [results stringForColumn:@"ResidenceAddress1"];
            address2 = [results stringForColumn:@"ResidenceAddress2"];
            address3 = [results stringForColumn:@"ResidenceAddress3"];
            town = [results stringForColumn:@"ResidenceAddressTown"];
            state = [results stringForColumn:@"ResidenceAddressState"];
            postcode = [results stringForColumn:@"ResidenceAddressPostCode"];
            country = [results stringForColumn:@"ResidenceAddressCountry"];
			if (country == NULL) {
				country = @"";
			}
            
            if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
                permanentForeignAddress = @"0";
            }
            else {
                permanentForeignAddress = @"1";
            }
            
            permanentAddress1 = [results stringForColumn:@"ResidenceAddress1"];
            permanentAddress2 = [results stringForColumn:@"ResidenceAddress2"];
            permanentAddress3 = [results stringForColumn:@"ResidenceAddress3"];
            permanentTown = [results stringForColumn:@"ResidenceAddressTown"];
            permanentState = [results stringForColumn:@"ResidenceAddressState"];
            permanentPostcode = [results stringForColumn:@"ResidenceAddressPostCode"];
            permanentCountry = [results stringForColumn:@"ResidenceAddressCountry"];
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            prospectProfileDate = [format dateFromString:[results stringForColumn:@"DateModified"]];
            
            results = nil;
            results = [database executeQuery:@"SELECT * FROM CFF_Personal_Details WHERE CFFID = ? AND PTypeCode = ?", cffId, @"1"];
            while ([results next]) {
                NSDate *theDate = [format dateFromString:[results stringForColumn:@"LastUpdated"]];
				
				//NSLog(@"d1 %@, d2 %@", theDate, prospectProfileDate);
                if ([theDate compare:prospectProfileDate] == NSOrderedDescending || prospectProfileDate == NULL) {
                    
                    if ([[results stringForColumn:@"MailingCountry"] isEqualToString:@"MAL"]) {
                        foreignAddress = @"0";
                    }
                    else {
                        foreignAddress = @"1";
                    }
                    
                    address1 = [results stringForColumn:@"MailingAddress1"];
                    address2 = [results stringForColumn:@"MailingAddress2"];
                    address3 = [results stringForColumn:@"MailingAddress3"];
                    town = [results stringForColumn:@"MailingTown"];
                    state = [results stringForColumn:@"MailingState"];
                    postcode = [results stringForColumn:@"MailingPostCode"];
                    country = [results stringForColumn:@"MailingCountry"];
					if (country == NULL) {
						country = @"";
					}
                }
                
                addFromCFF = [results stringForColumn:@"AddFromCFF"] != NULL ? [results stringForColumn:@"AddFromCFF"] : @"";
                addNewPayor = [results stringForColumn:@"AddNewPayor"] != NULL ? [results stringForColumn:@"AddNewPayor"] : @"";
                sameAsPO = [results stringForColumn:@"SameAsPO"] != NULL ? [results stringForColumn:@"SameAsPO"] : @"";
                NSString *PTypeCode1 = [results stringForColumn:@"PTypeCode"] != NULL ? [results stringForColumn:@"PTypeCode"] : @"";
                NSString *PTypecode = [[PTypeCode1 componentsSeparatedByCharactersInSet: [[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
                PYFlag = @"True";
                addressSameAsPO = [results stringForColumn:@"MailingAddressSameAsPO"] != NULL ? [results stringForColumn:@"MailingAddressSameAsPO"] : @"";
                permanentAddressSameAsPO = [results stringForColumn:@"PermanentAddressSameAsPO"] != NULL ? [results stringForColumn:@"PermanentAddressSameAsPO"] : @"";
            }
            
            if (addFromCFF == NULL) {
                addFromCFF = @"";
            }
            if (addNewPayor == NULL) {
                addNewPayor = @"";
            }
            if (sameAsPO == NULL) {
                sameAsPO = @"";
            }
            if (PTypeCode == NULL) {
                PTypeCode = @"";
            }
            if (PYFlag == NULL) {
                PYFlag = @"";
            }
            if (addressSameAsPO == NULL) {
                addressSameAsPO = @"";
            }
            if (permanentAddressSameAsPO == NULL) {
                permanentAddressSameAsPO = @"";
            }
            
            results = nil;
            results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",cff_indexNo, @"CONT006"];
            while ([results next]) {
                residenceNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
            }
            if (residenceNo == NULL) {
                residenceNo = @"";
            }
            
            results = nil;
            results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",cff_indexNo, @"CONT007"];
            while ([results next]) {
                officePhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
            }
            if (officePhoneNo == NULL) {
                officePhoneNo = @"";
            }
            
            results = nil;
            results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",cff_indexNo, @"CONT008"];
            while ([results next]) {
                mobilePhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
            }
            if (mobilePhoneNo == NULL) {
                mobilePhoneNo = @"";
            }
            
            results = nil;
            results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",cff_indexNo, @"CONT009"];
            while ([results next]) {
                faxPhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"Prefix"], [results stringForColumn:@"ContactNo"]];
            }
            if (faxPhoneNo == NULL) {
                faxPhoneNo = @"";
            }
            
            
            
        }
        
        //nationality, race, religion, sex, maritalStatus
        nationality = [textFields trimWhiteSpaces:nationality];
        race = [textFields trimWhiteSpaces:race];
        religion = [textFields trimWhiteSpaces:religion];
        sex = [textFields trimWhiteSpaces:sex];
        maritalStatus = [textFields trimWhiteSpaces:maritalStatus];
        
        results = Nil;
        results = [database executeQuery:@"select NationCode from eProposal_Nationality where NationDesc = ?", nationality, Nil];
        if ([results next]) {
            nationality = [results stringForColumn:@"NationCode"];
        }
        
        results = Nil;
        results = [database executeQuery:@"select RaceCode from eProposal_Race where RaceDesc = ?", race, Nil];
        if ([results next]) {
            race = [results stringForColumn:@"RaceCode"];
        }
        
        results = Nil;
        results = [database executeQuery:@"select ReligionCode from eProposal_Religion where ReligionDesc = ?", religion, Nil];
        if ([results next]) {
            religion = [results stringForColumn:@"ReligionCode"];
        }
        
        sex = [[sex substringWithRange:NSMakeRange(0, 1)] uppercaseString];
        
        results = Nil;
        results = [database executeQuery:@"select MSCode from eProposal_Marital_Status where MSDesc = ?", maritalStatus, Nil];
        if ([results next]) {
            maritalStatus = [results stringForColumn:@"MSCode"];
        }
        
        // for addFromCFF and addNewPayor
        results = Nil;
        if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"TRAD"] ) {
            results = [database executeQuery:@"select count(*) as count from trad_Lapayor as a, clt_profile as b where a.custcode = b.custcode and sino = ? and  b.indexno = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [NSString stringWithFormat:@"%d", indexNo], Nil];
        }
        else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
            results = [database executeQuery:@"select count(*) as count from UL_LAPayor as a, clt_profile as b where a.custcode = b.custcode and sino = ? and  b.indexno = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [NSString stringWithFormat:@"%d", indexNo], Nil];
        }
        if ([results next]) {
            int i = [results intForColumn:@"count"];
            if (i > 0) {
                addFromCFF = @"True";
                addNewPayor = @"True";
            }
            else {
                addFromCFF = @"False";
                addNewPayor = @"False";
            }
        }
        
        // same as PO
        results = Nil;
        results = [database executeQuery:@"select ProspectProfileID from eProposal_LA_Details where eProposalNo = ? and POFlag = 'Y'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
        if ([results next]) {
            if (indexNo == [results intForColumn:@"ProspectProfileID"]) {
                sameAsPO = @"True";
            }
            else {
                sameAsPO = @"False";
            }
        }
        
        // NSLog(@"1A");
        
        if([foreignAddress isEqualToString:@"0"])
        {
            foreignAddress = @"N";
        }
        if ([foreignAddress isEqualToString:@"1"])
        {
            foreignAddress = @"Y";
            
        }
        
        if([permanentForeignAddress isEqualToString:@"0"])
        {
            permanentForeignAddress = @"N";
        }
        if ([permanentForeignAddress isEqualToString:@"1"])
        {
            permanentForeignAddress = @"Y";
            
        }
        
        NSString *Title1 = [self getTitleCode:title passdb:database];
        NSString *Sex1 = sex;
        if ([Title1 isEqualToString:@"DT"] && [Sex1 isEqualToString:@"F"]) {
            Title1 = @"DT (FEMALE)";
        }
        
        NSDictionary *personalInfo = @{@"CFFParty ID=\"1\"" :
                                           @{@"AddFromCFF" : addFromCFF,
                                             @"AddNewPayor" : addNewPayor,
                                             @"SameAsPO" : sameAsPO,
                                             @"PTypeCode" : [NSString stringWithFormat:@"LA%@",PTypeCode],
                                             @"PYFlag" : PYFlag,
                                             @"Title" : Title1,
                                             @"Name" : prospectName,
                                             @"NewICNo" : newICNo,
                                             @"OtherIDType" : otherIDType,
                                             @"OtherID" : otherID,
                                             @"Nationality" : nationality,
                                             @"Race" : race,
                                             @"Religion" : religion,
                                             @"Sex" : Sex1,
                                             @"Smoker" : smoker,
                                             @"DOB" : dob,
                                             @"Age" : age,
                                             @"MaritalStatus" : maritalStatus,
                                             @"Occupation" : occupation,
                                             @"ResidencePhoneNo" : residenceNo,
                                             @"OfficePhoneNo" : officePhoneNo,
                                             @"MobilePhoneNo" : mobilePhoneNo,
                                             @"FaxPhoneNo" : faxPhoneNo,
                                             @"EmailAddress" : emailAddress,
                                             @"CFFAddresses" :
                                                 @{@"CFFAddress Type=\"Mailing\"" :
                                                       @{@"AddressSameAsPO":sameAsPO,
                                                         @"Address1":address1,
                                                         @"Address2":address2,
                                                         @"Address3":address3,
                                                         @"Town": town,
                                                         @"State":state,
                                                         @"Postcode":postcode,
                                                         @"Country":country,
                                                         @"ForeignAddress":foreignAddress,
                                                         },
                                                   @"CFFAddress Type=\"Permanent\"" :
                                                       @{@"AddressSameAsPO":permanentAddressSameAsPO,
                                                         @"Address1":permanentAddress1,
                                                         @"Address2":permanentAddress2,
                                                         @"Address3":permanentAddress3,
                                                         @"Town":permanentTown,
                                                         @"State":permanentState,
                                                         @"Postcode":permanentPostcode,
                                                         @"Country":permanentCountry,
                                                         @"ForeignAddress":permanentForeignAddress,
                                                         },
                                                   },
                                             },
                                       };
        //NSLog(@"2");
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:personalInfo forKey:@"eCFFPersonalInfo"];
        
        //personal info for cff partner
        NSString *partnerAddFromCFF = @"";
        NSString *partnerAddNewPayor = @"";
        NSString *partnerSameAsPO = @"";
        NSString *partnerPTypeCode = @"";
        NSString *partnerPYFlag = @"";
        NSString *partnerTitle = @"";
        NSString *partnerName = @"";
        NSString *partnerNewICNo = @"";
        NSString *partnerOtherIDType = @"";
        NSString *partnerOtherID = @"";
        NSString *partnerNationality = @"";
        NSString *partnerRace = @"";
        NSString *partnerReligion = @"";
        NSString *partnerSex = @"";
        NSString *partnerSmoker = @"";
        NSString *partnerDob = @"";
        NSString *partnerAge = @"";
        NSString *partnerMaritalStatus = @"";
        NSString *partnerOccupation = @"";
        NSString *partnerResidenceNo = @"";
        NSString *partnerOfficePhoneNo = @"";
        NSString *partnerMobilePhoneNo = @"";
        NSString *partnerFaxPhoneNo = @"";
        NSString *partnerEmailAddress = @"";
        NSString *partnerAddressSameAsPO = @"";
        NSString *partnerAddress1 = @"";
        NSString *partnerAddress2 = @"";
        NSString *partnerAddress3 = @"";
        NSString *partnerTown = @"";
        NSString *partnerState = @"";
        NSString *partnerPostcode = @"";
        NSString *partnerCountry = @"";
        NSString *partnerForeignAddress = @"";
        NSString *partnerPermanentAddressSameAsPO = @"";
        NSString *partnerPermanentAddress1 = @"";
        NSString *partnerPermanentAddress2 = @"";
        NSString *partnerPermanentAddress3 = @"";
        NSString *partnerPermanentTown = @"";
        NSString *partnerPermanentState = @"";
        NSString *partnerPermanentPostcode = @"";
        NSString *partnerPermanentCountry = @"";
        NSString *partnerPermanentForeignAddress = @"";
        
        results = nil;
        //        results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]]];
        results = [database executeQuery:@"select * from prospect_profile where IndexNo = ?",[NSString stringWithFormat:@"%d", partner_indexNo]];
        NSString *gotPartner = @"";
        //  NSLog(@"existing partner: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"]);
        //NSLog(@"eapp check listt - partnerid: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]);
        while ([results next]) {
            gotPartner = @"Y";
            partnerTitle = [results stringForColumn:@"ProspectTitle"];
            partnerName = [results stringForColumn:@"ProspectName"];
            partnerNewICNo = [results stringForColumn:@"IDTypeNo"];
            if (partnerNewICNo == NULL) {
                partnerNewICNo = @"";
            }
            partnerOtherIDType = [results stringForColumn:@"OtherIDType"];
            if (partnerOtherIDType == NULL) {
                partnerOtherIDType = @"";
            }
            partnerOtherID = [results stringForColumn:@"OtherIDTypeNo"];
            if (partnerOtherID == NULL) {
                partnerOtherID = @"";
            }
            
            NSString *pNation=[results stringForColumn:@"Nationality"];
            FMResultSet  *resultNation = [database executeQuery:@"select NationCode from eProposal_Nationality where NationDesc = ?",pNation, Nil];
            while ([resultNation next]) {
                partnerNationality = [resultNation stringForColumn:@"NationCode"];
            }
            
            NSString *pRace=[results stringForColumn:@"Race"];
            FMResultSet *resultRace = [database executeQuery:@"select RaceCode from eProposal_Race where RaceDesc = ?", pRace, Nil];
            if ([resultRace next]) {
                partnerRace = [resultRace stringForColumn:@"RaceCode"];
            }
            
            NSString *pReligion=[results stringForColumn:@"Religion"];
            FMResultSet *resultReligion = [database executeQuery:@"select ReligionCode from eProposal_Religion where ReligionDesc = ?", pReligion, Nil];
            if ([resultReligion next]) {
                partnerReligion = [resultReligion stringForColumn:@"ReligionCode"];
            }
            
            NSString *pSex = [results stringForColumn:@"ProspectGender"];
            if([pSex isEqualToString:@"MALE"])
                partnerSex = @"M";
            else if([pSex isEqualToString:@"FEMALE"])
                partnerSex = @"F";
            
            partnerSmoker = [results stringForColumn:@"Smoker"];
            partnerDob = [results stringForColumn:@"ProspectDOB"];
            
            NSDate *todayDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM/dd/yyyy"];
            int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:dob]];
            int allDays = (((time/60)/60)/24);
            int days = allDays%365;
            int years = (allDays-days)/365;
            partnerAge = [NSString stringWithFormat:@"%d",years];
            
            NSString *pMarital = [results stringForColumn:@"MaritalStatus"];
            FMResultSet *resultsMarital = [database executeQuery:@"select MSCode from eProposal_Marital_Status where MSDesc = ?", pMarital, Nil];
            if ([resultsMarital next]) {
                partnerMaritalStatus = [resultsMarital stringForColumn:@"MSCode"];
            }
            
            
            partnerOccupation = [results stringForColumn:@"ProspectOccupationCode"];
            
            partnerEmailAddress = [results stringForColumn:@"ProspectEmail"];
            
            if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
                partnerForeignAddress = @"0";
            }
            else {
                partnerForeignAddress = @"1";
            }
            
            partnerAddress1 = [results stringForColumn:@"ResidenceAddress1"];
            partnerAddress2 = [results stringForColumn:@"ResidenceAddress2"];
            partnerAddress3 = [results stringForColumn:@"ResidenceAddress3"];
            partnerTown = [results stringForColumn:@"ResidenceAddressTown"];
            partnerState = [results stringForColumn:@"ResidenceAddressState"];
            partnerPostcode = [results stringForColumn:@"ResidenceAddressPostCode"];
            partnerCountry = [results stringForColumn:@"ResidenceAddressCountry"];
            
            if ([[results stringForColumn:@"ResidenceAddressCountry"] isEqualToString:@"MAL"]) {
                partnerPermanentForeignAddress = @"0";
            }
            else {
                partnerPermanentForeignAddress = @"1";
            }
            
            partnerPermanentAddress1 = [results stringForColumn:@"ResidenceAddress1"];
            partnerPermanentAddress2 = [results stringForColumn:@"ResidenceAddress2"];
            partnerPermanentAddress3 = [results stringForColumn:@"ResidenceAddress3"];
            partnerPermanentTown = [results stringForColumn:@"ResidenceAddressTown"];
            partnerPermanentState = [results stringForColumn:@"ResidenceAddressState"];
            partnerPermanentPostcode = [results stringForColumn:@"ResidenceAddressPostCode"];
            partnerPermanentCountry = [results stringForColumn:@"ResidenceAddressCountry"];
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            prospectProfileDate = [format dateFromString:[results stringForColumn:@"DateModified"]];
            
            results = nil;
            results = [database executeQuery:@"SELECT * FROM CFF_Personal_Details WHERE CFFID = ? AND PTypeCode = ?", cffId, @"2"];
            while ([results next]) {
                NSDate *theDate = [format dateFromString:[results stringForColumn:@"LastUpdated"]];
                if ([theDate compare:prospectProfileDate] == NSOrderedDescending || prospectProfileDate == NULL) {
                    
                    if ([[results stringForColumn:@"MailingCountry"] isEqualToString:@"MAL"]) {
                        partnerForeignAddress = @"0";
                    }
                    else {
                        partnerForeignAddress = @"1";
                    }
                    
                    partnerAddress1 = [results stringForColumn:@"MailingAddress1"];
                    partnerAddress2 = [results stringForColumn:@"MailingAddress2"];
                    partnerAddress3 = [results stringForColumn:@"MailingAddress3"];
                    partnerTown = [results stringForColumn:@"MailingTown"];
                    partnerState = [results stringForColumn:@"MailingState"];
                    partnerPostcode = [results stringForColumn:@"MailingPostCode"];
                    partnerCountry = [results stringForColumn:@"MailingCountry"];
                }
                
                partnerAddFromCFF = [results stringForColumn:@"AddFromCFF"];
                partnerAddNewPayor = [results stringForColumn:@"AddNewPayor"];
                partnerSameAsPO = [results stringForColumn:@"SameAsPO"];
                partnerPTypeCode = [results stringForColumn:@"PTypeCode"];
                partnerPYFlag = @"False";
                partnerAddressSameAsPO = [results stringForColumn:@"MailingAddressSameAsPO"];
                partnerPermanentAddressSameAsPO = [results stringForColumn:@"PermanentAddressSameAsPO"];
            }
            
            if (partnerAddFromCFF == NULL) {
                partnerAddFromCFF = @"";
            }
            if (partnerAddNewPayor == NULL) {
                partnerAddNewPayor = @"";
            }
            if (partnerAddressSameAsPO == NULL) {
                partnerAddressSameAsPO = @"";
            }
            if (partnerPTypeCode == NULL) {
                partnerPTypeCode = @"";
            }
            if (partnerPYFlag == NULL) {
                partnerPYFlag = @"False";
            }
            if (partnerSameAsPO == NULL) {
                partnerSameAsPO = @"";
            }
            if (partnerPermanentAddressSameAsPO == NULL) {
                partnerPermanentAddressSameAsPO = @"";
            }
            
            // for addFromCFF and addNewPayor
            results = Nil;
            results = [database executeQuery:@"select count(*) as count from trad_Lapayor as a, clt_profile as b where a.custcode = b.custcode and sino = ? and  b.indexno = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"PartnerProfileID"]], Nil];
            if ([results next]) {
                int i = [results intForColumn:@"count"];
                if (i > 0) {
                    partnerAddFromCFF = @"False";
                    partnerAddNewPayor = @"Fasle";
                }
                else {
                    partnerAddFromCFF = @"True";
                    partnerAddNewPayor = @"True";
                }
            }
            
            // same as PO
            results = Nil;
            results = [database executeQuery:@"select ProspectProfileID from eProposal_LA_Details where eProposalNo = ? and POFlag = 'Y'", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], Nil];
            if ([results next]) {
                if (indexNo == [results intForColumn:@"ProspectProfileID"]) {
                    partnerSameAsPO = @"True";
                }
                else {
                    partnerSameAsPO = @"False";
                }
            }
            
            results = nil;
            //            results = [database executeQuery:@"select * from contact_input where IndexNo = ? and ContactCode = ?",[NSString stringWithFormat:@"%@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"customerIndexNo"]], @"CONT006"];
            results = [database executeQuery:@"select * from eProposal_CFF_Personal_Details where CFFID = ? AND PTypeCode = ?",cffId,@"2"];
            while ([results next]) {
                partnerResidenceNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"ResidencePhoneNoExt"], [results stringForColumn:@"ResidencePhoneNo"]];
                partnerOfficePhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"OfficePhoneNoExt"], [results stringForColumn:@"OfficePhoneNo"]];
                partnerMobilePhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"MobilePhoneNoExt"], [results stringForColumn:@"MobilePhoneNo"]];
                partnerFaxPhoneNo = [NSString stringWithFormat:@"%@%@", [results stringForColumn:@"FaxPhoneNoExt"], [results stringForColumn:@"FaxPhoneNo"]];
            }
            if (partnerResidenceNo == NULL) {
                partnerResidenceNo = @"";
            }
            if (partnerOfficePhoneNo == NULL) {
                partnerOfficePhoneNo = @"";
            }
            if (partnerMobilePhoneNo == NULL) {
                partnerMobilePhoneNo = @"";
            }
            if (partnerFaxPhoneNo == NULL) {
                partnerFaxPhoneNo = @"";
            }
            
            results = nil;
            
        }
        
        
        //        if (![[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
        if (![gotPartner isEqualToString:@"Y"]){
            partnerAddFromCFF = @"";
            partnerAddNewPayor = @"";
            partnerSameAsPO = @"";
            partnerPTypeCode = @"";
            partnerPYFlag = @"";
            partnerTitle = @"";
            partnerName= @"";
            partnerNewICNo = @"";
            partnerOtherIDType = @"";
            partnerOtherID = @"";
            partnerNationality = @"";
            partnerRace = @"";
            partnerReligion = @"";
            partnerSex = @"";
            partnerSmoker = @"";
            partnerDob = @"";
            partnerAge = @"";
            partnerMaritalStatus = @"";
            partnerOccupation = @"";
            partnerResidenceNo = @"";
            partnerOfficePhoneNo = @"";
            partnerMobilePhoneNo = @"";
            partnerFaxPhoneNo = @"";
            partnerEmailAddress = @"";
            partnerAddressSameAsPO = @"";
            partnerAddress1 = @"";
            partnerAddress2 = @"";
            partnerAddress3 = @"";
            partnerTown = @"";
            partnerState = @"";
            partnerPostcode = @"";
            partnerCountry = @"";
            partnerForeignAddress = @"";
            partnerPermanentAddressSameAsPO = @"";
            partnerPermanentAddress1 = @"";
            partnerPermanentAddress2 = @"";
            partnerPermanentAddress3 = @"";
            partnerPermanentTown = @"";
            partnerPermanentState = @"";
            partnerPermanentPostcode = @"";
            partnerPermanentCountry = @"";
            partnerPermanentForeignAddress = @"";
        }
        
        if([partnerForeignAddress isEqualToString:@"0"])
        {
            partnerForeignAddress = @"N";
        }
        if ([partnerForeignAddress isEqualToString:@"1"])
        {
            partnerForeignAddress = @"Y";
            
        }
        
        if([partnerPermanentForeignAddress isEqualToString:@"0"])
        {
            partnerPermanentForeignAddress = @"N";
        }
        if ([partnerPermanentForeignAddress isEqualToString:@"1"])
        {
            partnerPermanentForeignAddress = @"Y";
            
        }
        
        //        if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ExistingPartner"] isEqualToString:@"1"]){
        if ([gotPartner isEqualToString:@"Y"]){
            NSDictionary *partnerInfo = @{@"CFFParty ID=\"2\"" :
                                              @{@"AddFromCFF" : partnerAddFromCFF,
                                                @"AddNewPayor" : partnerAddNewPayor,
                                                @"SameAsPO" : partnerSameAsPO,
                                                @"PTypeCode" : partnerPTypeCode,
                                                @"PYFlag" : partnerPYFlag,
                                                @"Title" : partnerTitle,
                                                @"Name" : partnerName,
                                                @"NewICNo" : partnerNewICNo,
                                                @"OtherIDType" : partnerOtherID,
                                                @"OtherID" : partnerOtherID,
                                                @"Nationality" : partnerNationality,
                                                @"Race" : partnerRace,
                                                @"Religion" : partnerReligion,
                                                @"Sex" : partnerSex,
                                                @"Smoker" : partnerSmoker,
                                                @"DOB" : partnerDob,
                                                @"Age" : partnerAge,
                                                @"MaritalStatus" : partnerMaritalStatus,
                                                @"Occupation" : partnerOccupation,
                                                @"ResidencePhoneNo" : partnerResidenceNo,
                                                @"OfficePhoneNo" : partnerOfficePhoneNo,
                                                @"MobilePhoneNo" : partnerMobilePhoneNo,
                                                @"FaxPhoneNo" : partnerFaxPhoneNo,
                                                @"EmailAddress" : partnerEmailAddress,
                                                @"CFFAddresses" :
                                                    @{@"CFFAddress Type=\"Mailing\"" :
                                                          @{@"AddressSameAsPO":partnerAddressSameAsPO,
                                                            @"Address1":partnerAddress1,
                                                            @"Address2":partnerAddress2,
                                                            @"Address3":partnerAddress3,
                                                            @"Town":partnerTown,
                                                            @"State":partnerState,
                                                            @"Postcode":partnerPostcode,
                                                            @"Country":partnerCountry,
                                                            @"ForeignAddress":partnerForeignAddress,
                                                            },
                                                      @"CFFAddress Type=\"Permanent\"" :
                                                          @{@"AddressSameAsPO":partnerPermanentAddressSameAsPO,
                                                            @"Address1":partnerPermanentAddress1,
                                                            @"Address2":partnerPermanentAddress2,
                                                            @"Address3":partnerPermanentAddress3,
                                                            @"Town":partnerPermanentTown,
                                                            @"State":partnerPermanentState,
                                                            @"Postcode":partnerPermanentPostcode,
                                                            @"Country":partnerPermanentCountry,
                                                            @"ForeignAddress":partnerPermanentForeignAddress,
                                                            },
                                                      },
                                                },
                                          };
            
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:partnerInfo forKey:@"eCFFPartnerInfo"];
            
        }
        
        // child info
        
        //results = nil;
        [results close];
        //cffId=[NSString stringWithFormat:@"%@", cffId];
        NSString *Dummycffid= [NSString stringWithFormat:@"%@", cffId];
        NSString *sqlstrng = [NSString stringWithFormat:@"select count(*) as cnt from eProposal_CFF_Family_Details where CFFID='%@'",Dummycffid];
        
        // NSString *sqlstrng1 = [NSString stringWithFormat:@"select count(*) as cnt from eProposal_CFF_Family_Details where CFFID = ?",Dummycffid];
        // NSLog(@"%@",sqlstrng1);
        
        // NSString *sqlstrng2 = [NSString stringWithFormat:@"select count(*) as cnt from eProposal_CFF_Family_Details where CFFID = %@",Dummycffid];
        // NSLog(@"%@",sqlstrng2);
        
        if (eAppIsUpdate) {
            results = [database executeQuery:sqlstrng];
        }
        else {
            results = [database executeQuery:@"select count(*) as cnt from CFF_Family_Details where CFFID = %s",Dummycffid,Nil];
        }
        int gotChild = 0;
        int gotChildCount = 0;
        if (!results)
            NSLog(@"select error: %@", [database lastErrorMessage]);
        while ([results next]){
            //            NSLog(@"%d %@", [results intForColumnIndex:0], [results dateForColumnIndex:0]);
            if ([results intForColumnIndex:0] > 0){
                //results intForColumn:@"cnt"]
                gotChild = 1;
            }
            
        }
        //        NSLog(@"%i",[results intForColumn:@"cnt"]);
        
        // while ([results next]) {
        // }
        if (gotChild == 1){
            // results = Nil;
            [results close];
            if (!eAppIsUpdate) {
                results = [database executeQuery:@"select * from CFF_Family_Details where CFFID = '%@' order by ID asc",Dummycffid,Nil];
            }
            else {
                NSString *sqlstrng = [NSString stringWithFormat:@"select * from eProposal_CFF_Family_Details where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]];
                
                //                NSLog(@"%@",sqlstrng);
                
                results = [database executeQuery:sqlstrng];
            }
            
            NSString *addFromCFF;
            NSString *sameAsPO;
            NSString *PTypeCode;
            NSString *childName;
            NSString *relationship;
            NSString *dob;
            NSString *age;
            NSString *sex;
            NSString *support;
            
            
            
            
            NSMutableArray *childsInfo = [NSMutableArray array];
            while ([results next]) {
                
                
                gotChildCount++;
                addFromCFF = [results stringForColumn:@"AddFromCFF"];
                sameAsPO = [results stringForColumn:@"SameAsPO"];
                PTypeCode = [results stringForColumn:@"PTypeCode"];
                childName = [results stringForColumn:@"Name"];
                relationship = [results stringForColumn:@"Relationship"];
                dob = [results stringForColumn:@"DOB"];
                age = [results stringForColumn:@"Age"];
                sex = [results stringForColumn:@"Sex"];
                support = [results stringForColumn:@"YearsToSupport"];
                NSString *idno = [NSString stringWithFormat:@"%d", gotChildCount];
                
                if ([addFromCFF isEqualToString:@"1"]) {
                    addFromCFF = @"True";
                }
                else {
                    addFromCFF = @"False";
                }
                
                if ([sameAsPO isEqualToString:@"1"]) {
                    sameAsPO = @"True";
                }
                else {
                    sameAsPO = @"False";
                }
                if ([sex isEqualToString:@"Male"]) {
                    sex = @"M";
                }
                else {
                    sex = @"F";
                }
                
                
                NSDictionary *childInfo = @{[NSString stringWithFormat: @"ChildParty ID=\"%@\"", idno] :
                                                @{@"AddFromCFF":addFromCFF,
                                                  @"SameAsPO":sameAsPO,
                                                  @"PTypeCode":PTypeCode,
                                                  @"Name":childName,
                                                  @"Relationship":relationship,
                                                  @"DOB":dob,
                                                  @"Age":age,
                                                  @"Sex":sex,
                                                  @"YearsToSupport":support,
                                                  },
                                            
                                            };
                [childsInfo addObject:childInfo];
                
            }
            
            
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:childsInfo forKey:@"eCFFChildInfo"];
        }
        
        //protection info
        results = Nil;
        if (!eAppIsUpdate) {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Protection where CFFID = '%@'",cffId]];
        }
        else {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Protection where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
        }
        
        NSString *allocateIncome1;
        NSString *allocateIncome2;
        NSString *totalSACurAmt;
        NSString *totalSAReqAmt;
        NSString *totalSASurAmt;
        NSString *totalCISACurAmt;
        NSString *totalCISAReqAmt;
        NSString *totalCISASurAmt;
        NSString *totalHBCurAmt;
        NSString *totalHBReqAmt;
        NSString *totalHBSurAmt;
        NSString *totalPACurAmt;
        NSString *totalPAReqAmt;
        NSString *totalPASurAmt;
        NSString *hasProtection = @"True";
        bool gotProtection = FALSE;
        while ([results next]) {
            gotProtection = TRUE;
            hasProtection = [results stringForColumn:@"NoExistingPlan"] != NULL ? [results stringForColumn:@"NoExistingPlan"] : @"";
            if ([hasProtection isEqualToString:@"0"]) {
                hasProtection=@"False";
            }
            allocateIncome1 = [results stringForColumn:@"AllocateIncome_1"] != NULL ? [results stringForColumn:@"AllocateIncome_1"] : @"0.00";
            allocateIncome1 = [allocateIncome1 stringByReplacingOccurrencesOfString:@"," withString:@""];
            allocateIncome2 = [results stringForColumn:@"AllocateIncome_2"] != NULL ? [results stringForColumn:@"AllocateIncome_2"] : @"0.00";
            allocateIncome2 = [allocateIncome2 stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalSACurAmt = [results stringForColumn:@"TotalSA_CurrentAmt"] != NULL ? [results stringForColumn:@"TotalSA_CurrentAmt"] : @"0.00";
            totalSACurAmt = [totalSACurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalSAReqAmt = [results stringForColumn:@"TotalSA_RequiredAmt"] != NULL ? [results stringForColumn:@"TotalSA_RequiredAmt"] : @"0.00";
            totalSAReqAmt = [totalSAReqAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalSASurAmt = [results stringForColumn:@"TotalSA_SurplusShortFall"] != NULL ? [results stringForColumn:@"TotalSA_SurplusShortFall"] : @"0.00";
            totalSASurAmt = [totalSASurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalCISACurAmt = [results stringForColumn:@"TotalCISA_CurrentAmt"] != NULL ? [results stringForColumn:@"TotalCISA_CurrentAmt"] : @"0.00";
            totalCISACurAmt = [totalCISACurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalCISAReqAmt = [results stringForColumn:@"TotalCISA_RequiredAmt"] != NULL ? [results stringForColumn:@"TotalCISA_RequiredAmt"] : @"0.00";
            totalCISAReqAmt = [totalCISAReqAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalCISASurAmt = [results stringForColumn:@"TotalCISA_SurplusShortFall"] != NULL ? [results stringForColumn:@"TotalCISA_SurplusShortFall"] : @"0.00";
            totalCISASurAmt = [totalCISASurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalHBCurAmt = [results stringForColumn:@"TotalHB_CurrentAmt"] != NULL ? [results stringForColumn:@"TotalHB_CurrentAmt"] : @"0.00";
            totalHBCurAmt = [totalHBCurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalHBReqAmt = [results stringForColumn:@"TotalHB_RequiredAmt"] != NULL ? [results stringForColumn:@"TotalHB_RequiredAmt"] : @"0.00";
            totalHBReqAmt = [totalHBReqAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalHBSurAmt = [results stringForColumn:@"TotalHB_SurplusShortFall"] != NULL ? [results stringForColumn:@"TotalHB_SurplusShortFall"] : @"0.00";
            totalHBSurAmt = [totalHBSurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalPACurAmt = [results stringForColumn:@"TotalPA_CurrentAmt"] != NULL ? [results stringForColumn:@"TotalPA_CurrentAmt"] : @"0.00";
            totalPACurAmt = [totalPACurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalPAReqAmt = [results stringForColumn:@"TotalPA_RequiredAmt"] != NULL ? [results stringForColumn:@"TotalPA_RequiredAmt"] : @"0.00";
            totalPAReqAmt = [totalPAReqAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            totalPASurAmt = [results stringForColumn:@"TotalHB_SurplusShortFall"] != NULL ? [results stringForColumn:@"TotalHB_SurplusShortFall"] : @"0.00";
            totalPASurAmt = [totalPASurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            
        }
        
        
        
        if (gotProtection) {
            NSDictionary *protectionInfo = @{@"NoExistingPlan" : hasProtection,
                                             @"AllocateIncome_1" : allocateIncome1,
                                             @"AllocateIncome_2" : allocateIncome2,
                                             @"TotalSA_CurAmt" : totalSACurAmt,
                                             @"TotalSA_ReqAmt" : totalSAReqAmt,
                                             @"TotalSA_SurAmt" : totalSASurAmt,
                                             @"TotalCISA_CurAmt" : totalCISACurAmt,
                                             @"TotalCISA_ReqAmt" : totalCISAReqAmt,
                                             @"TotalCISA_SurAmt" : totalCISASurAmt,
                                             @"TotalHB_CurAmt" : totalHBCurAmt,
                                             @"TotalHB_ReqAmt" : totalHBReqAmt,
                                             @"TotalHB_SurAmt" : totalHBSurAmt,
                                             @"TotalPA_CurAmt" : totalPACurAmt,
                                             @"TotalPA_ReqAmt" : totalPAReqAmt,
                                             @"TotalPA_SurAmt" : totalPASurAmt
                                             };
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:protectionInfo forKey:@"eCFFProtectionInfo"];
        }
        //pyna child info
        //protection details
        //? replace with '%@'
        results = Nil;
        int protectionCount;
        protectionCount = 0;
        if (!eAppIsUpdate) {
            results = [database executeQuery:@"select * from CFF_Protection_Details where CFFID = ? order by SeqNo asc",cffId,Nil];
        }
        else  {
            results = [database executeQuery:@"select * from eProposal_CFF_Protection_Details where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
        }
        
        NSMutableArray *protectionsDetails = [NSMutableArray array];
        while ([results next]) {
            
            protectionCount++;
            //hasProtection = [results stringForColumn:@"NoExistingPlan"] != NULL ? [results stringForColumn:@"NoExistingPlan"] : @"";
            NSString *poName = [results stringForColumn:@"POName"] != NULL ? [results stringForColumn:@"POName"] : @"";;
            NSString *company = [results stringForColumn:@"CompanyName"] != NULL ? [results stringForColumn:@"CompanyName"] : @"";;
            NSString *planType = [results stringForColumn:@"PlanType"] != NULL ? [results stringForColumn:@"PlanType"] : @"";;
            NSString *laName = [results stringForColumn:@"LifeAssuredName"] != NULL ? [results stringForColumn:@"LifeAssuredName"] : @"";;
            NSString *benefit1 = [results stringForColumn:@"Benefit1"] != NULL ? [results stringForColumn:@"Benefit1"] : @"";;
            benefit1 = [benefit1 stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *benefit2 = [results stringForColumn:@"Benefit2"] != NULL ? [results stringForColumn:@"Benefit2"] : @"";;
            benefit2 = [benefit2 stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *benefit3 = [results stringForColumn:@"Benefit3"] != NULL ? [results stringForColumn:@"Benefit3"] : @"";;
            benefit3 = [benefit3 stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *benefit4 = [results stringForColumn:@"Benefit4"] != NULL ? [results stringForColumn:@"Benefit4"] : @"";;
            benefit4 = [benefit4 stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *premium = [results stringForColumn:@"Premium"] != NULL ? [results stringForColumn:@"Premium"] : @"";;
            premium = [premium stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *mode = [results stringForColumn:@"Mode"] != NULL ? [results stringForColumn:@"Mode"] : @"";;
            if([mode isEqualToString:@"Annual"])
                mode = @"12";
            else if([mode isEqualToString:@"Semi Annual"])
                mode = @"06";
            else if([mode isEqualToString:@"Quarterly"])
                mode = @"03";
            else if([mode isEqualToString:@"Monthly"])
                mode = @"01";
            NSString *maturityDate = [results stringForColumn:@"MaturityDate"] != NULL ? [results stringForColumn:@"MaturityDate"] : @"";;
            
            NSDictionary *protectionDetails = @{[NSString stringWithFormat:@"ProtectionPlanInfo ID=\"%d\"", protectionCount]:
                                                    @{@"POName":poName,
                                                      @"Company":company,
                                                      @"PlanType":planType,
                                                      @"LAName":laName,
                                                      @"Benefit1":benefit1,
                                                      @"Benefit2":benefit2,
                                                      @"Benefit3":benefit3,
                                                      @"Benefit4":benefit4,
                                                      @"Premium":premium,
                                                      @"Mode":mode,
                                                      @"MaturityDate":maturityDate,
                                                      }
                                                };
            [protectionsDetails addObject:protectionDetails];
        }
        
        if ([protectionsDetails count] > 0) {
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:protectionsDetails forKey:@"eCFFProtectionDetails"];
        }
        
        //retirement info
        results = Nil;
        if (!eAppIsUpdate) {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement where CFFID = '%@'",cffId]];
        }
        else {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
        }
        
        NSString *retirementAllocateIncome1;
        NSString *retirementAllocateIncome2;
        NSString *incomeSource1;
        NSString *incomeSource2;
        NSString *curAmt;
        NSString *reqAmt;
        NSString *surAmt;
        NSString *noExistingPlan = @"True";
        bool gotRetirementPlan = FALSE;
        while ([results next]) {
            gotRetirementPlan = TRUE;
            retirementAllocateIncome1 = [results stringForColumn:@"AllocateIncome_1"] != NULL ? [results stringForColumn:@"AllocateIncome_1"] : @"0.00";
            retirementAllocateIncome1 = [retirementAllocateIncome1 stringByReplacingOccurrencesOfString:@"," withString:@""];
            retirementAllocateIncome2 = [results stringForColumn:@"AllocateIncome_2"] != NULL ? [results stringForColumn:@"AllocateIncome_2"] : @"0.00";
            retirementAllocateIncome2 = [retirementAllocateIncome2 stringByReplacingOccurrencesOfString:@"," withString:@""];
            incomeSource1 = [results stringForColumn:@"OtherIncome_1"] != NULL ? [results stringForColumn:@"OtherIncome_1"] : @"";
            incomeSource2 = [results stringForColumn:@"OtherIncome_2"] != NULL ? [results stringForColumn:@"OtherIncome_2"] : @"";
            curAmt = [results stringForColumn:@"CurrentAmt"] != NULL ? [results stringForColumn:@"CurrentAmt"] : @"0.00";
            curAmt = [curAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            reqAmt = [results stringForColumn:@"RequiredAmt"] != NULL ? [results stringForColumn:@"RequiredAmt"] : @"";
            reqAmt = [reqAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            surAmt = [results stringForColumn:@"SurplusShortFallAmt"] != NULL ? [results stringForColumn:@"SurplusShortFallAmt"] : @"";
            surAmt = [surAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            noExistingPlan = [results stringForColumn:@"NoExistingPlan"] != NULL ? [results stringForColumn:@"NoExistingPlan"] : @"";
            if ([noExistingPlan isEqualToString:@"0"]) {
                noExistingPlan=@"False";
            }
        }
        
        if (gotRetirementPlan) {
            NSDictionary *retirementInfo = @{@"NoExistingPlan" : noExistingPlan,
                                             @"AllocateIncome_1" : retirementAllocateIncome1,
                                             @"AllocateIncome_2" : retirementAllocateIncome2,
                                             @"IncomeSource_1" : incomeSource1,
                                             @"IncomeSource_2" : incomeSource2,
                                             @"CurAmt" : curAmt,
                                             @"ReqAmt" : reqAmt,
                                             @"SurAmt" : surAmt,
                                             };
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:retirementInfo forKey:@"eCFFRetirementInfo"];
        }
        
        results = Nil;
        int retirementCount;
        retirementCount = 0;
        if (!eAppIsUpdate) {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Retirement_Details where CFFID = '%@' order by SeqNo asc",cffId]];
        }
        else {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Retirement_Details where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
        }
        NSMutableArray *retirementsDetails = [NSMutableArray array];
		
        while ([results next]) {
            retirementCount++;
            
            NSString *poName = [results stringForColumn:@"POName"];
            NSString *company = [results stringForColumn:@"CompanyName"];
            NSString *planType = [results stringForColumn:@"PlanType"];
            NSString *premium = [results stringForColumn:@"Premium"];
            premium = [premium stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *frequency = [results stringForColumn:@"Frequency"];
            if([frequency isEqualToString:@"Annual"])
                frequency = @"12";
            else if([frequency isEqualToString:@"Semi Annual"])
                frequency = @"06";
            else if([frequency isEqualToString:@"Quarterly"])
                frequency = @"03";
            else if([frequency isEqualToString:@"Monthly"])
                frequency = @"01";
            NSString *startDate = [results stringForColumn:@"StartDate"];
            NSString *endDate = [results stringForColumn:@"MaturityDate"];
            NSString *LSMaturityAmt = [results stringForColumn:@"ProjectedLumSum"];
            LSMaturityAmt = [LSMaturityAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *AIMaturityAmt = [results stringForColumn:@"ProjectedAnnualIncome"];
            AIMaturityAmt = [AIMaturityAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *benefits = [results stringForColumn:@"AdditionalBenefits"];
            benefits = [benefits stringByReplacingOccurrencesOfString:@"," withString:@""];
			if (benefits == NULL)      //Added by emi, remove null to avoid crash
				benefits = @"";
            
            NSDictionary *retirementDetails = @{[NSString stringWithFormat:@"RetirementPlanInfo ID=\"%d\"", retirementCount] :
                                                    @{@"POName" : poName,
                                                      @"Company" : company,
                                                      @"PlanType" : planType,
                                                      @"Premium" : premium,
                                                      @"Frequency" : frequency,
                                                      @"StartDate" : startDate,
                                                      @"EndDate" : endDate,
                                                      @"LSMaturityAmt" : LSMaturityAmt,
                                                      @"AIMaturityAmt" : AIMaturityAmt,
                                                      @"Benefits" : benefits
                                                      },
                                                };
            [retirementsDetails addObject:retirementDetails];
        }
        
        if ([retirementsDetails count] > 0) {
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:retirementsDetails forKey:@"eCFFRetirementDetails"];
        }
        
        //education info
        results = Nil;
        if (!eAppIsUpdate) {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education where CFFID = '%@'",cffId]];
        }
        else {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
			//NSLog(@"SQL: select * from eProposal_CFF_Education where CFFID = '%@'",cffId );
        }
        
        NSString *educationAllocateIncome1;
        NSString *curAmtC1;
        NSString *reqAmtC1;
        NSString *surAmtC1;
        NSString *curAmtC2;
        NSString *reqAmtC2;
        NSString *surAmtC2;
        NSString *curAmtC3;
        NSString *reqAmtC3;
        NSString *surAmtC3;
        NSString *curAmtC4;
        NSString *reqAmtC4;
        NSString *surAmtC4;
        NSString *educationNoExistingPlan=@"True";
        NSString *eduNoChild=@"True";
        bool gotEducation = FALSE;
        while ([results next]) {
            gotEducation = TRUE;
            educationAllocateIncome1 = [results stringForColumn:@"AllocateIncome_1"] != NULL ? [results stringForColumn:@"AllocateIncome_1"] : @"";
            educationAllocateIncome1 = [educationAllocateIncome1 stringByReplacingOccurrencesOfString:@"," withString:@""];
            curAmtC1 = [results stringForColumn:@"CurrentAmt_Child_1"] != NULL ? [results stringForColumn:@"CurrentAmt_Child_1"] : @"";
            curAmtC1 = [curAmtC1 stringByReplacingOccurrencesOfString:@"," withString:@""];
            reqAmtC1 = [results stringForColumn:@"RequiredAmt_Child_1"] != NULL ? [results stringForColumn:@"RequiredAmt_Child_1"] : @"";
            reqAmtC1 = [reqAmtC1 stringByReplacingOccurrencesOfString:@"," withString:@""];
            surAmtC1 = [results stringForColumn:@"SurplusShortFallAmt_Child_1"] != NULL ? [results stringForColumn:@"SurplusShortFallAmt_Child_1"] : @"";
            surAmtC1 = [surAmtC1 stringByReplacingOccurrencesOfString:@"," withString:@""];
            curAmtC2 = [results stringForColumn:@"CurrentAmt_Child_2"] != NULL ? [results stringForColumn:@"CurrentAmt_Child_2"] : @"";
            curAmtC2 = [curAmtC2 stringByReplacingOccurrencesOfString:@"," withString:@""];
            reqAmtC2 = [results stringForColumn:@"RequiredAmt_Child_2"] != NULL ? [results stringForColumn:@"RequiredAmt_Child_2"] : @"";
            reqAmtC2 = [reqAmtC2 stringByReplacingOccurrencesOfString:@"," withString:@""];
            surAmtC2 = [results stringForColumn:@"SurplusShortFallAmt_Child_2"] != NULL ? [results stringForColumn:@"SurplusShortFallAmt_Child_2"] : @"";
            surAmtC2 = [surAmtC2 stringByReplacingOccurrencesOfString:@"," withString:@""];
            curAmtC3 = [results stringForColumn:@"CurrentAmt_Child_3"] != NULL ? [results stringForColumn:@"CurrentAmt_Child_3"] : @"";
            curAmtC3 = [curAmtC3 stringByReplacingOccurrencesOfString:@"," withString:@""];
            reqAmtC3 = [results stringForColumn:@"RequiredAmt_Child_3"] != NULL ? [results stringForColumn:@"RequiredAmt_Child_3"] : @"";
            reqAmtC3 = [reqAmtC3 stringByReplacingOccurrencesOfString:@"," withString:@""];
            surAmtC3 = [results stringForColumn:@"SurplusShortFallAmt_Child_3"] != NULL ? [results stringForColumn:@"SurplusShortFallAmt_Child_3"] : @"";
            surAmtC3 = [surAmtC3 stringByReplacingOccurrencesOfString:@"," withString:@""];
            curAmtC4 = [results stringForColumn:@"CurrentAmt_Child_4"] != NULL ? [results stringForColumn:@"CurrentAmt_Child_4"] : @"";
            curAmtC4 = [curAmtC4 stringByReplacingOccurrencesOfString:@"," withString:@""];
            reqAmtC4 = [results stringForColumn:@"RequiredAmt_Child_4"] != NULL ? [results stringForColumn:@"RequiredAmt_Child_4"] : @"";
            reqAmtC4 = [reqAmtC4 stringByReplacingOccurrencesOfString:@"," withString:@""];
            surAmtC4 = [results stringForColumn:@"SurplusShortFallAmt_Child_4"] != NULL ? [results stringForColumn:@"SurplusShortFallAmt_Child_4"] : @"";
            surAmtC4 = [surAmtC4 stringByReplacingOccurrencesOfString:@"," withString:@""];
            educationNoExistingPlan = [results stringForColumn:@"NoExistingPlan"] != NULL ? [results stringForColumn:@"NoExistingPlan"] : @"";
            if ([educationNoExistingPlan isEqualToString:@"0"]) {
                educationNoExistingPlan=@"False";
            }
            eduNoChild = [results stringForColumn:@"NoChild"] != NULL ? [results stringForColumn:@"NoChild"] : @"";
            if ([eduNoChild isEqualToString:@"0"]) {
                eduNoChild=@"False";
            }
        }
        
        if (gotEducation) {
            NSDictionary *educationInfo = @{@"NoExistingPlan" : educationNoExistingPlan,
                                            @"NoChild" : eduNoChild,
                                            @"AllocateIncome_1" : educationAllocateIncome1,
                                            @"CurAmt_C1" : curAmtC1,
                                            @"ReqAmt_C1" : reqAmtC1,
                                            @"SurAmt_C1" : surAmtC1,
                                            @"CurAmt_C2" : curAmtC2,
                                            @"ReqAmt_C2" : reqAmtC2,
                                            @"SurAmt_C2" : surAmtC2,
                                            @"CurAmt_C3" : curAmtC3,
                                            @"ReqAmt_C3" : reqAmtC3,
                                            @"SurAmt_C3" : surAmtC3,
                                            @"CurAmt_C4" : curAmtC4,
                                            @"ReqAmt_C4" : reqAmtC4,
                                            @"SurAmt_C4" : surAmtC4
                                            };
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:educationInfo forKey:@"eCFFEducationInfo"];
        }
        
        //education details
        results = Nil;
        int educationCount;
        educationCount = 0;
        NSMutableArray *educationsDetails = [NSMutableArray array];
        if (!eAppIsUpdate) {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_Education_Details where CFFID = '%@' order by SeqNo asc",cffId]];
        }
        else {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_Education_Details where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
        }
        while ([results next]) {
            educationCount++;
            
            NSString *eduName = [results stringForColumn:@"Name"];
            NSString *company = [results stringForColumn:@"CompanyName"];
            NSString *premium = [results stringForColumn:@"Premium"];
            premium = [premium stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *frequency = [results stringForColumn:@"Frequency"];
            if([frequency isEqualToString:@"Annual"])
                frequency = @"12";
            else if([frequency isEqualToString:@"Semi Annual"])
                frequency = @"06";
            else if([frequency isEqualToString:@"Quarterly"])
                frequency = @"03";
            else if([frequency isEqualToString:@"Monthly"])
                frequency = @"01";
            NSString *startDate = [results stringForColumn:@"StartDate"];
            NSString *endDate = [results stringForColumn:@"MaturityDate"];
            NSString *maturityAmt = [results stringForColumn:@"ProjectedValueAtMaturity"];
            maturityAmt = [maturityAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            NSDictionary *educationDetails = @{[NSString stringWithFormat:@"EducPlanInfo ID=\"%d\"",educationCount] :
                                                   @{@"Name" : eduName,
                                                     @"Company" : company,
                                                     @"Premium" : premium,
                                                     @"Frequency" : frequency,
                                                     @"StartDate" : startDate,
                                                     @"EndDate" : endDate,
                                                     @"MaturityAmt" : maturityAmt
                                                     },
                                               
                                               };
            [educationsDetails addObject:educationDetails];
        }
        if ([educationsDetails count] > 0) {
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:educationsDetails forKey:@"eCFFEducationDetails"];
        }
        
        //savings info
        NSString *savingsAllocateIncome1;
        NSString *savingsCurAmt;
        NSString *savingsReqAmt;
        NSString *savingsSurAmt;
        NSString *savingsNoExistingPlan=@"True";
        bool gotSavings = FALSE;
        results = Nil;
        if (!eAppIsUpdate) {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_SavingsInvest where CFFID = '%@'",cffId]];
        }
        else {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_SavingsInvest where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
        }
        
        while ([results next]) {
            gotSavings = TRUE;
            savingsAllocateIncome1 = [results stringForColumn:@"AllocateIncome_1"] != NULL ? [results stringForColumn:@"AllocateIncome_1"] : @"";
            savingsAllocateIncome1 = [savingsAllocateIncome1 stringByReplacingOccurrencesOfString:@"," withString:@""];
            savingsCurAmt = [results stringForColumn:@"CurrentAmt"] != NULL ? [results stringForColumn:@"CurrentAmt"] : @"";
            savingsCurAmt = [savingsCurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            savingsReqAmt = [results stringForColumn:@"RequiredAmt"] != NULL ? [results stringForColumn:@"RequiredAmt"] : @"";
            savingsReqAmt = [savingsReqAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            savingsSurAmt = [results stringForColumn:@"SurplusShortFallAmt"] != NULL ? [results stringForColumn:@"SurplusShortFallAmt"] : @"";
            savingsSurAmt = [savingsSurAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            savingsNoExistingPlan = [results stringForColumn:@"NoExistingPlan"] != NULL ? [results stringForColumn:@"NoExistingPlan"] : @"";
            if ([savingsNoExistingPlan isEqualToString:@"0"]) {
                savingsNoExistingPlan=@"False";
            }
        }
        
        if (gotSavings) {
            NSDictionary *savingInfo = @{@"NoExistingPlan" : savingsNoExistingPlan,
                                         @"AllocateIncome_1" : savingsAllocateIncome1,
                                         @"CurAmt" : savingsCurAmt,
                                         @"ReqAmt" : savingsReqAmt,
                                         @"SurAmt" : savingsSurAmt
                                         };
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:savingInfo forKey:@"eCFFSavingInfo"];
            
        }
        
        //savings details
        results = Nil;
        int savingsCount;
        savingsCount = 0;
        NSMutableArray *savingsDetails = [NSMutableArray array];
        if (!eAppIsUpdate) {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_SavingsInvest_Details where CFFID = '%@' order by SeqNo asc",cffId]];
        }
        else {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from eProposal_CFF_SavingsInvest_Details where eProposalNo = '%@'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]]];
        }
        
        while ([results next]) {
            savingsCount++;
            NSString *poName = [results stringForColumn:@"POName"] != NULL ? [results stringForColumn:@"POName"] : @"";
            NSString *company = [results stringForColumn:@"CompanyName"] != NULL ? [results stringForColumn:@"CompanyName"] : @"";
            NSString *type = [results stringForColumn:@"PlanType"] != NULL ? [results stringForColumn:@"PlanType"] : @"";
            NSString *purpose = [results stringForColumn:@"Purpose"] != NULL ? [results stringForColumn:@"Purpose"] : @"";
            NSString *premium = [results stringForColumn:@"Premium"] != NULL ? [results stringForColumn:@"Premium"] : @"";
            premium = [premium stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *comDate = [results stringForColumn:@"CommDate"] != NULL ? [results stringForColumn:@"CommDate"] : @"";
            NSString *maturityAmt = [results stringForColumn:@"MaturityAmt"] != NULL ? [results stringForColumn:@"MaturityAmt"] : @"";
            maturityAmt = [maturityAmt stringByReplacingOccurrencesOfString:@"," withString:@""];
            // NSDictionary *savingDetails = @{@"SavingPlanInfo ID=\"%d\"",savingsCount;
            NSDictionary *savingDetails = @{[NSString stringWithFormat:@"SavingPlanInfo ID=\"%d\"", savingsCount] :
                                                @{@"POName" : poName,
                                                  @"Company" : company,
                                                  @"Type" : type,
                                                  @"Purpose" : purpose,
                                                  @"Premium" : premium,
                                                  @"ComDate" : comDate,
                                                  @"MaturityAmt" : maturityAmt,
                                                  }
                                            };
            [savingsDetails addObject:savingDetails];
        }
        
        if ([savingsDetails count] > 0) {
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:savingsDetails forKey:@"eCFFSavingsDetails"];
        }
        
        
        //section G
        NSString *gSameAsQuotation = @"";
        NSString *gPlanType = @"";
		
		eAppsListing *eAppList = [[eAppsListing alloc]init];
		gPlanType = [eAppList GetPlanData:1 :[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
		
        
        NSString *gTerm = @"";
        NSString *gInsurerName = @"";
        NSString *gInsuredName = @"";
        NSString *gSA = @"";
        NSString *gReason = @"";
        NSString *gAction = @"";
        NSString *gRecoredOfAdviceBenefits = @"";
        int cff_recordOfAdvice_count = 0;
        NSString *cff_recordOfAdvice_count1;
        
        if (!eAppIsUpdate) {
            results = [database executeQuery:@"select * from CFF_RecordOfAdvice where CFFID = ? and Priority = '1'",cffId,Nil];
        }
        else {
            
            FMResultSet *resultsCount = [database executeQuery:@"select count(*) as cnt from eProposal_CFF_RecordOfAdvice where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
            while ([resultsCount next]) {
                
                cff_recordOfAdvice_count = [resultsCount intForColumn:@"cnt"];
                cff_recordOfAdvice_count1 = [NSString stringWithFormat:@"%d",cff_recordOfAdvice_count];
            }
            results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where eProposalNo = ? and Priority = '1'",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
        }
        
        while ([results next]) {
            gSameAsQuotation = @"True";
            gTerm = [results stringForColumn:@"Term"] != NULL ? [results stringForColumn:@"Term"] : @"";
            gInsurerName = @"Hong Leong Assurance Berhad";
            gInsuredName = [results stringForColumn:@"InsuredName"] != NULL ? [results stringForColumn:@"InsuredName"] : @"";
            gSA = [results stringForColumn:@"SumAssured"] != NULL ? [results stringForColumn:@"SumAssured"] : @"";
            gSA = [gSA stringByReplacingOccurrencesOfString:@"," withString:@""];
            gReason = [results stringForColumn:@"ReasonRecommend"] != NULL ? [results stringForColumn:@"ReasonRecommend"] : @"";
            gAction = [results stringForColumn:@"ActionRemark"] != NULL ? [results stringForColumn:@"ActionRemark"] : @"";
            
        }
        
        results = Nil;
        if (!eAppIsUpdate) {
            results = [database executeQuery:@"select * from CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '1' order by Seq asc",cffId,Nil];
        }
        else {
            
            results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ? and Priority = '1' order by Seq asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
        }
        
        while ([results next]) {
            gRecoredOfAdviceBenefits = [results stringForColumn:@"RiderName"] != NULL ? [results stringForColumn:@"RiderName"] : @"";
        }
        
        NSString *siNo1 = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
        NSString *insuredName1;
//        NSString *planType1 = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
		NSString *planType1 = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
        NSMutableArray *addBen = [NSMutableArray array];
        if ([planType1 isEqualToString:@"TRAD"]) {
            results = [database executeQuery:@"select b.name from Trad_LAPayor as a, Clt_Profile as B where sino = ? and a.custcode = b.custcode and a.PTypeCode = 'LA' and a.sequence = '1'", siNo1, Nil];
            while ([results next]) {
                gInsuredName = [results stringForColumn:@"name"] != NULL ? [results stringForColumn:@"name"] : @"";
            }
            
            results = Nil;
            results = [database executeQuery:@"select PolicyTerm, BasicSA from Trad_Details where SINo = ?", siNo1];
            while ([results next]) {
                gTerm = [results stringForColumn:@"PolicyTerm"] != NULL ? [results stringForColumn:@"PolicyTerm"] : @"";
                gSA = [results stringForColumn:@"BasicSA"] != NULL ? [results stringForColumn:@"BasicSA"] : @"";
                gSA = [gSA stringByReplacingOccurrencesOfString:@"," withString:@""];
            }
            
            results = Nil;
            results = [database executeQuery:@"select riderCode from Trad_Rider_Details where SINo = ?", siNo1, Nil];
            NSMutableArray *riders = [NSMutableArray array];
            while ([results next]) {
                //additionalBenefits = [NSString stringWithFormat:@"%@ %@", additionalBenefits, [results stringForColumn:@"riderCode"]];
                [riders addObject:[results stringForColumn:@"riderCode"]];
                
            }
            FMResultSet *results3;
            
            results = Nil;
            int counter = 1;
            for (NSString *riderCode in riders) {
                results = [database executeQuery:@"select RiderDesc from Trad_Sys_Rider_Profile where RiderCode = ?", riderCode];
                if ([results next]) {
                    NSDictionary *riderDetails;
                    //                    NSDictionary *riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter]:
                    //                                                       @{
                    //                                                           @"RiderName": [results stringForColumn:@"RiderDesc"],
                    //                                                           }};
                    //                    [addBen addObject:riderDetails];
                    
                    results3 = [database executeQuery:@"select * from Trad_Rider_Details where SINo = ? and RiderCode = ?",siNo1, riderCode];
                    while ([results3 next]) {
                        NSString *CoverageUnits = [results3 objectForColumnName:@"Units"];
                        NSString *RiderFullName;
                        NSInteger unit_convert = [CoverageUnits intValue];
                        
                        
                        
                        if (!unit_convert ==0) {
                            RiderFullName = [NSString stringWithFormat:@"%@ (%@ Unit(s))",[results3 stringForColumn:@"RiderDesc"],CoverageUnits];
                            
                            riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter]:
                                                 @{
                                                     @"RiderName": RiderFullName,
                                                     }};
                            [addBen addObject:riderDetails];;
                            
                            
                        }
                        else
                        {
                            
                            riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter]:
                                                 @{
                                                     @"RiderName": [results3 stringForColumn:@"RiderDesc"],
                                                     }};
                            [addBen addObject:riderDetails];
                            
                        }
                    }
                    
                    
                }
            }
        }
        else if ([planType1 isEqualToString:@"ES"]) {
            results = [database executeQuery:@"select b.name from UL_LAPayor as a, Clt_Profile as B where sino = ? and a.custcode = b.custcode and a.PTypeCode = 'LA' and a.seq = '1'", siNo1, Nil];
            while ([results next]) {
                gInsuredName = [results stringForColumn:@"name"] != NULL ? [results stringForColumn:@"name"] : @"";
            }
            
            results = Nil;
            results = [database executeQuery:@"select ATPrem, BasicSA, CovPeriod from UL_Details where SINo = ?", siNo1];
            while ([results next]) {
                gTerm = [results stringForColumn:@"CovPeriod"] != NULL ? [results stringForColumn:@"CovPeriod"] : @"";
                gSA = [results stringForColumn:@"BasicSA"] != NULL ? [results stringForColumn:@"BasicSA"] : @"";
                gSA = [gSA stringByReplacingOccurrencesOfString:@"," withString:@""];
            }
            
            results = Nil;
            results = [database executeQuery:@"select riderCode from UL_Rider_Details where SINo = ?", siNo1, Nil];
            NSMutableArray *riders = [NSMutableArray array];
            while ([results next]) {
                //additionalBenefits = [NSString stringWithFormat:@"%@ %@", additionalBenefits, [results stringForColumn:@"riderCode"]];
                [riders addObject:[results stringForColumn:@"riderCode"]];
            }
            
            results = Nil;
            int counter = 1;
            for (NSString *riderCode in riders) {
                results = [database executeQuery:@"select RiderDesc from UL_Rider_Profile where RiderCode = ?", riderCode];
                if ([results next]) {
                    NSDictionary *riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter]:
                                                       @{
                                                           @"RiderName": [results stringForColumn:@"RiderDesc"],
                                                           }};
                    [addBen addObject:riderDetails];
                }
            }
        }
        
        NSDictionary *recordOfAdviceP1 = @{@"RecCount":cff_recordOfAdvice_count1,
                                           @"Priority ID=\"1\"" :
                                               @{@"Seq" : @"1",
                                                 @"SameAsQuotation" : gSameAsQuotation,
                                                 @"PlanType" : gPlanType,
                                                 @"Term" : gTerm,
                                                 @"InsurerName" : gInsurerName,
                                                 @"InsuredName" : gInsuredName,
                                                 @"SA" : gSA,
                                                 @"Reason" : gReason,
                                                 @"Action" : gAction,
                                                 @"RecordOfAdviceBenefits" : addBen
                                                 }
                                           };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:recordOfAdviceP1 forKey:@"eCFFRecordOfAdviceP1"];
        
        NSString *g2SameAsQuotation = @"";
        NSString *g2PlanType = @"";
        NSString *g2Term = @"";
        NSString *g2InsurerName = @"";
        NSString *g2InsuredName = @"";
        NSString *g2SA = @"";
        NSString *g2Reason = @"";
        NSString *g2Action = @"";
        NSString *g2RecoredOfAdviceBenefits = @"";
        NSString *checkPlanType = @"";
        bool gotP2 = FALSE;
        results = nil;
        if (!eAppIsUpdate) {
            results = [database executeQuery:@"select * from CFF_RecordOfAdvice where CFFID = ? and Priority = '2'",cffId,Nil];
        }
        else {
            results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice where eProposalNo = ? and Priority = '2' and PlanType != ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],checkPlanType,Nil];
        }
        
        while ([results next]) {
            gotP2 = TRUE;
            g2SameAsQuotation = @"1";
            g2PlanType = [results stringForColumn:@"PlanType"] != NULL ? [results stringForColumn:@"PlanType"] : @"";
            g2Term = [results stringForColumn:@"Term"] != NULL ? [results stringForColumn:@"Term"] : @"";
            g2InsurerName = @"Hong Leong Assurance Berhad";
            g2InsuredName = [results stringForColumn:@"InsuredName"] != NULL ? [results stringForColumn:@"InsuredName"] : @"";
            g2SA = [results stringForColumn:@"SumAssured"] != NULL ? [results stringForColumn:@"SumAssured"] : @"";
            g2SA = [g2SA stringByReplacingOccurrencesOfString:@"," withString:@""];
            g2Reason = [results stringForColumn:@"ReasonRecommend"] != NULL ? [results stringForColumn:@"ReasonRecommend"] : @"";
            g2Action = [results stringForColumn:@"ActionRemark"] != NULL ? [results stringForColumn:@"ActionRemark"] : @"";
            
        }
        
        results = Nil;
        if (!eAppIsUpdate) {
            results = [database executeQuery:@"select * from CFF_RecordOfAdvice_Rider where CFFID = ? and Priority = '2' order by Seq asc",cffId,Nil];
        }
        else {
            results = [database executeQuery:@"select * from eProposal_CFF_RecordOfAdvice_Rider where eProposalNo = ? and Priority = '2' order by Seq asc",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
        }
        
        while ([results next]) {
            g2RecoredOfAdviceBenefits = [results stringForColumn:@"RiderName"] != NULL ? [results stringForColumn:@"RiderName"] : @"";
        }
        
        if (gotP2) {
            NSDictionary *recordOfAdviceP2 = @{@"Priority ID=\"2\"" :
                                                   @{@"Seq" : @"2",
                                                     @"SameAsQuotation" : g2SameAsQuotation,
                                                     @"PlanType" : g2PlanType,
                                                     @"Term" : g2Term,
                                                     @"InsurerName" : g2InsurerName,
                                                     @"InsuredName" : g2InsuredName,
                                                     @"SA" : g2SA,
                                                     @"Reason" : g2Reason,
                                                     @"Action" : g2Action,
                                                     @"RecordOfAdviceBenefits" : g2RecoredOfAdviceBenefits
                                                     },
                                               };
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:recordOfAdviceP2 forKey:@"eCFFRecoredOfAdviceP2"];
        }
        
        
        //Section I
        NSString *choice1 = @"";
        NSString *choice2 = @"";
        NSString *choice3 = @"";
        NSString *choice4 = @"";
        NSString *choice5 = @"";
        NSString *choice6 = @"";
        NSString *choice6Desc = @"";
        
        results = Nil;
        if (!eAppIsUpdate) {
            results = [database executeQuery:[NSString stringWithFormat:@"select * from CFF_CA where CFFID = '%@'",cffId]];
        }
        else {
            results = [database executeQuery:@"select * from eProposal_CFF_CA where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],Nil];
        }
        
        while ([results next]) {
            
            choice1 = [results stringForColumn:@"Choice1"] != NULL ? [results stringForColumn:@"Choice1"] : @"";
            choice2 = [results stringForColumn:@"Choice2"] != NULL ? [results stringForColumn:@"Choice2"] : @"";
            choice3 = [results stringForColumn:@"Choice3"] != NULL ? [results stringForColumn:@"Choice3"] : @"";
            choice4 = [results stringForColumn:@"Choice4"] != NULL ? [results stringForColumn:@"Choice4"] : @"";
            choice5 = [results stringForColumn:@"Choice5"] != NULL ? [results stringForColumn:@"Choice5"] : @"";
            choice6 = [results stringForColumn:@"Choice6"] != NULL ? [results stringForColumn:@"Choice6"] : @"";
            choice6Desc = [results stringForColumn:@"Choices6Desc"] != NULL ? [results stringForColumn:@"Choices6Desc"] : @"";
        }
        
        
        NSDictionary *confirmationOfAdviceGivenTo = @{@"Choice1" : ![choice1 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                      @"Choice2" : ![choice2 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                      @"Choice3" : ![choice3 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                      @"Choice4" : ![choice4 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                      @"Choice5" : ![choice5 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                      @"Choice6" : ![choice6 isEqualToString:@"0"] ? @"TRUE" : @"FALSE",
                                                      @"Choice6_desc" : choice6Desc,
                                                      };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:confirmationOfAdviceGivenTo forKey:@"eCFFConfirmationAdviceGivenTo"];
        
        results = Nil;
        int recommendCount;
        recommendCount = 0;//ok
        NSMutableArray *recommendedProducts = [NSMutableArray array];
        NSString *siNo = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
        NSString *insuredName;
        NSString *planType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
		NSString *SIType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
		
        NSString *term;
        NSString *premium;
        NSString *frequency = @"12";
        NSString *SA;
        NSString *boughtOption = @"Y";
        NSString *addNew = @"N";
        NSString *additionalBenefits = @"";
        //FMResultSet *result_paymentAmount;
        
        NSString *mode = @"";
        NSString *PaymentMode_Trad = @"";
        NSString *PaymentMode = @"";
        NSString *sino = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
        
        NSString *eproposalNo =  [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
        
        
        
        if ([SIType isEqualToString:@"TRAD"]) {
            
            results = [database executeQuery:@"select b.name from Trad_LAPayor as a, Clt_Profile as B where sino = ? and a.custcode = b.custcode", siNo, Nil];
            NSMutableArray *sampleArray=[[NSMutableArray alloc]init];
            while ([results next]) {
                insuredName = [results stringForColumn:@"name"] != NULL ? [results stringForColumn:@"name"] : @"";
                [sampleArray addObject:insuredName];
                NSLog(@"%@",sampleArray
                      );
            }
            
            for (int i=0; i<sampleArray.count; i++) {
                insuredName=[sampleArray objectAtIndex:i];
                
                results = Nil;
                results = [database executeQuery:@"select PolicyTerm, BasicSA from Trad_Details where SINo = ?", siNo];
                while ([results next]) {
                    term = [results stringForColumn:@"PolicyTerm"] != NULL ? [results stringForColumn:@"PolicyTerm"] : @"";
                    SA = [results stringForColumn:@"BasicSA"] != NULL ? [results stringForColumn:@"BasicSA"] : @"";
                }
                
                results = Nil;
                FMResultSet *results;
                FMResultSet *results2;
                
                
                
                
                results = [database executeQuery:@"SELECT SIType, SIVersion,BasicPlanCode, eAppVersion, CreatedAt, PaymentMode, SystemName from eProposal WHERE eProposalNo = ?",eproposalNo];
                
                while ([results next]) {
                    
                    
                    
                    PaymentMode_Trad  = [results stringForColumn:@"PaymentMode"];
                }
                //            results = [database executeQuery:@"select Annually from SI_Store_premium where SINo = ? and Type = 'B'", siNo, Nil];
                //            while ([results next]) {
                //                premium = [results stringForColumn:@"Annually"] != NULL ? [results stringForColumn:@"Annually"] : @"";
                //            }
                //modif//
				
				NSString *GSTmode;
				
                if([PaymentMode_Trad isEqualToString:@"Annual"])
                {
                    
                    results =  [database executeQuery:@"SELECT  Annually, GST_Annual  FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                    mode = @"Annually";
                    PaymentMode = @"12";
					GSTmode = @"GST_Annual";
                }
                
                else if([PaymentMode_Trad isEqualToString:@"SemiAnnual"])
                {
                    
                    results =  [database executeQuery:@"SELECT  SemiAnnually, GST_Semi FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                    mode = @"SemiAnnually";
                    PaymentMode = @"06";
					GSTmode = @"GST_Semi";
                }
                
                else if([PaymentMode_Trad isEqualToString:@"Quarterly"])
                {
                    
                    results =  [database executeQuery:@"SELECT  Quarterly, GST_Quarter FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",siNo];
                    mode = @"Quarterly";
                    PaymentMode = @"03";
					GSTmode = @"GST_Quarter";
                }
                
                else if([PaymentMode_Trad isEqualToString:@"Monthly"])
                {
                    
                    results =  [database executeQuery:@"SELECT  Monthly, GST_Month FROM SI_Store_premium WHERE SiNo = ? AND Type != 'BOriginal' and SemiAnnually IS NOT NULL",sino];
                    mode = @"Monthly";
                    PaymentMode = @"01";
					GSTmode = @"GST_Month";
                    
                }
                
				
				double Test1 = 0;
				double Test2 = 0;
				NSString *testtest = @"";
				
				NSString *TGst;
				double CalGST = 0;
				
				NSNumberFormatter *fmt2 = [[NSNumberFormatter alloc] init];
				[fmt2 setMaximumFractionDigits:2];
				[fmt2 setPositiveFormat:@"###0.00"];
				
                while ([results next]) {
                    
                    //                    premium = [results stringForColumn:mode];
                    
					testtest = [[results stringForColumn:mode]stringByReplacingOccurrencesOfString:@"," withString:@""];
					Test1 = [testtest doubleValue];
					Test2 = Test1 + Test2;
					
					TGst = [[results stringForColumn:GSTmode]stringByReplacingOccurrencesOfString:@"," withString:@""];
					CalGST = [TGst doubleValue];
					Test2 = Test2 + CalGST;
					
					premium = [NSString stringWithFormat:@"%g",Test2];
					premium = [fmt2 stringFromNumber:[fmt2 numberFromString:premium]];
					
					SavingValue =premium;
					
										
                }
				
                //				NSLog(@"premium: %@", premium);
                //modify//
				
				
                results = Nil;
                
                if(i==0){
                    
                    
                    
                    
                    results = [database executeQuery:@"select riderCode, riderdesc from Trad_Rider_Details where SINo = ? and Seq='1' and PTypeCode ='LA'", siNo, Nil];
                    
                }
                else if(i==1)
                {
                    
                    
                    results = [database executeQuery:@"select distinct riderCode, riderdesc,seq,ptypecode from Trad_Rider_Details where SINo = ? and Seq = '2' or PTypeCode ='PY' ", siNo, Nil];
                    
                }
                
                NSMutableArray *riders = [NSMutableArray array];
                while ([results next]) {
                    //additionalBenefits = [NSString stringWithFormat:@"%@ %@", additionalBenefits, [results stringForColumn:@"riderCode"]];
                    [riders addObject:[results stringForColumn:@"riderCode"]];
                }
                
                results = Nil;
                results2 = Nil;
                NSString *PlanOption;
                NSString *CoverageUnits;
                NSString *Deductible;
                NSString *RiderFullName;
                int counter = 1;
                NSMutableArray *addBen = [NSMutableArray array];
                NSDictionary *riderDetails;
                for (NSString *riderCode in riders) {
                    results = [database executeQuery:@"select RiderDesc from Trad_Sys_Rider_Profile where RiderCode = ?", riderCode];
                    if ([results next]) {
                        
                        results2 = [database executeQuery:@"select * from Trad_Rider_Details where SINo = ? and RiderCode = ?",siNo, riderCode];
                        while ([results2 next]) {
                            PlanOption = [results2 objectForColumnName:@"PlanOption"];
                            CoverageUnits = [results2 objectForColumnName:@"Units"];
                            NSInteger unit_convert = [CoverageUnits intValue];
                            Deductible = [results2 objectForColumnName:@"Deductible"];
                            
                            
                            if (!unit_convert ==0) {
                                RiderFullName = [NSString stringWithFormat:@"%@ (%@ Unit(s))",[results2 stringForColumn:@"RiderDesc"],CoverageUnits];
                                
                                riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter++]:
                                                     @{
                                                         @"RiderName": RiderFullName,
                                                         }};
                                [addBen addObject:riderDetails];
                                
                                
                            }
                            else
                            {
                                //                            if (![PlanOption isEqualToString:@"(null)"]) {
                                //                                if ([Deductible isEqualToString:@"(null)"]) {
                                //                                    RiderFullName = [NSString stringWithFormat:@"%@ (%@)",[results stringForColumn:@"RiderDesc"],PlanOption];
                                //                                    riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter++]:
                                //                                                         @{
                                //                                                             @"RiderName": RiderFullName,
                                //                                                             }};
                                //                                    [addBen addObject:riderDetails];
                                //
                                //
                                //                                }
                                //                                else
                                //                                {
                                //                                    RiderFullName = [NSString stringWithFormat:@"%@ (%@) (Deductible - %@)",[results stringForColumn:@"RiderDesc"],PlanOption,Deductible];
                                //                                    riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter++]:
                                //                                                         @{
                                //                                                             @"RiderName": RiderFullName,
                                //                                                             }};
                                //                                    [addBen addObject:riderDetails];
                                //
                                //
                                //                                }
                                //
                                //                            }
                                //                            else
                                //                            {
                                
                                riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter++]:
                                                     @{
                                                         @"RiderName": [results2 stringForColumn:@"RiderDesc"],
                                                         }};
                                [addBen addObject:riderDetails];
                                //                            }
                            }
                            
                            
                            
                        }
                        
                        
                    }
                }
                
                NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
                [fmt setMaximumFractionDigits:2];
                [fmt setPositiveFormat:@"###0.00"];
                // SA = [fmt stringFromNumber:[fmt numberFromString:SA]];
                // premium = [fmt stringFromNumber:[fmt numberFromString:premium]];
                SA = [SA stringByReplacingOccurrencesOfString:@"," withString:@""];
                premium = [premium stringByReplacingOccurrencesOfString:@"," withString:@""];
                
                FMResultSet *results_getcount;
                NSString *precCount;
                
                //results_getcount = [database executeQuery:@"select count(*) as count_rec from Trad_LAPayor where siNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]];
                
                results_getcount = [database executeQuery:@"select count(*) as count_rec from Trad_LAPayor as a, Clt_Profile as B where sino = ? and a.custcode = b.custcode", siNo, Nil];
                
                //results_getcount = [database executeQuery:@"select count(*) as count_rec from Trad_LAPayor where sino = ?", siNo, Nil];
                
                while ([results_getcount next]) {
                    precCount = [results_getcount stringForColumn:@"count_rec"] != NULL ? [results_getcount stringForColumn:@"count_rec"] : @"0";
                }
                
                //                                                                   @"RecCount": precCount,
                
                
                if(premium==NULL)
                    premium=@"";
                if (insuredName == NULL)
                    insuredName = @"";
                if (planType == NULL)
                    planType = @"";
                if (term == NULL)
                    term = @"";
                if (PaymentMode == NULL)
                    PaymentMode = @"";
                if (SA == NULL)
                    SA = @"";
                if (boughtOption == NULL)
                    boughtOption = @"";
                if (addNew == NULL)
                    addNew = @"";
                
                NSDictionary *productRecommended = @{@"RecCount":precCount,
                                                     [NSString stringWithFormat:@"RecommendationInfo ID=\"%d\"", ++recommendCount]:
                                                         @{@"Seq" : [NSString stringWithFormat:@"%d", 1],
                                                           @"InsuredName" : insuredName,
                                                           @"PlanType" : planType,
                                                           @"Term" : term,
                                                           @"Premium" : premium,
                                                           @"Frequency" : PaymentMode,
                                                           @"SA" : SA,
                                                           @"BoughtOpt" : boughtOption,
                                                           @"AddNew" : addNew,
                                                           @"AdditionalBenefits" : addBen,
                                                           }
                                                     };
                
                [recommendedProducts addObject:productRecommended];
            }
        }
        
        // }
        
        
        else if ([SIType isEqualToString:@"ES"]) {
            
            results = [database executeQuery:@"select b.name from UL_LAPayor as a, Clt_Profile as B where sino = ? and a.custcode = b.custcode and a.PTypeCode = 'LA' and a.seq = '1'", siNo, Nil];
            
            while ([results next]) {
                insuredName = [results stringForColumn:@"name"] != NULL ? [results stringForColumn:@"name"] : @"";
            }
            
            results = Nil;
            results = [database executeQuery:@"select ATPrem, BasicSA, CovPeriod from UL_Details where SINo = ?", siNo];
            while ([results next]) {
                term = [results stringForColumn:@"CovPeriod"] != NULL ? [results stringForColumn:@"CovPeriod"] : @"";
                SA = [results stringForColumn:@"BasicSA"] != NULL ? [results stringForColumn:@"BasicSA"] : @"";
                premium = [results stringForColumn:@"ATPrem"] != NULL ? [results stringForColumn:@"ATPrem"] : @"";
            }
            
            results = Nil;
            results = [database executeQuery:@"select riderCode from UL_Rider_Details where SINo = ?", siNo, Nil];
            NSMutableArray *riders = [NSMutableArray array];
            while ([results next]) {
                //additionalBenefits = [NSString stringWithFormat:@"%@ %@", additionalBenefits, [results stringForColumn:@"riderCode"]];
                [riders addObject:[results stringForColumn:@"riderCode"]];
            }
            
            results = Nil;
            int counter = 1;
            NSMutableArray *addBen = [NSMutableArray array];
            for (NSString *riderCode in riders) {
                results = [database executeQuery:@"select RiderDesc from UL_Rider_Profile where RiderCode = ?", riderCode];
                if ([results next]) {
                    NSDictionary *riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" , counter++]:
                                                       @{
                                                           @"RiderName": [results stringForColumn:@"RiderDesc"],
                                                           }};
                    [addBen addObject:riderDetails];
                }
            }
            
            NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
            [fmt setMaximumFractionDigits:2];
            [fmt setPositiveFormat:@"###0.00"];
            // SA = [fmt stringFromNumber:[fmt numberFromString:SA]];
            // premium = [fmt stringFromNumber:[fmt numberFromString:premium]];
            SA = [SA stringByReplacingOccurrencesOfString:@"," withString:@""];
            premium = [premium stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            NSDictionary *productRecommended = @{[NSString stringWithFormat:@"RecommendationInfo ID=\"%d\"",++recommendCount] :
                                                     @{@"Seq" : [NSString stringWithFormat:@"%d", 1],
                                                       @"InsuredName" : insuredName,
                                                       @"PlanType" : planType,
                                                       @"Term" : term,
                                                       @"Premium" : premium,
                                                       @"Frequency" : frequency,
                                                       @"SA" : SA,
                                                       @"BoughtOpt" : boughtOption,
                                                       @"AddNew" : addNew,
                                                       @"AdditionalBenefits" : addBen,
                                                       }
                                                 };
            
            [recommendedProducts addObject:productRecommended];
            
        }
        
        if (!eAppIsUpdate) {
            results = [database executeQuery:@"select * from CFF_CA_Recommendation where CFFID = ? order by Seq asc",cffId,Nil];
        }
        else {
            results = [database executeQuery:@"select * from eProposal_CFF_CA_Recommendation where eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"]];
        }
        
        
        while ([results next]) {
            //recommendCount=2;
            recommendCount++;
            NSString *insuredName = [results stringForColumn:@"InsuredName"] != NULL ? [results stringForColumn:@"InsuredName"] : @"";
            NSString *planType = [results stringForColumn:@"PlanType"] != NULL ? [results stringForColumn:@"PlanType"] :@"";
            NSString *term = [results stringForColumn:@"Term"] != NULL ? [results stringForColumn:@"Term"] : @"";
            NSString *premium = [results stringForColumn:@"Premium"] != NULL ? [results stringForColumn:@"Premium"] : @"";
            NSString *frequency = [results stringForColumn:@"Frequency"] != NULL ? [results stringForColumn:@"Frequency"] : @"";
            NSString *SA = [results stringForColumn:@"SumAssured"] != NULL ? [results stringForColumn:@"SumAssured"] : @"";
            SA = [SA stringByReplacingOccurrencesOfString:@"," withString:@""];
            premium = [premium stringByReplacingOccurrencesOfString:@"," withString:@""];
            
            
            NSString *boughtOption = [results stringForColumn:@"BoughtOption"] != NULL ? [results stringForColumn:@"BoughtOption"] : @"";
            if ([boughtOption isEqualToString:@"-1"]) {
                boughtOption = @"Y";
            }
            else if ([boughtOption isEqualToString:@"0"])
            {
                boughtOption = @"N";
            }
            
            NSString *addNew = [results stringForColumn:@"AddNew"] != NULL ? [results stringForColumn:@"AddNew"] : @"";
            if ([addNew isEqualToString:@"True"]) {
                addNew = @"Y";
            }
            else if ([addNew isEqualToString:@"False"])
            {
                addNew = @"N";
            }
            
            //  NSString *additionalBenefits = [results stringForColumn:@"AddNew"] != NULL ? [results stringForColumn:@"AddNew"] : @"";
            //            NSArray* addben=[[NSArray alloc] init];
            NSMutableArray *addBen = [NSMutableArray array];
            //NSString *addben;
            NSString *seq;
            NSString *recomendCount_str;
            NSString *empty_field = @"";
            int adjusted_recomendCount;
            adjusted_recomendCount = recommendCount -1;
            recomendCount_str = [NSString stringWithFormat:@"%d",adjusted_recomendCount];
            
            FMResultSet *resultsAddBen;
            if (!eAppIsUpdate) {
                resultsAddBen = [database executeQuery:@"select * from  CFF_CA_Recommendation_Rider where CFFID = ?",cffId,Nil];
            }
            else {
                resultsAddBen = [database executeQuery:@"select * from  eProposal_CFF_CA_Recommendation_Rider where eProposalNo = ? And RiderName != ?",[[obj.eAppData objectForKey:@"EAPP"]  objectForKey:@"eProposalNo"],empty_field];
            }
            while ([resultsAddBen next]) {
                seq = [resultsAddBen stringForColumn:@"Seq"];
                if ([seq isEqualToString:recomendCount_str]) {
                    //addben = [resultsAddBen stringForColumn:@"RiderName"] != NULL ? [resultsAddBen stringForColumn:@"RiderName"] : @"";
                    
                    NSDictionary *riderDetails = @{[NSString stringWithFormat: @"Rider ID = \"%d\"" ,1]:
                                                       @{
                                                           @"RiderName": [resultsAddBen stringForColumn:@"RiderName"],
                                                           }};
                    [addBen addObject:riderDetails];
                    
                }
                
            }
            
            NSDictionary *productRecommended = @{[NSString stringWithFormat:@"RecommendationInfo ID=\"%d\"", recommendCount] :
                                                     @{@"Seq" : [NSString stringWithFormat:@"%d", recommendCount],
                                                       @"InsuredName" : insuredName,
                                                       @"PlanType" : planType,
                                                       @"Term" : term,
                                                       @"Premium" : premium,
                                                       @"Frequency" : frequency,
                                                       @"SA" : SA,
                                                       @"BoughtOpt" : boughtOption,
                                                       @"AddNew" : addNew,
                                                       @"AdditionalBenefits" :addBen,
                                                       }
                                                 };
            [recommendedProducts addObject:productRecommended];
        }
        
        if ([recommendedProducts count] > 0) {
            
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:recommendedProducts forKey:@"eCFFRecommendedProducts"];
        }
        
    }
    [database close];
}

#pragma mark - Proposal XML Data
-(void)storeProposalXML {
    //NSLog(@"insertIntoXML");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    NSString *stringID = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    
    //credit card info
    FMResultSet *resultsXML = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
    
    NSString *cardMemberAccountNo;
    NSString *cardExpiredDate;
    NSString *cardMemberName;
    NSString *cardMemberNewIcNo;
    NSString *cardMemberContactNo;
    NSString *cardMemberRelationship;
    NSString *creditCardType;
    NSString *creditCardBank;
    
    NSString *FTcardMemberAccountNo;
    NSString *FTcardExpiredDate;
    NSString *FTcardMemberName;
    NSString *FTcardMemberNewIcNo;
    NSString *FTcardMemberContactNo;
    NSString *FTcardMemberRelationship;
    NSString *FTcreditCardType;
    NSString *FTcreditCardBank;
    NSString *FTcardMemberSex;
    NSString *FTcardMemberDOB;
    NSString *FTcardMemberOtherIDType;
    NSString *FTcardMemberOtherID;
    NSString *FTEPP;
    
    //Directcredit Info
    
    NSString *PBBankname;
    NSString *DirectCredit;
    NSString *PBAccType;
    NSString *PBAccNo;
    NSString *PBPayeeType;
    NSString *PBNRIC;
    NSString *PBOtherIDType;
    NSString *PBOtherID;
    NSString *PBEmail;
    NSString *PBMobileNo;
    
    //FATCA Info
    NSString *PTypeCode;
    NSString *Seq;
    NSString *PersonChoice;
    NSString *BizCategoryChoice;
    NSString *FATCAClassification;
    NSString *GIIN;
    NSString *EntityType;
    
    
    
    
    
    
    bool gotCreditCard;
    bool gotFTCreditCard;
    while ([resultsXML next]) {
        gotCreditCard = TRUE;
        cardMemberAccountNo = [resultsXML stringForColumn:@"CardMemberAccountNo"] != NULL ? [resultsXML stringForColumn:@"CardMemberAccountNo"] : @"";
        cardExpiredDate = [resultsXML stringForColumn:@"CardExpiredDate"] != NULL ? [resultsXML stringForColumn:@"CardExpiredDate"] : @"";
        cardMemberName = [resultsXML stringForColumn:@"CardMemberName"] != NULL ? [resultsXML stringForColumn:@"CardMemberName"] : @"";
        cardMemberNewIcNo = [resultsXML stringForColumn:@"CardMemberNewICNo"] != NULL ? [resultsXML stringForColumn:@"CardMemberNewICNo"] : @"";
        cardMemberContactNo = [resultsXML stringForColumn:@"CardMemberContactNo"] != NULL ? [resultsXML stringForColumn:@"CardMemberContactNo"] : @"";
        cardMemberRelationship = [resultsXML stringForColumn:@"CardMemberRelationship"] != NULL ? [resultsXML stringForColumn:@"CardMemberRelationship"] : @"";
        FMResultSet  *resultRelationship = [database executeQuery:@"select RelCode from eProposal_Relation where RelDesc = ?",cardMemberRelationship, Nil];
        while ([resultRelationship next])
        {
            cardMemberRelationship = [resultRelationship stringForColumn:@"RelCode"];
        }
        creditCardType = [resultsXML stringForColumn:@"CreditCardType"] != NULL ? [resultsXML stringForColumn:@"CreditCardType"] : @"";
        creditCardBank = [resultsXML stringForColumn:@"CreditCardBank"] != NULL ? [resultsXML stringForColumn:@"CreditCardBank"] : @"";
        
        //For FTCreditCard
        FTcardMemberAccountNo = [resultsXML stringForColumn:@"FTCardMemberAccountNo"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberAccountNo"] : @"";
        FTcardMemberOtherIDType = [resultsXML stringForColumn:@"FTCardMemberOtherIDType"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberOtherIDType"] : @"";
        FTcardMemberOtherID = [resultsXML stringForColumn:@"FTCardMemberOtherID"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberOtherID"] : @"";
        FTcardMemberDOB = [resultsXML stringForColumn:@"FTCardMemberDOB"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberDOB"] : @"";
        FTcardMemberSex = [resultsXML stringForColumn:@"FTCardMemberSex"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberSex"] : @"";
        FTcardExpiredDate = [resultsXML stringForColumn:@"FTCardExpiredDate"] != NULL ? [resultsXML stringForColumn:@"FTCardExpiredDate"] : @"";
        FTcardMemberName = [resultsXML stringForColumn:@"FTCardMemberName"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberName"] : @"";
        FTcardMemberNewIcNo = [resultsXML stringForColumn:@"FTCardMemberNewICNo"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberNewICNo"] : @"";
        if  ((NSNull *) FTcardMemberNewIcNo == [NSNull null])
            FTcardMemberNewIcNo = @"";
        FTcardMemberContactNo = [resultsXML stringForColumn:@"FTCardMemberContactNo"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberContactNo"] : @"";
        FTcardMemberRelationship = [resultsXML stringForColumn:@"FTCardMemberRelationship"] != NULL ? [resultsXML stringForColumn:@"FTCardMemberRelationship"] : @"";
        FMResultSet  *FTresultRelationship = [database executeQuery:@"select RelCode from eProposal_Relation where RelDesc = ?",FTcardMemberRelationship, Nil];
        while ([FTresultRelationship next])
        {
            gotFTCreditCard = TRUE;
            FTcardMemberRelationship = [FTresultRelationship stringForColumn:@"RelCode"];
        }
        FTcreditCardType = [resultsXML stringForColumn:@"FTCreditCardType"] != NULL ? [resultsXML stringForColumn:@"FTCreditCardType"] : @"";
        FTcreditCardBank = [resultsXML stringForColumn:@"FTCreditCardBank"] != NULL ? [resultsXML stringForColumn:@"FTCreditCardBank"] : @"";
        
        FTEPP = [resultsXML stringForColumn:@"EPP"] != NULL ? [resultsXML stringForColumn:@"EPP"] : @"";
        
        
        
        if  ((NSNull *) FTcardMemberAccountNo == [NSNull null])
            FTcardMemberAccountNo = @"";
        
        if ([FTcardMemberAccountNo isEqualToString:@"(null)"] || [FTcardMemberAccountNo isEqualToString:@"nil"] || [FTcardMemberAccountNo isEqualToString:@"null"] || [FTcardMemberAccountNo isEqualToString:@"NULL"] || [FTcardMemberAccountNo isEqualToString:@"<null>"] || [FTcardMemberAccountNo isEqualToString:@"<nil>"]) {
            FTcardMemberAccountNo = @"";
        }
        
        if  ((NSNull *) FTcardExpiredDate == [NSNull null])
            FTcardExpiredDate = @"";
        
        if  ((NSNull *) FTcardMemberName == [NSNull null])
            FTcardMemberName = @"";
        
        if  ((NSNull *) FTcardMemberSex == [NSNull null])
            FTcardMemberSex = @"";
        
        if  ((NSNull *) FTcardMemberDOB == [NSNull null])
            FTcardMemberDOB = @"";
        
        if  ((NSNull *) FTcardMemberOtherIDType == [NSNull null])
            FTcardMemberOtherIDType = @"";
        
        if  ((NSNull *) FTcardMemberOtherID == [NSNull null])
            FTcardMemberOtherID = @"";
        
        if  ((NSNull *) FTcardMemberNewIcNo == [NSNull null])
            FTcardMemberNewIcNo = @"";
        
        if  ((NSNull *) FTcardMemberContactNo == [NSNull null])
            FTcardMemberContactNo = @"";
        
        if  ((NSNull *) FTcardMemberRelationship == [NSNull null])
            FTcardMemberRelationship = @"";
        
        if  ((NSNull *) FTcreditCardType == [NSNull null])
            FTcreditCardType = @"";
        
        if  ((NSNull *) FTcreditCardBank == [NSNull null])
            FTcreditCardBank = @"";
        
        if  ((NSNull *) FTEPP == [NSNull null])
            FTEPP = @"";
        
        
        
        //ForDirectCreditInfo
        
        //        DirectCredit = [resultsXML stringForColumn:@"isDirectCredit"] != NULL ? [resultsXML stringForColumn:@"isDirectCredit"] : @"";
        //
        //        if ([DirectCredit isEqualToString:@"false"]) {
        //            DirectCredit = @"N";
        //        }
        //        if ([DirectCredit isEqualToString:@"true"]) {
        //            DirectCredit = @"Y";
        //        }
        PBBankname = [resultsXML stringForColumn:@"DCBankName"] != NULL ? [resultsXML stringForColumn:@"DCBankName"] : @"";
        PBAccType = [resultsXML stringForColumn:@"DCAccType"] != NULL ? [resultsXML stringForColumn:@"DCAccType"] : @"";
        PBAccNo = [resultsXML stringForColumn:@"DCAccNo"] != NULL ? [resultsXML stringForColumn:@"DCAccNo"] : @"";
        PBPayeeType = [resultsXML stringForColumn:@"DCPayeeType"] != NULL ? [resultsXML stringForColumn:@"DCPayeeType"] : @"";
        PBNRIC = [resultsXML stringForColumn:@"DCNRIC"] != NULL ? [resultsXML stringForColumn:@"DCNRIC"] : @"";
        PBOtherIDType = [resultsXML stringForColumn:@"DCOtherIDType"] != NULL ? [resultsXML stringForColumn:@"DCOtherIDType"] : @"";
        PBOtherID = [resultsXML stringForColumn:@"DCOtherID"] != NULL ? [resultsXML stringForColumn:@"DCOtherID"] : @"";
        PBEmail = [resultsXML stringForColumn:@"DCEmail"] != NULL ? [resultsXML stringForColumn:@"DCEmail"] : @"";
        PBMobileNo = [resultsXML stringForColumn:@"DCMobileNo"] != NULL ? [resultsXML stringForColumn:@"DCMobileNo"] : @"";
        
        if  (((NSNull *) DirectCredit == [NSNull null]) || ([DirectCredit isEqualToString:@"(null)"]))
            DirectCredit = @"";
        
        if  (((NSNull *) PBBankname == [NSNull null]) || ([PBBankname isEqualToString:@"(null)"]))
            PBBankname = @"";
        
        if  (((NSNull *) PBAccType == [NSNull null]) || ([PBAccType isEqualToString:@"(null)"]))
            PBAccType = @"";
        
        if  (((NSNull *) PBAccNo == [NSNull null]) || ([PBAccNo isEqualToString:@"(null)"]))
            PBAccNo = @"";
        
        if  (((NSNull *) PBPayeeType == [NSNull null]) || ([PBPayeeType isEqualToString:@"(null)"]))
            PBPayeeType = @"";
        
        if  (((NSNull *) PBNRIC == [NSNull null]) || ([PBNRIC isEqualToString:@"(null)"]))
            PBNRIC = @"";
        
        if  (((NSNull *) PBOtherIDType == [NSNull null]) || ([PBOtherIDType isEqualToString:@"(null)"]))
            PBOtherIDType = @"";
        
        if  (((NSNull *) PBOtherID == [NSNull null]) || ([PBOtherID isEqualToString:@"(null)"]))
            PBOtherID = @"";
        
        if  (((NSNull *) PBEmail == [NSNull null]) || ([PBEmail isEqualToString:@"(null)"]))
            PBEmail = @"";
        
        if  (((NSNull *) PBMobileNo == [NSNull null]) || ([PBMobileNo isEqualToString:@"(null)"]))
            PBMobileNo = @"";
        
        
        
        //ForFATCA info
        
        PTypeCode = @"PO";
        Seq = @"1";
        PersonChoice = [resultsXML stringForColumn:@"FACTA_Q2"] != NULL ? [resultsXML stringForColumn:@"FACTA_Q2"] : @"";
        BizCategoryChoice = [resultsXML stringForColumn:@"FACTA_Q4"] != NULL ? [resultsXML stringForColumn:@"FACTA_Q4"] : @"";
        FATCAClassification = [resultsXML stringForColumn:@"FACTA_Q4_Ans_1"] != NULL ? [resultsXML stringForColumn:@"FACTA_Q4_Ans_1"] : @"";
        GIIN = [resultsXML stringForColumn:@"FACTA_Q4_Ans_2"] != NULL ? [resultsXML stringForColumn:@"FACTA_Q4_Ans_2"] : @"";
        EntityType = [resultsXML stringForColumn:@"FACTA_Q5_Entity"] != NULL ? [resultsXML stringForColumn:@"FACTA_Q5_Entity"] : @"";
        
        
        if  (((NSNull *) PersonChoice == [NSNull null]) || ([PersonChoice isEqualToString:@"(null)"]))
            PersonChoice = @"";
        
        if  (((NSNull *) BizCategoryChoice == [NSNull null]) || ([BizCategoryChoice isEqualToString:@"(null)"]))
            BizCategoryChoice = @"";
        
        if  (((NSNull *) FATCAClassification == [NSNull null]) || ([FATCAClassification isEqualToString:@"(null)"]))
            FATCAClassification = @"";
        
        if  (((NSNull *) GIIN == [NSNull null]) || ([GIIN isEqualToString:@"(null)"]))
            GIIN = @"";
        
        if  (((NSNull *) EntityType == [NSNull null]) || ([EntityType isEqualToString:@"(null)"]))
            EntityType = @"";
        
        
        
        
    }
    
    if (gotCreditCard) {
        cardExpiredDate = [cardExpiredDate stringByReplacingOccurrencesOfString:@" " withString:@"/"];
        cardMemberContactNo = [cardMemberContactNo stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSDictionary *creditCardInfo = @{@"CardMemberAccountNo" : cardMemberAccountNo,
                                         @"CardExpiredDate" : cardExpiredDate,
                                         @"CardMemberName" : cardMemberName,
                                         @"CardMemberNewICNo" : cardMemberNewIcNo,
                                         @"CardMemberContactNo" : cardMemberContactNo,
                                         @"CardMemberRelationship" : cardMemberRelationship,
                                         @"CreditCardType" : creditCardType,
                                         @"CreditCardBank" : creditCardBank,
                                         @"PBPayeeType" :PBPayeeType,
                                         };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:creditCardInfo forKey:@"proposalCreditCardInfo"];
        
        FTcardExpiredDate = [FTcardExpiredDate stringByReplacingOccurrencesOfString:@" " withString:@"/"];
        FTcardMemberContactNo = [FTcardMemberContactNo stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSDictionary *FTcreditCardInfo = @{@"FTCardMemberAccountNo" : FTcardMemberAccountNo,
                                           @"FTCardExpiredDate" : FTcardExpiredDate,
                                           @"FTCardMemberName" : FTcardMemberName,
                                           @"FTCardMemberSex" : FTcardMemberSex,
                                           @"FTCardMemberDOB" : FTcardMemberDOB,
                                           @"FTCardMemberOtherIDType" : FTcardMemberOtherIDType,
                                           @"FTCardMemberOtherID" : FTcardMemberOtherID,
                                           @"FTCardMemberNewICNo" : FTcardMemberNewIcNo,
                                           @"FTCardMemberContactNo" : FTcardMemberContactNo,
                                           @"FTCardMemberRelationship" : FTcardMemberRelationship,
                                           @"FTCreditCardType" : FTcreditCardType,
                                           @"FTCreditCardBank" : FTcreditCardBank,
                                           @"FTEPP":FTEPP,
                                           };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:FTcreditCardInfo forKey:@"proposalFTCreditCardInfo"];
        
        
        
        NSDictionary *DCcreditCardInfo =  @{@"DirectCredit" : PBBankname,
                                            @"PBBankname" : PBBankname,
                                            @"PBAccType" : PBAccType,
                                            @"PBAccNo" : PBAccNo,
                                            @"PBPayeeType" :PBPayeeType,
                                            @"PBNRIC" : PBNRIC,
                                            @"PBOtherIDType" : PBOtherIDType,
                                            @"PBOtherID" : PBOtherID,
                                            @"PBEmail" : PBEmail,
                                            @"PBMobileNo" : PBMobileNo,
                                            };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:DCcreditCardInfo forKey:@"DCCreditCardInfo"];
        
        NSDictionary *FATCAInfo =      @{@"PTypeCode" : PTypeCode,
                                         @"Seq" : Seq,
                                         @"PersonChoice" : PersonChoice,
                                         @"BizCategoryChoice" : BizCategoryChoice,
                                         @"FATCAClassification" : FATCAClassification,
                                         @"GIIN" : GIIN,
                                         @"EntityType" : EntityType,
                                         
                                         };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:FATCAInfo forKey:@"FATCAInfo"];
        
        
    }
    

    
    //payment info
    resultsXML = nil;
    resultsXML = [database executeQuery:@"select * from  eProposal where eProposalNo = ?",stringID,Nil];
    
    NSString *firstTimePayment;
    NSString *paymentMode;
    NSString *paymentMethod;
    NSString *totalModalPremium;
    NSString *totalModalPremium1;
    NSString *paymentFinalAcceptance;
	
	NSString *totalGST;
	NSString *totalPayAmt;
	
    bool gotPayment = FALSE;
    while ([resultsXML next])
	{
        gotPayment = TRUE;
        firstTimePayment = [resultsXML stringForColumn:@"FirstTimePayment"] != NULL ? [resultsXML stringForColumn:@"FirstTimePayment"] : @"";
        paymentMode = [resultsXML stringForColumn:@"PaymentMode"] != NULL ? [resultsXML stringForColumn:@"PaymentMode"] : @"";
        paymentMethod = [resultsXML stringForColumn:@"RecurringPayment"] != NULL ? [resultsXML stringForColumn:@"RecurringPayment"] : @"";
        totalModalPremium1 = [resultsXML stringForColumn:@"TotalModalPremium"] != NULL ? [resultsXML stringForColumn:@"TotalModalPremium"] : @"";
        paymentFinalAcceptance = [resultsXML stringForColumn:@"PaymentUponFinalAcceptance"] != NULL ? [resultsXML stringForColumn:@"PaymentUponFinalAcceptance"] : @"";
		totalModalPremium = totalModalPremium1;
		
		totalPayAmt = [resultsXML stringForColumn:@"TotalPayableAmt"] != NULL ? [resultsXML stringForColumn:@"TotalPayableAmt"] : @"";
		totalGST = [resultsXML stringForColumn:@"TotalGSTAmt"] != NULL ? [resultsXML stringForColumn:@"TotalGSTAmt"] : @"";
		
        if ([CompanyCase isEqualToString:@"Yes"]) {
            float tmp = [totalModalPremium floatValue];
            tmp = tmp * 1.06;
            totalModalPremium = [NSString stringWithFormat:@"%.2f",tmp];
//			SavingValue = totalModalPremium;
			
			NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
			NSString *totalValueOfPayable = [prefs1 stringForKey:@"totalAllValue"];
			SavingValue = totalValueOfPayable;
			
        }
        
    }
    
    if ([paymentMode isEqualToString:@"Annual"]) {
        paymentMode = @"YEARLY";
    }
    else if ([paymentMode isEqualToString:@"SemiAnnual"]) {
        paymentMode = @"HALF YEARLY";
    }
    else if ([paymentMode isEqualToString:@"Quarterly"]) {
        paymentMode = @"QUARTERLY";
    }
    else if ([paymentMode isEqualToString:@"Monthly"]) {
        paymentMode = @"MONTHLY";
    }
	else if ([paymentMode isEqualToString:@""] || ((NSNull *) paymentMode == [NSNull null]) || ([paymentMode isEqualToString:@"(null)"])) {
        paymentMode = @"";
    }
	
	if (((NSNull *) firstTimePayment == [NSNull null]) || ([firstTimePayment isEqualToString:@"(null)"])) {
		firstTimePayment = @"";
    }
	
	if (((NSNull *) paymentMethod == [NSNull null]) || ([paymentMethod isEqualToString:@"(null)"])) {
		paymentMethod = @"";
    }
	
	if (((NSNull *) paymentFinalAcceptance == [NSNull null]) || ([paymentFinalAcceptance isEqualToString:@"(null)"])) {
		paymentFinalAcceptance = @"";
    }
	
	if (((NSNull *) SavingValue == [NSNull null]) || ([SavingValue isEqualToString:@"(null)"]) || SavingValue == nil) {
		SavingValue = @"";
    }
	SavingValue = [SavingValue stringByReplacingOccurrencesOfString:@"," withString:@""];
	

	if (((NSNull *) totalGST == [NSNull null]) || ([totalGST isEqualToString:@"(null)"])) {
		totalGST = @"";
    }
	if (((NSNull *) totalPayAmt == [NSNull null]) || ([totalPayAmt isEqualToString:@"(null)"])) {
		totalPayAmt = @"";
    }
	
	NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
	[prefs1 setObject:totalPayAmt forKey:@"totalAllValue"];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:totalGST forKey:@"totalGstValue"];
	
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select PaymentModeCode from eProposal_Payment_Mode where PaymentModeDesc = ?", paymentMode];
    while ([resultsXML next]) {
        paymentMode = [resultsXML stringForColumn:@"PaymentModeCode"] != NULL ? [resultsXML stringForColumn:@"PaymentModeCode"] : @"";
    }
	

    
    if (gotPayment) {
        NSDictionary *paymentInfo = @{@"FirstTimePayment" : firstTimePayment,
                                      @"PaymentMode" : paymentMode,
                                      @"PaymentMethod" : paymentMethod,
                                      @"TotalModalPremium" : SavingValue,
                                      @"PaymentFinalAcceptance" : paymentFinalAcceptance,
                                      };
        //NSLog(@"paymentMode: %@", paymentInfo);
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:paymentInfo forKey:@"proposalPaymentInfo"];
    }
    
    //quesionaire
    resultsXML = Nil;
	resultsXML = [database executeQuery:@"select count(*) as count from  eProposal_QuestionAns where eProposalNo = ?",stringID,Nil];
	int gotHQ = 0;
	int gotHQCount = 0;
	while ([resultsXML next]) {
		if ([resultsXML intForColumn:@"count"] > 0) {
			gotHQ = 1;
		}
	}
    if (gotHQ == 1) {
        NSMutableArray *questionaires = [NSMutableArray array];
        NSArray *LATypes = [[NSArray alloc] initWithObjects:@"LA1", @"LA2", @"PO", nil];
        for (NSString *LAType in LATypes) {
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and LAType = ? order by ID asc",stringID, LAType, Nil];
            int gotHQCount = 0;
            NSString *height;
            NSString *weight;
            NSString *q1BAns;
            NSString *q1BReason;
            //            NSString *q2Ans;
            //            NSString *q2Reason;
            NSString *q3Ans;
            NSString *q3Reason1;
            NSString *q3Reason2;
            NSString *q3Reason3;
            NSString *q4Ans;
            NSString *q4Reason;
            NSString *q5Ans;
            NSString *q5Reason;
            //            NSString *q6Ans;
            //            NSString *q6Reason;
            NSString *q7AAns;
            NSString *q7AReason;
            NSString *q7BAns;
            NSString *q7BReason;
            NSString *q7CAns;
            NSString *q7CReason;
            NSString *q7DAns;
            NSString *q7DReason;
            NSString *q7EAns;
            NSString *q7EReason;
            NSString *q7FAns;
            NSString *q7FReason;
            NSString *q7GAns;
            NSString *q7GReason;
            NSString *q7HAns;
            NSString *q7HReason;
            NSString *q7IAns;
            NSString *q7IReason;
            NSString *q7JAns;
            NSString *q7JReason;
            NSString *q8AAns;
            NSString *q8AReason;
            NSString *q8BAns;
            NSString *q8BReason;
            NSString *q8CAns;
            NSString *q8CReason;
            //            NSString *q8DAns;
            //            NSString *q8DReason;
            //            NSString *q8EAns;
            //            NSString *q8EReason;
            //            NSString *q9Ans;
            //            NSString *q9Reason;
            NSString *q10Ans;
            NSString *q10Reason;
            NSString *q11Ans;
            NSString *q11Reason;
            NSString *q12Ans;
            NSString *q12Reason;
            NSString *q13Ans;
            NSString *q13Reason;
            NSString *q14AAns;
            NSString *q14AReason;
            NSString *q14BAns;
            NSString *q14BReason;
            NSString *q15Ans;
            NSString *q15Reason;
            NSString *hw;
            NSArray *ary;
            NSArray *smokeARY;
            int totalSmoke;
            NSString *cigarettes;
            NSString *pipe;
            NSString *cigar;
            NSString *eCigarettes;
            int icigarettes;
            int ipipe;
            int icigar;
            int ieCigarettes;
            NSArray *pregnantAry;
            NSString *weeks;
            NSString *months;
            double iweeks;
            int imonths;
            
            while ([resultsXML next]) {
                gotHQCount++;
                switch (gotHQCount) {
                    case 1:
                        hw = [resultsXML stringForColumn:@"Answer"];
                        ary = [hw componentsSeparatedByString:@" "];
                        height = ![[ary objectAtIndex:0] isEqualToString:@"(null)"] ? [ary objectAtIndex:0] : @"";
                        weight = ![[ary objectAtIndex:1] isEqualToString:@"(null)"] ? [ary objectAtIndex:1] : @"";
                        break;
                    case 2:
                        q1BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q1BReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //NSLog(@"q1BReason: %@", q1BReason);
                        break;
                        //                    case 3:
                        //                        q2Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q2Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        break;
                    case 3:
                        q3Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q3Reason1 = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        q3Reason1 = [q3Reason1 stringByReplacingOccurrencesOfString:@" " withString:@";"];
                        
                        //                        q3Reason2 = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        q3Reason3 = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 4:
                        q4Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q4Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        
                        smokeARY = [q4Reason componentsSeparatedByString:@" "];
                        cigarettes = ![[smokeARY objectAtIndex:0] isEqualToString:@"(null)"] ? [smokeARY objectAtIndex:0] : @"";
                        pipe = ![[smokeARY objectAtIndex:1] isEqualToString:@"(null)"] ? [smokeARY objectAtIndex:1] : @"";
                        cigar = ![[smokeARY objectAtIndex:1] isEqualToString:@"(null)"] ? [smokeARY objectAtIndex:2] : @"";
                        eCigarettes = ![[smokeARY objectAtIndex:1] isEqualToString:@"(null)"] ? [smokeARY objectAtIndex:3] : @"";
                        
                        icigarettes = [cigarettes intValue];
                        ipipe = [pipe intValue];
                        icigar = [cigar intValue];
                        ieCigarettes = [eCigarettes intValue];
                        
                        totalSmoke = icigarettes + ipipe + icigar + ieCigarettes;
                        
                        //                        q4Reason = [q4Reason stringByReplacingOccurrencesOfString:@" " withString:@";"];
                        if ([q4Ans isEqualToString:@"Y"]) {
                            
                            q4Reason = [NSString stringWithFormat:@"%d;Cigarettes:%@|Pipe:%@|Cigar:%@|Electronic Cigarettes:%@", totalSmoke, cigarettes, pipe, cigar, eCigarettes];
                            
                        }else
                        {
                            q4Reason = @"";
                        }
                        
                        
                        break;
                    case 5:
                        q5Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q5Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                        //                    case 7:
                        //                        q6Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q6Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        break;
                    case 6:
                        q7AAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7AReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 7:
                        q7BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7BReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 8:
                        q7CAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7CReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 9:
                        q7DAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7DReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 10:
                        q7EAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7EReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 11:
                        q7FAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7FReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 12:
                        q7GAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7GReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 13:
                        q7HAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7HReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 14:
                        q7IAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7IReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 15:
                        q7JAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q7JReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 16:
                        q8AAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q8AReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 17:
                        q8BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q8BReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    case 18:
                        q8CAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q8CReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                        //                    case 21:
                        //                        q8DAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q8DReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        break;
                        //                    case 22:
                        //                        q8EAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q8EReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        break;
                        //                    case 23:
                        //                        q9Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        //                        q9Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        //                        break;
                    case 19:
                        q10Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                        q10Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                        break;
                    default:
                        break;
                }
            }
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1029", LAType, Nil];
            while ([resultsXML next]) {
                q11Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q11Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1030", LAType, Nil];
            while ([resultsXML next]) {
                q12Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q12Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1031", LAType, Nil];
            while ([resultsXML next]) {
                q13Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q13Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            // This is for Female Questions
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1027", LAType, Nil];
            while ([resultsXML next]) {
                q14AAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q14AReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                
                if ([q14AAns isEqualToString:@"Y"]) {
                    
                    pregnantAry = [q14AReason componentsSeparatedByString:@" "];
                    weeks = ![[pregnantAry objectAtIndex:0] isEqualToString:@"(null)"] ? [pregnantAry objectAtIndex:0] : @"";
                    months = ![[pregnantAry objectAtIndex:1] isEqualToString:@"(null)"] ? [pregnantAry objectAtIndex:1] : @"";
                    
                    iweeks = [weeks intValue];
                    
                    imonths = round(iweeks/4);
                    
                    //                    q14AReason = [q14AReason stringByReplacingOccurrencesOfString:@" " withString:@";"];
                    if (imonths < 1)
                    {
                        imonths = 1;
                    }
                    else if (imonths > 9)
                    {
                        imonths = 9;
                    }
                    q14AReason = [NSString stringWithFormat:@"%d;%@:Months|%@:Weeks", imonths, months, weeks];
                }
                else
                {
                    q14AReason = @"";
                }
                
                
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1028", LAType, Nil];
            while ([resultsXML next]) {
                q14BAns = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q14BReason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
            }
            
            resultsXML = nil;
            resultsXML = [database executeQuery:@"select * from  eProposal_QuestionAns where eProposalNo = ? and QnID = ? and LAType = ?",stringID, @"Q1032", LAType, Nil];
            while ([resultsXML next]) {
                q15Ans = [resultsXML stringForColumn:@"Answer"] != NULL ? [resultsXML stringForColumn:@"Answer"] : @"";
                q15Reason = [resultsXML stringForColumn:@"Reason"] != NULL ? [resultsXML stringForColumn:@"Reason"] : @"";
                q15Reason = [q15Reason stringByReplacingOccurrencesOfString:@" " withString:@";"];
                
            }
            
            if (gotHQCount > 0) {
                
                NSString *SeqQ;
                if ([LAType isEqualToString:@"LA1"]) {
                    SeqQ = @"1";
                }
                else if ([LAType isEqualToString:@"LA2"]) {
                    SeqQ = @"2";
                }
                else if ([LAType isEqualToString:@"PO"]) {
                    SeqQ = @"2";
                }
                
                if([q3Ans isEqualToString:@"N"])
                {
                    q3Reason1 = @"";
                }
                
                if([q15Ans isEqualToString:@"N"])
                {
                    q15Reason = @"";
                }
                
                
                
                
                NSString *LAType1 = [[LAType componentsSeparatedByCharactersInSet: [[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
                
                NSString *PYChange1 = @"N";
                if([LAType1 isEqualToString:@"PO"] && [SeqQ isEqualToString:@"2"]){
                    LAType1=@"LA";
                    PYChange1 =@"Y";
                }
                NSDictionary *questionaireInfo = @{@"QuestionaireCount" : @"30",
                                                   @"Questionaire ID=\"1\"" :
                                                       @{@"PTypeCode" : LAType1,
                                                         @"Seq" : SeqQ,
                                                         @"Height" : height,
                                                         @"Weight" : weight,
                                                         @"Questions ID=\"1\"" :
                                                             @{@"QnID":@"Q1001",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"TXT",
                                                               @"Answer":[NSString stringWithFormat:@"%@;%@",height, weight],
                                                               @"Reason":@"",
                                                               },
                                                         @"Questions ID=\"2\"" :
                                                             @{@"QnID":@"Q1002",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q1BAns,
                                                               @"Reason":q1BReason,
                                                               },
                                                         //                                                         @"Questions ID=\"3\"" :
                                                         //                                                             @{@"QnID":@"Q1003",
                                                         //                                                               @"QnParty":@"I",
                                                         //                                                               @"AnswerType":@"OPT",
                                                         //                                                               @"Answer":q2Ans,
                                                         //                                                               @"Reason":q2Reason,
                                                         //                                                               },
                                                         @"Questions ID=\"3\"" :
                                                             @{@"QnID":@"Q1004",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q3Ans,
                                                               @"Reason":q3Reason1,
                                                               },
                                                         // [NSString stringWithFormat:@"%@;%@;",q3Reason1,q3Reason2,q3Reason3]
                                                         //                                                        @"Questions ID=\"4\"" :
                                                         //                                                             @{@"QnID":@"Q1004",
                                                         //                                                               @"QnParty":@"I",
                                                         //                                                              @"AnswerType":@"OPT",
                                                         //                                                               @"Answer":q3Ans,
                                                         //                                                               @"Reason":q3Reason2,
                                                         //                                                               },
                                                         //                                                         @"Questions ID=\"4\"" :
                                                         //                                                             @{@"QnID":@"Q1004",
                                                         //                                                               @"QnParty":@"I",
                                                         //                                                               @"AnswerType":@"OPT",
                                                         //                                                              @"Answer":q3Ans,
                                                         //                                                               @"Reason":q3Reason3,
                                                         //                                                               },
                                                         @"Questions ID=\"4\"" :
                                                             @{@"QnID":@"Q1005",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q4Ans,
                                                               @"Reason":q4Reason,
                                                               },
                                                         @"Questions ID=\"5\"" :
                                                             @{@"QnID":@"Q1006",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q5Ans,
                                                               @"Reason":q5Reason,
                                                               },
                                                         //                                                         @"Questions ID=\"7\"" :
                                                         //                                                             @{@"QnID":@"Q1007",
                                                         //                                                               @"QnParty":@"I",
                                                         //                                                               @"AnswerType":@"OPT",
                                                         //                                                               @"Answer":q6Ans,
                                                         //                                                               @"Reason":q6Reason,
                                                         //                                                               },
                                                         @"Questions ID=\"6\"" :
                                                             @{@"QnID":@"Q1008",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7AAns,
                                                               @"Reason":q7AReason,
                                                               },
                                                         @"Questions ID=\"7\"" :
                                                             @{@"QnID":@"Q1010",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7BAns,
                                                               @"Reason":q7BReason,
                                                               },
                                                         @"Questions ID=\"8\"" :
                                                             @{@"QnID":@"Q1011",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7CAns,
                                                               @"Reason":q7CReason,
                                                               },
                                                         @"Questions ID=\"9\"" :
                                                             @{@"QnID":@"Q1012",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7DAns,
                                                               @"Reason":q7DReason,
                                                               },
                                                         @"Questions ID=\"10\"" :
                                                             @{@"QnID":@"Q1013",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7EAns,
                                                               @"Reason":q7EReason,
                                                               },
                                                         @"Questions ID=\"11\"" :
                                                             @{@"QnID":@"Q1014",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7FAns,
                                                               @"Reason":q7FReason,
                                                               },
                                                         @"Questions ID=\"12\"" :
                                                             @{@"QnID":@"Q1015",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7GAns,
                                                               @"Reason":q7GReason,
                                                               },
                                                         @"Questions ID=\"13\"" :
                                                             @{@"QnID":@"Q1016",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7HAns,
                                                               @"Reason":q7HReason,
                                                               },
                                                         @"Questions ID=\"14\"" :
                                                             @{@"QnID":@"Q1017",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7IAns,
                                                               @"Reason":q7IReason,
                                                               },
                                                         @"Questions ID=\"15\"" :
                                                             @{@"QnID":@"Q1018",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q7JAns,
                                                               @"Reason":q7JReason,
                                                               },
                                                         @"Questions ID=\"16\"" :
                                                             @{@"QnID":@"Q1033",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q8AAns,
                                                               @"Reason":q8AReason,
                                                               },
                                                         @"Questions ID=\"17\"" :
                                                             @{@"QnID":@"Q1034",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q8BAns,
                                                               @"Reason":q8BReason,
                                                               },
                                                         @"Questions ID=\"18\"" :
                                                             @{@"QnID":@"Q1035",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q8CAns,
                                                               @"Reason":q8CReason,
                                                               },
                                                         //                                                         @"Questions ID=\"21\"" :
                                                         //                                                             @{@"QnID":@"Q1023",
                                                         //                                                               @"QnParty":@"I",
                                                         //                                                               @"AnswerType":@"OPT",
                                                         //                                                               @"Answer":q8DAns,
                                                         //                                                               @"Reason":q8DReason,
                                                         //                                                               },
                                                         //                                                         @"Questions ID=\"22\"" :
                                                         //                                                             @{@"QnID":@"Q1024",
                                                         //                                                               @"QnParty":@"I",
                                                         //                                                               @"AnswerType":@"OPT",
                                                         //                                                               @"Answer":q8EAns,
                                                         //                                                               @"Reason":q8EReason,
                                                         //                                                               },
                                                         //                                                         @"Questions ID=\"23\"" :
                                                         //                                                             @{@"QnID":@"Q1025",
                                                         //                                                               @"QnParty":@"I",
                                                         //                                                               @"AnswerType":@"OPT",
                                                         //                                                               @"Answer":q9Ans,
                                                         //                                                               @"Reason":q9Reason,
                                                         //                                                               },
                                                         @"Questions ID=\"19\"" :
                                                             @{@"QnID":@"Q1026",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q10Ans,
                                                               @"Reason":q10Reason,
                                                               },
                                                         @"Questions ID=\"20\"" :
                                                             @{@"QnID":@"Q1029",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q11Ans,
                                                               @"Reason":q11Reason,
                                                               },
                                                         @"Questions ID=\"21\"" :
                                                             @{@"QnID":@"Q1025",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q12Ans,
                                                               @"Reason":q12Reason,
                                                               },
                                                         @"Questions ID=\"22\"" :
                                                             @{@"QnID":@"Q1031",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q13Ans,
                                                               @"Reason":q13Reason,
                                                               },
                                                         @"Questions ID=\"23\"" :
                                                             @{@"QnID":@"Q1027",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q14AAns,
                                                               @"Reason":q14AReason,
                                                               },
                                                         @"Questions ID=\"24\"" :
                                                             @{@"QnID":@"Q1028",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q14BAns,
                                                               @"Reason":q14BReason,
                                                               },
                                                         @"Questions ID=\"25\"" :
                                                             @{@"QnID":@"Q1032",
                                                               @"QnParty":@"I",
                                                               @"AnswerType":@"OPT",
                                                               @"Answer":q15Ans,
                                                               @"Reason":q15Reason,
                                                               },
                                                         },
                                                   };
                [questionaires addObject:questionaireInfo];
                if([PYChange1 isEqualToString:@"Y"]){
                    LAType1=@"PO";
                    PYChange1 =@"N";
                }
            }
        }
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:questionaires forKey:@"proposalQuestionairies"];
    }
    
    //existing policies
    resultsXML = Nil;
    
    int  polCount=0;
    NSString *existingPolQues_1 = @"";
    NSString *existingPolQues_2 = @"";
    NSString *existingPolQues_3 = @"";
    NSString *existingPolQues_4 = @"";
    NSString *existingPolQues_5 = @"";
    NSString *existingPolQues_1a = @"";
    resultsXML = [database executeQuery:@"select * from eProposal_Existing_Policy_1 where eProposalNo = ?", stringID, Nil];
    while ([resultsXML next]) {
        //ProposalPTypeCode
        if ( [[resultsXML objectForColumnName:@"ProposalPTypeCode"] isEqualToString:@"LA1"] ) {
            polCount++;
        }
        if ( [[resultsXML objectForColumnName:@"ProposalPTypeCode"] isEqualToString:@"LA2"] ) {
            polCount++;
        }
        
        existingPolQues_1 = [NSString stringWithFormat:@"%@",[resultsXML objectForColumnName:@"ExistingPolicy_Answer1"]];
        if ([existingPolQues_1 isEqual: @""] || [existingPolQues_1 isEqualToString:NULL]) {
            existingPolQues_1 = @"";
        }
        
        existingPolQues_1a = [NSString stringWithFormat:@"%@",[resultsXML objectForColumnName:@"ExistingPolicy_Answer1a"]];
        if ([existingPolQues_1a isEqual: @""] || [existingPolQues_1a isEqualToString:NULL]) {
            existingPolQues_1a = @"";
        }
        
        existingPolQues_2 = [NSString stringWithFormat:@"%@",[resultsXML objectForColumnName:@"ExistingPolicy_Answer2"]];
        if ([existingPolQues_2 isEqual: @""] || [existingPolQues_2 isEqualToString:NULL]) {
            existingPolQues_2 = @"";
        }
        
        if ([existingPolQues_2 isEqualToString:@"Y"]) {
            existingPolQues_3 = [NSString stringWithFormat:@"%@",[resultsXML objectForColumnName:@"ExistingPolicy_Answer3"]];
            if ([existingPolQues_3 isEqual: @""] || [existingPolQues_3 isEqualToString:NULL]) {
                existingPolQues_3 = @"";
            }
            
            existingPolQues_4 = [NSString stringWithFormat:@"%@",[resultsXML objectForColumnName:@"ExistingPolicy_Answer4"]];
            if ([existingPolQues_4 isEqual: @""] || [existingPolQues_4 isEqualToString:NULL]) {
                existingPolQues_4 = @"";}
            
            existingPolQues_5 = [NSString stringWithFormat:@"%@",[resultsXML objectForColumnName:@"ExistingPolicy_Answer5"]];
            if ([existingPolQues_5 isEqual: @""] || [existingPolQues_5 isEqualToString:NULL]) {
                existingPolQues_5 = @"";}
        } else
        {
            existingPolQues_3 = @"";
            existingPolQues_4 = @"";
            existingPolQues_5 = @"";
        }
        
        
        
    }
    //NSLog(@"#######%i########",polCount);
    NSMutableDictionary *existingPolInfo = [NSMutableDictionary dictionary];
    // [existingPolInfo setValue:@"ExistingPolCount" forKey:[NSString stringWithFormat:@"%d", [mutAry count]]];
    //[existingPolInfo setValue:[NSString stringWithFormat:@"%d",polCount] forKey:@"ExistingPolCount"];
    
    [existingPolInfo setValue:[NSString stringWithFormat:@"%@",existingPolQues_1] forKey:@"ExistingPolQues_1"];
    [existingPolInfo setValue:[NSString stringWithFormat:@"%@",existingPolQues_2] forKey:@"ExistingPolQues_2"];
    [existingPolInfo setValue:[NSString stringWithFormat:@"%@",existingPolQues_3] forKey:@"ExistingPolQues_3"];
    [existingPolInfo setValue:[NSString stringWithFormat:@"%@",existingPolQues_4] forKey:@"ExistingPolQues_4"];
    [existingPolInfo setValue:[NSString stringWithFormat:@"%@",existingPolQues_5] forKey:@"ExistingPolQues_5"];
    [existingPolInfo setValue:[NSString stringWithFormat:@"%@",existingPolQues_1a] forKey:@"ExistingPolQues_1a"];
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:existingPolInfo forKey:@"policyExistingLifePolicies"];
    
    resultsXML = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCode = ? order by PTypeCodeDesc", stringID, @"1st Life Assured", Nil];
    
    //NSLog(@"#######XML result ########",resultsXML);
    
    NSMutableArray *mutAry = [NSMutableArray array];
    while ([resultsXML next]) {
        
        NSArray *details = [NSArray arrayWithObjects:[resultsXML objectForColumnName:@"PTypeCodeDesc"] != NULL ? [resultsXML objectForColumnName:@"PTypeCodeDesc"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_Company"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_Company"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_LifeTerm"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_LifeTerm"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_Accident"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_Accident"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_CriticalIllness"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_CriticalIllness"] : @"",
                            [resultsXML objectForColumnName:@"ExistingPolicy_DateIssued"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_DateIssued"] : @"",
                            nil];
        
        [mutAry addObject:[details copy]];
        
    }
    if (mutAry.count>0) {
        
        NSArray *tempdetails = [mutAry objectAtIndex:0];
        
        NSMutableDictionary *tempexistingPolInfo = [NSMutableDictionary dictionary];
        NSMutableDictionary *tempexistingPolInfo1 = [NSMutableDictionary dictionary];
        if (tempdetails.count>0) {
            // tempexistingPolInfo=@{[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",1] :
            // @{@"PTypeCode" : @"LA",
            // @"Seq" : [NSString stringWithFormat:@"%d",1],
            //  @"PTypeCodeDesc" : [tempdetails objectAtIndex:0], @"ExistingPolDetailsCount" : [NSString stringWithFormat:@"%d", mutAry.count]}};
            NSString* existpolID=[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",1];
            //@{[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",1] :
            [tempexistingPolInfo setValuesForKeysWithDictionary:
             @{@"PTypeCode" : @"LA",
             @"Seq" : [NSString stringWithFormat:@"%d",1],
             @"PTypeCodeDesc" : [tempdetails objectAtIndex:0], @"ExistingPolDetailsCount" : [NSString stringWithFormat:@"%d", mutAry.count]}];
            for (int i = 0; i < mutAry.count; i++) {
                NSArray *details = [mutAry objectAtIndex:i];
                //NSString *sample = [];
                NSString *extPolLife = [details objectAtIndex:2];
                NSString *extPolPA = [details objectAtIndex:3];
                NSString *extPolHI = [details objectAtIndex:4];
                NSString *extPolCI = [details objectAtIndex:5];
                extPolLife = [extPolLife stringByReplacingOccurrencesOfString:@"," withString:@""];
                extPolPA = [extPolPA stringByReplacingOccurrencesOfString:@"," withString:@""];
                extPolHI = [extPolHI stringByReplacingOccurrencesOfString:@"," withString:@""];
                extPolCI = [extPolCI stringByReplacingOccurrencesOfString:@"," withString:@""];
                NSDictionary *polInfo = @{[NSString stringWithFormat:@"ExistingPolDetails ID=\"%d\"", i+1] :
                                              @{@"ExtPolCompany":[details objectAtIndex:1],
                                                @"ExtPolLife":extPolLife,
                                                @"ExtPolPA":extPolPA,
                                                @"ExtPolHI":extPolHI,
                                                @"ExtPolCI":extPolCI,
                                                @"ExtPolDateIssued":[details objectAtIndex:6],
                                                @"ExtPolLA":[details objectAtIndex:0],
                                                }
                                          };
                [tempexistingPolInfo setValuesForKeysWithDictionary:polInfo];
            }
            [existingPolInfo setValue:[NSString stringWithFormat:@"%d",polCount] forKey:@"ExistingPolCount"];
            NSDictionary *existingpolDetailDic = @{[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",1]:tempexistingPolInfo};
            [existingPolInfo setValuesForKeysWithDictionary:existingpolDetailDic];
            
            /////////2nd starts
            
            resultsXML = Nil;
            resultsXML = [database executeQuery:@"select * from eProposal_Existing_Policy_2 where eProposalNo = ? and PTypeCode = ? order by PTypeCodeDesc", stringID, @"2nd Life Assured", Nil];
            mutAry = [NSMutableArray array];
            while ([resultsXML next]) {
                
                NSString *pTypeCodeDesc = [resultsXML objectForColumnName:@"PTypeCodeDesc"] != NULL ? [resultsXML objectForColumnName:@"PTypeCodeDesc"] : @"";
                NSString *existingPolicyCompany = [resultsXML objectForColumnName:@"ExistingPolicy_Company"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_Company"] : @"";
                NSString *existingPolicyLifeTerm = [resultsXML objectForColumnName:@"ExistingPolicy_LifeTerm"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_LifeTerm"] : @"";
                NSString *existingPolicyAccident = [resultsXML objectForColumnName:@"ExistingPolicy_Accident"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_Accident"] : @"";
                NSString *existingPolicyDailyHospitalIncome = [resultsXML objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_DailyHospitalIncome"] : @"";
                NSString *existingPolicyCriticalIllness = [resultsXML objectForColumnName:@"ExistingPolicy_CriticalIllness"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_CriticalIllness"] : @"";
                NSString *existingPolicyDateIssued = [resultsXML objectForColumnName:@"ExistingPolicy_DateIssued"] != NULL ? [resultsXML objectForColumnName:@"ExistingPolicy_DateIssued"] : @"";
                
                NSArray *details = [NSArray arrayWithObjects: pTypeCodeDesc, existingPolicyCompany, existingPolicyLifeTerm, existingPolicyAccident,existingPolicyDailyHospitalIncome, existingPolicyCriticalIllness, existingPolicyDateIssued, nil];
                
                [mutAry addObject:[details copy]];
                
            }
            [tempexistingPolInfo1 setValuesForKeysWithDictionary:
             @{@"PTypeCode" : @"LA",
             @"Seq" : [NSString stringWithFormat:@"%d",2],
             @"PTypeCodeDesc" : [tempdetails objectAtIndex:0], @"ExistingPolDetailsCount" : [NSString stringWithFormat:@"%d", mutAry.count]}];
            for (int i = 0; i < mutAry.count; i++) {
                NSArray *details = [mutAry objectAtIndex:i];
                //NSString *sample = [];
                NSString *extPolLife = [details objectAtIndex:2];
                NSString *extPolPA = [details objectAtIndex:3];
                NSString *extPolHI = [details objectAtIndex:4]; // Testing
                NSString *extPolCI = [details objectAtIndex:5];
                extPolLife = [extPolLife stringByReplacingOccurrencesOfString:@"," withString:@""];
                extPolPA = [extPolPA stringByReplacingOccurrencesOfString:@"," withString:@""];
                extPolHI = [extPolHI stringByReplacingOccurrencesOfString:@"," withString:@""];
                extPolCI = [extPolCI stringByReplacingOccurrencesOfString:@"," withString:@""];
                
                NSDictionary *polInfo = @{[NSString stringWithFormat:@"ExistingPolDetails ID=\"%d\"", i+1] :
                                              @{@"ExtPolCompany":[details objectAtIndex:1],
                                                @"ExtPolLife":extPolLife,
                                                @"ExtPolPA":extPolPA,
                                                @"ExtPolHI":extPolHI,
                                                @"ExtPolCI":extPolCI,
                                                @"ExtPolDateIssued":[details objectAtIndex:6],
                                                @"ExtPolLA":[details objectAtIndex:0],
                                                }
                                          };
                [tempexistingPolInfo1 setValuesForKeysWithDictionary:polInfo];
            }
            NSDictionary *existingpolDetailDic1 = @{[NSString stringWithFormat:@"ExistingPol ID=\"%d\"",2]:tempexistingPolInfo1};
            [existingPolInfo setValuesForKeysWithDictionary:existingpolDetailDic1];
            [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:existingPolInfo forKey:@"policyExistingLifePolicies"];
            
        }
        
    }
    //
    
    //    for (int i = 0; i < mutAry.count; i++) {
    //        NSArray *details = [mutAry objectAtIndex:i];
    //        NSDictionary *polInfo = @{[NSString stringWithFormat:@"ExistingPol ID=\"%d\"", i+1] :
    //                                      @{@"PTypeCode" : @"LA2",
    //                                        @"Seq" : [NSString stringWithFormat:@"%d", i+1],
    //                                        @"PTypeCodeDesc" : [details objectAtIndex:0],
    //                                        @"ExistingPolDetailsCount" : [NSString stringWithFormat:@"%d", details.count],
    //                                        [NSString stringWithFormat:@"ExistingPolDetails ID=\"%d\"", i+1] :
    //                                            @{@"ExtPolCompany":[details objectAtIndex:1],
    //                                              @"ExtPolLife":[details objectAtIndex:2],
    //                                              @"ExtPolPA":[details objectAtIndex:3],
    //                                              @"ExtPolCI":[details objectAtIndex:4],
    //                                              @"ExtPolDateIssued":[details objectAtIndex:5],
    //                                              },
    //                                        },
    //                                  };
    //        [existingPolInfo setValuesForKeysWithDictionary:polInfo];
    //    }
    
    
    
    
    //Additional Questions
    resultsXML = Nil;
	resultsXML = [database executeQuery:@"select * from  eProposal_Additional_Questions_1 where eProposalNo = ?",stringID, Nil];
    NSString *addQuesName;
    NSString *addQuesMthlyIncome;
    NSString *addQuesOccpCode;
    NSString *addQuesInsured;
    NSString *addQuesReason;
    bool gotAddQues = FALSE;
    while ([resultsXML next]) {
        gotAddQues = TRUE;
        addQuesName = [resultsXML stringForColumn:@"AdditionalQuestionsName"] != NULL ?[resultsXML stringForColumn:@"AdditionalQuestionsName"] : @"";
        addQuesMthlyIncome = [resultsXML stringForColumn:@"AdditionalQuestionsMonthlyIncome"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsMonthlyIncome"] : @"";
        addQuesMthlyIncome = [addQuesMthlyIncome stringByReplacingOccurrencesOfString:@"," withString:@""];
        addQuesOccpCode = [resultsXML stringForColumn:@"AdditionalQuestionsOccupationCode"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsOccupationCode"] : @"";
        addQuesInsured = [resultsXML stringForColumn:@"AdditionalQuestionsInsured"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsInsured"] : @"";
        addQuesReason = [resultsXML stringForColumn:@"AdditionalQuestionsReason"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsReason"] : @"";
    }
    if (gotAddQues) {
        NSDictionary *addQuesInfo = @{@"AddQuesID = \"1\"" :
                                          @{@"AddQuesName": addQuesName,
                                            @"AddQuesMthlyIncome" : addQuesMthlyIncome,
                                            @"AddQuesOccpCode" : addQuesOccpCode,
                                            @"AddQuesInsured" : addQuesInsured,
                                            @"AddQuesReason" : addQuesReason
                                            },
                                      };
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:addQuesInfo forKey:@"propoalAddQuesInfo"];
    }
    
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select count(*) as count from eProposal_Additional_Questions_2 where eProposalNo = ?", stringID, nil];
    int gotQuesCount = 0;
    while ([resultsXML next]) {
        if ([resultsXML intForColumn:@"count"] > 0) {
            gotQuesCount = [resultsXML intForColumn:@"count"];
        }
    }
    if(gotQuesCount != 0) {
        NSMutableArray *addQuesDetails = [NSMutableArray array];
        resultsXML = Nil;
        resultsXML = [database executeQuery:@"select * from eProposal_Additional_Questions_2 where eProposalNo = ?", stringID, nil];
        int quesCount = 0;
        while ([resultsXML next]) {
            quesCount++;
            NSString *addQuesCompany = [resultsXML stringForColumn:@"AdditionalQuestionsCompany"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsCompany"] : @"";
            NSString *addQuesAmountInsured = [resultsXML stringForColumn:@"AdditionalQuestionsAmountInsured"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsAmountInsured"] : @"";
            addQuesAmountInsured = [addQuesAmountInsured stringByReplacingOccurrencesOfString:@"," withString:@""];
            NSString *addQuesLifeAccidentDisease = [resultsXML stringForColumn:@"AdditionalQuestionsLifeAccidentDisease"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsLifeAccidentDisease"] : @"";
            NSString *addQuesYrIssued = [resultsXML stringForColumn:@"AdditionalQuestionsYrIssued"] != NULL ? [resultsXML stringForColumn:@"AdditionalQuestionsYrIssued"] : @"";
            NSDictionary *addQues = @{[NSString stringWithFormat:@"AddQuesDetails ID = \"%d\"", quesCount] : @{@"AddQuesCompany":addQuesCompany, @"AddQuesAmountInsured":addQuesAmountInsured, @"AddQuesLifeAccidentDisease":addQuesLifeAccidentDisease,@"AddQuesYrIssued":addQuesYrIssued},};
            [addQuesDetails addObject:addQues];
            
        }
        
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:addQuesDetails forKey:@"proposalAddQuesDetails"];
    }
    
    //dividen info
    resultsXML = nil;
    resultsXML = [database executeQuery:@"select * from eProposal where eProposalNo = ?", stringID,nil];
    NSString *cashPaymentOption;
    NSString *cashDividendOption;
    NSString *fullPaidUpOption;
    NSString *fullPaidUpTerm;
    NSString *revisedSA;
    NSString *amtRevised;
    NSString *reducePaidUpYear;
    NSString *reInvestYI;
    NSString *partialAcc = @"0";
    NSString *partialPayout = @"0";
    bool gotDividen = FALSE;
    while ([resultsXML next]) {
        gotDividen = TRUE;
        cashPaymentOption = @"";
        cashDividendOption = @"";
        fullPaidUpOption = [resultsXML stringForColumn:@"FullyPaidUpOption"] != NULL ? [resultsXML stringForColumn:@"FullyPaidUpOption"] : @"";
        fullPaidUpTerm = [resultsXML stringForColumn:@"FullyPaidUpTerm"] != NULL ? [resultsXML stringForColumn:@"FullyPaidUpTerm"] : @"";
        revisedSA = [resultsXML stringForColumn:@"RevisedSA"] != NULL ? [resultsXML stringForColumn:@"RevisedSA"] : @"";
        amtRevised = [resultsXML stringForColumn:@"AmtRevised"].length != 0 ? [resultsXML stringForColumn:@"AmtRevised"] : @"0.00";
        reducePaidUpYear = [resultsXML stringForColumn:@"reducePaidUpYear"].length != 0 ? [resultsXML stringForColumn:@"reducePaidUpYear"] : @"";
        //reducePaidUpYear = @"";
        reInvestYI = @"";
    }
    
    resultsXML = [database executeQuery:@"select CashDividend, PartialAcc, PartialPayout from Trad_Details where SINo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"],Nil];
	while ([resultsXML next]) {
        
        //		cashDividendOption = [[resultsXML stringForColumn:@"CashDividend"] isEqualToString:@"ACC"] ? @"DIV002" : @"DIV001";
		cashDividendOption = [resultsXML stringForColumn:@"CashDividend"];
        if ([cashDividendOption isEqualToString:@"ACC"]) {
            cashDividendOption = @"DIV002";
        }
        else if ([cashDividendOption isEqualToString:@"POF"])
        {
            cashDividendOption = @"DIV001";
        }
        else
        {
            cashDividendOption = @"";
        }
        
        
        partialAcc = [resultsXML stringForColumn:@"PartialAcc"] != NULL ? [resultsXML stringForColumn:@"PartialAcc"] : @"0";
        partialPayout = [resultsXML stringForColumn:@"PartialPayout"] != NULL ? [resultsXML stringForColumn:@"PartialPayout"] : @"0";
	}
    
    if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"] isEqualToString:@"ES"]) {
        resultsXML = nil;
        resultsXML = [database executeQuery:@"select count(*) as count from UL_Rider_Details where ReinvestGYI = 'Yes' and SINO = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], nil];
        bool reinvest = FALSE;
        while ([resultsXML next]) {
            if ([resultsXML intForColumn:@"count"] > 0) {
                reinvest = TRUE;
                reInvestYI = @"True";
            }
            else {
                reInvestYI = @"False";;
            }
        }
        if (reinvest) {
            reInvestYI = @"True";
        }
        else if (!reinvest) {
            reInvestYI = @"False";
        }
    }
    if (gotDividen) {
        
        if ([partialAcc intValue] == 100) {
            cashPaymentOption=@"SUR_PAY_02";
        }
        else if ([partialPayout intValue] == 100) {
            cashPaymentOption=@"SUR_PAY_01";
        }
        else if ([partialAcc intValue] > 0 && [partialPayout intValue] > 0)  {
            cashPaymentOption=@"SUR_PAY_05";
        }
        
        
        
        
        
        //        if([partialAcc intValue]>=[partialPayout intValue])
        //            cashPaymentOption=@"SUR_PAY_01";
        //        else
        //             cashPaymentOption=@"SUR_PAY_02";
        // if([partialPayout isEqualToString:@"100"])
        // cashPaymentOption=@"SUR_PAY_02";
        
        //        if (partialPayout > partialAcc) {
        //            cashPaymentOption=@"SUR_PAY_01";
        //        }
        
        NSDictionary *pay01=nil;
        NSDictionary *pay02=nil;
        NSMutableArray *options = [[NSMutableArray alloc] init];
        if ([partialAcc intValue]==100) {
            pay02 = @{@"OptionType": @"SUR_PAY_02",
                      @"Percentage": partialAcc};
            [options addObject:pay02];
        }
        else   if ([partialPayout intValue]==100){
            pay01 = @{@"OptionType": @"SUR_PAY_01",
                      @"Percentage": partialPayout};
            [options addObject:pay01];
        }
        else if ([partialAcc intValue]==0 && ([partialPayout intValue]==0))
        {
            // do nothing
        }
        else{
            pay01 = @{@"OptionType": @"SUR_PAY_01",
                      @"Percentage": partialPayout};
            
            pay02 = @{@"OptionType": @"SUR_PAY_02",
                      @"Percentage": partialAcc};
            [options addObject:pay01];
            [options addObject:pay02];
        }
        
        
        NSDictionary *dividenInfo = @{
                                      @"CashPaymentOption" : cashPaymentOption,
                                      @"CashDividendOption" : cashDividendOption,
                                      @"FullPaidUpOption" : [fullPaidUpOption isEqualToString:@"Y"] ? @"True" : @"False",
                                      @"FullPaidUpTerm" : fullPaidUpTerm,
                                      @"RevisedSA" : [fullPaidUpOption isEqualToString:@"Y"] ? @"True" : @"False",
                                      @"AmtRevised" : amtRevised,
                                      @"ReducePaidUpYear" : reducePaidUpYear,
                                      @"ReInvestYI" : reInvestYI,
                                      @"CashPaymentOptionType" : @{
                                              @"Options" : options
                                              }
                                      };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:dividenInfo forKey:@"proposalDividenInfo"];
    }
    
    
    //iMobileExtraInfo
    resultsXML = nil;
    resultsXML = [database executeQuery:@"select * from eProposal where eProposalNo = ?", stringID,nil];
    NSString *guardianame = @"";
    NSString *guardianNewIC = @"";
    
    
    
    
    while ([resultsXML next]) {
        NSLog(@"");
        guardianame = [resultsXML stringForColumn:@"GuardianName"] != NULL ? [resultsXML stringForColumn:@"GuardianName"] : @"";
        guardianNewIC = [resultsXML stringForColumn:@"GuardianNewICNo"] != NULL ? [resultsXML stringForColumn:@"GuardianNewICNo"] : @"";
        
    }
    
    NSDictionary *iMobileExtraInfo = @{@"GuardianName" : guardianame ,
                                       @"GuardianNewICNo" : guardianNewIC ,
                                       };
    //NSLog(@"iMobileExtraInfo");
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:iMobileExtraInfo forKey:@"iMobileExtraInfo"];
    
    
    // fund info
    NSString *lien;
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select LIEN from  eProposal where eProposalNo = ?",stringID,Nil];
    while ([resultsXML next]) {
        lien = [resultsXML stringForColumn:@"LIEN"];
    }
    NSDictionary *fundInfo = @{@"BenefitChoices": @"",
                               @"ExcessPaymentOpt" : @"",
                               @"LienOpt" : lien,
                               @"StrategyCode" : @"",
                               @"InvestHorizon" : @"",
                               };
    
    [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:fundInfo forKey:@"proposalFundInfo"];
    
    //Sec D Nominees
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select count(*) as count from eProposal_NM_Details where eProposalNo = ? AND NMName <> ?", stringID, @"NULL",Nil];
    int gotNominee = 0;
    int gotNomineeCount = 0;
    while ([resultsXML next]) {
        gotNominee = [resultsXML intForColumn:@"count"];
    }
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select * from eProposal_NM_Details where eProposalNo = ?", stringID, Nil];
    while ([resultsXML next]) {
        NSString *nmname = [resultsXML stringForColumn:@"NMName"];
        if(nmname==NULL || [nmname isEqualToString:@""])
            gotNominee=0;}
    
    if (gotNominee > 0) {
        NSMutableDictionary *nomineesInfo = [NSMutableDictionary dictionary];
        [nomineesInfo setValue:[NSString stringWithFormat:@"%d", gotNominee] forKey:@"NomineeCount"];
        resultsXML = Nil;
        resultsXML = [database executeQuery:@"select * from eProposal_NM_Details where eProposalNo = ? order by ID asc", stringID, Nil];
        while ([resultsXML next]) {
            gotNomineeCount++;
            
            NSString *gender = [resultsXML stringForColumn:@"NMSex"] != NULL ? [resultsXML stringForColumn:@"NMSex"] : @"";
            if([gender isEqualToString:@"male"])
                gender = @"M";
            else if([gender isEqualToString:@"female"])
                gender = @"F";
            
            NSString *posameaddress =   [resultsXML stringForColumn:@"NMSamePOAddress"] != NULL ? [resultsXML stringForColumn:@"NMSamePOAddress"] : @"";
            
            if([posameaddress isEqualToString:@"same"])
                posameaddress = @"True";
            else
                posameaddress = @"False";
            
            NSString *AddressSameAsPO;
            NSString *getNomCorrenspondence = [resultsXML stringForColumn:@"NMCRAddress1"];
            if (![getNomCorrenspondence isEqualToString:@""])
                AddressSameAsPO = @"Y";
            else
                AddressSameAsPO  =@"N";
            
            NSString *ForeignAddress;
            NSString *CountryR = [resultsXML stringForColumn:@"NMCountry"] != NULL ? [resultsXML stringForColumn:@"NMCountry"] : @"";
            
            if([CountryR isEqualToString:@"MAL"])
            {
                ForeignAddress =@"N";
            }
            else if ([CountryR isEqualToString:@""])
            {
                ForeignAddress =@"";
            }
            else
            {
                ForeignAddress = @"Y";
            }
            
            NSString *CRForeignAddress;
            NSString *CountryCR = [resultsXML stringForColumn:@"NMCRCountry"] != NULL ? [resultsXML stringForColumn:@"NMCRCountry"] : @"";
            
            if([CountryCR isEqualToString:@"MAL"])
            {
                CRForeignAddress =@"N";
            }
            else if ([CountryCR isEqualToString:@""])
            {
                CRForeignAddress =@"";
            }
            else
            {
                CRForeignAddress = @"Y";
            }
            
            
            
            
            //******get relatioship code from DB
            
            NSString *relationship =   [resultsXML stringForColumn:@"NMRelationship"] != NULL ? [resultsXML stringForColumn:@"NMRelationship"] : @"";
            
            FMResultSet  *resultsXML2 = [database executeQuery:@"select RelCode from eProposal_Relation where RelDesc = ?", relationship, Nil];
            NSString *relcode = @"";
            while ([resultsXML2 next]) {
                
                relcode=  [resultsXML2 stringForColumn:@"RelCode"];
                
            }
            
            [resultsXML2 close];
            
            NSString *NMTitle1 = [resultsXML stringForColumn:@"NMTitle"] != NULL ? [resultsXML stringForColumn:@"NMTitle"] : @"";
			
			NMTitle1 = [NMTitle1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			NMTitle1 = [self getTitleCode:NMTitle1 passdb:database];
			
            NSString *NMSex1 = gender;
            if ([NMTitle1 isEqualToString:@"DT"] && [NMSex1 isEqualToString:@"F"]) {
                NMTitle1 = @"DT (FEMALE)";
            }
            
            NSDictionary *nominee = @{@"Seq" : [NSString stringWithFormat:@"%d", gotNomineeCount],
                                      @"NMTitle" : NMTitle1,
                                      @"NMName" : [resultsXML stringForColumn:@"NMName"] != NULL ? [resultsXML stringForColumn:@"NMName"] : @"",
                                      @"NMShare" : [resultsXML stringForColumn:@"NMShare"] != NULL ? [resultsXML stringForColumn:@"NMShare"] : @"",
                                      @"NMDOB" : [resultsXML stringForColumn:@"NMDOB"] != NULL ? [resultsXML stringForColumn:@"NMDOB"] : @"",
                                      @"NMSex" : NMSex1,
                                      @"NMRelationship" : relcode,
                                      @"NMNationality" : [resultsXML stringForColumn:@"NMNationality"] != NULL ? [resultsXML stringForColumn:@"NMNationality"] : @"",
                                      @"NMEmployerName" : [resultsXML stringForColumn:@"NMNameOfEmployer"] != NULL ? [resultsXML stringForColumn:@"NMNameOfEmployer"] : @"",
                                      @"NMOccupation" : [resultsXML stringForColumn:@"NMOccupation"] != NULL ? [resultsXML stringForColumn:@"NMOccupation"] : @"",
                                      @"NMExactDuties" : [resultsXML stringForColumn:@"NMExactDuties"] != NULL ? [resultsXML stringForColumn:@"NMExactDuties"] : @"",
                                      @"NMSamePOAddress" : posameaddress,
                                      @"NMTrustStatus" : [resultsXML stringForColumn:@"NMTrustStatus"] != NULL ? [resultsXML stringForColumn:@"NMTrustStatus"] : @"",
                                      @"NMChildAlive" : [resultsXML stringForColumn:@"NMChildAlive"] != NULL ? [resultsXML stringForColumn:@"NMChildAlive"] : @"",
                                      @"NMNewIC" :
                                          @{@"NMNewICCode":@"NRIC",
                                            @"NMNewICNo":[resultsXML stringForColumn:@"NMNewICNo"] != NULL ? [resultsXML stringForColumn:@"NMNewICNo"] : @"",
                                            },
                                      @"NMOtherID" :
                                          @{@"NMOtherIDType":[resultsXML stringForColumn:@"NMOtherIDType"] != NULL ? [resultsXML stringForColumn:@"NMOtherIDType"] : @"",
                                            @"NMOtherID":[resultsXML stringForColumn:@"NMOtherID"] != NULL ? [resultsXML stringForColumn:@"NMOtherID"] : @"",
                                            },
                                      @"NMAddrR" :
                                          @{@"AddressCode":@"ADR001",
                                            @"Address1":[resultsXML stringForColumn:@"NMAddress1"] != NULL ? [resultsXML stringForColumn:@"NMAddress1"] : @"",
                                            @"Address2":[resultsXML stringForColumn:@"NMAddress2"] != NULL ? [resultsXML stringForColumn:@"NMAddress2"] : @"",
                                            @"Address3":[resultsXML stringForColumn:@"NMAddress3"] != NULL ? [resultsXML stringForColumn:@"NMAddress3"] : @"",
                                            @"Town":[resultsXML stringForColumn:@"NMTown"] != NULL ? [resultsXML stringForColumn:@"NMTown"] : @"",
                                            @"State":[resultsXML stringForColumn:@"NMState"] != NULL ? [resultsXML stringForColumn:@"NMState"] : @"",
                                            @"Postcode":[resultsXML stringForColumn:@"NMPostcode"] != NULL ? [resultsXML stringForColumn:@"NMPostcode"] : @"",
                                            @"Country":[resultsXML stringForColumn:@"NMCountry"] != NULL ? [resultsXML stringForColumn:@"NMCountry"] : @"",
                                            @"ForeignAddress":ForeignAddress,
                                            @"AddressSameAsPO":@"N",
                                            },
                                      @"NMAddrC" :
                                          @{@"AddressCode":@"ADR001",
                                            @"Address1":[resultsXML stringForColumn:@"NMCRAddress1"] != NULL ? [resultsXML stringForColumn:@"NMCRAddress1"] : @"",
                                            @"Address2":[resultsXML stringForColumn:@"NMCRAddress2"] != NULL ? [resultsXML stringForColumn:@"NMCRAddress2"] : @"",
                                            @"Address3":[resultsXML stringForColumn:@"NMCRAddress3"] != NULL ? [resultsXML stringForColumn:@"NMCRAddress3"] : @"",
                                            @"Town":[resultsXML stringForColumn:@"NMCRTown"] != NULL ? [resultsXML stringForColumn:@"NMCRTown"] : @"",
                                            @"State":[resultsXML stringForColumn:@"NMCRState"] != NULL ? [resultsXML stringForColumn:@"NMCRState"] : @"",
                                            @"Postcode":[resultsXML stringForColumn:@"NMCRPostcode"] != NULL ? [resultsXML stringForColumn:@"NMCRPostcode"] : @"",
                                            @"Country":[resultsXML stringForColumn:@"NMCRCountry"] != NULL ? [resultsXML stringForColumn:@"NMCRCountry"] : @"",
                                            @"ForeignAddress":CRForeignAddress,
                                            @"AddressSameAsPO":AddressSameAsPO,
                                            },
                                      
                                      };
            NSString *key = [NSString stringWithFormat:@"Nominee ID = \"%d\"", gotNomineeCount];
            [nomineesInfo setValue:nominee forKey:key];
        }
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:nomineesInfo forKey:@"proposalNomineeInfo"];
        
        
    }
    
    //Sec D Trustees
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select count(*) as count from eProposal_Trustee_Details where eProposalNo = ?", stringID, Nil];
    int gotTrustee = 0;
    int gotTrusteeCount = 0;
    while ([resultsXML next]) {
        gotTrustee = [resultsXML intForColumn:@"count"];
    }
    
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select * from eProposal_Trustee_Details where eProposalNo = ?", stringID, Nil];
    
    
    while ([resultsXML next]) {
        NSString *trusteename = [resultsXML stringForColumn:@"TrusteeName"];
        if(trusteename==NULL || [trusteename isEqualToString:@""])
            gotTrustee=0;}
    if (gotTrustee > 0) {
        NSMutableDictionary *trusteeInfo = [NSMutableDictionary dictionary];
        [trusteeInfo setValue:[NSString stringWithFormat:@"%d", gotTrustee] forKey:@"TrusteeCount"];
        resultsXML = Nil;
        resultsXML = [database executeQuery:@"select * from eProposal_Trustee_Details where eProposalNo = ? order by ID asc", stringID, Nil];
        
        
        
        while ([resultsXML next]) {
            
            NSString *TrusteeTitle1 = [resultsXML stringForColumn:@"TrusteeTitle"] != NULL ? [resultsXML stringForColumn:@"TrusteeTitle"] : @"";
			
			TrusteeTitle1 = [TrusteeTitle1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
			TrusteeTitle1 = [self getTitleCode:TrusteeTitle1 passdb:database];
			
            NSString *TrusteeSex1 = [resultsXML stringForColumn:@"TrusteeSex"] != NULL ? [resultsXML stringForColumn:@"TrusteeSex"] : @"";
            
			
			if ([TrusteeTitle1 isEqualToString:@"DT"] && [TrusteeSex1 isEqualToString:@"F"]) {
                TrusteeTitle1 = @"DT (FEMALE)";
            }
            
            gotTrusteeCount++;
            NSDictionary *trustee = @{@"Seq" : [NSString stringWithFormat:@"%d", gotTrusteeCount],
                                      @"TrusteeTitle" : TrusteeTitle1,
                                      @"TrusteeName" : [resultsXML stringForColumn:@"TrusteeName"] != NULL ? [resultsXML stringForColumn:@"TrusteeName"] : @"",
                                      @"TrusteeRelationship" : [resultsXML stringForColumn:@"TrusteeRelationship"] != NULL ? [resultsXML stringForColumn:@"TrusteeRelationship"] : @"",
                                      @"TrusteeSex" : TrusteeSex1,
                                      @"TrusteeDOB" : [resultsXML stringForColumn:@"TrusteeDOB"] != NULL ? [resultsXML stringForColumn:@"TrusteeDOB"] : @"",
                                      @"TRNewIC" :
                                          @{@"TRNewICCode":@"NRIC",
                                            @"TRNewICNo":[resultsXML stringForColumn:@"TrusteeNewICNo"] != NULL ? [resultsXML stringForColumn:@"TrusteeNewICNo"] : @"",
                                            },
                                      @"TROtherID" :
                                          @{@"TrusteeOtherIDType":[resultsXML stringForColumn:@"TrusteeOtherIDType"] != NULL ? [resultsXML stringForColumn:@"TrusteeOtherIDType"] : @"",
                                            @"TrusteeOtherID":[resultsXML stringForColumn:@"TrusteeOtherID"] != NULL ? [resultsXML stringForColumn:@"TrusteeOtherID"] : @"",
                                            },
                                      @"TrusteeAddr" :
                                          @{@"AddressCode":@"ADR001",
                                            @"Address1":[resultsXML stringForColumn:@"TrusteeAddress1"] != NULL ? [resultsXML stringForColumn:@"TrusteeAddress1"] : @"",
                                            @"Address2":[resultsXML stringForColumn:@"TrusteeAddress2"] != NULL ? [resultsXML stringForColumn:@"TrusteeAddress2"] : @"",
                                            @"Address3":[resultsXML stringForColumn:@"TrusteeAddress3"] != NULL ? [resultsXML stringForColumn:@"TrusteeAddress3"] : @"",
                                            @"Town":[resultsXML stringForColumn:@"TrusteeTown"] != NULL ? [resultsXML stringForColumn:@"TrusteeTown"] : @"",
                                            @"State":[resultsXML stringForColumn:@"TrusteeState"] != NULL ? [resultsXML stringForColumn:@"TrusteeState"] : @"",
                                            @"Postcode":[resultsXML stringForColumn:@"TrusteePostcode"] != NULL ? [resultsXML stringForColumn:@"TrusteePostcode"] : @"",
                                            @"Country":[resultsXML stringForColumn:@"TrusteeCountry"] != NULL ? [resultsXML stringForColumn:@"TrusteeCountry"] : @"",
                                            @"ForeignAddress":[resultsXML stringForColumn:@"isForeignAddress"] != NULL ? [resultsXML stringForColumn:@"isForeignAddress"] : @"",
                                            @"AddressSameAsPO":[resultsXML stringForColumn:@"TrusteeSameAsPO"] != NULL ? [resultsXML stringForColumn:@"TrusteeSameAsPO"] : @"",
                                            },
                                      };
            NSString *key = [NSString stringWithFormat:@"Trustee ID = %d", gotTrusteeCount];
            [trusteeInfo  setValue:trustee forKey:key];
        }
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:trusteeInfo forKey:@"proposalTrusteeInfo"];
    }
    //Sec B CO
    resultsXML = Nil;
    resultsXML = [database executeQuery:@"select * from eProposal where eProposalNo = ?", stringID, Nil];
    while ([resultsXML next]) {
        
        
        NSString *coMobile = [resultsXML stringForColumn:@"COMobileNo"] != NULL ? [resultsXML stringForColumn:@"COMobileNo"] : @"";
        coMobile = [coMobile stringByReplacingOccurrencesOfString:@" " withString:@""];
        coMobile = [coMobile stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        
        if ([coMobile isEqualToString:@"(null)"] ){
            coMobile = @"";
        }
        NSString *coPhone = [resultsXML stringForColumn:@"COPhoneNo"] != NULL ? [resultsXML stringForColumn:@"COPhoneNo"] : @"";
        coPhone = [coPhone stringByReplacingOccurrencesOfString:@" " withString:@""];
        coPhone = [coPhone stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        if ([coPhone isEqualToString:@"(null)"] ){
            coPhone = @"";
        }
        
        
        
        NSDictionary *residenceCon = @{@"Contact Type = \"Residence\"": @{@"ContactCode": @"CONT006",
                                                                          @"ContactNo":  coPhone },
                                       };
        NSDictionary *mobileCon = @{@"Contact Type = \"Mobile\"": @{@"ContactCode": @"CONT008",
                                                                    @"ContactNo": coMobile }
                                    };
        
        NSDictionary *email = @{@"Contact Type = \"Email\"": @{@"ContactCode": @"CONT011",
                                                               @"ContactNo": [resultsXML stringForColumn:@"COEmailAddress"] != NULL ? [resultsXML stringForColumn:@"COEmailAddress"] : @""}
                                };
        NSString *sameAddAsPo = [resultsXML stringForColumn:@"COSameAddressPO"] != NULL ? [resultsXML stringForColumn:@"COSameAddressPO"] : @"";
        NSArray *COContacts = [[NSArray alloc] initWithObjects:residenceCon, mobileCon, email, nil];
        NSString *CoTitle1= [resultsXML stringForColumn:@"COTitle"] != NULL ? [resultsXML stringForColumn:@"COTitle"] : @"";
        NSString *cosex1= [resultsXML stringForColumn:@"COSex"] != NULL ? [resultsXML stringForColumn:@"COSex"] : @"";
        
        NSString *COSameAddressPO1;
        NSString *CoAddressCode1;
        NSString *CONewICCode1;
        
        if([CoTitle1 isEqualToString:@"DT"] && [cosex1 isEqualToString:@"F"] )
        {
            CoTitle1=@"DT (FEMALE)";
        }
        
        if([CoTitle1 isEqualToString:@""])
        {
            CoAddressCode1=@"";
            CONewICCode1=@"";
            COSameAddressPO1=@"";
            
        }else{
            CoAddressCode1=@"ADR001";
            CONewICCode1=@"NRIC";
            COSameAddressPO1=[sameAddAsPo isEqualToString:@"Y"] ? @"True" : @"False";
        }
        
        NSString *getCoCorrenspondence = [resultsXML stringForColumn:@"COCRAddress1"];
        NSString *CoCorrenspondence;
        
        if (![getCoCorrenspondence isEqualToString:@""])
        {
            CoCorrenspondence = @"Y";
        }
        else
        {
            CoCorrenspondence = @"";
        }
        
        
        
        NSDictionary *CODetails = @{
                                    @"COTitle":CoTitle1,
                                    @"COName":[resultsXML stringForColumn:@"COName"] != NULL ? [resultsXML stringForColumn:@"COName"] : @"",
                                    @"CODOB":[resultsXML stringForColumn:@"CODOB"] != NULL ? [resultsXML stringForColumn:@"CODOB"] : @"",
                                    @"COSex":cosex1,
                                    @"CONationality":[resultsXML stringForColumn:@"CONationality"] != NULL ? [resultsXML stringForColumn:@"CONationality"] : @"",
                                    @"CONameOfEmployer":[resultsXML stringForColumn:@"CONameOfEmployer"] != NULL ? [resultsXML stringForColumn:@"CONameOfEmployer"] : @"",
                                    @"COExactNatureOfWork":[resultsXML stringForColumn:@"COExactNatureOfWork"] != NULL ? [resultsXML stringForColumn:@"COExactNatureOfWork"] : @"",
                                    @"CORelationship":[resultsXML stringForColumn:@"CORelationship"] != NULL ? [resultsXML stringForColumn:@"CORelationship"] : @"",
                                    @"CONationality":[resultsXML stringForColumn:@"CONationality"] != NULL ? [resultsXML stringForColumn:@"CONationality"] : @"",
                                    @"COEmployerName":[resultsXML stringForColumn:@"CONameOfEmployer"] != NULL ? [resultsXML stringForColumn:@"CONameOfEmployer"] : @"",
                                    @"COOccupation":[resultsXML stringForColumn:@"COOccupation"] != NULL ? [resultsXML stringForColumn:@"COOccupation"] : @"",
                                    @"COExactDuties":[resultsXML stringForColumn:@"COExactNatureOfWork"] != NULL ? [resultsXML stringForColumn:@"COExactNatureOfWork"] : @"",
                                    @"COSameAddressPO": COSameAddressPO1,
                                    @"CONewIC": @{@"CONewICCode":  CONewICCode1,
                                                  @"CONewICNo": [resultsXML stringForColumn:@"CONewICNo"] != NULL ? [resultsXML stringForColumn:@"CONewICNo"] : @"",
                                                  },
                                    @"COOtherID":@{@"COOtherIDType": [resultsXML stringForColumn:@"COOtherIDType"] != NULL ? [resultsXML stringForColumn:@"COOtherIDType"] : @"",
                                                   @"COOtherID": [resultsXML stringForColumn:@"COOtherID"] != NULL ? [resultsXML stringForColumn:@"COOtherID"] : @"",
                                                   },
                                    @"COAddrR": @{@"AddressCode": CoAddressCode1,
                                                  @"Address1": [resultsXML stringForColumn:@"COAddress1"] != NULL ? [resultsXML stringForColumn:@"COAddress1"] : @"",
                                                  @"Address2": [resultsXML stringForColumn:@"COAddress2"] != NULL ? [resultsXML stringForColumn:@"COAddress2"] : @"",
                                                  @"Address3": [resultsXML stringForColumn:@"COAddress3"] != NULL ? [resultsXML stringForColumn:@"COAddress3"] : @"",
                                                  @"Town": [resultsXML stringForColumn:@"COTown"] != NULL ? [resultsXML stringForColumn:@"COTown"] : @"",
                                                  @"State": [resultsXML stringForColumn:@"COState"] != NULL ? [resultsXML stringForColumn:@"COState"] : @"",
                                                  @"Postcode": [resultsXML stringForColumn:@"COPostcode"] != NULL ? [resultsXML stringForColumn:@"COPostcode"] : @"",
                                                  @"Country": [resultsXML stringForColumn:@"COCountry"] != NULL ? [resultsXML stringForColumn:@"COCountry"] : @"",
                                                  @"ForeignAddress": [resultsXML stringForColumn:@"COForeignAddressFlag"] != NULL ? [resultsXML stringForColumn:@"COForeignAddressFlag"] : @"",
                                                  @"AddressSameAsPO": [resultsXML stringForColumn:@"COSameAddressPO"] != NULL ? [resultsXML stringForColumn:@"COSameAddressPO"] : @"",
                                                  },
                                    @"COAddrC": @{@"AddressCode": CoAddressCode1,
                                                  @"Address1": [resultsXML stringForColumn:@"COCRAddress1"] != NULL ? [resultsXML stringForColumn:@"COCRAddress1"] : @"",
                                                  @"Address2": [resultsXML stringForColumn:@"COCRAddress2"] != NULL ? [resultsXML stringForColumn:@"COCRAddress2"] : @"",
                                                  @"Address3": [resultsXML stringForColumn:@"COCRAddress3"] != NULL ? [resultsXML stringForColumn:@"COCRAddress3"] : @"",
                                                  @"Town": [resultsXML stringForColumn:@"COCRTown"] != NULL ? [resultsXML stringForColumn:@"COCRTown"] : @"",
                                                  @"State": [resultsXML stringForColumn:@"COCRState"] != NULL ? [resultsXML stringForColumn:@"COCRState"] : @"",
                                                  @"Postcode": [resultsXML stringForColumn:@"COCRPostcode"] != NULL ? [resultsXML stringForColumn:@"COCRPostcode"] : @"",
                                                  @"Country": [resultsXML stringForColumn:@"COCRCountry"] != NULL ? [resultsXML stringForColumn:@"COCRCountry"] : @"",
                                                  @"ForeignAddress": [resultsXML stringForColumn:@"COCRForeignAddressFlag"] != NULL ? [resultsXML stringForColumn:@"COCRForeignAddressFlag"] : @"",
                                                  @"AddressSameAsPO": CoCorrenspondence,
                                                  },
                                    @"COContacts": COContacts,
                                    };
        [[obj.eAppData objectForKey:@"EAPPDataSet"] setValue:CODetails forKey:@"proposalCODetails"];
    }
}
-(void) StoreXMLdata_AgentProfile
{
    
    obj=[DataClass getInstance];
    
    
    //BECAREFUL WITH THE PLAN CODE - CANNOT BE HLA CASH PROMISE/ HLA EVER LIFE!!
    NSString *plancode = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
    NSString *SIType = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
	
	if (SIType == nil)
		SIType = @"";
	
//    if( [ plancode isEqualToString:@"HLACP"] || [ plancode isEqualToString:@"L100"] || [ plancode isEqualToString:@"HLAWP"] )
//        SIType = @"TRAD";
//    else if([ plancode isEqualToString:@"UV"] || [ plancode isEqualToString:@"UP"])
//        SIType = @"ES";
//    else
//        SIType = @"";
    
    
    
    
    //GET SYSTEM NAME, SYSTEM VERSION
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
//	FMResultSet *results2;
	results2 = nil;
    
    NSString *eAppVersion = @"";
    NSString *SystemName = @"";
    NSString *createdDate = @"";
    NSString *PreferredLife= @"";
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
    
    results2 = [db executeQuery:@"SELECT PreferredLife FROM eProposal_Existing_Policy_1 WHERE eProposalNo = ?",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    
	while ([results2 next]) {
        
        PreferredLife = [results2 stringForColumn:@"PreferredLife"];
        
    }
    
    if  ((NSNull *) PreferredLife == [NSNull null])
        PreferredLife = @"";
    
    if (PreferredLife==NULL || [PreferredLife isEqualToString:@""]){
        PreferredLife = @"N";
    }
    else{
        PreferredLife = @"Y";
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
                       @"PreferredLife":PreferredLife,
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

-(void) getSys_SIVersio_AND_Trad_UL_Details
{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    NSString *str_Sys_SI_Version;
    NSString *str_UL_Trad_SIVersion;
    
    FMDatabase  *database2 = [FMDatabase databaseWithPath:path];
    [database2 open];
    [database2 beginTransaction];
    
    NSString *querySQL = [NSString stringWithFormat:@"select SIVersion, MAX(SILastUpdated) from  Trad_Sys_SI_Version_Details" ];
    FMResultSet *results =  [database2 executeQuery:querySQL];
    
    while ([results next]) {
        
        str_Sys_SI_Version = [results objectForColumnIndex:0];
        
    }
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:str_Sys_SI_Version forKey:@"Sys_SIVersion"];
    
    
    NSString *siplan =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"Plan"];
	NSString *sitype = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
	if (siplan==nil){
		siplan = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];
		sitype = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIType"];
	}
	if (sitype == nil) {
		if (siplan != nil) {
			eAppsListing *eAppList = [[eAppsListing alloc]init];
			sitype = [eAppList GetPlanData2:3 :sitype passdb:database2];
		}
		else {
			siplan = @"";
			sitype = @"";
		}
			
	}
	
	
    NSString *sino =     [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    if([sitype isEqualToString:@"TRAD"])
        
        querySQL = [NSString stringWithFormat:@"select SIVersion from Trad_Details WHERE SINo = '%@'", sino ];
    else
        querySQL = [NSString stringWithFormat:@"select SIVersion from UL_Details WHERE SINo = '%@'", sino ];
    
    
    results =  [database2 executeQuery:querySQL];
    
    while ([results next]) {
        
        str_UL_Trad_SIVersion = [results objectForColumnIndex:0];
        
        
        
    }
    if([str_UL_Trad_SIVersion isEqualToString:@"(null)"] | [str_UL_Trad_SIVersion isEqualToString:@"" ] | [str_UL_Trad_SIVersion isKindOfClass:[NSNull class]] | [str_UL_Trad_SIVersion length] == 0)
    {
        str_UL_Trad_SIVersion = str_Sys_SI_Version ;
    }
    
    [[obj.eAppData objectForKey:@"EAPP"] setValue:str_UL_Trad_SIVersion forKey:@"UL_Trad_SIVersion"];
    
    
    [database2 commit];
    [database2 close];
    
}

@end//prem//
