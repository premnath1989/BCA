//
//  UserProfile.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "UserProfile.h"
#import "ChangePassword.h"
#import "SecurityQuestion.h"
#import "Login.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SIUtilities.h"

@interface UserProfile ()

@end

@implementation UserProfile
@synthesize outletCancel;
@synthesize outletSave;
@synthesize lblAgentLoginID,FirstTimeLogin;
@synthesize lblStatus;
@synthesize ScrollView;
@synthesize txtAgentCode;
@synthesize txtAgentName;
@synthesize txtAgentContactNo;
@synthesize txtLeaderCode;
@synthesize txtLeaderName;
@synthesize txtBizRegNo;
@synthesize txtEmail, ChangePwdPassword, ChangePwdUsername;
@synthesize email,leaderCode,leaderName,contactNo,code, username, name, registerNo, idRequest, indexNo;
@synthesize txtICNo,txtAddr1,txtAddr2,txtAddr3,btnContractDate;
@synthesize contDate,ICNo,Addr1,Addr2,Addr3,txtAgencyPortalLogin, txtAgencyPortalPwd;
@synthesize datePopover = _datePopover;
@synthesize DatePicker = _DatePicker;
@synthesize previousElementName, elementName;

id temp;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    outletSave.hidden = TRUE;
    if (FirstTimeLogin == 1) {
        //outletCancel.enabled = false;
    }
    else {
        AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
        
        self.indexNo = zzz.indexNo;
        self.idRequest = zzz.userRequest;
        
        //outletCancel.enabled = true;
    }
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    //NSLog(@"receive User:%@",[self.idRequest description]);
    //NSLog(@"receive Index:%d",self.indexNo);
    
    lblAgentLoginID.text = [NSString stringWithFormat:@"%@",[self.idRequest description]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation==UIInterfaceOrientationLandscapeLeft )
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
{

    if (FirstTimeLogin == 1) {
        if (alertView.tag == 1) {
            Login *LoginPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            LoginPage.modalPresentationStyle = UIModalPresentationFullScreen;
            LoginPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:LoginPage animated:YES ];
            
            //[self dismissModalViewControllerAnimated:YES];
            
        }
		else if (alertView.tag == 2 && buttonIndex == 0){
			UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success"
															  message:@"Registration successful! Please re-login with the new password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
			success.tag = 1;
			[success show];
		}
		else if (alertView.tag == 3){
			exit(0);
		}
    }
	
	
    
    /*
    else {
        [self updateUserData];
    }
     */
    /*
    if (alertView.tag == 1) {
        NSLog(@"dsadasdasdas");
        [self dismissModalViewControllerAnimated:YES ];
    }
     */
}

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.ScrollView.frame = CGRectMake(0, 44, 768, 704-352);
    self.ScrollView.contentSize = CGSizeMake(768, 605);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 10;
    [self.ScrollView scrollRectToVisible:textFieldRect animated:YES];
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.ScrollView.frame = CGRectMake(0, 44, 768, 704);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeField = textField;
    return YES;
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
        
    }else {
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
            [txtAgentContactNo becomeFirstResponder];
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
                                                            message:@"Email address is not in valid form" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                                                        message:@"Agency Portal Login ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtAgencyPortalLogin becomeFirstResponder];
        return FALSE;
    }
	
	if ([[txtAgencyPortalPwd.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Agency Portal Login Password is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtAgencyPortalPwd becomeFirstResponder];
        return FALSE;
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

- (IBAction)btnCancel:(id)sender
{
    //[self dismissModalViewControllerAnimated:YES ];
    [self.view endEditing:TRUE];
    [self resignFirstResponder];
    [self updateUserData ];
}

- (IBAction)btnSave:(id)sender
{
    [self.view endEditing:TRUE];
    [self resignFirstResponder];
    [self updateUserData ];
	
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


#pragma mark sqlite DB

-(void)viewExisting
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT IndexNo, AgentLoginID, AgentCode, AgentName, AgentContactNo, ImmediateLeaderCode, ImmediateLeaderName, BusinessRegNumber, AgentEmail, AgentICNo, AgentContractDate, AgentAddr1, AgentAddr2, AgentAddr3 FROM Agent_Profile WHERE IndexNo=\"%d\"",self.indexNo];
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
                
                txtAgentCode.text = code;
                txtAgentName.text = name;
                txtAgentContactNo.text = contactNo;
                txtLeaderCode.text = leaderCode;
                txtLeaderName.text = leaderName;
                txtBizRegNo.text = registerNo;
                txtEmail.text = email;
                
                txtICNo.text = ICNo;
                [btnContractDate setTitle:contDate forState:UIControlStateNormal];
                txtAddr1.text = Addr1;
                txtAddr2.text = Addr2;
                txtAddr3.text = Addr3;
                
                
                
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
        sqlite3_stmt *statement2;
        
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_Profile SET AgentCode= \"%@\", AgentName= \"%@\", "
								  "AgentContactNo= \"%@\", ImmediateLeaderCode= \"%@\", ImmediateLeaderName= \"%@\", "
								  "BusinessRegNumber = \"%@\", AgentEmail= \"%@\", AgentICNo=\"%@\", AgentContractDate=\"%@\", "
								  "AgentAddr1=\"%@\", AgentAddr2=\"%@\", AgentAddr3=\"%@\", AgentPortalLoginID = \"%@\", "
								  "AgentPortalPassword = \"%@\" WHERE IndexNo=\"%d\"",
								  txtAgentCode.text, txtAgentName.text, txtAgentContactNo.text, txtLeaderCode.text,
								  txtLeaderName.text,txtBizRegNo.text,txtEmail.text,txtICNo.text, contDate, txtAddr1.text,
								  txtAddr2.text, txtAddr3.text, txtAgencyPortalLogin.text, txtAgencyPortalPwd.text, self.indexNo];
            
            const char *query_stmt = [querySQL UTF8String];
            //NSLog(@"%@",querySQL);
            
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    if (FirstTimeLogin == 1) {
                        NSString *FinalSQL = [NSString stringWithFormat:@"UPDATE User_Profile SET AgentPassword= \"%@\", FirstLogin = 0 WHERE IndexNo=\"%d\"", self.ChangePwdPassword ,self.indexNo];
                        
                        
                        if (sqlite3_prepare_v2(contactDB, [FinalSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK){
                            
                            if (sqlite3_step(statement2) == SQLITE_DONE)
                            {
								
                                UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                                  message:@"Registration successful! Please re-login with the new password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
                                success.tag = 1;
                                [success show];
								 
                            }
                            
                            sqlite3_finalize(statement2);
                        }
                    }
                    else {
                        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                          message:@"Record Saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
                        success.tag = 1;
                        [success show];
                    }
                    
                } else {
                    lblStatus.text = @"Failed to update!";
                    lblStatus.textColor = [UIColor redColor];
                    
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(contactDB);
        }
		//[self CheckAgentPortal];
    }
}

