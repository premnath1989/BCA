//
//  AppDelegate.m
//  HLA
//
//  Created by Md. Nazmus Saadat on 9/26/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "AppDelegate.h"
#import "ClearData.h"
#import "DataManager.h"
#import "UpdateTableWithSIType.h"
#import "UpdateACIRGST.h"

@implementation AppDelegate
@synthesize indexNo;
@synthesize userRequest, MhiMessage;
@synthesize SICompleted,ExistPayor, HomeIndex, ProspectListingIndex, NewProspectIndex,NewSIIndex, SIListingIndex, ExitIndex, EverMessage;
@synthesize bpMsgPrompt, isNeedPromptSaveMsg, isSIExist, PDFpath,firstLAsex,planChoose,secondLAsex,bundledData,eappProposal;

@synthesize window = _window;
@synthesize eApp;
@synthesize checkList;
@synthesize ViewFromPendingBool;
@synthesize ViewFromSubmissionBool,ViewDeleteSubmissionBool, ViewFromEappBool;
NSString * const NSURLIsExcludedFromBackupKey =@"NSURLIsExcludedFromBackupKey";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    NSString *ratesPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"HLA_Rates.sqlite"]];
    
    NSLog(@"%@",databasePath);
    
    SICompleted = YES;
    ExistPayor = YES;
    
    HomeIndex = 0;
    ProspectListingIndex = 1;
    SIListingIndex = 2;
    NewSIIndex = 3;
    ExitIndex = 4;
    
	/*
    //for ios6 start, will also clear out ios5.1
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *viewerPlistFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"viewer.plist"];
    NSString *viewerPlistFromDoc = [documents stringByAppendingPathComponent:@"viewer.plist"];
    BOOL plistExist = [fileManager fileExistsAtPath:viewerPlistFromDoc];
    if (!plistExist)
        [fileManager copyItemAtPath:viewerPlistFromApp toPath:viewerPlistFromDoc error:nil];
    

    NSString *WebSQLSubdir1 = @"Caches";
    NSString *WebSQLPath1 = [library stringByAppendingPathComponent:WebSQLSubdir1];
	NSString *masterFile = [WebSQLPath1 stringByAppendingPathComponent:@"Databases.db"];
	
	//databaseName = @"0000000000000001.sqlite";//dummy
    NSString *databaseName1 = @"hladb.sqlite";//actual
	NSString *WebSQLDb1 = [WebSQLPath1 stringByAppendingPathComponent:@"file__0"];
    NSString *databaseFile = [WebSQLDb1 stringByAppendingPathComponent:databaseName1];
    
    [fileManager removeItemAtPath:databaseFile error:nil]; //remove hladb.sqlite
    [fileManager removeItemAtPath:masterFile error:nil]; //remove databases.db
    fileManager = Nil;
    //for ios6 end
    
    documents = Nil, viewerPlistFromApp = Nil, viewerPlistFromDoc = Nil;
    library = Nil, databaseName1 = Nil, WebSQLDb1 = Nil, WebSQLPath1 = Nil, WebSQLSubdir1 = Nil, masterFile = Nil;
    databaseFile = Nil;
    */
    
    
