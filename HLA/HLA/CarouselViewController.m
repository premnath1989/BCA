//
//  CarouselViewController.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/10/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CarouselViewController.h"
#import "SIListing.h"
#import "ProspectListing.h"
#import "setting.h"
#import "MainScreen.h"
#import "Login.h"
#import "NewLAViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "eBrochureViewController.h"
#import "eBrochureListingViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "eSubmission.h"
#import "CustomerProfile.h"
#import "SettingUserProfile.h"
#import "SIUtilities.h"
#import "MainClient.h"
#import "MainCustomer.h"
#import "MaineApp.h"
#import <AdSupport/ASIdentifierManager.h>
#import "ClearData.h"
#import "CalculatorViewController.h"

const int numberOfModule = 7;

@interface CarouselViewController ()<UIActionSheetDelegate>{
    
}

@end

@implementation CarouselViewController
@synthesize outletCarousel, elementName, previousElementName, getInternet, getValid, indexNo, ErrorMsg,outletNavBar, outletBrochure, outletSetting, outletClientProfile, outletCustomerFF, outletEAPP,outletSI;
@synthesize outletExit, outletIconBG;
@synthesize delegate = _delegate;


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
	
	Login *mainLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
	mainLogin.modalPresentationStyle = UIModalPresentationFullScreen;
	mainLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	//            [self presentModalViewController:mainLogin animated:YES];
	[self presentViewController:mainLogin animated:YES completion:nil];
	
	NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath2 = [paths2 objectAtIndex:0];
    NSString *path2 = [docsPath2 stringByAppendingPathComponent:@"hladb.sqlite"];
	
	UILabel *UDID=[[UILabel alloc]initWithFrame:CGRectMake(690, 690, 320,50)];
	UDID.backgroundColor =[UIColor clearColor];
	UDID.textAlignment = UITextAlignmentCenter;
//    UDID.textColor = [CustomColor colorWithHexString:@"FFFFFF"];
//    UDID.backgroundColor =[CustomColor colorWithHexString:@"4F81BD"];
    UDID.font=[UIFont boldSystemFontOfSize:15];
    UDID.text=[[[UIDevice currentDevice] identifierForVendor] UUIDString];//[NSString stringWithFormat:@"Time Remaining"];
    [self.view addSubview:UDID];

    
    //[self copyRatesJSONFromPath:docsPath2];
	
	NSString *AgentName1;

	FMDatabase *database = [FMDatabase databaseWithPath:path2];
    [database open];
    FMResultSet *results;
    NSString *query;
    int totalRecords = 0;
    
    results = [database executeQuery:@"select AgentCode,AgentName from Agent_profile"];
    NSString *agentCode;
    NSString *agentName;
    while([results next]) {
       // agentCode = [results stringForColumn:@"AgentCode"];
        AgentName1  = [results stringForColumn:@"AgentName"];
    }
	
	_AgentName.text = AgentName1;

	
//    outletCarousel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BcaBackgroundFade.jpg"]];
//    self.view.backgroundColor = [UIColor clearColor];
//    _myView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"BcaBackgroundFade.jpg"]];
//    self.view.backgroundColor = [UIColor clearColor];
    
    [outletNavBar setBackgroundImage:[UIImage imageNamed:@"NewHLAHeader.png"] forBarMetrics:UIBarMetricsDefault];
    outletBrochure.hidden = TRUE;
    outletSetting.hidden = TRUE;
    
    outletNavBar.topItem.rightBarButtonItem = nil; // to hide exit button
    
    outletIconBG.hidden = TRUE;
    
    
    UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitBtn addTarget:self action:@selector(goToHome:) forControlEvents:UIControlEventTouchUpInside];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"house.png"] forState:UIControlStateNormal];
    exitBtn.frame = CGRectMake(980.1, 16.1, 27.0, 29.0);
	
	UIButton *protestion = [UIButton buttonWithType:UIButtonTypeCustom];
    [protestion addTarget:self action:@selector(ProtectionCalculator) forControlEvents:UIControlEventTouchUpInside];
    [protestion setBackgroundImage:[UIImage imageNamed:@"protection_Calculator_findv3.png"] forState:UIControlStateNormal];
    protestion.frame = CGRectMake(275.1, 356.1, 130.0, 155.0);
	
