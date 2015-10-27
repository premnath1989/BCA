//
//  Login.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "Login.h"
#import "MainScreen.h"
#import "setting.h"
#import "ForgotPwd.h"
#import "FirstTimeViewController.h"
#import "AppDelegate.h"
#import "CarouselViewController.h"
#import "SecurityQuestion.h"
#import "ViewController.h"
#import "Reachability.h"
#import "AFJSONRequestOperation.h"
#import "AFNetworking.h"
#import "SettingUserProfile.h"
#import "SIUtilities.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "AgentPortalLogin.h"
#import "AgentProfile.h"
#import "StoreVarFirstTimeReg.h"
#import "ColorHexCode.h"
#import "MBProgressHUD.h"
#import <AdSupport/ASIdentifierManager.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface Login ()

@end
NSString *ProceedStatus = @"";

@implementation Login
@synthesize outletReset;
@synthesize scrollViewLogin;
@synthesize txtUsername;
@synthesize txtPassword;
@synthesize lblForgotPwd;
@synthesize statusLogin,indexNo,agentID;
@synthesize labelUpdated,labelVersion,outletLogin,agentPortalLoginID,agentPortalPassword;
@synthesize delegate = _delegate;
@synthesize previousElementName, agentCode;
@synthesize elementName, msg, lblLastLogin, lblTimeRemaining;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"HLA_Rates.sqlite"]];
	UL_RatesDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"UL_Rates.sqlite"]];
	CommDatabasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"Rates.json"]];
    [self makeDBCopy];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPassword:)];
    tapGesture.numberOfTapsRequired = 1;
    [lblForgotPwd addGestureRecognizer:tapGesture];
	
	
	NSString *deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
	
	NSLog(@"devideId %@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]);
	[self ShowLoginDate];
	
	//txtPassword.text = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
	//txtPassword.enabled = FALSE;
	//txtPassword.textColor = [UIColor grayColor];

    
    //[self isFirstTimeLogin];
	
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"HLA Ipad-Info"  ofType:@"plist"];
    //NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    
    //outletReset.hidden = YES;
    
	// NSString *version = [NSString stringWithFormat:
	//                    @"Version %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
	
	/*
	 sqlite3_stmt *statement;
	 int intStatus = 0;
	 
	 if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
	 {
	 NSString *querySQL = [NSString stringWithFormat: @"SELECT AgentStatus FROM User_Profile WHERE AgentLoginID=\"hla\" "];
	 
	 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
	 if (sqlite3_step(statement) == SQLITE_ROW){
	 intStatus = sqlite3_column_int(statement, 0);
	 }
	 sqlite3_finalize(statement);
	 }
	 sqlite3_close(contactDB);
	 querySQL = Nil;
	 }
	 */
	NSString *version = [NSString stringWithFormat:
						 @"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
	NSDate *endDate =  [[NSDate date] dateByAddingTimeInterval:8 *60 * 60 ];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init ];
	[formatter setDateFormat:@"yyyy-MM-dd"];
	NSDate *StartDate = [formatter dateFromString:@"2013-04-03"];
	
	
	NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
														fromDate:StartDate
														  toDate:endDate
														 options:0];
	
	
	
	
	labelVersion.text = @"CDY V 1.4.0.240";
    labelVers = labelVersion.text;
	labelUpdated.text = @"Last Updated: 02 OCT 2014 11:00AM";
	outletLogin.hidden = FALSE;
	
	//[txtUsername becomeFirstResponder];
	/*
	 if (intStatus != 0) {
	 
	 if ([components day ] > 43 ) {
	 labelVersion.text = @"";
	 lblForgotPwd.hidden = YES;
	 labelUpdated.numberOfLines = 2;
	 labelUpdated.text = @"Thank you for using iMobile Planner (1.1), this version is now EXPIRED. \nPlease watch up for our announcement for a new release ";
	 outletLogin.hidden = TRUE;
	 
	 if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
	 {
	 NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"0\" WHERE AgentLoginID=\"hla\" "];
	 
	 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
	 if (sqlite3_step(statement) == SQLITE_DONE){
	 
	 }
	 
	 sqlite3_finalize(statement);
	 }
	 
	 sqlite3_close(contactDB);
	 querySQL = Nil;
	 }
	 
	 statement = Nil;
	 
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Thank you for using iMobile Planner "
	 "(1.1), this version is now EXPIRED. \nPlease watch up for our announcement for a new release "
	 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
	 alert.tag = 1001;
	 [alert show];
	 }
	 else{
	 
	 labelVersion.text = version;
	 labelUpdated.text = @"Last Updated: 25 April 2013";
	 outletLogin.hidden = FALSE;
	 
	 [txtUsername becomeFirstResponder];
	 }
	 }
	 else{
	 
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expire" message:@"Thank you for using iMobile Planner "
	 "(1.1), this version is now EXPIRED. \nPlease watch up for our announcement for a new release "
	 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
	 alert.tag = 1001;
	 [alert show];
	 }
	 */
	
	
	
    dirPaths = Nil;
    docsDir = Nil;
    version = Nil;
    endDate =  Nil;
    formatter = Nil;
    StartDate = Nil;
    gregorianCalendar = Nil;
    components = Nil;
	
//    [self setAndpopulateUsername];
	
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
    
}

//added by Edwin 12-02-2014
static NSString *labelVers;
+(NSString*)getLabelVersion
{
    return labelVers;
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

//username is defaulted to agent code and non editable
-(void) setAndpopulateUsername
{
    txtUsername.enabled = YES;
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    txtUsername.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    
    txtUsername.text = @"Username problem";
    
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
		
        NSString *querySQL = @"SELECT \"AgentLoginID\" FROM Agent_profile";
		
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
				if(sqlite3_column_text(statement, 0)==nil)
                {
                    
                }else
                {
                    txtUsername.text = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                }
            } else {
				NSLog(@"wrong query");
                
            }
            sqlite3_finalize(statement);
        }
		else{
			NSLog(@"wrong query");
		}
        sqlite3_close(contactDB);
        querySQL = Nil;
        query_stmt = Nil;
    }
	else{
		NSLog(@"cannot open");
	}
    
    dbpath = Nil;
    statement = Nil;
}


- (void) doOnlineLogin
{
    xmlType = XML_TYPE_GET_AGENT_INFO;
    
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
		NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
							"GetAgentInfo?Input1=%@&Input2=%@",
							[SIUtilities WSLogin],  agentCode, [self getDeviceSerial]];
		
		NSLog(@"%@", strURL);
		NSURL *url = [NSURL URLWithString:strURL];
		NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
		
		AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                                                               success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                                                                   
                                                                                                   XMLParser.delegate = self;
                                                                                                   [XMLParser setShouldProcessNamespaces:YES];
                                                                                                   [XMLParser parse];
                                                                                                   
                                                                                               } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                                                                   [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                                                   NSLog(@"error in calling web service");
                                                                                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                                                                                                   message:@"Error in connecting to Web service. You will now be logged in as offline mode."
                                                                                                                                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                                                   alert.tag = 10;
                                                                                                   [alert show];
                                                                                                   
                                                                                                   alert = Nil;
                                                                                               }];
		[operation start];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
	
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    /*
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
     */
    [self IsFirstDevice];
	
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1001) {
        exit(0);
    }
	else if (alertView.tag == 1){
		/*
		 SettingUserProfile * UserProfileView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingUserProfile"];
		 UserProfileView.modalPresentationStyle = UIModalPresentationPageSheet;
		 UserProfileView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		 UserProfileView.indexNo = self.indexNo;
		 [self presentModalViewController:UserProfileView animated:YES];
		 UserProfileView.view.superview.frame = CGRectMake(150, 50, 700, 748);
		 UserProfileView = nil;
		 */
	}
    else if (alertView.tag == 10)
    {
        [self doOfflineLoginCheck];
    }
    
}

