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
@synthesize elementName, msg;

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
    
    [self isFirstTimeLogin];

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
	
	
	
	
	labelVersion.text = @"1.2";
	labelUpdated.text = @"Last Updated: 1 Nov 2013";
	outletLogin.hidden = FALSE;
	
	[txtUsername becomeFirstResponder];
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
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expire" message:@"Thank you for using iMobile Planner "
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
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
    
}

#pragma mark - handle db

- (void)makeDBCopy 
{	
    BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    
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
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
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

	
	
    success = [fileManager fileExistsAtPath:databasePath];
    //if (success) return;
    if (!success) {
		
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hladb.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:databasePath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }

        defaultDBPath = Nil;
    }

	if([fileManager fileExistsAtPath:CommDatabasePath] == FALSE ){
		
		//if there are any changes, system will delete the old rates.json file and replace with the new one
		// code here
		//--------------
		
		NSString *CommissionRatesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Rates.json"];
		success = [fileManager copyItemAtPath:CommissionRatesPath toPath:CommDatabasePath error:&error];
		if (!success) {
			NSAssert1(0, @"Failed to create Commision Rates json file with message '%@'.", [error localizedDescription]);
		}
		CommissionRatesPath= Nil;
	}
	
	//[fileManager removeItemAtPath:UL_RatesDatabasePath error:Nil];
	
	if([fileManager fileExistsAtPath:UL_RatesDatabasePath] == FALSE ){
		
		NSString *ULRatesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"UL_Rates.sqlite"];
		success = [fileManager copyItemAtPath:ULRatesPath toPath:UL_RatesDatabasePath error:&error];
		if (!success) {
			NSAssert1(0, @"Failed to create UL Rates file with message '%@'.", [error localizedDescription]);
		}
		ULRatesPath= Nil;
	}
    
	if([fileManager fileExistsAtPath:RatesDatabasePath] == FALSE ){
		NSString *RatesDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"HLA_Rates.sqlite"];
		success = [fileManager copyItemAtPath:RatesDBPath toPath:RatesDatabasePath error:&error];
		if (!success) {
			NSAssert1(0, @"Failed to create writable Rates database file with message '%@'.", [error localizedDescription]);
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"User ID is required" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil ];
        [alert show];
        alert = Nil;
    }
    else {
        if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat: @"SELECT * FROM User_Profile WHERE AgentLoginID=\"%@\" ", txtUsername.text];
            
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
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
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


