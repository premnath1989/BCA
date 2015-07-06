//
//  AppDelegate.m
//  HLA
//
//  Created by Md. Nazmus Saadat on 9/26/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize indexNo;
@synthesize userRequest, MhiMessage;
@synthesize SICompleted,ExistPayor, HomeIndex, ProspectListingIndex, NewProspectIndex,NewSIIndex, SIListingIndex, ExitIndex, EverMessage;
@synthesize bpMsgPrompt, isNeedPromptSaveMsg, isSIExist, PDFpath;

@synthesize window = _window;

NSString * const NSURLIsExcludedFromBackupKey =@"NSURLIsExcludedFromBackupKey";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
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
	
    return YES;
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