#pragma mark - handle db

- (void)makeDBCopy
{
    BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *DBerror;
    
	/*
	 u1, insert 2 new column into Trad_rider_Detail, tempHL1KSA and tempHL1KSATerm
	 u2, update Trad_Rider_Label,
	 //update trad_sys_rider_label set labelcode = 'HL10T' where ridercode in ('PR', 'SP_PRE', 'SP_STD') and labeldesc = 'Health Loading (Per 1K SA) Term';
	 //update trad_sys_rider_label set labelcode = 'HL10' where ridercode in ('PR', 'SP_PRE', 'SP_STD') and labeldesc = 'Health Loading (Per 1K SA)';
	 //update trad_sys_rider_label set labeldesc = 'Health Loading (Per 100 SA)' where ridercode in ('PR', 'SP_PRE', 'SP_STD') and labelcode = 'HL10';
	 //update trad_sys_rider_label set labeldesc = 'Health Loading (Per 100 SA) Term' where ridercode in ('PR', 'SP_PRE', 'SP_STD') and labelcode = 'HL10T';
	 //update trad_sys_rider_label set labeldesc = 'Sum Assured (%%)' where ridercode in ('PR', 'SP_PRE', 'SP_STD') and labelcode = 'SUMA';
	 //update trad_sys_rider_label set labelcode = 'SUAS' where ridercode in ('PR', 'SP_PRE', 'SP_STD') and labelcode = 'Sum Assured (%%)';
	 u3, update Trad_Rider_Label,
	 //update trad_sys_rider_label set labeldesc = 'Health Loading 1 (Per 100 SA)' where labeldesc = 'Health Loading (Per 100 SA)';
	 //update trad_sys_rider_label set labeldesc = 'Health Loading 1 (Per 100 SA) Term' where labeldesc = 'Health Loading (Per 100 SA) Term';
	 //update trad_sys_rider_label set labeldesc = 'Health Loading 1 (Per 1K SA)' where labeldesc = 'Health Loading (Per 1K SA)';
	 //update trad_sys_rider_label set labeldesc = 'Health Loading 1 (Per 1K SA) Term' where labeldesc = 'Health Loading (Per 1K SA) Term';
	 //update trad_sys_rider_label set labeldesc = 'Health Loading 1 (%%)' where labeldesc = 'Health Loading (%%)';
	 //update trad_sys_rider_label set labeldesc = 'Health Loading 1 (%%) Term' where labeldesc = 'Health Loading (%%) Term';
	 u4, insert 5 new jobs
	 //	insert into Adm_Occp_Loading_Penta Values('OCC02452', 'VICE PRESIDENT', '1', 'A', 'EM', '1', '0', '0' );
	 insert into Adm_Occp_Loading_Penta Values('OCC02453', 'PRESIDENT', '1', 'A', 'EM', '1', '0', '0' );
	 insert into Adm_Occp_Loading_Penta Values('OCC02454', 'CUSTOMER SERVICE EXEC', '1', 'A', 'EM', '1', '0', '0' );
	 insert into Adm_Occp_Loading_Penta Values('OCC02455', 'SALES ENGINEER', '1', 'A', 'EM', '1', '0', '0' );
	 insert into Adm_Occp_Loading_Penta Values('OCC02456', 'SERVICE ENGINEER', '1', 'A', 'EM', '2', '0', '0' );
	 insert into Adm_Occp_Loading Values('OCC02452', 'STD', '1', '1', '1' );
	 insert into Adm_Occp_Loading Values('OCC02453', 'STD', '1', '1', '1');
	 insert into Adm_Occp_Loading Values('OCC02454', 'STD', '1', '1', '1');
	 insert into Adm_Occp_Loading Values('OCC02455', 'STD', '1', '1', '1');
	 insert into Adm_Occp_Loading Values('OCC02456', 'STD', '1', '1', '1');
	 insert into Adm_Occp Values('OCC02452', 'VICE PRESIDENT', '1', '', '', '', '', '' );
	 insert into Adm_Occp Values('OCC02453', 'PRESIDENT', '1', '', '', '', '', '' );
	 insert into Adm_Occp Values('OCC02454', 'CUSTOMER SERVICE EXEC', '1', '', '', '', '', '' );
	 insert into Adm_Occp Values('OCC02455', 'SALES ENGINEER', '1', '', '', '', '', '' );
	 insert into Adm_Occp Values('OCC02456', 'SERVICE ENGINEER', '1', '', '', '', '', '' );
	 u5, update trad_sys_mtn
	 update trad_sys_mtn set MaxAge = '63' where PlanCode = 'HLACP';
	 u6, Delete From Adm_Occp_Loading_Penta where OccpCode = 'OCC01717';
	 Update Trad_Sys_Rider_Mtn set MaxAge = '63' where RiderCode in ('ETPDB', 'EDB');
	 
	 u7, ALTER TABLE \"Agent_profile\" ADD COLUMN \"AgentPortalLoginID\" VARCHAR
	 ALTER TABLE \"Agent_profile\" ADD COLUMN \"AgentPortalPassword\" VARCHAR
	 */
	
	/*
	 sqlite3_stmt *statement;
	 if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
	 {
	 
	 NSString *querySQL = [NSString stringWithFormat:
	 @"update trad_sys_Rider_mtn set MaxSA = '1500000' where RiderCode = 'CIR';"];
	 
	 if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
	 if (sqlite3_step(statement) == SQLITE_DONE){
	 
	 }
	 else {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
	 message:@"ERROR" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
	 [alert show];
	 alert = Nil;
	 }
	 sqlite3_finalize(statement);
	 }
	 
	 sqlite3_close(contactDB);
	 querySQL = Nil;
	 
	 }
	 */
	
    /*  update Occupation list with Professional Athlete : Edwin 21-11-2013  */
    sqlite3_stmt *statement;
    BOOL proceedInsert = false;
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT OccpCode FROM Adm_Occp_Loading_Penta WHERE OccpCode='OCC01717'"];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                proceedInsert = false;
            }else
            {
                proceedInsert = true;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
        query_stmt = Nil;
        querySQL = Nil;
    }
    statement = Nil;
    
	
    if(proceedInsert)
    {
        sqlite3_stmt *statement;
        if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
        {
            
            NSString *querySQL = [NSString stringWithFormat:
                                  @"insert into Adm_Occp_Loading_Penta Values('OCC01717', 'PROFESSIONAL ATHLETE', '4', 'A', 'EM', '4', '0.0', '0.0' )"];
            
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
                if (sqlite3_step(statement) == SQLITE_DONE){
					
                }
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
            querySQL = Nil;
            
        }
    }
    /*                                                      */
	
	
    success = [fileManager fileExistsAtPath:databasePath];
    //if (success) return;
    if (!success) {
		
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hladb.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:databasePath error:&DBerror];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [DBerror localizedDescription]);
        }
		
        defaultDBPath = Nil;
    }
	
	if([fileManager fileExistsAtPath:CommDatabasePath] == FALSE ){
		
		//if there are any changes, system will delete the old rates.json file and replace with the new one
		// code here
		//--------------
		
		NSString *CommissionRatesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Rates.json"];
		success = [fileManager copyItemAtPath:CommissionRatesPath toPath:CommDatabasePath error:&DBerror];
		if (!success) {
			NSAssert1(0, @"Failed to create Commision Rates json file with message '%@'.", [DBerror localizedDescription]);
		}
		CommissionRatesPath= Nil;
	}
	
	//[fileManager removeItemAtPath:UL_RatesDatabasePath error:Nil];
	
	if([fileManager fileExistsAtPath:UL_RatesDatabasePath] == FALSE ){
		
		NSString *ULRatesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"UL_Rates.sqlite"];
		success = [fileManager copyItemAtPath:ULRatesPath toPath:UL_RatesDatabasePath error:&DBerror];
		if (!success) {
			NSAssert1(0, @"Failed to create UL Rates file with message '%@'.", [DBerror localizedDescription]);
		}
		ULRatesPath= Nil;
	}
    
	if([fileManager fileExistsAtPath:RatesDatabasePath] == FALSE ){
		NSString *RatesDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"HLA_Rates.sqlite"];
		success = [fileManager copyItemAtPath:RatesDBPath toPath:RatesDatabasePath error:&DBerror];
		if (!success) {
			NSAssert1(0, @"Failed to create writable Rates database file with message '%@'.", [DBerror localizedDescription]);
		}
		RatesDBPath = Nil;
	}
	else {
		return;
	}
    
	fileManager = Nil;
    error = Nil;
    
    
}



