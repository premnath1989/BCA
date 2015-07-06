//
//  eAppReport.m
//  iMobile Planner
//
//  Created by kuan on 11/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "eAppReport.h"
#import "SICell.h"
#import "PolicyOwnerCell.h"
#import "CFFCell.h"
#import "eAppCell.h"
#import "eSignCell.h"
#import "eSubCell.h"
#import "DataClass.h"
#import "FormViewController.h"
#import "ColorHexCode.h"
#import "MBProgressHUD.h"
#import "ESignGenerator.h"
#import "eSignController.h"

#import "SIxml.h"
#import "PRxml.h"
#import "PDFCreaterHeader.h"

#import "CA_Form.h"
#import "FF_Form.h"
#import "XMLDictionary.h"

#import "CashPromiseViewController.h"

@interface eAppReport ()
{
    NSMutableArray *items;
    
    SICell *siCell;
    PolicyOwnerCell *poCell;
    CFFCell *cffCell;
    eAppCell *eappCell;
    eAppCell *coaCell;
    eAppCell *eauthCell;
    eAppCell *genformsCell;
    eSubCell *esubcell;
    
    DataClass *obj;
    NSMutableArray *dataItems;
}

@property (nonatomic,strong)PDFCreater *proposalCreator;
@end

@implementation eAppReport
@synthesize CAPDFGenerator;
@synthesize FFPDFGenerator;

@synthesize SupplementaryProposalPDFGenerator;

//@synthesize SIPDFGenerator;
@synthesize ProposalPDFGenerator;
@synthesize ApplicationAuthorizationPDFGenerator;
@synthesize getPlanName, getPlanCode,progressLabel,progressView;
@synthesize proposalNo_display;


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
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    obj=[DataClass getInstance];
    appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (appobject.ViewFromPendingBool==YES) {
        
        self.navigationItem.leftBarButtonItem.title= @"Pending Submission Listing";
        
        [self removeGenerateButton];
    }
    if (appobject.ViewFromSubmissionBool==YES) {
        
        self.navigationItem.leftBarButtonItem.title= @"Submitted Cases Listing";
        
        [self removeGenerateButton];
    }
	if (appobject.ViewFromEappBool==YES) {
        
//        self.navigationItem.leftBarButtonItem.title= @"Submitted Cases Listing";
        
        [self DoShowGenerateButton];
    }
    
    
    //NSLog(@"data:%@");
    
    // NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pdfData" ofType:@"plist"]];
    // dataItems = [[NSMutableArray alloc] initWithArray:[dict objectForKey:@"pdfFiles"]];
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    [self initFormListItems];
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
    //    if(MenuOption.DeletePDF==NO){
    //        [self deleteOldPdfs];
    //    }
    
    //    appobject.ViewFromPendingBool=NO;
    //    appobject.ViewFromSubmissionBool=NO;
    
    self.reportTable.scrollEnabled = YES;
    
	// Do any additional setup after loading the view.
    
    
    NSString *displayThis = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    if ([displayThis isEqualToString:NULL]) {
        displayThis = @"";
    }
    
    
    self.reportTable.scrollEnabled = NO;
    
    proposalNo_display =[[UILabel alloc]initWithFrame:CGRectMake(700,5, 930, 20)];
    proposalNo_display.backgroundColor =[UIColor clearColor];
    proposalNo_display.textColor =[UIColor darkGrayColor];
    proposalNo_display.font =[UIFont systemFontOfSize:15];
    proposalNo_display.text =[NSString stringWithFormat:@"Proposal Number: %@",displayThis];
    proposalNo_display.hidden =NO;
    [self.view addSubview:self.proposalNo_display];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doGenerateReport:(id)sender {
    buttonGenerate = (UIButton *)sender;
    [buttonGenerate setHidden:YES];
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MenuOption.FormsTickMark=NO;

    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setFrame:CGRectMake(45, 470, 930, 100)];
    progressView.hidden =NO;
    [self.view addSubview:self.progressView];

    progressLabel =[[UILabel alloc]initWithFrame:CGRectMake((progressView.frame.origin.x +450), progressView.frame.origin.y +10, 50, 50)];
    progressLabel.backgroundColor =[UIColor clearColor];
    progressLabel.hidden =NO;
    [self.view addSubview:self.progressLabel];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(updateProgreessBar) userInfo:nil repeats:YES];

    appobject=(AppDelegate *)[[UIApplication sharedApplication]delegate];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CompareSign"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ComparePhoto"];
    [[NSUserDefaults standardUserDefaults] synchronize];


    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"]) {
        NSMutableArray *array=[[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"] mutableCopy];
        if (![array containsObject:appobject.eappProposal]) {
            [array addObject:appobject.eappProposal];
        }
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"compareString"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSMutableArray *array=[[NSMutableArray alloc] init];
        [array addObject:appobject.eappProposal];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"compareString"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }


    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *SIType = @"";

    //create SIXML Path if not exist
    NSString *SIPath =  [documentsDirectory stringByAppendingPathComponent:@"SIXML"];

    if(![[NSFileManager defaultManager] fileExistsAtPath:SIPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:SIPath withIntermediateDirectories:NO attributes:nil error:nil];
    }


    //create ProposalXML Path if not exist
    NSString *PRPath =  [documentsDirectory stringByAppendingPathComponent:@"ProposalXML"];

    if(![[NSFileManager defaultManager] fileExistsAtPath:PRPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:PRPath withIntermediateDirectories:NO attributes:nil error:nil];
    }


    //create Forms Path if not exist
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];

    if(![[NSFileManager defaultManager] fileExistsAtPath:FormsPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:FormsPath withIntermediateDirectories:NO attributes:nil error:nil];
    }

    [self performSelector:@selector(updateProgreessBar) withObject:nil afterDelay:6.0];


    //XML TO PDF ----->>>
    //XMLs
    SIxml *SIXMLgenerator = [[SIxml alloc]init];
    [SIXMLgenerator GenerateSIXML:self.populateSIXMLData RNNumber:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    NSLog(@"Generate XML : SIXML - generated!");

    PRxml *PRXMLgenerator = [[PRxml alloc]init];
    [PRXMLgenerator GeneratePRXML:self.populatePRXMLData RNNumber:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    NSLog(@"Generate XML : ProposalXML - generated!");


    NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];

    NSString *xmlSIPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"SIXML/%@_SI.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];


    [self forSIdetails];


    //Prepare NSDICTIONARY

    NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];



    NSString  *sqlDBPath = [[NSBundle mainBundle] pathForResource:@"hladb" ofType:@"sqlite"];

    //To Check if this is company case
    NSString *otherIDType_check = @"CR";
    NSString *ptypeCode_check = @"PO";
    NSString *comcase = @"No";
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];

    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];

    FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];

    while ([results_check_comcase next]) {
        comcase = @"Yes";
    }

    if ([comcase isEqualToString:@"No"]) {

        //FF Form will be generated for Non-Company Case
        FF_Form *ffForm = [[FF_Form alloc]init];
        [ffForm returnPDFFromDictionary:xmlDoc proposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] referenceNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] sqliteDBPath:sqlDBPath];
        NSLog(@"Generate Forms : Customer Fact Find - generated!");

        // CA Form will be generated for Non-Company Case
        CA_Form *caCreator = [[CA_Form alloc]init];
        [caCreator returnPDFFromDictionary:xmlDoc proposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] referenceNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] ];
        NSLog(@"Generate Forms : Comfirmaion Of Advice - generated!");
    }

    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    NSDate *currDate = [NSDate date];
    [dateFormatter2 setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter2 stringFromDate:currDate];

    NSString *queryB = @"";
    queryB = [NSString stringWithFormat:@"UPDATE eApp_Listing SET DateUpdated = '%@' WHERE ProposalNo = '%@'", dateString, [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
    [database executeUpdate:queryB];


    eSignController *esignCon = [[eSignController alloc]init];
    [esignCon eApplicationForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
    NSLog(@"Generate Forms : Authorization Form - generated!");


    //PR Form
    self.proposalCreator = [[PDFCreater alloc] init];
    [self.proposalCreator generatePRFormFromPRXMLPath:xmlPRPath
                                         andSIXMLPath:xmlSIPath
                                  andDatabaseFilePath:sqlDBPath];
    NSLog(@"Generate Forms : Proposal Form - generated!");


    appobject.checkList=YES;
}

- (IBAction)doEAppChecklist:(id)sender {
    dataItems = nil;
    [self dismissViewControllerAnimated:TRUE completion:nil];
}



//
//- (void) deletePDFs{
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//
//    //create Forms Path if not exist
//    NSString *FormsPath =  [documentsDirectoryPath stringByAppendingPathComponent:@"Forms"];
//
//
//    if(![[NSFileManager defaultManager] fileExistsAtPath:FormsPath]){
//        [[NSFileManager defaultManager] createDirectoryAtPath:FormsPath withIntermediateDirectories:NO attributes:nil error:nil];
//
//
//    }
//    NSString *PR =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
//    NSString *SP=[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SP_1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
//    NSString *SI =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
//    NSString *FF =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FF.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
//    NSString *CA =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_CA.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
//    NSString *AU =[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
//
//
//
//	//NSString *secondaryDirectoryPath = [documentsDirectoryPath stringByAppendingPathComponent:FormsPath];
//	//NSString *databaseFile = [secondaryDirectoryPath stringByAppendingPathComponent:@"hladb.sqlite"];
//
//	NSFileManager *fileManager = [NSFileManager defaultManager];
//	[fileManager removeItemAtPath:PR error:NULL];
//    [fileManager removeItemAtPath:SP error:NULL];
//    [fileManager removeItemAtPath:SI error:NULL];
//    [fileManager removeItemAtPath:FF error:NULL];
//    [fileManager removeItemAtPath:CA error:NULL];
//    [fileManager removeItemAtPath:AU error:NULL];
//}



-(void)updateProgreessBar
{
    static int count =0; count++;
    
    if (count ==12)
    {
        count =0;
    }
    
    // NSLog(@"thecount %d",count);
    
    if (count <=10)
    {
        //NSLog(@"iShouldBeere %d",count);
        progressLabel.text = [NSString stringWithFormat:@"%d %%",count*10];
        progressLabel.font = [UIFont boldSystemFontOfSize:16];
        self.progressView.progress = (float)count/10.0f;
        NSLog(@"progree_bar loading %@",progressLabel.text);
    }
    
    else
    {
        [self.myTimer invalidate];
        self.myTimer = nil;
        
        NSLog(@"progree_bar loadingMy %@",progressLabel.text);
        
        if ([progressLabel.text isEqualToString:@"100 %"])
        {
            [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(TimerToRun) userInfo:nil repeats:NO];
            
        }
        
    }
    
}

-(void)TimerToRun
{
    
    self.progressLabel.hidden =YES;
    self.progressView.hidden =YES;
    self.Background.hidden =YES;
    
    [self initFormListItems];
    [self.reportTable reloadData];
    [self.reportTable setNeedsDisplay];
    
    // NSLog(@"submitted form");
    [self AlertGenerateDone];
    
}

-(void)AlertGenerateDone
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                    message:@"Forms have been generated successfully."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
    
}


-(void)stopSpinner{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self initFormListItems];
    [self.reportTable reloadData];
    [self.reportTable setNeedsDisplay];
    
    
}