//	UILabel  * labelbg1 = [[UILabel alloc] initWithFrame:CGRectMake(270, 350, 900, 160)];
//    labelbg1.backgroundColor = [UIColor grayColor];
//    // label1.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
//    labelbg1.alpha =0.4;
//    labelbg1.numberOfLines=0;
//	//    labelbg.lineBreakMode=UILineBreakModeWordWrap;
//    labelbg1.lineBreakMode=NSLineBreakByWordWrapping;
//    [self.view addSubview:labelbg1];
    
    NSString *version= [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *build= [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    UILabel  * label = [[UILabel alloc] initWithFrame:CGRectMake(3, 670, 600, 50)];
    label.backgroundColor = [UIColor clearColor];
   // label.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
    label.textColor=[UIColor blackColor];
    label.numberOfLines=0;
//    label.lineBreakMode=UILineBreakModeWordWrap;
    label.lineBreakMode=NSLineBreakByWordWrapping;
	
	NSDate *todayDate = [NSDate date];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	
	NSString *LoginDate = [dateFormatter stringFromDate:[NSDate date]];
	
    label.text =[NSString stringWithFormat:@"Last Login : %@", LoginDate];
    [self.view addSubview:label];
	
	
    
    UILabel  * labelbg = [[UILabel alloc] initWithFrame:CGRectMake(0, 670, 300, 100)];
    labelbg.backgroundColor = [UIColor grayColor];
    // label1.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
    labelbg.alpha =0.3;
    labelbg.numberOfLines=0;
//    labelbg.lineBreakMode=UILineBreakModeWordWrap;
    labelbg.lineBreakMode=NSLineBreakByWordWrapping;
    [self.view addSubview:labelbg];

    
//    NSString *id = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    UILabel  * label1 = [[UILabel alloc] initWithFrame:CGRectMake(3, 700, 600, 50)];
    label1.backgroundColor = [UIColor clearColor];
   // label1.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
    label1.textColor=[UIColor blackColor];
    label1.numberOfLines=0;
//    label1.lineBreakMode=UILineBreakModeWordWrap;
    label1.lineBreakMode=NSLineBreakByWordWrapping;
	
	NSDate *fiveDaysAgo = [todayDate dateByAddingTimeInterval:-5*24*60*60];
	NSString *calDate = [dateFormatter stringFromDate:fiveDaysAgo];
	
    label1.text =[NSString stringWithFormat:@"Last Authenticate : %@", calDate];
    [self.view addSubview:label1];
    
    UILabel  * label2 = [[UILabel alloc] initWithFrame:CGRectMake(3, 640, 600, 50)];
    label2.backgroundColor = [UIColor clearColor];
    // label1.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
    label2.textColor=[UIColor blackColor];
    label2.numberOfLines=0;
//    label2.lineBreakMode=UILineBreakModeWordWrap;
    label2.lineBreakMode=NSLineBreakByWordWrapping;
    
    NSString *string =[SIUtilities WSLogin];
    
    if ([string rangeOfString:@"echannel.dev"].location == NSNotFound)
    {
        NSLog(@"string does not contain echannel");
        label2.text =[NSString stringWithFormat:@"App type : Production"];
    } else {
        NSLog(@"string contains echannel");
        label2.text =[NSString stringWithFormat:@"App type : Development"];
    }
    
    NSLog(@"What app is this %@" ,[SIUtilities WSLogin]);    
    
    [self.view addSubview:exitBtn];
	[self.view addSubview:protestion];
    
    int width = 128;
    int height = 160;
    int positionY = 310;
    
    [outletClientProfile setFrame:CGRectMake(420, positionY, width, height)];
    [outletCustomerFF setFrame:CGRectMake(565, positionY, width, height)];
    [outletSI setFrame:CGRectMake(715, positionY, width, height)];
    [outletEAPP setFrame:CGRectMake(860, 300, width, 160)]; // EAPP words consist of one line only
    [outletSetting setFrame:CGRectMake(800, 500, 200, 200)]; //  for testing only, to be remove for actual version
    
	
	ClearData *CleanData =[[ClearData alloc]init];
	[CleanData ClientWipeOff];
    
}

- (void)goToHome:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    NSString *URLEncodedText = [self encodeToPercentEscapeString:@"hlafast"];
    NSString *ourPath = [@"com.hla.fast://" stringByAppendingString:URLEncodedText];
    
    NSLog(@"path = %@" , ourPath);
    NSURL *ourURL = [NSURL URLWithString:ourPath];
    
    if ([app canOpenURL:ourURL])
    {
        [app openURL:ourURL];
    }else
    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"HLA FAST" message:@"HLA FAST is not installed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];        
//        [alertView show];
		
		Login *mainLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
		mainLogin.modalPresentationStyle = UIModalPresentationFullScreen;
		mainLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		//            [self presentModalViewController:mainLogin animated:YES];
		[self presentViewController:mainLogin animated:YES completion:nil];
    }
    
}