- (void)forgotPassword:(id)sender
{
    sqlite3_stmt *statement;
    
    if (txtUsername.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"User ID is required" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
        [alert show];
        alert = Nil;
    }
    else {
        if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
        {
            //NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM User_Profile WHERE AgentLoginID=\"%@\" ", txtUsername.text];
            NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM Agent_Profile WHERE AgentLoginID=\"%@\" ", txtUsername.text];
            
            if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
                if (sqlite3_step(statement) == SQLITE_ROW){
                    ForgotPwd *forgotView = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPwd"];
                    forgotView.modalPresentationStyle = UIModalPresentationFormSheet;
                    forgotView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    forgotView.LoginID = txtUsername.text;
                    [self presentModalViewController:forgotView animated:NO];
                    forgotView.view.superview.bounds = CGRectMake(0, 0, 550, 600);
                    
                    forgotView = Nil;
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:@"Username does not exist. Unable to retrieve password." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
                    [alert show];
                    alert = Nil;
                }
                sqlite3_finalize(statement);
            }
			
            sqlite3_close(contactDB);
            querySQL = Nil;
            
        }
        
        
    }
    statement = Nil;
	
}


-(void)IsFirstDevice
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber *aNumber = [defaults objectForKey:@"isFirstDevice"];
    NSInteger anInt = [aNumber intValue];
    anInt=1;
    if(anInt==1)
    {
        isFirstDevice = FALSE;
    }else
    {
        isFirstDevice = TRUE;
        
        AgentPortalLogin *agentPortalLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"agentPortalLogin"];
        agentPortalLogin.modalPresentationStyle = UIModalPresentationPageSheet;
        agentPortalLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:agentPortalLogin animated:YES completion:nil];
        agentPortalLogin.view.superview.frame = CGRectMake(150, 50, 700, 600);
    }
	
    //[self resetFirstDevice];
}


/* added by Edwin for new device registration, resets to as new device*/
-(void)resetFirstDevice
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSNumber numberWithInt:0] forKey:@"isFirstDevice"];
    
}


-(void)checkingFirstLogin
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    agentPortalLoginID = @"";
	agentPortalPassword = @"";
	agentID = @"";
	agentCode =@"";
	
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
		
       /* NSString *querySQL = [NSString stringWithFormat: @"SELECT A.IndexNo,A.AgentLoginID,A.FirstLogin,B.AgentPortalLoginID, "
							  "B.AgentPortalPassword, B.AgentCode FROM User_Profile A, Agent_Profile B WHERE A.AgentLoginID = B.AgentLoginID AND "
							  "A.AgentLoginID=\"%@\" and A.AgentPassword=\"%@\"",
							  txtUsername.text,txtPassword.text];*/
        NSString *querySQL = [NSString stringWithFormat: @"SELECT IndexNo, AgentLoginID, FirstLogin, AgentPortalLoginID, AgentPortalPassword, AgentCode "
                              "FROM Agent_Profile WHERE "
							  "AgentLoginID=\"%@\" and AgentPassword=\"%@\"",
							  txtUsername.text,txtPassword.text];
		
        NSLog(@"querySQL %@", querySQL);
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                indexNo = sqlite3_column_int(statement, 0);
                agentID = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                statusLogin = sqlite3_column_int(statement, 2);
                
                const char *portalLogin = (const char*)sqlite3_column_text(statement, 3);
                agentPortalLoginID = portalLogin == NULL ? nil : [[NSString alloc] initWithUTF8String:portalLogin];
                
                const char *portalPswd = (const char*)sqlite3_column_text(statement, 4);
                agentPortalPassword = portalPswd == NULL ? nil : [[NSString alloc] initWithUTF8String:portalPswd];
                
                const char *portalCode = (const char*)sqlite3_column_text(statement, 5);
                agentCode = portalCode == NULL ? nil : [[NSString alloc] initWithUTF8String:portalCode];
                //txtPassword.text = @"";
				
            } else {
				[MBProgressHUD hideHUDForView:self.view animated:YES];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Password. Please check your password" delegate:Nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
//                [alert show];
//                alert = Nil;
                
            }
            sqlite3_finalize(statement);
        }
		else{
			statusLogin = 2;
			NSLog(@"wrong query");
		}
        sqlite3_close(contactDB);
        querySQL = Nil;
        query_stmt = Nil;
    }
	else{
		NSLog(@"cannot open");
	}
    
    dbpath = Nil;
    statement = Nil;
}

-(void)checkingPassword
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
		
       // NSString *querySQL = [NSString stringWithFormat: @"SELECT \"AgentPassword\" FROM User_Profile WHERE \"AgentLoginID\"=\"%@\"", txtUsername.text];
        NSString *querySQL = [NSString stringWithFormat: @"SELECT \"AgentPassword\" FROM Agent_Profile WHERE \"AgentLoginID\"=\"%@\"", txtUsername.text];
		
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                NSLog(@"password is %@", [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]);
                
				
            } else {
				
                
            }
            sqlite3_finalize(statement);
        }
		else{
			NSLog(@"wrong query");
		}
        sqlite3_close(contactDB);
        querySQL = Nil;
        query_stmt = Nil;
    }
	else{
		NSLog(@"cannot open");
	}
    
    dbpath = Nil;
    statement = Nil;
}


-(void)updateDateLogin
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET LastLogonDate= \"%@\" WHERE IndexNo=\"%d\"",dateString,indexNo];
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_Profile SET LastLogonDate= \"%@\" WHERE IndexNo=\"%d\"",dateString,indexNo];
        
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
    
    dateFormatter = Nil;
    dateString = Nil;
    dbpath = Nil;
    statement = Nil;
}

-(void)checkingLastLogout
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"SELECT LastLogoutDate FROM User_Profile WHERE IndexNo=\"%d\"",indexNo];
        NSString *querySQL = [NSString stringWithFormat: @"SELECT LastLogoutDate FROM Agent_Profile WHERE IndexNo=\"%d\"",indexNo];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
                
                //                NSDate *logoutDate = [NSDate dateWithTimeIntervalSinceNow: sqlite3_column_double(statement, 0)];
                
                NSString *logoutDate = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                
                //                NSDate *logoutDate = [dateFormatter stringFromDate:[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)]];
                
                
                NSLog(@"%@",logoutDate);
                dateFormatter = Nil;
                logoutDate = Nil;
                
            } else {
                NSLog(@"error check logout");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
        querySQL = Nil, query_stmt = Nil;
    }
    
    dbpath = Nil, statement = Nil;
}