-(void)initFormListItems{
    //initialize Form path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    
    //dataItems = [[NSMutableArray alloc] initWithObjects:@"Brochure_MajorMedi", @"Brochure_Cashpromise_ENGBM", @"Brochure_MajorMediPlus",@"Brochure_MedGlobalIVP",nil];
    
    //prepare array to store forms path
    dataItems = [[NSMutableArray alloc] init];
    
    //check if Form exists.
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
        //  NSLog(@"exist proposal form haha");
        [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SP_1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
        // NSLog(@"exist proposal form haha");
        [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SP_1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
        // NSLog(@"exist proposal form haha");
        [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FF.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
        // NSLog(@"exist proposal form haha");
        [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FF.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_CA.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
        // NSLog(@"exist proposal form haha");
        [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_CA.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
        //  NSLog(@"exist proposal form haha");
        [dataItems addObject:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]];
    }
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    //[self.reportTable setNeedsDisplay];
    //[self.view setNeedsDisplay];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self removeGenerateButton];
    
    //    [self.reportTable reloadData];
    //    [self.reportTable setNeedsDisplay];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    
}

-(void)removeGenerateButton
{
    [buttonGenerate setHidden:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)DoShowGenerateButton
{
    [buttonGenerate setHidden:NO];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSDictionary *) populateSIXMLData
{
    
    NSMutableDictionary *SIXMLData = [[NSMutableDictionary alloc] init];
    obj=[DataClass getInstance];
    //NSLog(@"Report data:%@",obj.eAppData);
    
    //Getting eSystemInfo Key
    NSDictionary *eSystemInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eSystemInfo"];
    //NSLog(@"%@", eSystemInfo);
    if (eSystemInfo) {
        [SIXMLData setObject:eSystemInfo forKey:@"eSystemInfo"];
    }
    
    //Getting SIDetails key
    NSDictionary *SIDetails = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"SIDetails"];
    //NSLog(@"%@", SIDetails);
    if (SIDetails) {
        [SIXMLData setObject:SIDetails forKey:@"SIDetails"];
    }
    
    
    
    return SIXMLData;
    
    
    
}

- (NSDictionary *) populatePRXMLData
{
    NSMutableDictionary *PRXMLData = [[NSMutableDictionary alloc] init];
    obj=[DataClass getInstance];
    //NSLog(@"Report data:%@",obj.eAppData);
    
    //Getting eSystemInfo key
    NSDictionary *eSystemInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eSystemInfo"];
    if (eSystemInfo) {
        [PRXMLData setObject:eSystemInfo forKey:@"eSystemInfo"];
    }
    
    //NSLog(@"%@", eSystemInfo);
    
    //Getting SubmissionInfo key
    NSDictionary *SubmissionInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"SubmissionInfo"];
    
    if (SubmissionInfo) {
        [PRXMLData setObject:SubmissionInfo forKey:@"SubmissionInfo"];
    }
    //NSLog(@"%@",SubmissionInfo);
    
    //Getting ChannelInfo Key
    NSDictionary *ChannelInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"ChannelInfo"];
    if (ChannelInfo) {
        [PRXMLData setObject:ChannelInfo forKey:@"ChannelInfo"];
    }
    
    // NSLog(@"%@",ChannelInfo);
    
    //Gettig AgentInfo Key
    NSDictionary *AgentInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"AgentInfo"];
    if (AgentInfo) {
        [PRXMLData setObject:AgentInfo forKey:@"AgentInfo"];
    }
    
    //NSLog(@"%@",AgentInfo);
    
    //Getting AssuredInfo Key
    NSDictionary *AssuredInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"AssuredInfo"];
    if (AssuredInfo) {
        [PRXMLData setObject:AssuredInfo forKey:@"AssuredInfo"];
    }
    
    //NSLog(@"%@", AssuredInfo);
    
	
    
    //Getting eCFFInfo Key
    NSDictionary *eCFFInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFInfo"];
    if (eCFFInfo) {
        [PRXMLData setObject:eCFFInfo forKey:@"eCFFInfo"];
    }
    
    //NSLog(@"%@",eCFFInfo);
    
    //Getting eCFFPersonalInfo Key
    NSDictionary *eCFFPersonalInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFPersonalInfo"];
    if (eCFFPersonalInfo) {
        [PRXMLData setObject:eCFFPersonalInfo forKey:@"eCFFPersonalInfo"];
    }
    
    //NSLog(@"%@",eCFFPersonalInfo);
    /* for(id key in eCFFPersonalInfo) {
     id value = [eCFFPersonalInfo objectForKey:key];
     for (id key2 in value) {
     id value2 = [value objectForKey:key2];
     if ([key isEqual: @"1"]){
     if([key2 isEqual: @"CFFParty"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_Name"];
     
     }else if([key2 isEqual: @"2"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_NewIC"];
     
     }
     }
     }
     }*/
    //Getting eCFFPartnerInfo Key
    NSDictionary *eCFFPartnerInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFPartnerInfo"];
    if (eCFFPartnerInfo) {
        [PRXMLData setObject:eCFFPartnerInfo forKey:@"eCFFPartnerInfo"];
    }
    //
    //NSLog(@"%@",eCFFPartnerInfo);
    
    //Getting eCFFChildInfo Key
    NSDictionary *eCFFChildInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFChildInfo"];
    if (eCFFChildInfo) {
        [PRXMLData setObject:eCFFChildInfo forKey:@"eCFFChildInfo"];
    }
    //NSLog(@"%@", eCFFChildInfo);
    /* for(id key in eCFFChildInfo) {
     id value = [eCFFChildInfo objectForKey:key];
     for (id key2 in value) {
     id value2 = [value objectForKey:key2];
     if ([key isEqual: @"1"]){
     if([key2 isEqual: @"ChildParty"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_Name"];
     
     }else if([key2 isEqual: @"2"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_NewIC"];
     
     }
     }
     }
     }
     
     */
    //Getting eCFFProtectionInfo Key
    NSDictionary *eCFFProtectionInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFProtectionInfo"];
    if (eCFFProtectionInfo) {
        [PRXMLData setObject:eCFFProtectionInfo forKey:@"eCFFProtectionInfo"];
    }
    
    //NSLog(@"%@", eCFFProtectionInfo);
    
    //Getting eCFFProtectionDetails Key
    NSDictionary *eCFFProtectionDetails = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFProtectionDetails"];
    if (eCFFProtectionDetails) {
        [PRXMLData setObject:eCFFProtectionDetails forKey:@"eCFFProtectionDetails"];
    }
    //NSLog(@"%@", eCFFProtectionDetails);
    /*for(id key in eCFFProtectionDetails) {
     id value = [eCFFProtectionDetails objectForKey:key];
     for (id key2 in value) {
     id value2 = [value objectForKey:key2];
     if ([key isEqual: @"1"]){
     if([key2 isEqual: @"ProtectionPlanInfo"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_Name"];
     
     }else if([key2 isEqual: @"2"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_NewIC"];
     
     }
     }
     }
     }
     */
    //Getting eCFFRetirementInfo Key
    NSDictionary *eCFFRetirementInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFRetirementInfo"];
    if (eCFFRetirementInfo) {
        [PRXMLData setObject:eCFFRetirementInfo forKey:@"eCFFRetirementInfo"];
    }
    //NSLog(@"%@", eCFFRetirementInfo);
    
    //Getting eCFFRetirementDetails Key
    NSDictionary *eCFFRetirementDetails = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFRetirementDetails"];
    if (eCFFRetirementDetails) {
        [PRXMLData setObject:eCFFRetirementDetails forKey:@"eCFFRetirementDetails"];
    }
    //NSLog(@"%@", eCFFRetirementDetails);
    /*for(id key in eCFFRetirementDetails) {
     id value = [eCFFRetirementDetails objectForKey:key];
     for (id key2 in value) {
     id value2 = [value objectForKey:key2];
     if ([key isEqual: @"1"]){
     if([key2 isEqual: @"RetirementPlanInfo"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_Name"];
     
     }else if([key2 isEqual: @"2"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_NewIC"];
     
     }
     }
     }
     }
     */
    //Getting eCFFEducationInfo Key
    NSDictionary *eCFFEducationInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFEducationInfo"];
    if (eCFFEducationInfo) {
        [PRXMLData setObject:eCFFEducationInfo forKey:@"eCFFEducationInfo"];
    }
    //NSLog(@"%@", eCFFEducationInfo);
    
    //Getting eCFFEducationDetails Key
    NSDictionary *eCFFEducationDetails = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFEducationDetails"];
    if (eCFFEducationDetails) {
        [PRXMLData setObject:eCFFEducationDetails forKey:@"eCFFEducationDetails"];
    }
    
    //NSLog(@"%@", eCFFEducationDetails);
    
    //Getting eCFFSavingInfo Key
    NSDictionary *eCFFSavingInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFSavingInfo"];
    if (eCFFSavingInfo) {
        [PRXMLData setObject:eCFFSavingInfo forKey:@"eCFFSavingInfo"];
    }
    
    //NSLog(@"%@", eCFFSavingInfo);
    
    //Getting eCFFSavingsDetails Key
    NSDictionary *eCFFSavingsDetails = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFSavingsDetails"];
    if (eCFFSavingsDetails) {
        [PRXMLData setObject:eCFFSavingsDetails forKey:@"eCFFSavingsDetails"];
    }
    
    //NSLog(@"%@", eCFFSavingsDetails);
    
    //Getting eCFFRecordOfAdviceP1 Key
    NSDictionary *eCFFRecordOfAdviceP1 = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFRecordOfAdviceP1"];
    if (eCFFRecordOfAdviceP1) {
        [PRXMLData setObject:eCFFRecordOfAdviceP1 forKey:@"eCFFRecordOfAdviceP1"];
    }
    
    // NSLog(@"%@", eCFFRecordOfAdviceP1);
    /*  for(id key in eCFFRecordOfAdviceP1) {
     id value = [eCFFRecordOfAdviceP1 objectForKey:key];
     for (id key2 in value) {
     id value2 = [value objectForKey:key2];
     if ([key isEqual: @"1"]){
     if([key2 isEqual: @"Rider"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_Name"];
     
     }else if([key2 isEqual: @"2"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_NewIC"];
     
     }
     }
     }
     }
     */
    //Getting eCFFRecoredOfAdviceP2 Key
    NSDictionary *eCFFRecoredOfAdviceP2 = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFRecoredOfAdviceP2"];
    
    if (eCFFRecoredOfAdviceP2) {
        [PRXMLData setObject:eCFFRecoredOfAdviceP2 forKey:@"eCFFRecoredOfAdviceP2"];
    }
    //NSLog(@"%@", eCFFRecoredOfAdviceP2);
    
    //Getting eCFFConfirmationAdviceGivenTo Key
    NSDictionary *eCFFConfirmationAdviceGivenTo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFConfirmationAdviceGivenTo"];
    if (eCFFConfirmationAdviceGivenTo) {
        [PRXMLData setObject:eCFFConfirmationAdviceGivenTo forKey:@"eCFFConfirmationAdviceGivenTo"];
    }
    
    //NSLog(@"%@", eCFFConfirmationAdviceGivenTo);
    
    //Getting eCFFRecommendedProducts Key
    NSDictionary *eCFFRecommendedProducts = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"eCFFRecommendedProducts"];
    if (eCFFRecommendedProducts) {
        [PRXMLData setObject:eCFFRecommendedProducts forKey:@"eCFFRecommendedProducts"];
    }
    
    //NSLog(@"%@", eCFFRecommendedProducts);
    /*for(id key in eCFFRecommendedProducts) {
     id value = [eCFFRecommendedProducts objectForKey:key];
     for (id key2 in value) {
     id value2 = [value objectForKey:key2];
     if ([key isEqual: @"1"]){
     if([key2 isEqual: @"eCFFRecommendedProducts"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_Name"];
     
     }else if([key2 isEqual: @"ID"]){
     
     //[Proposaldictionary setValue:value2 forKey:@"LifeAssured_NewIC"];
     
     }
     }
     }
     }*/
    //Getting proposalCreditCardInfo Key
    NSDictionary *proposalCreditCardInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalCreditCardInfo"];
    if (proposalCreditCardInfo) {
        [PRXMLData setObject:proposalCreditCardInfo forKey:@"proposalCreditCardInfo"];
    }
    NSDictionary *proposalFTCreditCardInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalFTCreditCardInfo"];
    if (proposalFTCreditCardInfo) {
        [PRXMLData setObject:proposalFTCreditCardInfo forKey:@"proposalFTCreditCardInfo"];
    }
    
    NSDictionary *DCCreditCardInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"DCCreditCardInfo"];
    if (DCCreditCardInfo) {
        [PRXMLData setObject:DCCreditCardInfo forKey:@"DCCreditCardInfo"];
    }
    
    NSDictionary *FATCAInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"FATCAInfo"];
    if (FATCAInfo) {
        [PRXMLData setObject:FATCAInfo forKey:@"FATCAInfo"];
    }
    
    //    NSDictionary *GSTInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"GSTInfo"];
    //    if (GSTInfo) {
    //        [PRXMLData setObject:GSTInfo forKey:@"GSTInfo"];
    //    }
    
    
    //NSLog(@"%@", proposalCreditCardInfo);
    
    //getting proposalPaymentInfo key
    NSDictionary *proposalPaymentInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalPaymentInfo"];
    if (proposalPaymentInfo) {
        [PRXMLData setObject:proposalPaymentInfo forKey:@"proposalPaymentInfo"];
    }
    
    //NSLog(@"%@", proposalPaymentInfo);
    
    //Getting proposalQuestionairies key
    NSDictionary *proposalQuestionairies = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalQuestionairies"];
    if (proposalQuestionairies) {
        [PRXMLData setObject:proposalQuestionairies forKey:@"proposalQuestionairies"];
    }
    
    //NSLog(@"%@", proposalQuestionairies);
    
    //Getting policyExistingLifePolicies Key
    NSDictionary *policyExistingLifePolicies = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"policyExistingLifePolicies"];
    if (policyExistingLifePolicies) {
        [PRXMLData setObject:policyExistingLifePolicies forKey:@"policyExistingLifePolicies"];
    }
    
    //NSLog(@"%@", policyExistingLifePolicies);
    
    //getting propoalAddQuesInfo key
    NSDictionary *propoalAddQuesInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"propoalAddQuesInfo"];
    if (propoalAddQuesInfo) {
        [PRXMLData setObject:propoalAddQuesInfo forKey:@"propoalAddQuesInfo"];
    }
    
    //NSLog(@"%@", propoalAddQuesInfo);
    
    //Getting proposalAddQuesDetails key
    NSDictionary *proposalAddQuesDetails = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalAddQuesDetails"];
    if (proposalAddQuesDetails) {
        [PRXMLData setObject:proposalAddQuesDetails forKey:@"proposalAddQuesDetails"];
    }
    
    //NSLog(@"%@", proposalAddQuesDetails);
    
    
    //Getting proposalDividenInfo key
    NSDictionary *proposalDividenInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalDividenInfo"];
    if (proposalDividenInfo) {
        [PRXMLData setObject:proposalDividenInfo forKey:@"proposalDividenInfo"];
    }
    
    // NSLog(@"%@", proposalDividenInfo);
    
    NSDictionary *proposalFundInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalFundInfo"];
    if (proposalDividenInfo) {
        [PRXMLData setObject:proposalFundInfo forKey:@"proposalFundInfo"];
    }
    
    //NSLog(@"%@", proposalFundInfo);
    
    
    
    //getting proposalNomineeInfo key
    NSDictionary *proposalNomineeInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalNomineeInfo"];
    if (proposalNomineeInfo) {
        [PRXMLData setObject:proposalNomineeInfo forKey:@"proposalNomineeInfo"];
    }
    // NSLog(@"%@", proposalNomineeInfo);
    
    //Getting proposalTrusteeInfo key
    NSDictionary *proposalTrusteeInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalTrusteeInfo"];
    if (proposalTrusteeInfo) {
        [PRXMLData setObject:proposalTrusteeInfo forKey:@"proposalTrusteeInfo"];
    }
    
    //NSLog(@"%@", proposalTrusteeInfo);
    
    
    //Getting proposalCODetails key
    NSDictionary *proposalCODetails = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"proposalCODetails"];
    if (proposalCODetails) {
        [PRXMLData setObject:proposalCODetails forKey:@"proposalCODetails"];
    }
    
    //NSLog(@"%@", proposalCODetails);
    //getting iMobileExtraInfo
    NSDictionary *iMobileExtraInfo = [[obj.eAppData objectForKey:@"EAPPDataSet"] objectForKey:@"iMobileExtraInfo"];
    if (iMobileExtraInfo) {
        [PRXMLData setObject:iMobileExtraInfo forKey:@"iMobileExtraInfo"];
    }
    
    //NSLog(@"%@", iMobileExtraInfo);
    
    
    
    
    
    
    
    /*
     
     NSDictionary *PReApps=
     @{@"eSystemInfo":@{@"SystemName" : @"eApps",
     @"eSystemVersion" : @"2.0",
     },
     @"SubmissionInfo":@{@"CreatedAt" : @"14/06/2013 17:03:33",
     @"XMLGeneratedAt" : @"14/06/2013 17:11:46",
     @"BackDate" : @"False",
     @"Backdating" : @"",
     @"SIType" : @"ES",
     @"CFFStatus" : @"Y",
     },
     @"ChannelInfo":@{@"Channel" : @"AGT",
     },
     @"AgentInfo":@{@"AgentCount" : @"2",
     @"Agent ID=\"1\"" :
     @{@"Seq" : @"1",
     @"AgentCode" : @"A0047307",
     @"AgentContactNo" : @"1234567890",
     @"LeaderCode" : @"",
     @"LeaderName" : @"",
     @"BRCode" : @"",
     @"ISONo" : @"",
     @"BRClosed" : @"",
     @"AgentPercentage" : @"50",
     },
     @"Agent ID=\"2\"" :
     @{@"Seq" : @"2",
     @"AgentCode" : @"A0013420",
     @"AgentContactNo" : @"010-3579132",
     @"LeaderCode" : @"",
     @"LeaderName" : @"",
     @"BRCode" : @"",
     @"ISONo" : @"",
     @"BRClosed" : @"",
     @"AgentPercentage" : @"50",
     },
     },
     @"AssuredInfo":@{//@"eProposalNo" : @"RN130614050333513",
     @"Party ID=\"1\"" :
     @{@"PTypeCode" : @"2",
     @"Seq" : @"A0013420",
     @"DeclarationAuth" : @"010-3579132",
     @"ClientChoice" : @"",
     @"LATitle" : @"",
     @"LAName" : @"",
     @"LASex" : @"",
     @"LADOB" : @"",
     @"AgeAdmitted" : @"50",
     @"LAMaritalStatus" : @"2",
     @"LARace" : @"A0013420",
     @"LAReligion" : @"010-3579132",
     @"LANationality" : @"",
     @"LAOccupationCode" : @"",
     @"LAExactDuties" : @"",
     @"LATypeOfBusiness" : @"",
     @"LAEmployerName" : @"",
     @"LAYearlyIncome" : @"50",
     @"LARelationship" : @"50",
     @"ChildFlag" : @"50",
     @"ResidenceOwnRented" : @"50",
     @"CorrespondenceAddress" : @"50",
     @"LANewIC" :
     @{@"LANewICCode" : @"2",
     @"LANewICNo" : @"A0013420",
     },
     @"LAOtherID" :
     @{@"LAOtherIDType" : @"2",
     @"LAOtherID" : @"A0013420",
     },
     @"Addresses" :
     @{@"Address Type=\"Residence\"" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     },
     @"Address Type=\"Office\"" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     },
     },
     @"Contacts" :
     @{@"Contact Type=\"Residence\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Office\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Mobile\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Email\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Fax\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     },
     @"PentalHealthDetails" :
     @{@"PentalHealth_1" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     @"PentalHealth_2" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     @"PentalHealth_3" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     },
     },
     @"Party ID=\"2\"" :
     @{@"PTypeCode" : @"2",
     @"Seq" : @"A0013420",
     @"DeclarationAuth" : @"010-3579132",
     @"ClientChoice" : @"",
     @"LATitle" : @"",
     @"LAName" : @"",
     @"LASex" : @"",
     @"LADOB" : @"",
     @"AgeAdmitted" : @"50",
     @"LAMaritalStatus" : @"2",
     @"LARace" : @"A0013420",
     @"LAReligion" : @"010-3579132",
     @"LANationality" : @"",
     @"LAOccupationCode" : @"",
     @"LAExactDuties" : @"",
     @"LATypeOfBusiness" : @"",
     @"LAEmployerName" : @"",
     @"LAYearlyIncome" : @"50",
     @"LARelationship" : @"50",
     @"ChildFlag" : @"50",
     @"ResidenceOwnRented" : @"50",
     @"CorrespondenceAddress" : @"50",
     @"LANewIC" :
     @{@"LANewICCode" : @"2",
     @"LANewICNo" : @"A0013420",
     },
     @"LAOtherID" :
     @{@"LAOtherIDType" : @"2",
     @"LAOtherID" : @"A0013420",
     },
     @"Addresses" :
     @{@"Address Type=\"Residence\"" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     },
     @"Address Type=\"Office\"" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     },
     },
     @"Contacts" :
     @{@"Contact Type=\"Residence\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Office\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Mobile\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Email\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Fax\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     },
     @"PentalHealthDetails" :
     @{@"PentalHealth_1" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     @"PentalHealth_2" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     @"PentalHealth_3" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     },
     },
     
     @"Party ID=\"3\"" :
     @{@"PTypeCode" : @"2",
     @"Seq" : @"A0013420",
     @"DeclarationAuth" : @"010-3579132",
     @"ClientChoice" : @"",
     @"LATitle" : @"",
     @"LAName" : @"",
     @"LASex" : @"",
     @"LADOB" : @"",
     @"AgeAdmitted" : @"50",
     @"LAMaritalStatus" : @"2",
     @"LARace" : @"A0013420",
     @"LAReligion" : @"010-3579132",
     @"LANationality" : @"",
     @"LAOccupationCode" : @"",
     @"LAExactDuties" : @"",
     @"LATypeOfBusiness" : @"",
     @"LAEmployerName" : @"",
     @"LAYearlyIncome" : @"50",
     @"LARelationship" : @"50",
     @"ChildFlag" : @"50",
     @"ResidenceOwnRented" : @"50",
     @"CorrespondenceAddress" : @"50",
     @"LANewIC" :
     @{@"LANewICCode" : @"2",
     @"LANewICNo" : @"A0013420",
     },
     @"LAOtherID" :
     @{@"LAOtherIDType" : @"2",
     @"LAOtherID" : @"A0013420",
     },
     @"Addresses" :
     @{@"Address Type=\"Residence\"" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     },
     @"Address Type=\"Office\"" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     },
     },
     @"Contacts" :
     @{@"Contact Type=\"Residence\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Office\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Mobile\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Email\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Fax\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     },
     @"PentalHealthDetails" :
     @{@"PentalHealth_1" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     @"PentalHealth_2" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     @"PentalHealth_3" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     },
     },
     
     @"Party ID=\"4\"" :
     @{@"PTypeCode" : @"2",
     @"Seq" : @"A0013420",
     @"DeclarationAuth" : @"010-3579132",
     @"ClientChoice" : @"",
     @"LATitle" : @"",
     @"LAName" : @"",
     @"LASex" : @"",
     @"LADOB" : @"",
     @"AgeAdmitted" : @"50",
     @"LAMaritalStatus" : @"2",
     @"LARace" : @"A0013420",
     @"LAReligion" : @"010-3579132",
     @"LANationality" : @"",
     @"LAOccupationCode" : @"",
     @"LAExactDuties" : @"",
     @"LATypeOfBusiness" : @"",
     @"LAEmployerName" : @"",
     @"LAYearlyIncome" : @"50",
     @"LARelationship" : @"50",
     @"ChildFlag" : @"50",
     @"ResidenceOwnRented" : @"50",
     @"CorrespondenceAddress" : @"50",
     @"LANewIC" :
     @{@"LANewICCode" : @"2",
     @"LANewICNo" : @"A0013420",
     },
     @"LAOtherID" :
     @{@"LAOtherIDType" : @"2",
     @"LAOtherID" : @"A0013420",
     },
     @"Addresses" :
     @{@"Address Type=\"Residence\"" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     },
     @"Address Type=\"Office\"" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     },
     },
     @"Contacts" :
     @{@"Contact Type=\"Residence\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Office\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Mobile\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Email\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     @"Contact Type=\"Fax\"" :
     @{@"ContactCode" : @"2",
     @"ContactNo" : @"A0013420",
     },
     },
     @"PentalHealthDetails" :
     @{@"PentalHealth_1" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     @"PentalHealth_2" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     @"PentalHealth_3" :
     @{@"Code" : @"2",
     @"Status" : @"A0013420",
     },
     },
     },
     },
     @"NomineeInfo":@{@"NomineeCount" : @"1",
     @"Nominee ID=\"1\"" :
     @{@"Seq" : @"",
     @"NMTitle" : @"",
     @"NMName" : @"False",
     @"NMShare" : @"",
     @"NMDOB" : @"False",
     @"NMSex" : @"0.0000",
     @"NMRelationship" : @"0.0000",
     @"NMSamePOAddress" : @"0.0000",
     @"NMTrustStatus" : @"0.0000",
     @"NMChildAlive" : @"0.0000",
     @"NMNewIC" :
     @{@"NMNewICCode":@"True",
     @"NMNewICNo":@"* Jln Tan Cheng Lock",
     },
     @"NMOtherID" :
     @{@"NMOtherIDType":@"AN",
     @"NMOtherID":@"A12345678",
     },
     @"NMAddr" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     @"AddressSameAsPO":@"Y",
     },
     },
     },
     @"CreditCardInfo":@{@"CardMemberAccountNo" : @"4444333322221111",
     @"CardExpiredDate" : @"12/2014",
     @"CardMemberName" : @"Tan Ah Kao",
     @"CardMemberNewICNo" : @"",
     @"CardMemberContactNo" : @"01289132542",
     @"CardMemberRelationship" : @"SELF",
     @"CreditCardType" : @"HLB VISA",
     @"CreditCardBank" : @"BOC",
     },
     @"PaymentInfo":@{@"FirstTimePayment" : @"03",
     @"PaymentMode" : @"12",
     @"PaymentMethod" : @"05",
     @"TotalModalPremium" : @"2635.11",
     @"PaymentFinalAcceptance" : @"",
     },
     @"TrusteeInfo":@{@"TrusteeCount" : @"1",
     @"Trustee ID=\"1\"" :
     @{@"Seq" : @"",
     @"TrusteeTitle" : @"",
     @"TrusteeName" : @"False",
     @"TrusteeRelationship" : @"",
     @"TrusteeSex" : @"False",
     @"TrusteeDOB" : @"0.0000",
     @"TRNewIC" :
     @{@"TRNewICCode":@"True",
     @"TRNewICNo":@"* Jln Tan Cheng Lock",
     },
     @"TROtherID" :
     @{@"TrusteeOtherIDType":@"AN",
     @"TrusteeOtherID":@"A12345678",
     },
     @"TrusteeAddr" :
     @{@"AddressCode":@"ADR001",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WP",
     @"Postcode":@"54000",
     @"Country":@"MAL",
     @"ForeignAddress":@"N",
     @"AddressSameAsPO":@"Y",
     },
     },
     },
     @"ExistingPolInfo":@{@"ExistingPolCount" : @"1",
     @"ExistingPol ID=\"1\"" :
     @{@"PTypeCode" : @"LA",
     @"Seq" : @"1",
     @"PTypeCodeDesc" : @"1st Life Assured",
     @"ExistingPolDetailsCount" : @"1",
     @"ExistingPolDetails ID=\"1\"" :
     @{@"ExtPolCompany":@"PRU",
     @"ExtPolLife":@"150,000.00",
     @"ExtPolPA":@"",
     @"ExtPolCI":@"",
     @"ExtPolDateIssued":@"2010",
     },
     },
     },
     
     @"QuestionaireInfo":@{@"QuestionaireCount" : @"2",
     @"Questionaire ID=\"1\"" :
     @{@"PTypeCode" : @"14/06/2013 17:08:22",
     @"Seq" : @"14/06/2013 17:08:22",
     @"Height" : @"1",
     @"Weight" : @"",
     @"Questions ID=\"1\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"2\"" :
     @{@"QnID":@"Q1002",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"3\"" :
     @{@"QnID":@"Q1003",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"4\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"5\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"6\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"7\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"8\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"9\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"10\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"11\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"12\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"13\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"14\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"15\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"16\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"17\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"18\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"19\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"20\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"21\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"22\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"23\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"24\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"25\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"26\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"27\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"28\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"29\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"30\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     },
     @"Questionaire ID=\"2\"" :
     @{@"PTypeCode" : @"14/06/2013 17:08:22",
     @"Seq" : @"14/06/2013 17:08:22",
     @"Height" : @"1",
     @"Weight" : @"",
     @"Questions ID=\"1\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"2\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"3\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"4\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"5\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"6\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"7\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"8\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"9\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"10\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"11\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"12\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"13\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"14\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"15\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"16\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"17\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"18\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"19\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"20\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"21\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"22\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"23\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"24\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"25\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"26\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"27\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"28\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"29\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     @"Questions ID=\"30\"" :
     @{@"QnID":@"Q1001",
     @"QnParty":@"I",
     @"AnswerType":@"TXT",
     @"Answer":@"150;55",
     @"Reason":@"",
     },
     },
     },
     @"ContigentInfo":@{@"COTitle" : @"",
     @"COName" : @"",
     @"CODOB" : @"",
     @"COSex" : @"",
     @"CORelationship" : @"",
     @"COSameAddressPO" : @"False",
     @"CONewIC" :
     @{@"CONewICCode" : @"",
     @"CONewICNo" : @"",
     },
     @"COOtherID" :
     @{@"COOtherIDType" : @"",
     @"COOtherID" : @"",
     },
     @"COAddr" :
     @{@"AddressCode" : @"",
     @"Address1" : @"",
     @"Address2" : @"",
     @"Address3" : @"",
     @"Town" : @"",
     @"State" : @"IC",
     @"Postcode" : @"PD",
     @"Country" : @"False",
     @"ForeignAddress" : @"",
     @"AddressSameAsPO" : @"N",
     },
     @"COContacts" :
     @{@"COContact Type=\"Residence\"" :
     @{@"ContactCode" : @"",
     @"ContactNo" : @"",
     },
     @"COContact Type=\"Mobile\"" :
     @{@"ContactCode" : @"",
     @"ContactNo" : @"",
     },
     @"COContact Type=\"Email\"" :
     @{@"ContactCode" : @"",
     @"ContactNo" : @"",
     },
     },
     },
     @"DividendInfo":@{@"CashPaymentOption" : @"",
     @"CashDividendOption" : @"",
     @"FullPaidUpOption" : @"False",
     @"FullPaidUpTerm" : @"",
     @"RevisedSA" : @"False",
     @"AmtRevised" : @"0.0000",
     @"ReducePaidUpYear" : @"0",
     @"GYIOption" : @"",
     @"ReInvestYI" : @"",
     },
     @"FundInfo":@{@"BenefitChoices" : @"IC",
     @"ExcessPaymentOpt" : @"PD",
     @"LienOpt" : @"False",
     @"StrategyCode" : @"",
     @"InvestHorizon" : @"",
     },
     @"eCFFInfo":@{@"CreatedAt" : @"14/06/2013 17:08:22",
     @"LastUpdatedAt" : @"14/06/2013 17:08:22",
     @"IntermediaryStatus" : @"1",
     @"BrokerName" : @"",
     @"ClientChoice" : @"2",
     @"RiskReturnProfile" : @"2",
     @"NeedsQ1_Ans1" : @"Y",
     @"NeedsQ1_Ans2" : @"Y",
     @"NeedsQ1_Priority" : @"1",
     @"NeedsQ2_Ans1" : @"Y",
     @"NeedsQ2_Ans2" : @"N",
     @"NeedsQ2_Priority" : @"2",
     @"NeedsQ3_Ans1" : @"Y",
     @"NeedsQ3_Ans2" : @"N",
     @"NeedsQ3_Priority" : @"3",
     @"NeedsQ4_Ans1" : @"Y",
     @"NeedsQ4_Ans2" : @"N",
     @"NeedsQ4_Priority" : @"4",
     @"NeedsQ5_Ans1" : @"Y",
     @"NeedsQ5_Ans2" : @"N",
     @"NeedsQ5_Priority" : @"5",
     @"IntermediaryCode" : @"A0047307",
     @"IntermediaryName" : @"HLA Agents",
     @"IntermediaryNRIC" : @"770101011111",
     @"IntermediaryContractDate" : @"10/04/1977",
     @"IntermediaryAddress1" : @"agent address d'crimson",
     @"IntermediaryAddress2" : @"",
     @"IntermediaryAddress3" : @"",
     @"IntermediaryAddress4" : @"",
     @"IntermediaryManagerName" : @"",
     @"ClientAck": @"1",
     @"ClientComments" : @"",
     },
     @"PersonalInfo":@{@"CFFParty ID=\"1\"" :
     @{@"AddFromCFF" : @"False",
     @"AddNewPayor" : @"False",
     @"SameAsPO" : @"True",
     @"PTypeCode" : @"LA2",
     @"PYFlag" : @"True",
     @"Title" : @"ENCIK",
     @"Name" : @"Tan Ah Kao",
     @"NewICNo" : @"",
     @"OtherIDType" : @"AN",
     @"OtherID" : @"A12345678",
     @"Nationality" : @"",
     @"Race" : @"CHINESE",
     @"Religion" : @"NON-MUSLIM",
     @"Sex" : @"M",
     @"Smoker" : @"Y",
     @"DOB" : @"12/02/1974",
     @"Age" : @"39",
     @"MaritalStatus" : @"M",
     @"Occupation" : @"ACCOUNT MANAGER",
     @"ResidencePhoneNo" : @"0345678922",
     @"OfficePhoneNo" : @"0354852121",
     @"MobilePhoneNo" : @"01289132542",
     @"FaxPhoneNo" : @"",
     @"EmailAddress" : @"",
     @"CFFAddresses" :
     @{@"CFFAddress Type=\"Mailing\"" :
     @{@"AddressSameAsPO":@"True",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WILAYAH PERSEKUTUAN",
     @"Postcode":@"54000",
     @"Country":@"MALAYSIA",
     @"ForeignAddress":@"N",
     },
     @"CFFAddress Type=\"Permanent\"" :
     @{@"AddressSameAsPO":@"True",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WILAYAH PERSEKUTUAN",
     @"Postcode":@"54000",
     @"Country":@"MALAYSIA",
     @"ForeignAddress":@"N",
     },
     },
     },
     @"CFFParty ID=\"2\"" :
     @{@"AddFromCFF" : @"False",
     @"AddNewPayor" : @"False",
     @"SameAsPO" : @"False",
     @"PTypeCode" : @"LA1",
     @"PYFlag" : @"False",
     @"Title" : @"CIK",
     @"Name" : @"Lim Suk Mui",
     @"NewICNo" : @"770101022222",
     @"OtherIDType" : @"",
     @"OtherID" : @"",
     @"Nationality" : @"",
     @"Race" : @"CHINESE",
     @"Religion" : @"NON-MUSLIM",
     @"Sex" : @"F",
     @"Smoker" : @"N",
     @"DOB" : @"01/01/1977",
     @"Age" : @"36",
     @"MaritalStatus" : @"M",
     @"Occupation" : @"HOUSEWIFE",
     @"ResidencePhoneNo" : @"",
     @"OfficePhoneNo" : @"",
     @"MobilePhoneNo" : @"01754154512",
     @"FaxPhoneNo" : @"",
     @"EmailAddress" : @"",
     @"CFFAddresses" :
     @{@"CFFAddress Type=\"Mailing\"" :
     @{@"AddressSameAsPO":@"True",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WILAYAH PERSEKUTUAN",
     @"Postcode":@"54000",
     @"Country":@"MALAYSIA",
     @"ForeignAddress":@"N",
     },
     @"CFFAddress Type=\"Permanent\"" :
     @{@"AddressSameAsPO":@"True",
     @"Address1":@"* Jln Tan Cheng Lock",
     @"Address2":@"Tmn Yarl",
     @"Address3":@"",
     @"Town":@"KUALA LUMPUR",
     @"State":@"WILAYAH PERSEKUTUAN",
     @"Postcode":@"54000",
     @"Country":@"MALAYSIA",
     @"ForeignAddress":@"N",
     },
     },
     },
     },
     @"ChildInfo":@{@"ChildParty ID=\"1\"" :
     @{@"AddFromCFF":@"True",
     @"SameAsPO":@"False",
     @"PTypeCode":@"",
     @"Name":@"Tan Ah Son",
     @"Relationship":@"SON",
     @"DOB":@"01/10/1994",
     @"Age":@"18",
     @"Sex":@"M",
     @"YearsToSupport":@"2",
     },
     @"ChildParty ID=\"2\"" :
     @{@"AddFromCFF":@"True",
     @"SameAsPO":@"False",
     @"PTypeCode":@"",
     @"Name":@"Tan Ah Mui",
     @"Relationship":@"DAUGHTER",
     @"DOB":@"02/02/1990",
     @"Age":@"23",
     @"Sex":@"F",
     @"YearsToSupport":@"3",
     },
     },
     @"ProtectionInfo":@{@"AllocateIncome_1" : @"1,500.00",
     @"AllocateIncome_2" : @"200.00",
     @"TotalSA_CurAmt" : @"0.00",
     @"TotalSA_ReqAmt" : @"150,000.00",
     @"TotalSA_SurAmt" : @"150,000.00",
     @"TotalCISA_CurAmt" : @"0.00",
     @"TotalCISA_ReqAmt" : @"200,000.00",
     @"TotalCISA_SurAmt" : @"200,000.00",
     @"TotalHB_CurAmt" : @"0.00",
     @"TotalHB_ReqAmt" : @"300,000.00",
     @"TotalHB_SurAmt" : @"300,000.00",
     @"TotalPA_CurAmt" : @"0.00",
     @"TotalPA_ReqAmt" : @"400,000.00",
     @"TotalPA_SurAmt" : @"400,000.00",
     @"NoExistingPlan" : @"True",
     @"ProtectionPlanInfo ID=\"1\"" :
     @{@"POName":@"",
     @"Company":@"",
     @"PlanType ":@"",
     @"LAName ":@"",
     @"Benefit1 ":@"",
     @"Benefit2 ":@"",
     @"Benefit3 ":@"",
     @"Benefit4 ":@"",
     @"Premium ":@"",
     @"Mode ":@"",
     @"MaturityDate ":@"",
     },
     },
     @"RetirementInfo":@{@"AllocateIncome_1" : @"250.00",
     @"AllocateIncome_2" : @"300.00",
     @"IncomeSource_1" : @"Rent",
     @"IncomeSource_2" : @"Invest",
     @"CurAmt" : @"5,000,000.00",
     @"ReqAmt" : @"60,000,000.00",
     @"SurAmt" : @"55,000,000.00",
     @"NoExistingPlan" : @"False",
     @"RetirementPlanInfo ID=\"1\"" :
     @{@"POName" : @"Tan Ah Kao",
     @"Company" : @"HLA",
     @"PlanType" : @"Life 100",
     @"Premium" : @"500.00",
     @"Frequency" : @"01",
     @"StartDate" : @"Year 1999",
     @"EndDate" : @"Year 2015",
     @"LSMaturityAmt" : @"",
     @"AIMaturityAmt" : @"",
     @"Benefits" : @"",
     },
     @"RetirementPlanInfo ID=\"2\"" :
     @{@"POName" : @"Tan Ah Kao",
     @"Company" : @"PRU",
     @"PlanType" : @"PRULink",
     @"Premium" : @"600.00",
     @"Frequency" : @"01",
     @"StartDate" : @"Year 1991",
     @"EndDate" : @"Year 2016",
     @"LSMaturityAmt" : @"1,500,000.00",
     @"AIMaturityAmt" : @"25,200,000,000.00",
     @"Benefits" : @"rider 1, rider 2, rider 3",
     },
     },
     @"EducInfo":@{@"AllocateIncome_1" : @"150.00",
     @"CurAmt_C1" : @"0.00",
     @"ReqAmt_C1" : @"150,000.00",
     @"SurAmt_C1" : @"150,000.00",
     @"CurAmt_C2" : @"0.00",
     @"ReqAmt_C2" : @"250,000.00",
     @"SurAmt_C2" : @"250,000.00",
     @"CurAmt_C3" : @"0.00",
     @"ReqAmt_C3" : @"",
     @"SurAmt_C3" : @"",
     @"CurAmt_C4" : @"0.00",
     @"ReqAmt_C4" : @"",
     @"SurAmt_C4" : @"",
     @"NoExistingPlan" : @"True",
     @"EducPlanInfo ID=\"1\"" :
     @{@"Name" : @"",
     @"Company" : @"",
     @"Premium" : @"",
     @"Frequency" : @"",
     @"StartDate" : @"",
     @"EndDate" : @"",
     @"MaturityAmt" : @"",
     },
     },
     @"SavingInfo":@{@"AllocateIncome_1" : @"200.00",
     @"CurAmt" : @"0.00",
     @"ReqAmt" : @"200,000.00",
     @"SurAmt" : @"200,000.00",
     @"NoExistingPlan" : @"True",
     @"SavingPlanInfo ID=\"1\"" :
     @{@"POName" : @"",
     @"Company" : @"",
     @"Type" : @"",
     @"Purpose" : @"",
     @"Premium" : @"",
     @"ComDate" : @"",
     @"MaturityAmt" : @"",
     },
     },
     @"RecordOfAdvice":@{@"RecCount" : @"3",
     @"Priority ID=\"1\"" :
     @{@"Seq" : @"1",
     @"SameAsQuotation" : @"True",
     @"PlanType" : @"HLA EverLife",
     @"Term" : @"64",
     @"InsurerName" : @"Hong Leong Assurance Berhad",
     @"InsuredName" : @"Lim Suk Mui",
     @"SA" : @"63,000.00",
     @"Reason" : @"Saving",
     @"Action" : @"",
     @"RecordOfAdviceBenefits" :
     @{@"Rider ID=\"1\"" :
     @{@"RiderName" : @"Critical Illness Waiver of Premium Rider",
     },
     @"Rider ID=\"2\"" :
     @{@"RiderName" : @"HLA Major Medi",
     },
     @"Rider ID=\"3\"" :
     @{@"RiderName" : @"Living Care Waiver of Premium Rider",
     },
     },
     },
     },
     @"ConfirmationOfAdviceGivenTo":@{@"Choice1" : @"True",
     @"Choice2" : @"True",
     @"Choice3" : @"True",
     @"Choice4" : @"False",
     @"Choice5" : @"False",
     @"Choice6" : @"False",
     @"Choice6_desc" : @"",
     },
     @"ProductRecommended":@{@"RecCount" : @"2",
     @"RecommendationInfo ID=\"1\"" :
     @{@"Seq" : @"1",
     @"InsuredName" : @"True",
     @"PlanType" : @"True",
     @"Term" : @"False",
     @"Premium" : @"False",
     @"Frequency" : @"False",
     @"SA" : @"",
     @"BoughtOpt" : @"False",
     @"AddNew" : @"False",
     @"AdditionalBenefits" :
     @{@"RecommendedRider ID=\"1\"" :
     @{@"RiderName" : @"True",
     },
     @"RecommendedRider ID=\"2\"" :
     @{@"RiderName" : @"True",
     },
     },
     },
     @"RecommendationInfo ID=\"2\"" :
     @{@"Seq" : @"1",
     @"InsuredName" : @"True",
     @"PlanType" : @"True",
     @"Term" : @"False",
     @"Premium" : @"False",
     @"Frequency" : @"False",
     @"SA" : @"",
     @"BoughtOpt" : @"False",
     @"AddNew" : @"False",
     @"AdditionalBenefits" :
     @{@"RecommendedRider ID=\"1\"" :
     @{@"RiderName" : @"True",
     },
     },
     },
     
     },
     };
     
     
     
     */
    
    return PRXMLData;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (appobject.ViewDeleteSubmissionBool==YES)
    {
        (appobject.ViewDeleteSubmissionBool =NO);
        return 6;
    }
    if (appobject.ViewDeleteSubmissionBool==NO)
    {
        
        return 7;//[self.players count];
    }
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *eAppCellIdentifier = @"ProposalFormCell";
    static NSString *PolicyOwnerCellIdentifier = @"SupplementaryFormCell";
    static NSString *SICellIdentifier = @"SIFormCell";
    static NSString *CFFCellIdentifier = @"CFFFormCell";
    static NSString *COACellIdentifier = @"COAFormCell";
    static NSString *EAuthCellIdentifier = @"EAuthFormCell";
    static NSString *GenFormsCellIdentifier = @"GenerateFormsCell";
    
    UITableViewCell *cell;
    
    /*
     NSString *aa;
     aa = [NSString stringWithFormat:@"Selected SI No: %@   Client Name: %@   Plan Name: %@",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"ClientName"], [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
     siCell.descriptionLabel1.text = aa;
     */
    
    //initialize Form path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
    
    NSString *otherIDType_check = @"CR";
    NSString *ptypeCode_check = @"PO";
    NSString *comcase = @"No";
    // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];
    
    while ([results_check_comcase next]) {
        // NSLog(@"Company case, CA and CFF will not be generated!");
        comcase = @"Yes";
    }
    
    if (indexPath.row == 0){
        eappCell = [tableView dequeueReusableCellWithIdentifier:eAppCellIdentifier];
        
        //check if Form exists.
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [eappCell.statusLabel1 setImage:doneImage];
            eappCell.tag = 1;
        }
        
        return eappCell;
    }
    else if (indexPath.row == 1){
        poCell = [tableView dequeueReusableCellWithIdentifier:PolicyOwnerCellIdentifier];
        
        //check if Form exists.
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SP_1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [poCell.statusImage1 setImage:doneImage];
            poCell.tag = 1;
        }
        
        return poCell;
    }
    else if (indexPath.row == 2){
        siCell = [tableView dequeueReusableCellWithIdentifier:SICellIdentifier];
        
        //check if Form exists.
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [siCell.statusImage1 setImage:doneImage];
            siCell.tag = 1;
        }
        
        siCell.tag = 1;
        
        return siCell;
    }
    else if (indexPath.row == 3){
        cffCell = [tableView dequeueReusableCellWithIdentifier:CFFCellIdentifier];
        if([comcase isEqualToString:@"No"]){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FF.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
                [cffCell.statusLabel1 setImage:doneImage];
                cffCell.tag = 1;
            }
        }
        else if([comcase isEqualToString:@"Yes"]){
            UIImage *doneImage = [UIImage imageNamed: @"iconNotComplete.png"];
            [cffCell.statusLabel1 setImage:doneImage];
            cffCell.tag = 1;
        }
        return cffCell;
        
    }
    else if (indexPath.row == 4){
        coaCell = [tableView dequeueReusableCellWithIdentifier:COACellIdentifier];
        
        //check if Form exists.
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_CA.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [coaCell.statusLabel1 setImage:doneImage];
            coaCell.tag = 1;
        }
        
        return coaCell;
        
    }
    else if (indexPath.row == 5){
        eauthCell = [tableView dequeueReusableCellWithIdentifier:EAuthCellIdentifier];
        
        //check if Form exists.
        if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            
            UIImage *doneImage = [UIImage imageNamed: @"iconComplete.png"];
            [eauthCell.statusLabel1 setImage:doneImage];
            eauthCell.tag = 1;
        }
        
        
        return eauthCell;
        
    }
    else if (indexPath.row == 6)
    {
        genformsCell = [tableView dequeueReusableCellWithIdentifier:GenFormsCellIdentifier];
        
        if (appobject.ViewFromPendingBool==YES) {
            
            genformsCell.hidden =YES;
            genformsCell.userInteractionEnabled =NO;
            appobject.ViewFromPendingBool=NO;
            appobject.ViewFromSubmissionBool=NO;
            
            
            
        }
        if (appobject.ViewFromSubmissionBool==YES)
        {
            genformsCell.hidden =YES;
            genformsCell.userInteractionEnabled =NO;
            appobject.ViewFromPendingBool=NO;
            appobject.ViewFromSubmissionBool=NO;
            
            
        }
        
        
        return genformsCell;
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	NSString *proposalform12 =   [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"];
    NSArray *array=[[NSUserDefaults standardUserDefaults] objectForKey:@"compareString"];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsPath = [paths objectAtIndex:0];
	NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
	
    if(indexPath.row != 6)
    {
        //initialize Form path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
        
        NSString *otherIDType_check = @"CR";
        NSString *ptypeCode_check = @"PO";
        NSString *comcase = @"No";
        // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:path];
        [database open];
        
        FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];
        
        while ([results_check_comcase next]) {
            // NSLog(@"Company case, CA and CFF will not be generated!");
            comcase = @"Yes";
        }
        if(indexPath.row == 0){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                [self showFormDetails:indexPath];
            }
        }
        else if(indexPath.row == 1){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SP_1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                [self showFormDetails:indexPath];
            }
        }
        else if(indexPath.row == 2){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                // NSInteger newIndexRow=[indexPath indexAtPosition:indexPath.length-1];
                // indexPath=[[indexPath indexPathByRemovingLastIndex] indexPathByAddingIndex:newIndexRow];
                indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
                [self forSIdetails];
                [self showFormDetails:indexPath];
            }
        }
        else if((indexPath.row == 3) && [comcase isEqualToString:@"No"]){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FF.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                // NSInteger newIndexRow=indexPath.row+1;
                
                indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
                [self showFormDetails:indexPath];
            }
        }
        else if(indexPath.row == 4){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_CA.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
                [self showFormDetails:indexPath];
            }
        }
        else if(indexPath.row == 5)//{