-(void)ProtectionCalculator
{
//	Login *mainLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Logout"];
//	mainLogin.modalPresentationStyle = UIModalPresentationFullScreen;
//	mainLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//	//            [self presentModalViewController:mainLogin animated:YES];
//	[self presentViewController:mainLogin animated:YES completion:nil];
	
	
	CalculatorViewController *controller = [[CalculatorViewController alloc]
										 initWithNibName:@"CalculatorViewController"
										 bundle:nil];
	//controller.delegate = self;
	//controller.modalPresentationStyle = UIModalPresentationPageSheet;
	[self presentViewController:controller animated:YES completion:Nil];

}

-(NSString*) encodeToPercentEscapeString:(NSString *)string
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef) string,
                                                                                 NULL,
                                                                                 (CFStringRef) @"!*'();:@&+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
}

-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *appDele= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    NSLog(@"appDele.bundleData %@",appDele.bundleData);

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (! [defaults boolForKey:@"Terminated"]) {
        if([appDele.bundleData length] == 0) {
 //           [self showDialogAppLaunchWithHLAFast];
        } else {
            [self parseURL:appDele.bundleData];
        }
    }
}

-(void)parseURL:(NSString *) urlStr
{
    NSMutableDictionary *queryStringDict = [ [NSMutableDictionary alloc] init];
    NSArray *urlArr = [urlStr componentsSeparatedByString:@"&"];
    
    if (urlArr.count < 1) {
        return;//should not reach here
    }
    
    NSLog(@"parseURL: %@", urlStr);
    
    for(NSString *keyPair in urlArr)
    {
        NSArray *pairedComp = [keyPair componentsSeparatedByString:@"="];
        NSString *key = [pairedComp objectAtIndex:0];
        NSString *value = [pairedComp objectAtIndex:1];
        
        [queryStringDict setObject:value forKey:key];
    }
    
    NSString* agentCode = [queryStringDict objectForKey:@"agentCode"];
    NSString* agentName = [queryStringDict objectForKey:@"agentName"];
    NSString* agentType = [queryStringDict objectForKey:@"agentType"];
    NSString* immediateLeaderCode = [queryStringDict objectForKey:@"immediateLeaderCode"];
    NSString* immediateLeaderName = [queryStringDict objectForKey:@"immediateLeaderName"];
    NSString* BusinessRegNumber = [queryStringDict objectForKey:@"BusinessRegNumber"];
    NSString* agentEmail = [queryStringDict objectForKey:@"agentEmail"];
    NSString* agentLoginId = [queryStringDict objectForKey:@"agentLoginId"];
    NSString* agentIcNo = [queryStringDict objectForKey:@"agentIcNo"];
    NSString* agentContractDate = [queryStringDict objectForKey:@"agentContractDate"];
    NSString* agentAddr1 = [queryStringDict objectForKey:@"agentAddr1"];
    NSString* agentAddr2 = [queryStringDict objectForKey:@"agentAddr2"];
    NSString* agentAddr3 = [queryStringDict objectForKey:@"agentAddr3"];
    NSString* agentAddrPostcode = [queryStringDict objectForKey:@"agentAddrPostcode"];
    NSString* agentContactNumber = [queryStringDict objectForKey:@"agentContactNumber"];
    NSString* agentPassword = [queryStringDict objectForKey:@"agentPassword"];
    //NSString* lastLogonDate = [queryStringDict objectForKey:@"lastLogonDate"];
    //NSString* lastLogoutDate = [queryStringDict objectForKey:@"lastLogoutDate"];
    NSString* agentStatus = [queryStringDict objectForKey:@"agentStatus"];
    NSString* channel = [queryStringDict objectForKey:@"channel"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:agentCode forKey:KEY_AGENT_CODE];
    [defaults synchronize];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        BOOL newRec = FALSE;
        
        querySQL = [NSString stringWithFormat:
                    @"select agentCode FROM agent_profile where agentCode = '%@' ", agentCode ];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_ROW){
                newRec = FALSE;
            }
            else{
                newRec = TRUE;
            }
            sqlite3_finalize(statement);
        }
        
        if (newRec == FALSE) {
            querySQL = [NSString stringWithFormat: @"Delete FROM agent_profile "];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
                if (sqlite3_step(statement) == SQLITE_DONE){
                }                
                sqlite3_finalize(statement);
            }            
        }
        
        querySQL = [NSString stringWithFormat:
                    @"insert into Agent_profile (agentCode, AgentName, AgentType, AgentContactNo, ImmediateLeaderCode, ImmediateLeaderName, BusinessRegNumber, AgentEmail, AgentLoginID, AgentICNo, "
                    "AgentContractDate, AgentAddr1, AgentAddr2, AgentAddr3, AgentAddr4, AgentPortalLoginID, AgentPortalPassword, AgentContactNumber, AgentPassword, AgentStatus, Channel, AgentAddrPostcode, agentNRIC ) VALUES "
                    "('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@', '%@', '%@') ",
                    agentCode, agentName, agentType, agentContactNumber, immediateLeaderCode, immediateLeaderName,BusinessRegNumber, agentEmail, agentLoginId, agentIcNo, agentContractDate, agentAddr1, agentAddr2, agentAddr3, @"", agentLoginId, agentPassword, agentContactNumber, agentPassword, agentStatus, channel, agentAddrPostcode, agentIcNo ];
                
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_DONE){
                
            }
            else{
                NSLog(@"%@",[[NSString alloc] initWithUTF8String:sqlite3_errmsg(contactDB)]) ;
            }
            sqlite3_finalize(statement);
        }
        else{
            NSLog(@"%@",[[NSString alloc] initWithUTF8String:sqlite3_errmsg(contactDB)]) ;
        }
        
        sqlite3_close(contactDB);
        querySQL = Nil;
        
    }
    
}