#pragma mark - keyboard display

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{/*
  self.scrollViewLogin.frame = CGRectMake(0, 0, 1024, 748-352);
  self.scrollViewLogin.contentSize = CGSizeMake(1024, 748);
  
  CGRect textFieldRect = [activeField frame];
  textFieldRect.origin.y += 10;
  [self.scrollViewLogin scrollRectToVisible:textFieldRect animated:YES];
  */
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.scrollViewLogin.frame = CGRectMake(0, 0, 1024, 748);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeField = textField;
    return YES;
}

#pragma mark - action

- (IBAction)btnLogin:(id)sender {
	//[self checkingPassword];
    
    [self loginAction];
    
}

- (void) ShowLoginDate
{
    NSString *todaysDate = [self getTodayDate];
    NSString *lastSyncDate = [self getLastSyncDate];
	int dayRem = 0;
    
    NSLog(@"lastSyncDate %@", lastSyncDate);
    if( lastSyncDate == nil )
    {
        lastSyncDate = todaysDate;
    }
	
	
    if (lastSyncDate !=(NSString *)[NSNull null]) {
		int dateDifference = [self dateDiffrenceFromDate:todaysDate second:lastSyncDate];
		
		if(dateDifference<0)
		{
			dateDifference = dateDifference * -1;
		}
		
		lblLastLogin.text = lastSyncDate;
		
		dayRem = 7-dateDifference;
	}
	else {
		lblLastLogin.text = @"";
	}
	
	if (dayRem<0) {
		lblTimeRemaining.textColor = [UIColor redColor];
		lblTimeRemaining.text = [NSString stringWithFormat:@"0 days"];
	}
	else {
		lblTimeRemaining.textColor = [UIColor blackColor];
		lblTimeRemaining.text = [NSString stringWithFormat:@"%d days", dayRem];
	}
}

- (void) loginAction
{
	
//	txtUsername.text= @"emi";
//	txtPassword.text = @"password";
	
	if (txtUsername.text.length <= 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Username is required" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtUsername becomeFirstResponder];
        alert = Nil;
        
    }
	
	if (![self IsConnected]) {
		// not connected
		NSLog(@"got");
	} else {
		// connected, do some internet stuff
		NSLog(@"nogot");
	}
	
	
	
	
	//http://192.168.2.107/AgentWebService/AgentMgmt.asmx/ValidateAgentAndDevice?strAgentID=&strDeviceID=
	
	NSString *deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
	
	NSLog(@"devideId %@", [[[UIDevice currentDevice] identifierForVendor] UUIDString]);
	
	
	
	
	
   
//	NSString *post = [NSString stringWithFormat:@"strAgentID=%@&strPassword=%@&strDeviceID=%@",txtUsername.text,txtPassword.text, @"1AE92BBE-1B69-413E-982A-557CBA969D4B"];
	NSString *post = [NSString stringWithFormat:@"strAgentID=%@&strPassword=%@&strDeviceID=%@",txtUsername.text,txtPassword.text, [[[UIDevice currentDevice] identifierForVendor] UUIDString]];
	
//	NSString *post = [NSString stringWithFormat:@"strAgentID=%@&strDeviceID=%@",@"cd",@"ds"];
	
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	
	NSString *url = [NSString stringWithFormat:@"http://192.168.0.140/AgentWebService/AgentMgmt.asmx/ValidateLogin"];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSData *urlData;
    NSURLResponse *response;
	//D33D26AB-2319-4088-A7AD-E8A69F675F19
    NSError *error;
    urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	BOOL hasConn;
    if(conn) {
		hasConn = TRUE;
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
		hasConn = FALSE;
    }
	
	if (hasConn) {
		NSString *aStr = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
		
		NSRange rangeValue1 = [aStr rangeOfString:@"True" options:NSCaseInsensitiveSearch];
		NSRange rangeValue2 = [aStr rangeOfString:@"False" options:NSCaseInsensitiveSearch];
		
		if (aStr == nil || [aStr isEqualToString:@""]) {
			NSLog(@"no conn");
			[self doOfflineLoginCheck];
		}
		if (rangeValue1.length > 0)
		{
			[self loginSuccess];
			
			[self parseURL:aStr];
		}
		if (rangeValue2.length > 0)
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Login" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			
			[txtUsername becomeFirstResponder];
			alert = Nil;
		}
	}
	else {
	
		[self doOfflineLoginCheck];
	
	}
	


//	if ([txtUsername.text isEqualToString:@"prem"] &&[txtPassword.text isEqualToString:@"password123"])
//	{
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"User Account been disable,Please authenticate with the portal to enable" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        
//        [txtPassword becomeFirstResponder];
//        alert = Nil;
//
//	}
//	else if ([txtUsername.text isEqualToString:@"emi"] &&[txtPassword.text isEqualToString:@"password123"])
//	{
//		[self loginSuccess];
//		        
//	}
//	
//	else
//	{
//	  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Password. Please check your password" delegate:Nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
//	  [alert show];
//		
//	}
//	
//
//	
//    
    
//    else if (txtPassword.text.length <=0) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Password is required" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        
//        [txtPassword becomeFirstResponder];
//        alert = Nil;
//    }
    /*
	 else if (![txtUsername.text isEqualToString:@"hla"]) {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Login ID." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [alert show];
	 
	 [txtPassword becomeFirstResponder];
	 alert = Nil;
	 }*/
//    else if( [Login forSMPD_Acturial:txtPassword.text] )
//    {
//        [self openHome];
//    }
//    else if (isFirstDevice)
//    {
//        if ([[Reachability reachabilityWithHostname:@"www.hla.com.my"] currentReachabilityStatus] == NotReachable) {
//            // Show alert because no wifi or 3g is available..
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                            message:@"Error in connecting to Web service. Please check your internet connection"
//                                                           delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            
//            alert = Nil;
//        }else
//        {
//            
//            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 5), ^{
//                
//                xmlType = XML_TYPE_VALIDATE_AGENT;
//                NSString *sBadAttempt = [NSString stringWithFormat:@"%d", [self getBadAttempts]];
//                NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
//                                    "ValidateAgent?Input1=%@&Input2=%@&Input3=%@&Input4=%@",
//                                    [SIUtilities WSLogin],  txtUsername.text, txtPassword.text, [self getIPAddress], sBadAttempt];
//                NSLog(@"%@", strURL);
//                NSURL *url = [NSURL URLWithString:strURL];
//                NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
//                
//                AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
//                                                                                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
//                                                                                                           
//                                                                                                           XMLParser.delegate = self;
//                                                                                                           [XMLParser setShouldProcessNamespaces:YES];
//                                                                                                           [XMLParser parse];
//                                                                                                           
//                                                                                                       } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
//                                                                                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
//                                                                                                           NSLog(@"error in calling web service");
//                                                                                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                                                                                                                           message:@"Error in connecting to Web service. Please check your internet connection"
//                                                                                                                                                          delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                                                                                           [alert show];
//                                                                                                           
//                                                                                                           alert = Nil;
//                                                                                                       }];
//                [operation start];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [MBProgressHUD hideHUDForView:self.view animated:YES];
//                });
//            });
//        }
//		
//		
//    }
//    else {
//        
//        [self checkingFirstLogin];
//        NSLog(@"loginstatus:%d",statusLogin);
//        NSLog(@"indexNo:%d",indexNo);
//        NSLog(@"user:%@",agentID);
//        statusLogin = 0; //hardcoded as due to previous design that this was used to trigger the security questions.
//        if (statusLogin == 1 && indexNo != 0) {
//            
//			
//			SecurityQuestion *securityPage = [self.storyboard instantiateViewControllerWithIdentifier:@"SecurityQuestion"];
//			securityPage.userID = indexNo;
//			securityPage.FirstTimeLogin = 1;
//			securityPage.modalPresentationStyle = UIModalPresentationPageSheet;
//			securityPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//			[self presentModalViewController:securityPage animated:NO];
//			
//			securityPage = Nil;
//			
//			
//            scrollViewLogin = Nil;
//            activeField = Nil;
//			
//			
//            
//        } else if (statusLogin == 0 && indexNo != 0) {
//            
//			
//			
//            if ([[Reachability reachabilityWithHostname:@"www.hla.com.my"] currentReachabilityStatus] == NotReachable) {
//                [self doOfflineLoginCheck];
//            }else
//            {
//                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//                    
//                    [self doOnlineLogin];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [MBProgressHUD hideHUDForView:self.view animated:YES];
//                    });
//                });
//            }
//            
//            
//        }
//		else if (statusLogin == 2){
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please Contact System Admin." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//			[alert show];
//			
//			alert = Nil;
//		}
//		
//    }
}