//            //check if Form exists.
//            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
//                indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
//                [self showFormDetails:indexPath];
//            }
//        }
			
		{
            
            if ([array containsObject:proposalform12])
            {
                
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
                
                // NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"xml"];
                
                NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
                
                NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];
                
                
                //   [self.navigationController setNavigationBarHidden:YES animated:NO];
                
                
                _signController = [[eSignController alloc]init];
                
                _signController.delegate=self;
                _signController.cellRghtbuttonDisabled1 =@"disable";
                
                [_signController eApplicationForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
                
                // [self.navigationController.navigationBar setUserInteractionEnabled:NO];
                
                _signController.view.frame = CGRectMake(0, 20, _signController.view.frame.size.width, _signController.view.frame.size.height);
                //how o_signController.navigationController.navigationItem.rightBarButtonItem.isEnabled =FALSE;
                
                [self.navigationController.view addSubview:_signController.view];
                ;
                
                
                
                
                //  [self.navigationController setNavigationBarHidden:NO animated:YES];
                
            }
            
            
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
    
    
    if(indexPath.row != 6)
    {
        
        NSString *otherIDType_check = @"CR";
        NSString *ptypeCode_check = @"PO";
        NSString *comcase = @"No";
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path1 = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
        
        FMDatabase *database = [FMDatabase databaseWithPath:path1];
        [database open];
        
        FMResultSet *results_check_comcase = [database executeQuery:@"SELECT * from eProposal_LA_Details WHERE eProposalNo = ? AND PTypeCode =? AND LAOtherIDType = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], ptypeCode_check, otherIDType_check];
        
        while ([results_check_comcase next]) {
            // NSLog(@"Company case, CA and CFF will not be generated!");
            comcase = @"Yes";
        }
        //initialize Form path
        // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *FormsPath =  [documentsDirectory stringByAppendingPathComponent:@"Forms"];
        
        
        if(indexPath.row == 0){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_PR.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                [self showFormDetails:indexPath];
            }
        }
        else if(indexPath.row == 1){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SP_1.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                [self showFormDetails:indexPath];
            }
        }
        else if(indexPath.row == 2){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_SI.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                // NSInteger newIndexRow=[indexPath indexAtPosition:indexPath.length-1];
                // indexPath=[[indexPath indexPathByRemovingLastIndex] indexPathByAddingIndex:newIndexRow];
                indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
                //[self forSIdetails];
                [self showFormDetails:indexPath];
            }
        }
        else if((indexPath.row == 3) && [comcase isEqualToString:@"No"]){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_FF.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                
                // NSInteger newIndexRow=indexPath.row+1;
                
                indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
                [self showFormDetails:indexPath];
            }
        }
        else if(indexPath.row == 4){
            //check if Form exists.
            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_CA.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
                indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
                [self showFormDetails:indexPath];
            }
        }
        
        
        else if(indexPath.row == 5)
            //        {
            //            //check if Form exists.
            //            if([[NSFileManager defaultManager] fileExistsAtPath:[FormsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_AU.pdf",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]]]){
            //                indexPath=[NSIndexPath indexPathForRow:indexPath.row-1 inSection:indexPath.section];
            //                // [self showFormDetails:indexPath];
            //
            //                NSLog(@"pressPremHere");
            //
            //                [self showEcondfromData];
            //                //[self showFormDetails:indexPath];
            //
            //            }
            //        }
        {
            
            if ([array containsObject:proposalform12])
            {
                
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                
                NSString *documentsDirectory = [paths objectAtIndex:0];
                
                NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
                
                // NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"xml"];
                
                NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
                
                NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];
                
                
                //   [self.navigationController setNavigationBarHidden:YES animated:NO];
                
                
                _signController = [[eSignController alloc]init];
                
                _signController.delegate=self;
                _signController.cellRghtbuttonDisabled1 =@"disable";
                
                [_signController eApplicationForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
                
                // [self.navigationController.navigationBar setUserInteractionEnabled:NO];
                
                _signController.view.frame = CGRectMake(0, 20, _signController.view.frame.size.width, _signController.view.frame.size.height);
                //how o_signController.navigationController.navigationItem.rightBarButtonItem.isEnabled =FALSE;
                
                [self.navigationController.view addSubview:_signController.view];
                ;
                
                
                
                
                //  [self.navigationController setNavigationBarHidden:NO animated:YES];
                
            }
            
            
        }
        
        
        
    }
    
}
- (UIView *)createUIForPDF
{
    UIView *pdfView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    int y = 0;
    
    
    for (int i= 1 ; i<6; i++) {
        [[NSUserDefaults standardUserDefaults]setInteger:i forKey:@"pageNo"];
        NSMutableData *data;
        struct SIGNDOC_ByteArray *blob;
        blob = renderTest(self.view.frame.size.height*2);
        data = [[NSMutableData alloc] initWithBytesNoCopy:SIGNDOC_ByteArray_data(blob) length:SIGNDOC_ByteArray_count(blob)];
        UIImage *resultImage = [UIImage imageWithData:data];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"image%i.png",i]];
        
        // Save image.
        [UIImagePNGRepresentation(resultImage) writeToFile:filePath atomically:YES];
        
        
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height*2)];
        [imgView setImage:resultImage];
        [pdfView addSubview:imgView];
        y+= (self.view.frame.size.height*2) + 10;
    }
    pdfView.frame = CGRectMake(0, 0, self.view.frame.size.width, y+50);
    return pdfView;
}