-(void)CheckAgentPortal{
	NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
						"ValidateLogin?strid=%@&strpwd=%@&strIPAddres=123&iBadAttempts=0&strFirstAgentCode=%@",
					   	[SIUtilities WSLogin], txtAgencyPortalLogin.text, txtAgencyPortalPwd.text, txtAgentCode.text];
	
	NSLog(@"%@", strURL);
	NSURL *url = [NSURL URLWithString:strURL];
	NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10];
	
	AFXMLRequestOperation *operation =
	[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
														success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
															XMLParser.delegate = self;
															[XMLParser setShouldProcessNamespaces:YES];
															[XMLParser parse];
															
														} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
															/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
																			message:@"Error in connecting to web service. Do you want to skip this process ?"
																			delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
															
															alert.tag = 2;
															[alert show];
															
															alert = Nil;
															 */
															UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success"
																											  message:@"Registration successful! Please re-login with the new password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
															success.tag = 1;
															[success show];
															NSLog(@"error in connecting to web service");
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
															  message:@"Registration successful! Please re-login with the new password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
			success.tag = 1;
			[success show];
			
		}
		else{
			/*
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agent Portal"
									message:[string stringByAppendingFormat:@". Do you want to skip this process ?" ]
									delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil ];

			alert.tag = 2;
			
			[alert show];
			*/
			if([string isEqualToString:@"Account suspended."]){
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agent Portal"
																  message:@"Account suspended. Please Contact Hong Leong Assurance." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
				alert.tag = 3;

				//reset back to first time login
				sqlite3_stmt *statement2;
				if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
				{
					if (FirstTimeLogin == 1) {
						NSString *FinalSQL = [NSString stringWithFormat:@"UPDATE User_Profile SET FirstLogin = 1, AgentCode = \"\", AgentName = \"\", "
											  "AgentEmail = \"\"  WHERE IndexNo=\"%d\"", self.indexNo];
								
							if (sqlite3_prepare_v2(contactDB, [FinalSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK){
									
								if (sqlite3_step(statement2) == SQLITE_DONE)
								{

								}
									
								sqlite3_finalize(statement2);
							}
					}
					
					sqlite3_close(contactDB);
				}
				
				[alert show];
			}
			else{ // for incorrect id or password
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agency Portal"
															message:[NSString stringWithFormat:@"%@", string]
															   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
				//success.tag = 1;
				
				//reset back to first time login
				sqlite3_stmt *statement2;
				if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
				{
					if (FirstTimeLogin == 1) {
						NSString *FinalSQL = [NSString stringWithFormat:@"UPDATE User_Profile SET FirstLogin = 1 WHERE IndexNo=\"%d\"", self.indexNo];
						
						if (sqlite3_prepare_v2(contactDB, [FinalSQL UTF8String], -1, &statement2, NULL) == SQLITE_OK){
							
							if (sqlite3_step(statement2) == SQLITE_DONE)
							{
								
							}
							
							sqlite3_finalize(statement2);
						}
					}
					
					sqlite3_close(contactDB);
				}
				[alert show];
			}
			
		}
		
	}
	
	else if([self.elementName isEqualToString:@"BadAttempts"]){
		
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	self.elementName = nil;
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
	
	
	
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
    [self setScrollView:nil];
    [self setTxtAgentCode:nil];
    [self setTxtAgentName:nil];
    [self setTxtAgentContactNo:nil];
    [self setTxtLeaderCode:nil];
    [self setTxtLeaderName:nil];
    [self setLblAgentLoginID:nil];
    [self setLblStatus:nil];
    [self setOutletCancel:nil];
    [self setTxtBizRegNo:nil];
    [self setTxtEmail:nil];
    [self setOutletSave:nil];
	[self setTxtAgencyPortalLogin:nil];
	[self setTxtAgencyPortalPwd:nil];
    [super viewDidUnload];
}
@end