-(void)parseURL:(NSString *) urlStr
{
    NSMutableDictionary *queryStringDict = [ [NSMutableDictionary alloc] init];
    NSArray *urlArr = [urlStr componentsSeparatedByString:@"|"];
    
    if (urlArr.count < 1) {
        return;//should not reach here
    }
    
    NSLog(@"parseURL: %@", urlStr);
    
//    for(NSString *keyPair in urlArr)
//    {
//        NSArray *pairedComp = [keyPair componentsSeparatedByString:@"="];
//        NSString *key = [pairedComp objectAtIndex:0];
//        NSString *value = [pairedComp objectAtIndex:1];
//        
//        [queryStringDict setObject:value forKey:key];
//    }
    
	NSString* validity = [urlArr objectAtIndex:0];
    NSString* agentCode_1 =  [urlArr objectAtIndex:1]; //[queryStringDict objectForKey:@"agentCode"];
    NSString* agentName_1 = [urlArr objectAtIndex:2];
    NSString* agentType_1 = [urlArr objectAtIndex:3];
    NSString* immediateLeaderCode_1 = [urlArr objectAtIndex:4];
    NSString* immediateLeaderName_1 = [urlArr objectAtIndex:5];
    NSString* BusinessRegNumber_1 = [urlArr objectAtIndex:6];
    NSString* agentEmail_1 = [urlArr objectAtIndex:7];
    NSString* agentLoginId_1 = [urlArr objectAtIndex:8];
    NSString* agentIcNo_1 = [urlArr objectAtIndex:9];
    NSString* agentContractDate_1 = [urlArr objectAtIndex:10];
    NSString* agentAddr1_1 = [urlArr objectAtIndex:11];
    NSString* agentAddr2_1 = [urlArr objectAtIndex:12];
    NSString* agentAddr3_1 = [urlArr objectAtIndex:13];
    NSString* agentAddrPostcode_1 = [urlArr objectAtIndex:14];
    NSString* agentContactNumber_1 = [urlArr objectAtIndex:15];
    NSString* agentPassword_1 = [urlArr objectAtIndex:16];
    //NSString* lastLogonDate = [queryStringDict objectForKey:@"lastLogonDate"];
    //NSString* lastLogoutDate = [queryStringDict objectForKey:@"lastLogoutDate"];
    NSString* agentStatus_1 = [urlArr objectAtIndex:17];
    NSString* channel_1 = [urlArr objectAtIndex:18];
    
	NSLog(@"");
	
	
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:agentCode_1 forKey:KEY_AGENT_CODE];
    [defaults synchronize];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *databasePath1 = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath1 UTF8String ], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL;
        BOOL newRec = FALSE;
        
        NSString *CheckSql = [NSString stringWithFormat:
							  @"select * FROM agent_profile"];
		
		
		FMDatabase *db = [FMDatabase databaseWithPath:databasePath1];
		[db open];
		
        FMResultSet *results;
		results = [db executeQuery:CheckSql];
		
		while ([results next]) {
			[db executeUpdate:@"DELETE FROM agent_profile"];
		}
		[db close];
		
		querySQL = [NSString stringWithFormat:
					@"insert into Agent_profile (agentCode, AgentName, AgentType, AgentContactNo, ImmediateLeaderCode, ImmediateLeaderName, BusinessRegNumber, AgentEmail, AgentLoginID, AgentICNo, "
					"AgentContractDate, AgentAddr1, AgentAddr2, AgentAddr3, AgentAddr4, AgentPortalLoginID, AgentPortalPassword, AgentContactNumber, AgentPassword, AgentStatus, Channel, AgentAddrPostcode, agentNRIC, LastLogonDate) VALUES "
					"('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@', '%@', '%@', %@) ",
					agentCode_1, agentName_1, agentType_1, agentContactNumber_1,immediateLeaderCode_1, immediateLeaderName_1,BusinessRegNumber_1, agentEmail_1, agentLoginId_1, agentIcNo_1, agentContractDate_1, agentAddr1_1, agentAddr2_1, agentAddr3_1, @"", agentLoginId_1, agentPassword_1, agentContactNumber_1, agentPassword_1, agentStatus_1, channel_1, agentAddrPostcode_1, agentIcNo_1, @"datetime(\"now\", \"+8 hour\")" ];
        
		
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



//- (void) loginSuccess
//{
//    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
//    zzz.indexNo = self.indexNo;
//    zzz.userRequest = agentID;
//    
//    CarouselViewController *carouselMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
//    carouselMenu.getInternet = @"No";
//    [self presentViewController:carouselMenu animated:YES completion:Nil];
//    [self updateDateLogin];
//}

+(bool)forSMPD_Acturial:(NSString*) password
{
    if( [password isEqualToString:@"Hla123"] )
    {
        return true;
    }else
    {
        return false;
    }
}

+(void)setFirstDevice
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSNumber numberWithInt:1] forKey:@"isFirstDevice"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) loginSuccess
{
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    zzz.indexNo = self.indexNo;
    zzz.userRequest = agentID;
    
    if( [[self getDeviceStatus] isEqualToString:@"I"] )
    {
        [self showDeviceInactive];
    }else
    {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDelegate.isLoggedIn = TRUE;
        
        [self openHome];
        [self updateDateLogin];
    }
}