-(void)showEcondfromData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *xmlPRPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"ProposalXML/%@_PR.xml",[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]]];
    
    // NSString *path = [[NSBundle mainBundle] pathForResource: @"Data" ofType: @"xml"];
    
    NSString *str = [NSString stringWithContentsOfFile:xmlPRPath encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:str];
    
    
    
    [self eApplicationForProposalNo:[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"] fromInfoDic:xmlDoc];
    
    
}
#pragma mark - Local Method
-(NSString *)eApplicationForProposalNo:(NSString *)proposalNo fromInfoDic:(NSDictionary *)infoDic
{
    if (infoDic) {
        
        ESignGenerator*  _eApplicationGenerator = [[ESignGenerator alloc]init];
        NSString *outPutFile=[_eApplicationGenerator eApplicationForProposalNo:proposalNo fromInfoDic:infoDic];
        //pdfPath = outPutFile;
        // proposalNumber = proposalNo;
        SetPDFPath(outPutFile);
        PDFViewController*_pdfViewController = [[PDFViewController alloc] initWithPath:outPutFile];
        _pdfViewController.title = proposalNo;
        //self.view.backgroundColor = [UIColor blueColor];
        
        ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
        
        _navC = [[UINavigationController alloc]initWithRootViewController:_pdfViewController];
        _navC.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
        _navC.view.frame = self.view.frame;
        _navC.view.autoresizingMask =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin;
        _navC.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
        
        _pdfViewController.view.frame=_navC.view.frame;
        _navC.navigationBar.translucent = NO;
        
        UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"e-Application Report" style:UIBarButtonItemStylePlain target:self action:@selector(cancelIt)];
        //[_pdfViewController.navigationItem setRightBarButtonItems:@[signBarButtonItem,cancelBarButtonItem]];
        
        [_pdfViewController.navigationItem setLeftBarButtonItems:@[cancelBarButtonItem]];
        
        cancelBarButtonItem.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
        
        [self.navigationController pushViewController:_pdfViewController animated:YES];
        //[self.navigationController.view addSubview:_navC.view];
        
    }
    return nil;
}
-(void)cancelIt{
    // [_navC.view removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    _navC=nil;
    // [self.view removeFromSuperview];
}