-(void) showDialogAppLaunchWithHLAFast
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                    message:@"You need to launch this app via HLA FAST." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
    alert.tag = 1001;
    [alert show];
    alert = Nil;
}


- (void)ActionExit:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@" ",nil)
                          message: NSLocalizedString(@"Are you sure you want to exit?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    
	alert.tag = 0;
    [alert show ];
    alert = Nil;
}



#pragma mark - XML parser
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict  {
    
	self.previousElementName = self.elementName;
	
    if (qName) {
        self.elementName = qName;
    }
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!self.elementName){
        return;
    }
	
	if([self.elementName isEqualToString:@"string"]){
		
		NSString *strURL = [NSString stringWithFormat:@"%@",  string];
		NSLog(@"%@", strURL);
		NSURL *url = [NSURL URLWithString:strURL];
		NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
        
		AFXMLRequestOperation *operation =
		[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
															success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
																
																XMLParser.delegate = self;
																[XMLParser setShouldProcessNamespaces:YES];
																[XMLParser parse];
																
															} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
																NSLog(@"error in calling web service");
															}];
		
		[operation start];
	}
	else if ([self.elementName isEqualToString:@"SITradVersion"]){
		NSString * AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
		NSLog(@"latest version is available %@", AppsVersion);
		if (![string isEqualToString:AppsVersion]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:[NSString stringWithFormat:@"Latest version is available for download. Do you want to download now ?"]
                                                           delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
			alert.tag = 2;
			[alert show];			
			alert = Nil;
		}
	}
	else if ([self.elementName isEqualToString:@"DLURL"]){
		NSLog(@"%@", string);
	}
	else if ([self.elementName isEqualToString:@"DLFilename"]){
		NSLog(@"%@", string);
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	self.elementName = nil;
}