-(void) showDeviceInactive
{
    NSString *inactiveMsg = nil;
    UIAlertView *alert = nil;
    
    if(showLogout)
    {
        inactiveMsg = @"Your device has become inactive, you'll be logged out.";
        alert = [[UIAlertView alloc] initWithTitle:@" "
                                           message:inactiveMsg
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 2001;
    }else
    {
        inactiveMsg = @"Couldn't log you in, your device is in inactive mode.";
        alert = [[UIAlertView alloc] initWithTitle:@" "
                                           message:inactiveMsg
                                          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self loginFail];
    
    [alert show];
    
    alert = Nil;
}

-(void) loginFail
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.isLoggedIn = FALSE;
}

- (void) openHome
{
    CarouselViewController *carouselMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
    carouselMenu.getInternet = @"No";
    [self presentViewController:carouselMenu animated:YES completion:Nil];
}

- (void) doOfflineLoginCheck
{
    NSString *todaysDate = [self getTodayDate];
    NSString *lastSyncDate = [self getLastSyncDate];
    
    NSLog(@"lastSyncDate %@", lastSyncDate);
    if (lastSyncDate !=(NSString *)[NSNull null] || [lastSyncDate isEqualToString:@""])
    {
        lastSyncDate = todaysDate;
    }
    
    int dateDifference = [self dateDiffrenceFromDate:todaysDate second:lastSyncDate];
    
    if(dateDifference<0)
    {
        dateDifference = dateDifference * -1;
    }
    //dateDifference = 20;
    if(dateDifference > 7)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
														message:@"You have not login with an internet connection for the past 7 days. Please connect to internet to login."
													   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        alert = Nil;
    }else
    {
		
		if ([self OfflineLogin]) {
			[self loginSuccess];	
		}
		else {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Login" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			
			[txtUsername becomeFirstResponder];
			alert = Nil;
		}
		
		
		
		
		
//        NSString *storedAgentStatus = [self getStoredAgentStatus];
        
//        if([storedAgentStatus isEqualToString:@"Y"])
//        {
//            [self loginSuccess];
//        }else
//			if([storedAgentStatus isEqualToString:@"N"])
//			{
//				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//																message:@"Your login is voided, please check with AASD or if your account is active, please login again with an active internet connection."
//															   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//				[alert show];
//				
//				alert = Nil;
//			}
		
    }
}

- (NSString *) getTodayDate
{
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    
    NSLog(@"%@",dateString);
    
    return dateString;
}

-(int)dateDiffrenceFromDate:(NSString *)date1 second:(NSString *)date2 {
    // Manage Date Formation same for both dates
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSDate *startDate = [formatter dateFromString:date1];
    NSDate *endDate = [formatter dateFromString:date2];
    
    
    unsigned flags = NSDayCalendarUnit;
    NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:startDate toDate:endDate options:0];
    
    int dayDiff = [difference day];
    
    return dayDiff;
}

-(NSString*) getDeviceSerial
{
    AgentProfile *agentProf = [ [AgentProfile alloc] init];
    NSString *deviceSerial = [agentProf getDeviceSerialNo];
    
    return deviceSerial;
}

-(void) getAppInfo
{
    if([agentCode length]==0)
    {
        agentCode = [self getStoredAgentCode];
    }
    
    xmlType = XML_TYPE_GET_APP_INFO;
    NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
                        "GetAppInfo?Input1=%@&Input2=%@&Input3=%@",
                        [SIUtilities WSLogin],  APP_TYPE_HLA_FAST, agentCode,[self getDeviceSerial]];
    NSLog(@"%@", strURL);
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
    
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                                                               
                                                                                               XMLParser.delegate = self;
                                                                                               [XMLParser setShouldProcessNamespaces:YES];
                                                                                               [XMLParser parse];
                                                                                               
                                                                                           } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                                                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                                                               NSLog(@"error in calling web service");
                                                                                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                                                                                               message:@"Error in connecting to Web service. Please check your internet connection"
                                                                                                                                              delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                                               [alert show];
                                                                                               
                                                                                               alert = Nil;
                                                                                           }];
    [operation start];
    
}

/*
 - (BOOL) isValidAgent
 {
 internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
 
 NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
 "ValidateAgent?strinput1=%@&strinput2=%@&strinput3=%@&iinput4=%@",
 [SIUtilities WSLogin],  txtUsername.text, txtPassword.text, [self getIPAddress], @"1"]; //for testing put 1, will need to get from a stored variable
 
 NSURL *url = [NSURL URLWithString:strURL];
 NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
 
 AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
 success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
 NSLog(@"responseobject: %@", [responseObject description]);
 } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
 NSLog(@"error in calling web service");
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
 message:@"Error in connecting to Web service. Please check your internet connection"
 delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
 [alert show];
 
 alert = Nil;
 }];
 
 }
 */

- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}


- (IBAction)btnReset:(id)sender
{
	
	
	[self loginSuccess];
	
	
	
	
//    const char *dbpath = [databasePath UTF8String];
//    sqlite3_stmt *statement;
//    sqlite3_stmt *statement2;
//    sqlite3_stmt *statement3;
//    
//    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
//    {
//        //NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET firstLogin = 1, agentPassword = \"password\" "];
//        /*NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_profile SET firstLogin = null, agentPassword = \"password\" "];
//        
//        const char *query_stmt = [querySQL UTF8String];
//        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
//        {
//            if (sqlite3_step(statement) == SQLITE_DONE)
//            {*/
//                NSString *querySQL2 = [NSString stringWithFormat:@"DELETE from SecurityQuestion_Input "];
//                if (sqlite3_prepare_v2(contactDB, [querySQL2 UTF8String], -1, &statement2, NULL) == SQLITE_OK)
//                {
//                    if (sqlite3_step(statement2) == SQLITE_DONE){
//                        
//                        NSString *querySQL3 = [NSString stringWithFormat:@"UPDATE Agent_Profile SET AgentCode = \"\", AgentName = \"\", "
//                                               " AgentContactNo = \"\", ImmediateLeaderCode = \"\", ImmediateLeaderName = \"\", BusinessRegNumber = \"\", "
//                                               " AgentEmail = \"\", AgentPassword = \"\" , firstLogin = null "];
//                        if (sqlite3_prepare_v2(contactDB, [querySQL3 UTF8String], -1, &statement3, NULL) == SQLITE_OK)
//                        {
//                            if (sqlite3_step(statement3) == SQLITE_DONE){
//                                
//                                [self resetFirstDevice];
//                                [self IsFirstDevice];
//                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                                                message:@"System has been restored to first time login mode" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                [alert show];
//                                
//                            }
//                            
//                            sqlite3_finalize(statement3);
//                        }
//                        
//                    }
//                    sqlite3_finalize(statement2);
//                    
//                }
//                sqlite3_close(contactDB);
//        /*
//            } else {
//                NSLog(@"reset error");
//            }
//            sqlite3_finalize(statement);
//        }
//        sqlite3_close(contactDB);*/
//    }
//    
//	/*
//	 
//	 if(_delegate != Nil){
//	 [(ViewController *)_delegate setSss:1 ];
//	 [self dismissModalViewControllerAnimated:NO];
//	 [_delegate Dismiss:@""];
//	 }
//	 */
//	
//	AgentPortalLogin *agentPortalLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"agentPortalLogin"];
//	agentPortalLogin.modalPresentationStyle = UIModalPresentationPageSheet;
//	agentPortalLogin.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//	
//	[self presentViewController:agentPortalLogin animated:YES completion:nil];
//	agentPortalLogin.view.superview.frame = CGRectMake(150, 50, 700, 600);
	
}

-(void) storeBadAttempts
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSNumber numberWithInt:badAttempts] forKey:KEY_BAD_ATTEMPTS];
    [defaults synchronize];
}

