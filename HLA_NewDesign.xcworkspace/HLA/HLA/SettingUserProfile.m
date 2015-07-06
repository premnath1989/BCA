//
//  SettingUserProfile.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 11/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SettingUserProfile.h"
#import "Login.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SIUtilities.h"

@interface SettingUserProfile ()

@end

@implementation SettingUserProfile
@synthesize outletSave;
@synthesize lblAgentLoginID, username, code, name, contactNo ;
@synthesize txtAgentCode, leaderCode, leaderName, registerNo, email;
@synthesize txtAgentName, idRequest, indexNo;
@synthesize txtAgentContactNo;
@synthesize txtLeaderCode;
@synthesize txtLeaderName;
@synthesize txtEmail;
@synthesize txtBixRegNo;
@synthesize txtICNo,txtAddr1,txtAddr2,txtAddr3,btnContractDate,myScrollView;
@synthesize contDate,ICNo,Addr1,Addr2,Addr3,txtAgencyPortalLogin, txtAgencyPortalPwd, AgentPortalLoginID, AgentPortalPassword;
@synthesize datePopover = _datePopover;
@synthesize DatePicker = _DatePicker;
@synthesize previousElementName, elementName, getLatest;


id temp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    self.indexNo = zzz.indexNo;
    self.idRequest = zzz.userRequest;
        
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    //NSLog(@"receive User:%@",[self.idRequest description]);
    //NSLog(@"receive Index:%d",self.indexNo);
    
    outletSave.hidden = YES;
    lblAgentLoginID.text = [NSString stringWithFormat:@"%@",[self.idRequest description]];
    
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
    [self viewExisting];
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

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{   /*
        if (alertView.tag == 1) {
            Login *LoginPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            LoginPage.modalPresentationStyle = UIModalPresentationFullScreen;
            LoginPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:LoginPage animated:YES ];
            
            [self dismissModalViewControllerAnimated:YES];
            
        }
     */
	        if (alertView.tag == 1) {
				if ([getLatest isEqualToString:@"Yes"]) { //not need check latest version when user edit on user profile
					NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
										"GetSIVersion_TRADUL?Type=IPAD_TRAD&Remarks=Agency&OSType=32", [SIUtilities WSLogin]];
					NSLog(@"%@", strURL);
					NSURL *url = [NSURL URLWithString:strURL];
					NSURLRequest *request = [NSURLRequest requestWithURL:url];
					
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
				
			}
			else if (alertView.tag == 2 && buttonIndex == 0){
				//download latest version
				[[UIApplication sharedApplication] openURL:[NSURL URLWithString:
									@"http://www.hla.com.my/agencyportal/includes/DLrotate2.asp?file=iMP/iMP.plist"]];
				
			}
			else if (alertView.tag == 3){
				exit(0);
			}
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeField = textField;
    return YES;
}

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 44, 768, 704-352);
    self.myScrollView.contentSize = CGSizeMake(768, 605);
    
	if ([txtAgencyPortalLogin isFirstResponder]) {
		activeField = txtAgencyPortalLogin;
	}
	if ([txtAgencyPortalPwd isFirstResponder]) {
		activeField = txtAgencyPortalPwd;
	}
	
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 30;
	
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
    activeField = nil;
	activeField = [[UITextField alloc] init ];

}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 44, 768, 704);
}


#pragma mark - validation