-(void) parserDidEndDocument:(NSXMLParser *)parser {	
}

#pragma mark - other
- (void)viewDidUnload
{
    [self setOutletCarousel:nil];
    [self setDoClientProfile:nil];
    [self setDoSI:nil];
    [self setDoSettings:nil];
    [self setDoEApp:nil];
    [self setDoeCFF:nil];
    [self setDoBrochure:nil];
    [self setDoSIBtn:nil];
    [self setMyView:nil];
    [self setSelectSI:nil];
    [self setCPBtn:nil];
    [self setOutletNavBar:nil];
    [self setOutletSetting:nil];
    [self setOutletBrochure:nil];
    [self setOutletClientProfile:nil];
    [self setOutletCustomerFF:nil];
    [self setOutletSI:nil];
    [self setOutletEAPP:nil];
    [self setOutletExit:nil];
    [self setOutletIconBG:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
    
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return numberOfModule;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 450.0f, 400.0f);
    
    if (index % numberOfModule == 1) {
        [button setBackgroundImage:[UIImage imageNamed:@"20130108Settings.png"] forState:UIControlStateNormal];
		button.tag = 1;
    }
    else if (index % numberOfModule == 0) {
        [button setBackgroundImage:[UIImage imageNamed:@"homeScreenBrochure2.png"] forState:UIControlStateNormal];
        button.tag = 0;
    }
    else if (index % numberOfModule == 2) {
        [button setBackgroundImage:[UIImage imageNamed:@"20130108eBrochure.png" ] forState:UIControlStateNormal];
        button.tag = 2;
    }
    else if (index % numberOfModule == 3) {
        [button setBackgroundImage:[UIImage imageNamed:@"20130108SalesIllustration.png" ] forState:UIControlStateNormal];
        button.tag = 3;
    }
    
    else if (index % numberOfModule == 4) { //e-sub
        
        [button setBackgroundImage:[UIImage imageNamed:@"homeScreenEApp.png" ] forState:UIControlStateNormal];
        button.tag = 4;
    }
    
    else if (index % numberOfModule == 5) { //customer profile
        
        [button setBackgroundImage:[UIImage imageNamed:@"homeScreenCFF.png" ] forState:UIControlStateNormal];
        button.tag = 5;
    }
    else if (index % numberOfModule == 6) { //Ever Series
		
		[button setBackgroundImage:[UIImage imageNamed:@"bg8.jpg" ] forState:UIControlStateNormal];
		button.tag = 6;
	}
    
    button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	
    return button;
    
}