-(void)showFormDetails:(NSIndexPath *) indexPath
{
    UIStoryboard *newStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    FormViewController *form = [newStoryboard
                                instantiateViewControllerWithIdentifier:@"forms"];
    // NSString *title =  [NSString stringWithFormat:@"%@", [dataItems objectAtIndex:indexPath.row] ];
    NSString *title;
    if (indexPath.row == 0) {
        title =  @"Proposal Form";}
    //    else if (indexPath.row == 1) {
    //        title =  @"Supplementary Form";}
    else if (indexPath.row == 1) {
        title =  @"Sales Illustration";}
    else if (indexPath.row == 2) {
        title =  @"Customer Fact Find";}
    else if (indexPath.row == 3) {
        title =  @"Confirmation Of Advice Form Given To";}
    //    else if (indexPath.row == 4) {
    //        title =  @"E-Application Authorization Form";}
    
    
    
    if  ((NSNull *) [dataItems objectAtIndex:indexPath.row] == [NSNull null])
        form.fileName  = @"";
    else
        form.fileName = [dataItems objectAtIndex:indexPath.row];
    
    if  ((NSNull *) title == [NSNull null])
        title = @"";
    else
        form.fileTitle = title;
    
    
    if(![form.fileName isEqualToString:@"" ] && ![form.fileTitle isEqualToString:@""] )
        
        [self.navigationController pushViewController:form animated:YES];
    
    
}


- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}



-(void)forSIdetails{
    CashPromiseViewController *CPReportPage = [[CashPromiseViewController alloc] init ];
    
    
    CPReportPage.SINo =[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SINumber"];
    
    CPReportPage.PDSorSI = @"SI";
    
    CPReportPage.pPlanCode = [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"];//HLACP
    
    CPReportPage.lang =@"English";
    
    [CPReportPage deleteTemp];
    
    [self presentViewController:CPReportPage animated:NO completion:Nil];
    
    
    
    [CPReportPage generateJSON_HLCP:NO];
    
    [CPReportPage copyReportFolderToDoc:@"SI"];
    
    [CPReportPage dismissViewControllerAnimated:NO completion:Nil];
    
    NSString *path;
    
//    if([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"HLAWP"]) //wealth plan plan code
//    {
//        path = [[NSBundle mainBundle] pathForResource:@"SI/eng_HLAWP_Page1" ofType:@"html"];
//    }
//    else if ([[[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"] isEqualToString:@"L100"]) //Life 100 plan code
//    {
//        path = [[NSBundle mainBundle] pathForResource:@"SI/eng_L100_Page1" ofType:@"html"];
//    }
	
	NSString *tempFileName = [NSString stringWithFormat:@"SI/eng_%@_Page1", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"SIPlanName"]];
	path = [[NSBundle mainBundle] pathForResource:tempFileName ofType:@"html"];
	
    
    NSURL *pathURL = [NSURL fileURLWithPath:path];
    
    NSArray* path_forDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString* documentsDirectory = [path_forDirectory objectAtIndex:0];
    
    NSData* data = [NSData dataWithContentsOfURL:pathURL];
    
    [data writeToFile:[NSString stringWithFormat:@"%@/SI_Temp.html",documentsDirectory] atomically:YES];
    
    NSString *HTMLPath = [documentsDirectory stringByAppendingPathComponent:@"SI_Temp.html"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:HTMLPath]) {
        
        NSURL *targetURL = [NSURL fileURLWithPath:HTMLPath];
        
        NSString *SIPDFName = [NSString stringWithFormat:@"Forms/%@_SI.pdf", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"]];
        
        self.PDFCreator = [NDHTMLtoPDF exportPDFWithURL:targetURL
                                             pathForPDF:[documentsDirectory stringByAppendingPathComponent:SIPDFName]
                                               delegate:self
                                               pageSize:kPaperSizeA4
                                                margins:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        
        
    }
    NSLog(@"Generate Forms : Sales Illustration - generated!");
    
}



- (void)viewDidUnload {
    [self setTextLabel:nil];
    [super viewDidUnload];
}
@end