-(BOOL) Validation
{
    
    if ([txtAgentCode.text isEqualToString:@""] || [txtAgentCode.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agent Code is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtAgentCode becomeFirstResponder];
        return FALSE;
        
    }
    else {
        if (txtAgentCode.text.length != 8) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Invalid Agent Code length. Agent Code length should be exact 8 characters long"
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        
            [txtAgentCode becomeFirstResponder];
            return FALSE;
        }
        
    }
    
    if ([txtAgentName.text isEqualToString:@""] || [txtAgentName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length == 0 ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agent Name is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtAgentName becomeFirstResponder];
        return FALSE;
        
        
    }
    else {
        
        BOOL valid;
        NSString *strToBeTest = [txtAgentName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] ;
        
        for (int i=0; i<strToBeTest.length; i++) {
            int str1=(int)[strToBeTest characterAtIndex:i];
            
            if((str1 >96 && str1 <123)  || (str1 >64 && str1 <91)){
                valid = TRUE;
                
            }else {
                valid = FALSE;
                break;
            }
        }
        if (!valid) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Agent name is not valid" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtAgentName becomeFirstResponder];
            return false;
        }
    }
    
    if(![[txtAgentContactNo.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"" ]){
        if (txtAgentContactNo.text.length > 11) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Contact number length must be less than 11 digits" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [txtAgentContactNo becomeFirstResponder ];
            return false;
        }
        
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtAgentContactNo.text];
        valid = [alphaNums isSupersetOfSet:inStringSet]; 
        if (!valid) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Contact number must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [txtAgentContactNo becomeFirstResponder];
            return false;
        }
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agent's Contact No is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtAgentContactNo becomeFirstResponder];
        return false;
    }
    
    if (![[txtLeaderCode.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        if (txtLeaderCode.text.length != 8) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid Immediate Leader Code length. Immediate Leader Code length should be 8 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtLeaderCode becomeFirstResponder];
            return false;
        }
    }
    
    
    //new
    if (![[txtICNo.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        if (txtICNo.text.length != 12) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Invalid IC No length. IC No length should be 12 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtICNo becomeFirstResponder];
            return false;
        }
        
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtICNo.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (!valid) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Agent's IC No must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [txtICNo becomeFirstResponder];
            return false;
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agent's IC No is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtICNo becomeFirstResponder];
        return false;
    }
    
    if (contDate.length == 0 || [self.btnContractDate.titleLabel.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agent's Contract Date is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return false;
    }
    
    if ([[txtAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agent's Correspendence Address is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtAddr1 becomeFirstResponder];
        return false;
    }
    //end
    
    if (![[txtEmail.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        if( [self NSStringIsValidEmail:txtEmail.text] == FALSE ){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"You have entered an invalid email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            [txtEmail becomeFirstResponder];
            return FALSE;
        }
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Email is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtEmail becomeFirstResponder];
        return FALSE;
    }
    
	if ([[txtAgencyPortalLogin.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agent Portal Login ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtAgencyPortalLogin becomeFirstResponder];
        return false;
    }
	
	if ([[txtAgencyPortalPwd.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agent Portal Login Password is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtAgencyPortalPwd becomeFirstResponder];
        return false;
    }
	
    return TRUE;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; 
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


#pragma mark - action

- (IBAction)btnClose:(id)sender
{
    [self dismissModalViewControllerAnimated:YES ];
}

- (IBAction)btnSave:(id)sender {
    [self.view endEditing:TRUE];
    [self resignFirstResponder];
    [self updateUserData ];
}

- (IBAction)btnDone:(id)sender {
    [self.view endEditing:TRUE];
    [self resignFirstResponder];
    [self updateUserData ];
	//[self CheckAgentPortal];
}

- (IBAction)btnContractDatePressed:(id)sender     //--bob
{
    [self.view endEditing:TRUE];
    [self resignFirstResponder];
    
    if (contDate.length==0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
        
        [btnContractDate setTitle:dateString forState:UIControlStateNormal];
        temp = btnContractDate.titleLabel.text;
    }
    else {
        temp = btnContractDate.titleLabel.text;
    }
    contDate = temp;
    
    if (_DatePicker == Nil) {
        
        self.DatePicker = [self.storyboard instantiateViewControllerWithIdentifier:@"showDate"];
        _DatePicker.delegate = self;
        _DatePicker.msgDate = temp;
        self.datePopover = [[UIPopoverController alloc] initWithContentViewController:_DatePicker];
    }
    
    [self.datePopover setPopoverContentSize:CGSizeMake(300.0f, 255.0f)];
    [self.datePopover presentPopoverFromRect:[sender frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
}

-(void)datePick:(DateViewController *)inController strDate:(NSString *)aDate strAge:(NSString *)aAge intAge:(int)bAge intANB:(int)aANB
{
    if (aDate == NULL) {
        [btnContractDate setTitle:temp forState:UIControlStateNormal];
        contDate = temp;
    }
    else {
        [self.btnContractDate setTitle:aDate forState:UIControlStateNormal];
        contDate = aDate;
    }
    NSLog(@"date:%@",contDate);
    
    [self.datePopover dismissPopoverAnimated:YES];
}

-(void)CheckAgentPortal{
	NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
									"ValidateLogin?strid=%@&strpwd=%@&strIPAddres=123&iBadAttempts=0&strFirstAgentCode=%@",
						[SIUtilities WSLogin], txtAgencyPortalLogin.text, txtAgencyPortalPwd.text, txtAgentCode.text];
	
		NSLog(@"%@", strURL);
		NSURL *url = [NSURL URLWithString:strURL];
		NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:5];
	
		AFXMLRequestOperation *operation =
		[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
		 													success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
			 													XMLParser.delegate = self;
			 														[XMLParser setShouldProcessNamespaces:YES];
			 														[XMLParser parse];
			 
			 													} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
				 													NSLog(@"error in calling web service");
																	UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success"
																													  message:@"Record Saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
																	success.tag = 1;
																	[success show];
																}];
		
		[operation start];
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
			UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success"
															  message:@"Record Saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
			success.tag = 1;
			[success show];
			
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
		else if ([string isEqualToString:@"Account suspended."]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agency Portal"
															message:[NSString stringWithFormat:@"Your Account is suspended. Please contact Hong Leong Assurance."]
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			alert.tag = 3;
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
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agent Portal"
									message:string delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
			
			[alert show];
			
		}
		
	}
	
	else if([self.elementName isEqualToString:@"BadAttempts"]){
		
	}
	
	else if([self.elementName isEqualToString:@"string"]){
		
		NSString *strURL = [NSString stringWithFormat:@"%@",  string];
		NSLog(@"%@", strURL);
		NSURL *url = [NSURL URLWithString:strURL];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		
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
		
		if (![string isEqualToString:AppsVersion]) {
				NSLog(@"latest version is available %@", AppsVersion);
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Latest Version"
															message:[NSString stringWithFormat:@"Latest version is available for download. Do you want to download now ? "]
														   delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
			alert.tag = 2;
			[alert show];
			
			alert = Nil;
		}
		NSLog(@"%@", string);
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

#pragma mark - sqlite DB

-(void)viewExisting
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT IndexNo, AgentLoginID, AgentCode, AgentName, AgentContactNo, "
							  "ImmediateLeaderCode, ImmediateLeaderName, BusinessRegNumber, AgentEmail, AgentICNo, "
							  "AgentContractDate, AgentAddr1, AgentAddr2, AgentAddr3, AgentPortalLoginID, AgentPortalPassword "
							  "FROM Agent_Profile WHERE IndexNo=\"%d\"",
							  self.indexNo];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                username = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                
                const char *code2 = (const char*)sqlite3_column_text(statement, 2);
                code = code2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:code2];
                
                const char *name2 = (const char*)sqlite3_column_text(statement, 3);
                name = name2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:name2];
                
                const char *contactNo2 = (const char*)sqlite3_column_text(statement, 4);
                contactNo = contactNo2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:contactNo2];
                
                const char *leaderCode2 = (const char*)sqlite3_column_text(statement, 5);
                leaderCode = leaderCode2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:leaderCode2];
                
                const char *leaderName2 = (const char*)sqlite3_column_text(statement, 6);
                leaderName = leaderName2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:leaderName2];
                
                const char *register2 = (const char*)sqlite3_column_text(statement, 7);
                registerNo = register2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:register2];
                
                const char *email2 = (const char*)sqlite3_column_text(statement, 8);
                email = email2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:email2];
                
                const char *ic = (const char*)sqlite3_column_text(statement, 9);
                ICNo = ic == NULL ? @"" : [[NSString alloc] initWithUTF8String:ic];
                
                const char *date = (const char*)sqlite3_column_text(statement, 10);
                contDate = date == NULL ? @"" : [[NSString alloc] initWithUTF8String:date];
                
                const char *add1 = (const char*)sqlite3_column_text(statement, 11);
                Addr1 = add1 == NULL ? @"" : [[NSString alloc] initWithUTF8String:add1];
                
                const char *add2 = (const char*)sqlite3_column_text(statement, 12);
                Addr2 = add2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:add2];
                
                const char *add3 = (const char*)sqlite3_column_text(statement, 13);
                Addr3 = add3 == NULL ? @"" : [[NSString alloc] initWithUTF8String:add3];
                
				const char *temp1 = (const char*)sqlite3_column_text(statement, 14);
                AgentPortalLoginID = temp1 == NULL ? @"" : [[NSString alloc] initWithUTF8String:temp1];
                
				const char *temp2 = (const char*)sqlite3_column_text(statement, 15);
                AgentPortalPassword = temp2 == NULL ? @"" : [[NSString alloc] initWithUTF8String:temp2];
                
				
                txtAgentCode.text = code;
                txtAgentName.text = name;
                txtAgentContactNo.text = contactNo;
                txtLeaderCode.text = leaderCode;
                txtLeaderName.text = leaderName;
                txtBixRegNo.text = registerNo;
                txtEmail.text = email;
                
                txtICNo.text = ICNo;
                [btnContractDate setTitle:contDate forState:UIControlStateNormal];
                txtAddr1.text = Addr1;
                txtAddr2.text = Addr2;
                txtAddr3.text = Addr3;
                txtAgencyPortalLogin.text = AgentPortalLoginID;
				txtAgencyPortalPwd.text = AgentPortalPassword;
                
                
            } else {
                NSLog(@"Failed!");
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)updateUserData
{
    if([self Validation] == TRUE){
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt *statement;
        
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            
            NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_Profile SET AgentCode= \"%@\", AgentName= \"%@\", "
								  "AgentContactNo= \"%@\", ImmediateLeaderCode= \"%@\", ImmediateLeaderName= \"%@\", "
								  "BusinessRegNumber = \"%@\", AgentEmail= \"%@\", AgentICNo=\"%@\", AgentContractDate=\"%@\", "
								  "AgentAddr1=\"%@\", AgentAddr2=\"%@\", AgentAddr3=\"%@\", AgentPortalLoginID = \"%@\", "
								  "AgentPortalPassword = \"%@\" WHERE IndexNo=\"%d\"",
								  txtAgentCode.text, txtAgentName.text, txtAgentContactNo.text, txtLeaderCode.text,
								  txtLeaderName.text,txtBixRegNo.text,txtEmail.text,txtICNo.text, contDate, txtAddr1.text,
								  txtAddr2.text, txtAddr3.text, txtAgencyPortalLogin.text, txtAgencyPortalPwd.text, self.indexNo];
            
            
            const char *query_stmt = [querySQL UTF8String];
            
            //NSLog(@"%@",querySQL);
            
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    
                    UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                      message:@"Record Saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
                    success.tag = 1;
                    [success show];
					 
                    
                } else {
                    //lblStatus.text = @"Failed to update!";
                    //lblStatus.textColor = [UIColor redColor];
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
		
		//[self CheckAgentPortal];
    }
}


#pragma mark - memory release

- (void)viewDidUnload
{
    [self setAddr1:nil];
    [self setAddr2:nil];
    [self setAddr3:nil];
    [self setContDate:nil];
    [self setICNo:nil];
    [self setTxtAddr1:nil];
    [self setTxtAddr2:nil];
    [self setTxtAddr3:nil];
    [self setTxtICNo:nil];
    [self setBtnContractDate:nil];
    [self setMyScrollView:nil];
    [self setLblAgentLoginID:nil];
    [self setTxtAgentCode:nil];
    [self setTxtAgentName:nil];
    [self setTxtAgentContactNo:nil];
    [self setTxtLeaderCode:nil];
    [self setTxtLeaderName:nil];
    [self setTxtBixRegNo:nil];
    [self setTxtEmail:nil];
    [self setOutletSave:nil];
	[self setTxtAgencyPortalLogin:nil];
	[self setTxtAgencyPortalPwd:nil];
    [super viewDidUnload];
}

@end