-(NSInteger) getBadAttempts
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *number = [defaults objectForKey:KEY_BAD_ATTEMPTS];
    
    NSInteger anInt = [number intValue];
    
    return anInt;
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
	
	if([self.elementName isEqualToString:@"LoginError"]){
		
		if ([string isEqualToString:@""]) {
			
			ProceedStatus = @"0";
			
		}
		else{
			
			ProceedStatus = @"1";
			/*
			 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agency Portal" message:[NSString stringWithFormat:@"%@", string]
			 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			 alert.tag = 1;
			 //[alert show];
			 
			 alert = Nil;
			 
			 
			 
			 */
			msg = string;
			
		}
		
	}
	
    if(xmlType == XML_TYPE_VALIDATE_AGENT)
    {
        if(isFirstDevice)
        {
            NSLog(@"%@" , self.elementName);
            NSLog(@"%@" , string);
            
            if([self.elementName isEqualToString:@"BadAttempts"]){
                badAttempts = [string intValue];
            }
            
            if([self.elementName isEqualToString:@"Status"]){
                status = string;
            }
            
            if([self.elementName isEqualToString:@"Error"]){
                error = string;
            }
            
            if([self.elementName isEqualToString:@"AgentInfo"]){
                agentInfo = string;
            }
            
            if([self.elementName isEqualToString:@"Output1"]){ //agent code
                agentCode = string;
            }
			
			
            if([self.elementName isEqualToString:@"Output2"]){ //agent name
                agentName = string;
            }
			
            if([self.elementName isEqualToString:@"Output3"]){ //new IC no
                icNo = string;
            }
			
            if([self.elementName isEqualToString:@"Output4"]){ //contract date
                contractDate = string;
            }
            
            if([self.elementName isEqualToString:@"Output5"]){ //email address
                email = string;
            }
            
            
            if([self.elementName isEqualToString:@"Output6"]){ //address1
                address1 = string;
            }
            
            if([self.elementName isEqualToString:@"Output7"]){ //address2
                address2 = string;
            }
            
            if([self.elementName isEqualToString:@"Output8"]){ //address3
                address3 = string;
            }
            
            if([self.elementName isEqualToString:@"Output9"]){ //postal
                postalCode = string;
            }
            
            if([self.elementName isEqualToString:@"Output10"]){ //state
                stateCode = string;
            }
            
            if([self.elementName isEqualToString:@"Output11"]){ //country
                countryCode = string;
            }
            
            if([self.elementName isEqualToString:@"Output12"]){ //agent status
                agentStatus = string;
            }
            
            if([self.elementName isEqualToString:@"Output13"]){ //leader code
                leaderCode = string;
            }
            
            if([self.elementName isEqualToString:@"Output14"]){ //leader name
                leaderName = string;
            }
        }
    }else
		if(xmlType == XML_TYPE_GET_AGENT_INFO)
		{
			NSLog(@"self.elementName : %@ || string : %@", self.elementName, string);
			if([self.elementName isEqualToString:@"Output1"]){
				agentStatus = string;
			}
			
			if([self.elementName isEqualToString:@"Output1_Desc"]){
				statusDesc = string;
			}
			
			if([self.elementName isEqualToString:@"Output2"]){
				loginDate = string;
			}
            
            if([self.elementName isEqualToString:@"Output3"]){
                deviceStatus = string;
            }
		}else
			if(xmlType == XML_TYPE_GET_APP_INFO)
			{
				if([self.elementName isEqualToString:@"Output1"]){
					currentVers = string;
				}
				
				if([self.elementName isEqualToString:@"Output2"]){
					lastUpdateDate = string;
				}
				
				if([self.elementName isEqualToString:@"Output3"]){
					obsoleteVersNo = string;
				}
				
				if([self.elementName isEqualToString:@"Output3"]){
					obsoleteDate = string;
				}
                
                if([self.elementName isEqualToString:@"Output4"]){
                    obsoleteDate = string;
                }
                
                if([self.elementName isEqualToString:@"Output5"]){
                    deviceStatus = string;
                }
                
                if([self.elementName isEqualToString:@"Output6"]){
                    licenseStatus = string;
                }
			}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	self.elementName = nil;
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	
    if(xmlType == XML_TYPE_VALIDATE_AGENT)
    {
        if(isFirstDevice)
        {
            [self storeBadAttempts];
            
            if([status isEqualToString:@"1"])
            {
                NSLog(@"valid");
                
                StoreVarFirstTimeReg *storeVar = [StoreVarFirstTimeReg sharedInstance];
                
                //agentCode,agentName,leaderCode,leaderName,icNo,contractDate;
                storeVar.agentLogin = txtUsername.text;
                storeVar.agentCode = agentCode;
                storeVar.agentName = agentName;
                storeVar.icNo = icNo;
                storeVar.contractDate = contractDate;
                storeVar.email = email;
                storeVar.address1 = address1;
                storeVar.address2 = address2;
                storeVar.address3 = address3;
                storeVar.postalCode = postalCode;
                storeVar.stateCode = stateCode;
                storeVar.countryCode = countryCode;
                storeVar.agentStatus = agentStatus;
                storeVar.leaderCode = leaderCode;
                storeVar.leaderName = leaderName;
                
                
                AgentProfile *agentProfile = [self.storyboard instantiateViewControllerWithIdentifier:@"AgentProfile"];
                agentProfile.modalPresentationStyle = UIModalPresentationPageSheet;
                agentProfile.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                
                [self presentViewController:agentProfile animated:YES completion:nil];
                agentProfile.view.superview.frame = CGRectMake(150, 50, 700, 600);
            }else
				if([status isEqualToString:@"0"])
				{
					NSLog(@"not valid");
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:error
																   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
					[alert show];
					
					alert = Nil;
				}
        }
        else
        {
            if ([ProceedStatus isEqualToString:@"0"]) {
                CarouselViewController *carouselMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
                carouselMenu.getInternet = @"Yes";
                carouselMenu.getValid = @"Valid";
                carouselMenu.indexNo = self.indexNo;
                carouselMenu.ErrorMsg = @"";
                [self presentViewController:carouselMenu animated:YES completion:Nil];
                [self updateDateLogin];
                
                sqlite3_stmt *statement;
                if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
                {
                    //NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"1\" WHERE "
                    //                      "AgentLoginID=\"hla\" "];
                    NSString *querySQL = [NSString stringWithFormat: @"UPDATE Agent_Profile set AgentStatus = \"1\" "];
                    
                    if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
                        if (sqlite3_step(statement) == SQLITE_DONE){
                            
                        }
                        
                        sqlite3_finalize(statement);
                    }
                    
                    sqlite3_close(contactDB);
                    querySQL = Nil;
                }
                statement = nil;
            }
            else{
                
                if ([msg isEqualToString:@"Account suspended."]) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
																	message:[NSString stringWithFormat:@"Your Account is suspended. Please contact Hong Leong Assurance."]
																   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                    alert = Nil;
                    
                    sqlite3_stmt *statement;
                    if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
                    {
                        //NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"0\" WHERE "
                        //                      "AgentLoginID=\"hla\" "];
                        NSString *querySQL = [NSString stringWithFormat: @"UPDATE Agent_Profile set AgentStatus = \"0\"  "];
                        
                        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
                            if (sqlite3_step(statement) == SQLITE_DONE){
                                
                            }
                            
                            sqlite3_finalize(statement);
                        }
                        
                        sqlite3_close(contactDB);
                        querySQL = Nil;
                    }
                    statement = nil;
                    
                }
                else{
                    CarouselViewController *carouselMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
                    carouselMenu.getInternet = @"Yes";
                    carouselMenu.getValid = @"Invalid";
                    carouselMenu.indexNo = self.indexNo;
                    
                    if ([[agentPortalLoginID stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""] ||
                        [[agentPortalLoginID stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"(null)"] ||
                        [[agentPortalLoginID stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"(null)"]){
                        carouselMenu.ErrorMsg = @"Please Fill in your Agent Portal Login and Agent Portal Password";
                    }
                    else{
                        carouselMenu.ErrorMsg = msg;
                    }
                    
                    [self presentViewController:carouselMenu animated:YES completion:Nil];
                    [self updateDateLogin];
                }
                /*
				 CarouselViewController *carouselMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
				 carouselMenu.getInternet = @"Yes";
				 carouselMenu.getValid = @"Invalid";
				 carouselMenu.indexNo = self.indexNo;
				 
				 if ([[agentPortalLoginID stringByReplacingOccurrencesOfString:@" " wi[thString:@"" ] isEqualToString:@""] ||
				 [[agentPortalLoginID stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"(null)"] ||
				 [[agentPortalLoginID stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"(null)"]){
				 carouselMenu.ErrorMsg = @"Please Fill in your Agent Portal Login and Agent Portal Password";
				 }
				 else{
				 carouselMenu.ErrorMsg = msg;
				 }
				 
				 [self presentViewController:carouselMenu animated:YES completion:Nil];
				 [self updateDateLogin];
                 */
            }
        }
    }else
		if(xmlType == XML_TYPE_GET_AGENT_INFO)
		{
			[self storeAgentStatus];
			[self storeLastSyncDate];
            [self storeLastCheckedDevice];
            [self storeDeviceStatus];
			
            if([agentStatus isEqualToString:@"Y"])
            {
                [self getAppInfo];
            }else
                if([agentStatus isEqualToString:@"N"])
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:statusDesc
                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
                    [alert show];
                }
		}else
			if(xmlType == XML_TYPE_GET_APP_INFO)
			{
                [self storeLastCheckedDevice];
                //            deviceStatus = @"I";
                [self storeDeviceStatus];
                //NSString * AppsVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
				NSString * AppsVersion = labelVersion.text;
				
				//currentVers = @"1.4"; for testing
				
				NSComparisonResult result = [AppsVersion compare:currentVers];
				
				if (result == NSOrderedAscending) // stringOne < stringTwo
				{
					//obsolete
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please download the latest version from the portal."
																   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
					[alert show];
				}else
					if (result == NSOrderedDescending) // stringOne > stringTwo
					{
						//impossible right? but still login anyway
						[self loginSuccess];
					}else
						if (result == NSOrderedSame) // stringOne == stringTwo
						{
							//do nothing, go to login
							[self loginSuccess];
						}
			}
	
}