- (void)buttonTapped:(UIButton *)sender
{
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	
    if (sender.tag % numberOfModule == 1) { //setting
        setting *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Setting"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz = Nil;
		NSLog(@"setting");
		[self.outletCarousel reloadData ];
    }    
    else if (sender.tag % numberOfModule == 0) { //prospect
        MainClient *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainClient"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = MenuOption.ProspectListingIndex;
		[self presentViewController:zzz animated:NO completion:Nil];
		zzz= Nil;
    }    
    else if (sender.tag % numberOfModule == 2) {    //ebrochure
        eBrochureListingViewController *BrochureListing = [self.storyboard instantiateViewControllerWithIdentifier:@"eBrochureListing"];
        BrochureListing.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:BrochureListing animated:NO completion:Nil];
        BrochureListing = Nil;
        NSLog(@"brochure");
    }    
    else if (sender.tag % numberOfModule == 3) {    //si listing        
        MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
		zzz.tradOrEver = @"TRAD";
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = MenuOption.SIListingIndex;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz= Nil;
        NSLog(@"si listing");
    }    
    else if (sender.tag % numberOfModule == 4) {    //e-app
        
        UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
        MaineApp *zzz= [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = 1;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz = Nil;
        secondStoryboard = Nil;
		NSLog(@"e-sub!");
    }
    
    else if (sender.tag % numberOfModule == 5) {    //cff
        
        //        CustomerProfile *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"customerProfile"];
        MainCustomer *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainCFF"];
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = 1;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz = Nil;
        NSLog(@"cff!");
    }
	else if (sender.tag % numberOfModule == 6) {    //Ever Series
		
        MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
        zzz.tradOrEver = @"EVER";
        zzz.modalPresentationStyle = UIModalPresentationFullScreen;
        zzz.IndexTab = MenuOption.SIListingIndex;
        [self presentViewController:zzz animated:NO completion:Nil];
        zzz= Nil;
        
	}
    
    outletCarousel = Nil;
    MenuOption = Nil;
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
        //checking
        UIApplication *ourApplication = [UIApplication sharedApplication];
        NSString *textBox = @"hlafast";
        NSString *URLEncodedText = [textBox stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *ourPath = [@"com.hla.fast://" stringByAppendingString:URLEncodedText];
        NSURL *ourURL = [NSURL URLWithString:ourPath];
        if ([ourApplication canOpenURL:ourURL]) {
            [ourApplication openURL:ourURL];
        }
        else {
            //Display error
            UIAlertView *quitAlertView = [[UIAlertView alloc] initWithTitle:@"HLA FAST Not Found" message:@"The HLA FAST App is not installed. It must be installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            quitAlertView.tag = 1002;
            [quitAlertView show];
        }
        
        exit(0);
        
    }
    else{
        if (buttonIndex == 0 && alertView.tag == 0 ) {
            [self updateDateLogout];
            
            Login *mainLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            mainLogin.modalPresentationStyle = UIModalPresentationFullScreen;
            mainLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            [self presentModalViewController:mainLogin animated:YES];
            [self presentViewController:mainLogin animated:YES completion:nil];
        }
        else if (buttonIndex == 0 && alertView.tag == 1){
            
            SettingUserProfile * UserProfileView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingUserProfile"];
            UserProfileView.modalPresentationStyle = UIModalPresentationPageSheet;
            UserProfileView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            UserProfileView.indexNo = self.indexNo;
            UserProfileView.getLatest = @"Yes";
//            [self presentModalViewController:UserProfileView animated:YES];
            [self presentViewController:UserProfileView animated:YES completion:nil];
            
            UserProfileView.view.superview.frame = CGRectMake(150, 50, 700, 748);
            UserProfileView = nil;
            
        }
        else if (buttonIndex == 0 && alertView.tag == 2){
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
                                                        @"http://www.hla.com.my/agencyportal/includes/DLrotate2.asp?file=iMP/iMP.plist"]];
        }
        else if (alertView.tag == 3){
            AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
            MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
            if (buttonIndex == 0) {
                zzz.tradOrEver = @"TRAD";
                zzz.modalPresentationStyle = UIModalPresentationFullScreen;
                zzz.IndexTab = MenuOption.SIListingIndex;
                [self presentViewController:zzz animated:NO completion:Nil];
                zzz= Nil;
                NSLog(@"si listing Trad");
                MenuOption = nil;
            }
            else{
                zzz.tradOrEver = @"EVER";
                zzz.modalPresentationStyle = UIModalPresentationFullScreen;
                zzz.IndexTab = MenuOption.SIListingIndex;
                [self presentViewController:zzz animated:NO completion:Nil];
                zzz= Nil;
                NSLog(@"si listing Ever");
                MenuOption = nil;
            }
            
        }
    }
}

-(void)updateDateLogout
{
    NSString *databasePath;
//    sqlite3 *contactDB;
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_Profile SET LastLogoutDate= \"%@\" WHERE IndexNo=\"%d\"",dateString, 1];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"date update!");
                
            } else {
                NSLog(@"date update Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
        query_stmt = Nil;
        querySQL = Nil;
    }
    
    databasePath = Nil, dbpath = Nil, statement = Nil;
    dirPaths = Nil, docsDir = Nil, dateFormatter = Nil, dateString = Nil;    
    
}

- (IBAction)ButtonInfo:(id)sender
{
	SettingUserProfile * UserProfileView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingUserProfile"];
	UserProfileView.modalPresentationStyle = UIModalPresentationPageSheet;
	UserProfileView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	UserProfileView.indexNo = self.indexNo;
	UserProfileView.getLatest = @"Yes";
	//            [self presentModalViewController:UserProfileView animated:YES];
	[self presentViewController:UserProfileView animated:YES completion:nil];
	
	UserProfileView.view.superview.frame = CGRectMake(150, 50, 700, 748);
	UserProfileView = nil;


	
}