//    sleep(5);
    /*
    UIView *layer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg18.jpg"]];
    [self.window addSubview:layer];
    
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(400, 350);
    spinner.hidesWhenStopped = YES;
    [self.window addSubview:spinner];
    UILabel *spinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(350, 370, 120, 40) ];
    spinnerLabel.text  = @" Please Wait...";
    spinnerLabel.backgroundColor = [UIColor blackColor];
    spinnerLabel.opaque = YES;
    spinnerLabel.textColor = [UIColor whiteColor];
    [self.window addSubview:spinnerLabel];
    [self.window setUserInteractionEnabled:NO];
    [spinner startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        //any action here
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [spinner stopAnimating];
            spinnerLabel.text = @"";
            [self.window setUserInteractionEnabled:YES];
            
            UIView *v =  [[self.window subviews] objectAtIndex:[self.window subviews].count - 1 ];
            [v removeFromSuperview];
            v = Nil;
            
        });
    });
    
    spinner = nil; */
    
    
    [SIUtilities makeDBCopy:databasePath];
    
	[SIUtilities checkDBCountry:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentICNo" type:@"INTEGER" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentContractDate" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentAddr1" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentAddr2" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentAddr3" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentPortalLoginID" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentPortalPassword" type:@"VARCHAR" dbpath:databasePath];
    
    [SIUtilities updateTable:@"Trad_Sys_Mtn" set:@"MaxAge" value:@"63" where:@"PlanCode" equal:@"HLACP" dbpath:databasePath];
    
    [SIUtilities addColumnTable:@"Trad_Rider_Details" column:@"TempHL1KSA" type:@"DOUBLE" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Trad_Rider_Details" column:@"TempHL1KSATerm" type:@"INTEGER" dbpath:databasePath];
    
    [SIUtilities createTableCFF:databasePath];
	
	[SIUtilities createTableeApp:databasePath];

    //added by Andy for data patching on Prospect Profile : ProspectTitle and OtherIDType
	// [SIUtilities patchTableProspectProfile:databasePath];
    //Pending testing

    //added by Andy for data patching on Question Table
//    [SIUtilities patcheProposal_Question:databasePath];
    
    //added by meng cheong start
        [SIUtilities addColumnTable:@"CFF_Family_Details" column:@"RelationshipIndexNo" type:@"TEXT" dbpath:databasePath];
    //added by meng cheong end
	
	//added by heng	
    //[SIUtilities updateTable:@"Trad_Sys_Medical_Comb" set:@"Limit" value:@"400" where:@"OccpCode" equal:@"UNEMP" dbpath:databasePath];
	[SIUtilities UPDATETrad_Sys_Medical_Comb:databasePath];
	[SIUtilities updateTable:@"Trad_Sys_Basic_LSD" set:@"FromSA" value:@"600" where:@"ToSA" equal:@"1199.99" dbpath:databasePath];
	[SIUtilities addColumnTable:@"Trad_Details" column:@"SIVersion" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"Trad_Details" column:@"SIStatus" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"SI_Store_Premium" column:@"WaiverSAAnnual" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"SI_Store_Premium" column:@"WaiverSASemi" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"SI_Store_Premium" column:@"WaiverSAQuarter" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"SI_Store_Premium" column:@"WaiverSAMonth" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"UL_Rider_Details" column:@"RiderLoadingPremium" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"Trad_Rider_Details" column:@"RiderDesc" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities updateTable:@"adm_occp_loading_penta" set:@"PA_CPA" value:@"1" where:@"Occpcode" equal:@"OCC02456" dbpath:databasePath];
	[SIUtilities InstallUpdate:databasePath];
    //added by heng end
	
    [SIUtilities addColumnTable:@"prospect_profile" column:@"ProspectGroup" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"ProspectTitle" type:@"VARCHAR" dbpath:databasePath];
//    [SIUtilities addColumnTable:@"prospect_profile" column:@"IDType" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"IDTypeNo" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"OtherIDType" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"OtherIDTypeNo" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"Smoker" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"prospect_profile" column:@"AnnualIncome" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"BussinessType" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"Race" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"MaritalStatus" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"Religion" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"prospect_profile" column:@"Nationality" type:@"VARCHAR" dbpath:databasePath];
    
    //added by kky start
    [SIUtilities addColumnTable:@"prospect_profile" column:@"QQFlag" type:@"BOOL NOT NULL  DEFAULT false" dbpath:databasePath];
    //added by kky end
    
	//added quotation language column @edwin 4-9-2013
    [SIUtilities addColumnTable:@"Trad_Details" column:@"QuotationLang" type:@"VARCHAR" dbpath:databasePath];
    //added by Edwin 02-01-2014
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentAddrPostcode" type:@"VARCHAR" dbpath:databasePath];
	[SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentContactNumber" type:@"VARCHAR" dbpath:databasePath];
    
    //added by Edwin 24-01-2014, to merge user_profile with agent_profile
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentPassword" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"AgentStatus" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"FirstLogin" type:@"INTEGER" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"LastLogonDate" type:@"DATETIME" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"LastLogoutDate" type:@"DATETIME" dbpath:databasePath];
    [SIUtilities addColumnTable:@"Agent_Profile" column:@"Channel" type:@"VARCHAR" dbpath:databasePath];
    [SIUtilities migrateIntoAgentProfile:databasePath];

    //Added for Trad 7.1 requirements by Edwin @ 19-12-2013
    [SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"RiderCode" value:@"TPDYLA" where:@"RiderCode" equal:@"ETPD" dbpath:databasePath];
    [SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"MaxAge" value:@"63" where:@"RiderCode" equal:@"TPDYLA" dbpath:databasePath];
    [SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"MinTerm" value:@"2" where:@"RiderCode" equal:@"TPDYLA" dbpath:databasePath];
	[SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"ExpiryAge" value:@"65" where:@"RiderCode" equal:@"TPDYLA" dbpath:databasePath];
    [SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"MinSA" value:@"5000" where:@"RiderCode" equal:@"TPDYLA" dbpath:databasePath];
    [SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"MinAge" value:@"0" where:@"RiderCode" equal:@"TPDYLA" dbpath:databasePath];//modified to 0 age as per 7.1 requirement, Edwin 04-03-2014
    [SIUtilities updateTable:@"Trad_Sys_Rider_Profile" set:@"RiderCode" value:@"TPDYLA" where:@"RiderCode" equal:@"ETPD" dbpath:databasePath];
    [SIUtilities updateTable:@"Trad_Sys_Rider_Profile" set:@"RiderDesc" value:@"TPD Yearly Living Allowance Rider" where:@"RiderCode" equal:@"TPDYLA" dbpath:databasePath];
    [SIUtilities updateTable:@"Trad_Sys_RiderComb" set:@"RiderCode" value:@"TPDYLA" where:@"RiderCode" equal:@"ETPD" dbpath:databasePath];
    
    [SIUtilities updateTable:@"Trad_Sys_Rider_Label" set:@"RiderCode" value:@"TPDYLA" where:@"RiderCode" equal:@"ETPD" dbpath:databasePath];
    [SIUtilities updateTable:@"Trad_Sys_Rider_Label" set:@"RiderName" value:@"TPD Yearly Living Allowance Rider" where:@"RiderName" equal:@"Extended TPD Rider" dbpath:databasePath];
    
    //Added for Life 100 by Edwin @ 22-01-2013
//    [SIUtilities InstallLife100:databasePath];

    //changed to 0.25 max factor for TPDYLA; Edwin @ 06-03-2014 
    [SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"MaxSAFactor" value:@"0.25" where:@"RiderCode" equal:@"TPDYLA" dbpath:databasePath];
    
    [SIUtilities upgradeRatesDB:ratesPath]; //remove @ 20140923
    
    //added @ 20-03-2014 Edwin
    [SIUtilities modTradSysOtherValue:databasePath];
    
    //01-04-2014 @ Edwin : update if LCPR is 1,000,000, to 1,500,000
    [SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"MaxSA" value:@"1500000.0" where:@"RiderCode" equal:@"LCPR" dbpath:databasePath];
    
    //Added for HLA Wealth Plan by Edwin @ 22-01-2013
//    [SIUtilities InstallWP:databasePath];

    //19-06-2014 @ Andy : update if Credit Card Types Master Card
    [SIUtilities updateTable:@"eProposal_Credit_Card_Types" set:@"CreditCardCode" value:@"HLA VISA" where:@"CreditCardDesc" equal:@"HLA VISA CARD" dbpath:databasePath];
    [SIUtilities updateTable:@"eProposal_Credit_Card_Types" set:@"CreditCardCode" value:@"HLB MASTER" where:@"CreditCardDesc" equal:@"HLB MASTER CARD" dbpath:databasePath];
    [SIUtilities updateTable:@"eProposal_Credit_Card_Types" set:@"CreditCardCode" value:@"HLB VISA" where:@"CreditCardDesc" equal:@"HLB VISA CARD" dbpath:databasePath];
    [SIUtilities updateTable:@"eProposal_Credit_Card_Types" set:@"CreditCardCode" value:@"MASTER" where:@"CreditCardDesc" equal:@"MASTER CARD - OTHERS" dbpath:databasePath];
    [SIUtilities updateTable:@"eProposal_Credit_Card_Types" set:@"CreditCardCode" value:@"VISA" where:@"CreditCardDesc" equal:@"VISA CARD - OTHERS" dbpath:databasePath];
    
    // remove HSP II from RiderComb
    NSString *query = @"DELETE FROM Trad_Sys_RiderComb WHERE RiderCode='HSP_II'";
    [SIUtilities runQuery:databasePath withQuery:query];

    query = @"UPDATE Trad_Sys_Rider_Mtn SET GST='1' WHERE  RiderCode='HB'";
    [SIUtilities runQuery:databasePath withQuery:query];
//    [SIUtilities updateTable:@"Trad_Sys_Rider_Mtn" set:@"GST" value:@"True" where:@"RiderCode" equal:@"HB" dbpath:databasePath];
        
    // update Trad_Sys_Profile table with new SIType column
    [UpdateTableWithSIType addSITypeColumn:databasePath];
    [UpdateACIRGST updateACIRMPPGST:databasePath];
    
	ClearData *CleanData =[[ClearData alloc]init];
	[CleanData ClientWipeOff];
	
    return YES;
}

-(BOOL) application:(UIApplication *) application handleOpenURL:(NSURL *) url
{
    NSLog(@"Launched by sender ... ?");
    NSString *text = [[url host] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"received %@",text);
   
    self.bundleData = text;

    [self checkAgentStatus];
    return YES;
}

- (void)presentTerminatedView {
    UIViewController *topController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    if (! [[topController restorationIdentifier] isEqualToString:@"AppDataWipe"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AppDataWipeStoryboard" bundle:nil];
        UIViewController *dataWipedViewController = [storyboard instantiateViewControllerWithIdentifier:@"AppDataWipe"];
        
        [topController presentViewController:dataWipedViewController animated:YES completion:NULL];
    }
}

- (void)checkAgentStatus {
    NSArray *queryTokens = [self.bundleData componentsSeparatedByString:@"&"];

    if (queryTokens.count != 1) {
        return;
    }

    for(NSString *keyValueString in queryTokens) {
        NSArray *keyValueArray = [keyValueString componentsSeparatedByString:@"="];

        if ([[keyValueArray objectAtIndex:0] isEqualToString:@"AgentState"] && [[keyValueArray objectAtIndex:1] isEqualToString:@"T"]) {
            [DataManager wipeAppData];

            [self presentTerminatedView];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"Terminated"]) {
        [self presentTerminatedView];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