-(void)isFirstTimeLogin
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT firstLogin FROM User_Profile WHERE AgentLoginID=\"hla\" "];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                int FirstLogin = sqlite3_column_int(statement, 0);
                
                if (FirstLogin == 0) {
                    lblForgotPwd.hidden = FALSE;
                }
                else {
                    lblForgotPwd.hidden = TRUE;
                }
                
            } else {
                
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
        query_stmt = Nil;
        querySQL = Nil;
    }
    dbpath = Nil;
    statement = Nil;
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

        NSString *querySQL = [NSString stringWithFormat: @"SELECT A.IndexNo,A.AgentLoginID,A.FirstLogin,B.AgentPortalLoginID, "
							  "B.AgentPortalPassword, B.AgentCode FROM User_Profile A, Agent_Profile B WHERE A.AgentLoginID = B.AgentLoginID AND "
							  "A.AgentLoginID=\"%@\" and A.AgentPassword=\"%@\"",
							  txtUsername.text,txtPassword.text];


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

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid Password. Please check your password" delegate:Nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                [alert show];
                alert = Nil;
                
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
		
        NSString *querySQL = [NSString stringWithFormat: @"SELECT \"AgentPassword\" FROM User_Profile WHERE \"AgentLoginID\"=\"%@\"", txtUsername.text];
		
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
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET LastLogonDate= \"%@\" WHERE IndexNo=\"%d\"",dateString,indexNo];
        //        NSString *querySQL = [NSString stringWithFormat:@"UPDATE tbl_User_Profile SET LastLogonDate= datetime('now') WHERE IndexNo=\"%d\"",indexNo];
        
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
        NSString *querySQL = [NSString stringWithFormat: @"SELECT LastLogoutDate FROM User_Profile WHERE IndexNo=\"%d\"",indexNo];
        
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
    if (txtUsername.text.length <= 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username is required" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtUsername becomeFirstResponder];
        alert = Nil;
        
    }
    else if (txtPassword.text.length <=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password is required" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtPassword becomeFirstResponder];
        alert = Nil;
    }
	else if (![txtUsername.text isEqualToString:@"hla"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid Login ID." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtPassword becomeFirstResponder];
        alert = Nil;
    }
    else {
        
        [self checkingFirstLogin];
        NSLog(@"loginstatus:%d",statusLogin);
        NSLog(@"indexNo:%d",indexNo);
        NSLog(@"user:%@",agentID);
        
        if (statusLogin == 1 && indexNo != 0) {
            
            /*
             FirstTimeViewController *newProfile = [self.storyboard instantiateViewControllerWithIdentifier:@"firstTimeLogin"];
             newProfile.userID = indexNo;
             //[self presentViewController:newProfile animated:YES completion:nil];
             newProfile.modalPresentationStyle = UIModalPresentationPageSheet;
             newProfile.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
             [self presentModalViewController:newProfile animated:YES];
             */
            /*	
            databasePath = Nil;
            RatesDatabasePath = Nil;
            contactDB = Nil;
			*/
			
			/* 20130523
			NSString *_zz = agentPortalLoginID;
			NSString *_zzz = agentPortalPassword;
			NSString *_zzz2 = agentCode;
			
			NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
								"ValidateLogin?strid=%@&strpwd=%@&strIPAddres=123&iBadAttempts=0&strFirstAgentCode=%@",
								[SIUtilities WSLogin],  _zz, _zzz, _zzz2];
			NSLog(@"%@", strURL);
			NSURL *url = [NSURL URLWithString:strURL];
			NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:5];
			
			AFXMLRequestOperation *operation =
			[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
																success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
																	SecurityQuestion *securityPage = [self.storyboard instantiateViewControllerWithIdentifier:@"SecurityQuestion"];
																	securityPage.userID = indexNo;
																	securityPage.FirstTimeLogin = 1;
																	securityPage.modalPresentationStyle = UIModalPresentationPageSheet;
																	securityPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
																	[self presentModalViewController:securityPage animated:NO];
																	
																	securityPage = Nil;
																			
																} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
																	NSLog(@"error in calling web service");
																	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
																							message:@"Error in connecting to Web service. Please check your internet connection"
																							delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
																	[alert show];
																	
																	alert = Nil;
																}];
			
			
			[operation start];
            */
			
			SecurityQuestion *securityPage = [self.storyboard instantiateViewControllerWithIdentifier:@"SecurityQuestion"];
			securityPage.userID = indexNo;
			securityPage.FirstTimeLogin = 1;
			securityPage.modalPresentationStyle = UIModalPresentationPageSheet;
			securityPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
			[self presentModalViewController:securityPage animated:NO];
			
			securityPage = Nil;
			
			
            scrollViewLogin = Nil;
            activeField = Nil;
			
			
            
        } else if (statusLogin == 0 && indexNo != 0) {
            
            //txtUsername.text = @"";
            //txtPassword.text = @"";
            
            AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
            zzz.indexNo = self.indexNo;
            zzz.userRequest = agentID;
            
            /*
             MainScreen *mainMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"Main"];
             mainMenu.userRequest = agentID;
             mainMenu.indexNo = indexNo;
             [self presentViewController:mainMenu animated:YES completion:nil];
             */
			
            /*20130523
			//check internet connection
			internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];

			
			NSString *_zz = agentPortalLoginID;
			NSString *_zzz = agentPortalPassword;
			NSString *_zzz2 = agentCode;
			id __weak weakself = self;
			id __weak weakself3 = self.storyboard;
			
			NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
								"ValidateLogin?strid=%@&strpwd=%@&strIPAddres=123&iBadAttempts=0&strFirstAgentCode=%@",
								[SIUtilities WSLogin],  _zz, _zzz, _zzz2];
			NSLog(@"%@", strURL);
			NSURL *url = [NSURL URLWithString:strURL];
			NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:3];
			
			AFXMLRequestOperation *operation =
			[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
																success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
																	XMLParser.delegate = weakself;
																	[XMLParser setShouldProcessNamespaces:YES];
																	[XMLParser parse];
																	
																} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
																	NSLog(@"error in calling web service");
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
																	
																	if (intStatus == 0) {
																		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agency Portal"
																														message:[NSString stringWithFormat:@"Your Account is suspended. Please contact Hong Leong Assurance."]
																													   delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
																		[alert show];
																		
																		alert = Nil;
																	}
																	else{
																		CarouselViewController *carouselMenu = [weakself3 instantiateViewControllerWithIdentifier:@"carouselView"];
																		carouselMenu.getInternet = @"No";
																		[weakself presentViewController:carouselMenu animated:YES completion:Nil];
																		[weakself updateDateLogin];
																	}
																	
																	
																}];


			[operation start];
			*/

			CarouselViewController *carouselMenu = [self.storyboard instantiateViewControllerWithIdentifier:@"carouselView"];
			carouselMenu.getInternet = @"No";
			[self presentViewController:carouselMenu animated:YES completion:Nil];
			[self updateDateLogin];
			
			/*
			internetReachableFoo.reachableBlock = ^(Reachability*reach)
			{

				// Update the UI on the main thread
				dispatch_async(dispatch_get_main_queue(), ^{
					NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
										"ValidateLogin?strid=%@&strpwd=%@&strIPAddres=123&iBadAttempts=0&strFirstAgentCode=%@",
										[SIUtilities WSLogin],  _zz, _zzz, _zzz2];
					NSLog(@"%@", strURL);
					NSURL *url = [NSURL URLWithString:strURL];
					NSURLRequest *request = [NSURLRequest requestWithURL:url];
					
					AFXMLRequestOperation *operation =
					[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
																		success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
																			
																			XMLParser.delegate = weakself;
																			[XMLParser setShouldProcessNamespaces:YES];
																			[XMLParser parse];
																			
																		} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
																			NSLog(@"error in calling web service");
																			CarouselViewController *carouselMenu = [weakself3 instantiateViewControllerWithIdentifier:@"carouselView"];
																			carouselMenu.getInternet = @"No";
																			[weakself presentViewController:carouselMenu animated:YES completion:Nil];
																			[weakself updateDateLogin];
																		}];
					
					[operation start];
					
				});
			};
			*/
			/*
			internetReachableFoo.unreachableBlock = ^(Reachability*reach)
			{
				// Update the UI on the main thread
				dispatch_async(dispatch_get_main_queue(), ^{
					CarouselViewController *carouselMenu = [weakself3 instantiateViewControllerWithIdentifier:@"carouselView"];
					carouselMenu.getInternet = @"No";
					[weakself presentViewController:carouselMenu animated:YES completion:Nil];
					[weakself updateDateLogin];

				});
			};
			
			[internetReachableFoo startNotifier];
			internetReachableFoo = nil;
			*/
			//-------- check end
			
			
            /*
            databasePath = Nil;
            RatesDatabasePath = Nil;
            zzz = Nil;
            //carouselMenu = Nil;
            contactDB = Nil;
            scrollViewLogin = Nil;
            activeField = Nil;
			 */
			//_zz = nil, _zzz = nil, _zzz2 = nil;
            
        }
		else if (statusLogin == 2){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Contact System Admin." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			
			alert = Nil;
		}

    }
    
}