-(void) storeAgentCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:agentCode forKey:KEY_AGENT_CODE];
    [defaults synchronize];
}

-(NSString *) getStoredAgentCode
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults stringForKey:KEY_AGENT_CODE];
}

-(void) storeLastCheckedDevice
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[self getTodayDateInStr] forKey:KEY_LAST_CHECK_DEVICE_DATE];
    [defaults synchronize];
    
}

-(NSString *) getStoredLastCheckedDeviceDate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults stringForKey:KEY_LAST_CHECK_DEVICE_DATE];
}

-(void) storeDeviceStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //    deviceStatus = @"N";
    
    [defaults setObject:deviceStatus forKey:KEY_DEVICE_STATUS];
    [defaults synchronize];
    
}

-(NSString *) getDeviceStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults stringForKey:KEY_DEVICE_STATUS];
}

-(void) storeAgentStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //[defaults setObject:@"N" forKey:KEY_AGENT_STATUS]; //for testing
    [defaults setObject:agentStatus forKey:KEY_AGENT_STATUS];
    [defaults synchronize];
}

-(NSString *) getStoredAgentStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults stringForKey:KEY_AGENT_STATUS];
}

-(void) storeLastSyncDate
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:loginDate forKey:KEY_LAST_SYNC_DATE];
    [defaults synchronize];
    
}

-(NSString *) getLastSyncDate
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    return [defaults stringForKey:KEY_LAST_SYNC_DATE];
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsDir = [dirPaths objectAtIndex:0];
	NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
	
	[db open];
	
	FMResultSet *result1 = [db executeQuery:@"select LastLogonDate from Agent_profile"];
	
	NSString *LastLogonDate = @"";
	while ([result1 next]) {
		LastLogonDate = [result1 objectForColumnName:@"LastLogonDate"];
		
		if (LastLogonDate !=(NSString *)[NSNull null]) {
			
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
			[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
			[dateFormatter2 setDateFormat:@"dd/MM/yyyy"];
			
			NSDate *date = [dateFormatter dateFromString: LastLogonDate];
			dateFormatter = [[NSDateFormatter alloc] init];
			
			LastLogonDate = [dateFormatter2 stringFromDate:date];
		}
		else {
			LastLogonDate = @"";
		}
		
	}
	
	[db close]; 

	return LastLogonDate;

}

-(BOOL) OfflineLogin
{
	BOOL successLog = FALSE;
	
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docsDir = [dirPaths objectAtIndex:0];
	NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
	
	[db open];
	NSString *AgentName;
	NSString *AgentPassword;
	
	FMResultSet *result1 = [db executeQuery:@"select AgentName, AgentPassword from Agent_profile"];
	
	while ([result1 next]) {
		AgentName = [[result1 objectForColumnName:@"AgentName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		AgentPassword = [[result1 objectForColumnName:@"AgentPassword"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		if ([txtUsername.text isEqualToString:AgentName] && [txtPassword.text isEqualToString:AgentPassword]) {
			successLog = TRUE;
		}
	}
	
	[db close];
	
	return successLog;
	
}

-(NSString*) getTodayDateInStr
{
    NSDate *today = [NSDate date]; 
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATE_FORMAT];
    
    NSString *stringFromDate = [formatter stringFromDate:today];
    
    return stringFromDate;
}

-(BOOL)hasCheckedToday
{
    NSString *lastCheckedDateStr = [self getStoredLastCheckedDeviceDate];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init ];
	[formatter setDateFormat:DATE_FORMAT];
    
    NSString *todayDateStr = [formatter stringFromDate:[NSDate date]];
    
    NSDate *todayDate = [formatter dateFromString:todayDateStr]; 
    NSDate *lastCheckedDate = [formatter dateFromString:lastCheckedDateStr];
    
    NSComparisonResult result; 
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [todayDate compare:lastCheckedDate]; // comparing two dates
    
    if([lastCheckedDateStr length]==0)
    {
        return NO;
    }else
    {
        if(result==NSOrderedAscending)
        {
            NSLog(@"today is less");
            return NO;
        }
        else if(result==NSOrderedDescending)
        {
            NSLog(@"newDate is less");
            return NO;
        }
        else
        {
            NSLog(@"Both dates are same");
            return YES;
        }
    }
}

-(void) doOnceADayCheck:(BOOL)showLogoutF
{
    showLogout = showLogoutF;
    if(![self hasCheckedToday])
    {
        [self getAppInfo];
    }
}


#pragma mark - memory

- (void)viewDidUnload
{
    [self setTxtUsername:nil];
    [self setTxtPassword:nil];
    [self setLblForgotPwd:nil];
    [self setScrollViewLogin:nil];
    [self setOutletReset:nil];
    [self setLabelVersion:nil];
    [self setLabelUpdated:nil];
    [self setLabelUpdated:nil];
    [self setLabelVersion:nil];
    [self setOutletLogin:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    databasePath = Nil;
    RatesDatabasePath = Nil;
}

- (BOOL)IsConnected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}


@end