- (IBAction)btnExit:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle: NSLocalizedString(@" ",nil)
                          message: NSLocalizedString(@"Are you sure you want to exit?",nil)
                          delegate: self
                          cancelButtonTitle: NSLocalizedString(@"Yes",nil)
                          otherButtonTitles: NSLocalizedString(@"No",nil), nil];
    
	alert.tag = 0;
    [alert show ];
    alert = Nil;
}

-(void) goToHome
{
    
    UIApplication *app = [UIApplication sharedApplication];
    NSString *URLEncodedText = @"";
    NSString *ourPath = [@"com.hla.pitstop://" stringByAppendingString:URLEncodedText];
    
    NSLog(@"path = %@" , ourPath);
    NSURL *ourURL = [NSURL URLWithString:ourPath];
    
    if ([app canOpenURL:ourURL])
    {
        [app openURL:ourURL];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@" " message:@"HLA Fast is not installed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];        
        [alertView show];
    }
}


- (IBAction)doClientProfileBtn:(id)sender {
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainClient *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainClient"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = MenuOption.ProspectListingIndex;
    [self presentViewController:zzz animated:NO completion:Nil];
    MenuOption = Nil;
    zzz= Nil;
}

- (IBAction)doSalesIllustrationBtn:(id)sender {
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainScreen *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
    zzz.tradOrEver = @"TRAD";
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = MenuOption.SIListingIndex;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz= Nil;
    NSLog(@"si listing");
    MenuOption = nil;
}

- (IBAction)doSettingsBtn:(id)sender {
    setting *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Setting"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    NSLog(@"setting");
    [self.outletCarousel reloadData ];
}

- (IBAction)doeCFFBtn:(id)sender {
    MainCustomer *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainCFF"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    NSLog(@"cff!");
}

- (IBAction)doeAppBtn:(id)sender {
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    MaineApp *zzz= [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    secondStoryboard = Nil;
    NSLog(@"e-sub!");
}

- (IBAction)doBrochureBtn:(id)sender {
    eBrochureListingViewController *BrochureListing = [self.storyboard instantiateViewControllerWithIdentifier:@"eBrochureListing"];
    BrochureListing.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:BrochureListing animated:NO completion:Nil];
    BrochureListing = Nil;
    NSLog(@"brochure");
}
- (IBAction)selectClientProfile:(id)sender {
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MainClient *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainClient"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = MenuOption.ProspectListingIndex;
    [self presentViewController:zzz animated:NO completion:Nil];
    MenuOption = Nil;
    zzz= Nil;
}
- (IBAction)selectSalesIllustration:(id)sender {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please Select which module you want" delegate:self cancelButtonTitle:@"Traditional" otherButtonTitles:@"Ever Series", nil];
	alert.tag = 3;
	[alert show];    
}

- (IBAction)selectBrochure:(id)sender {
    eBrochureListingViewController *BrochureListing = [self.storyboard instantiateViewControllerWithIdentifier:@"eBrochureListing"];
    BrochureListing.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:BrochureListing animated:NO completion:Nil];
    BrochureListing = Nil;
    NSLog(@"brochure");
}

- (IBAction)selectCFF:(id)sender {
    MainCustomer *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"mainCFF"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    NSLog(@"cff!");
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    MenuOption.eApp=NO;
}

- (IBAction)selectEApp:(id)sender {
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"NewStoryboard" bundle:Nil];
    MaineApp *zzz= [secondStoryboard instantiateViewControllerWithIdentifier:@"maineApp"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    zzz.IndexTab = 1;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    secondStoryboard = Nil;
    NSLog(@"e-sub!");
    AppDelegate *MenuOption= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
     MenuOption.eApp=YES;
}

- (IBAction)selectSettings:(id)sender {
    setting *zzz= [self.storyboard instantiateViewControllerWithIdentifier:@"Setting"];
    zzz.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:zzz animated:NO completion:Nil];
    zzz = Nil;
    NSLog(@"setting");
}
@end