- (IBAction)btnReset:(id)sender
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    sqlite3_stmt *statement2;
    sqlite3_stmt *statement3;
    
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET firstLogin = 1, agentPassword = \"password\" WHERE IndexNo=\"1\""];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSString *querySQL2 = [NSString stringWithFormat:@"DELETE from SecurityQuestion_Input "];
                if (sqlite3_prepare_v2(contactDB, [querySQL2 UTF8String], -1, &statement2, NULL) == SQLITE_OK)
                {
                    if (sqlite3_step(statement2) == SQLITE_DONE){
                        
                        NSString *querySQL3 = [NSString stringWithFormat:@"UPDATE Agent_Profile SET AgentCode = \"\", AgentName = \"\", "
                                               " AgentContactNo = \"\", ImmediateLeaderCode = \"\", ImmediateLeaderName = \"\", BusinessRegNumber = \"\", "
                                               " AgentEmail = \"\" "];
                        if (sqlite3_prepare_v2(contactDB, [querySQL3 UTF8String], -1, &statement3, NULL) == SQLITE_OK)
                        {
                            if (sqlite3_step(statement3) == SQLITE_DONE){
                                
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset"
                                                                                message:@"System has been restored to first time login mode" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                [alert show];
                                
                            }
                            
                            sqlite3_finalize(statement3);
                        }
                        
                    }
                    sqlite3_finalize(statement2);
                    
                }
                
                
            } else {
                NSLog(@"reset error");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
    
/*
	
	if(_delegate != Nil){
		[(ViewController *)_delegate setSss:1 ];
		[self dismissModalViewControllerAnimated:NO];
		[_delegate Dismiss:@""];
	}
 */
	 
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
	
	if([self.elementName isEqualToString:@"BadAttempts"]){
		
	}
	

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

	self.elementName = nil;
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	
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
			NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"1\" WHERE "
								  "AgentLoginID=\"hla\" "];
			
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
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agency Portal"
											message:[NSString stringWithFormat:@"Your Account is suspended. Please contact Hong Leong Assurance."]
											delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			[alert show];
			
			alert = Nil;
			
			sqlite3_stmt *statement;
			if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
			{
				NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"0\" WHERE "
									  "AgentLoginID=\"hla\" "];
				
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
		 */
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


@end
