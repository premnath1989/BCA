//
//  SettingUserProfile.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 11/16/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SettingUserProfileReg.h"
#import "Login.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SIUtilities.h"
#import "StoreVarFirstTimeReg.h"
#import "ColorHexCode.h"

@interface SettingUserProfileReg ()

@end

@implementation SettingUserProfileReg
@synthesize outletSave;
@synthesize lblAgentLoginID, username, code, name, contactNo,txtAgentId ;
@synthesize txtAgentCode, leaderCode, leaderName, registerNo, email;
@synthesize txtAgentName, idRequest, indexNo;
@synthesize txtAgentContactNo;
@synthesize txtLeaderCode;
@synthesize txtLeaderName;
@synthesize txtEmail;
@synthesize txtBixRegNo,txtContractDate;
@synthesize txtICNo,txtAddr1,txtAddr2,txtAddr3,btnContractDate,myScrollView;
@synthesize contDate,ICNo,Addr1,Addr2,Addr3,txtAgencyPortalLogin, txtAgencyPortalPwd, AgentPortalLoginID, AgentPortalPassword, AgentAddrPostcode, AgentContactNumber;
@synthesize datePopover = _datePopover;
@synthesize DatePicker = _DatePicker;
@synthesize previousElementName, elementName, getLatest;
@synthesize txtHomePostCode;
@synthesize txtHomeTown;
@synthesize txtHomeState;
@synthesize txtHomeCountry;
@synthesize SelectedStateCode;


id temp;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    self.indexNo = zzz.indexNo;
    self.idRequest = zzz.userRequest;
    
    self.indexNo = 1;
    
    [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    txtHomeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtHomeTown setTextColor:[UIColor grayColor]];
    txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtHomeState setTextColor:[UIColor grayColor]];
    txtHomeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtHomeCountry setTextColor:[UIColor grayColor]];
	
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    
    [self checkExisting];
    
    [self setStates];
    [self populateFields];
    
    outletSave.hidden = YES;
	txtAddr1.delegate = self;
	txtAddr2.delegate = self;
	txtAddr3.delegate = self;
    //lblAgentLoginID.text = [NSString stringWithFormat:@"%@",[self.idRequest description]];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
    
}

-(void) checkExisting
{
    StoreVarFirstTimeReg *storeVar = [StoreVarFirstTimeReg sharedInstance];
    
    if( [storeVar.agentLogin isEqualToString:@""] )
    {
        [self viewExisting];
        isFromFirstTime = FALSE;
    }else
    {
        isFromFirstTime = TRUE;
    }
}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}

-(void) setStates
{
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
	
    txtHomePostCode.text = @"";
    txtHomeTown.text = @"";
    txtHomeState.text = @"";
    txtHomeCountry.text = @"MALAYSIA";
    txtHomeTown.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtHomeTown setTextColor:[UIColor grayColor]];
    txtHomeState.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtHomeState setTextColor:[UIColor grayColor]];
    txtHomeCountry.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtHomeCountry setTextColor:[UIColor grayColor]];
    
    txtHomeTown.enabled = NO;
    txtHomeState.enabled = NO;
    txtHomeCountry.hidden = NO;
    
    [txtHomePostCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [txtHomePostCode addTarget:self action:@selector(EditTextFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
}


-(void)textFieldDidChange:(id) sender
{
    [self getPostcodeData];
}

-(void)getPostcodeData
{
    BOOL gotRow = false;
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    txtHomePostCode.text = [txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    /*
    if ([txtHomePostCode.text isEqualToString:@""]) {
        [self hideKeyboard];
        rrr = [[UIAlertView alloc] initWithTitle:@" "
                                         message:@"Postcode is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        rrr.tag = 12;
        [rrr show];
        return;
    }*/
    
    
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    if (!valid) {
        [self hideKeyboard];
        rrr = [[UIAlertView alloc] initWithTitle:@" "
                                         message:@"Postcode must be in numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        rrr.tag = 12;
        [rrr show];
        
        
        txtHomePostCode.text = @"";
        txtHomeState.text = @"";
        txtHomeTown.text = @"";
        txtHomeCountry.text = @"";
        SelectedStateCode = @"";
        PostcodeCont = FALSE;
        
    }
    else {
        if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK){
            NSString *querySQL = [NSString stringWithFormat:@"SELECT \"Town\", \"Statedesc\", b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = %@ ", txtHomePostCode.text];
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                
                while (sqlite3_step(statement) == SQLITE_ROW){
                    NSString *Town = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    NSString *State = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    NSString *Statecode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                    
                    txtHomeState.text = State;
                    txtHomeTown.text = Town;
                    txtHomeCountry.text = @"MALAYSIA";
                    SelectedStateCode = Statecode;
                    gotRow = true;
                    PostcodeCont = TRUE;
                    self.navigationItem.rightBarButtonItem.enabled = TRUE;
                }
                sqlite3_finalize(statement);
            }
            
            if (gotRow == false) {
                [self hideKeyboard];
                rrr = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid Postcode"
                                                delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                
                //rrr.tag = 12;
                [rrr show];
                
                txtHomePostCode.text = @"";
                txtHomeState.text = @"";
                txtHomeTown.text = @"";
                txtHomeCountry.text = @"";
                SelectedStateCode = @"";
                
                PostcodeCont = FALSE;
            }
            
            sqlite3_close(contactDB);
        }
        
    }
}

-(void) populateFields
{
    StoreVarFirstTimeReg *storeVar = [StoreVarFirstTimeReg sharedInstance];
    
    if( [storeVar.agentLogin isEqualToString:@""] )
    {
        //get from db
        
    }
    
    //lblAgentLoginID.text = storeVar.agentLogin;
    txtAgentId.text = storeVar.agentLogin;
    txtAgentCode.text = storeVar.agentCode;
    txtAgentName.text = storeVar.agentName;
    txtAgentContactNo.text = storeVar.agentContactNumber;
    txtICNo.text = storeVar.icNo;
    //txtICNo.text = @"841155062365"; //for testing
    txtEmail.text = storeVar.email;
    txtAddr1.text = storeVar.address1;
    txtAddr2.text = storeVar.address2;
    txtAddr3.text = storeVar.address3;
    txtLeaderCode.text = storeVar.leaderCode;
    txtLeaderName.text = storeVar.leaderName;
    //btnContractDate.titleLabel.text = storeVar.contractDate;
    txtContractDate.text = storeVar.contractDate;
    txtHomePostCode.text = storeVar.postalCode;
    /*
	 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	 [dateFormatter setDateFormat:@"yyyy-mm-dd"];
	 NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
	 */
    [btnContractDate setTitle:storeVar.contractDate forState:UIControlStateNormal];
    contDate = storeVar.contractDate;
    
    txtAgentId.enabled = NO;
    txtAgentCode.enabled = NO;
    txtAgentName.enabled = NO;
    txtLeaderCode.enabled = NO;
    txtLeaderName.enabled = NO;
    self.btnContractDate.enabled = NO;
    txtICNo.enabled = NO;
    txtContractDate.enabled = NO;
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    
    txtAgentId.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtAgentId setTextColor:[UIColor grayColor]];
    txtAgentCode.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtAgentCode setTextColor:[UIColor grayColor]];
    txtAgentName.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtAgentName setTextColor:[UIColor grayColor]];
    txtLeaderCode.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtLeaderCode setTextColor:[UIColor grayColor]];
    txtLeaderName.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtLeaderName setTextColor:[UIColor grayColor]];
    //self.btnContractDate.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    txtICNo.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtICNo setTextColor:[UIColor grayColor]];
    txtContractDate.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtContractDate setTextColor:[UIColor grayColor]];
    
    [btnContractDate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal]; 
    
    [self getPostcodeData];
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

-(void)EditTextFieldBegin:(id)sender
{
    self.navigationItem.rightBarButtonItem.enabled = FALSE;
}

///* added by Edwin for new device registration*/
//-(void)setFirstDevice
//{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    [defaults setObject:[NSNumber numberWithInt:1] forKey:@"isFirstDevice"];
//    
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}

-(void) setFirstLogin
{
    sqlite3_stmt *statement;
    if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"1\" WHERE "
        //"AgentLoginID=\"hla\" "];
        NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set FirstLogin = \"0\" "];
        
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

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (alertView.tag == 1) {
        
        if( isFromFirstTime )
        {
            [Login setFirstDevice];
            [self setFirstLogin];
            
            Login *LoginPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            LoginPage.modalPresentationStyle = UIModalPresentationFullScreen;
            LoginPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:LoginPage animated:YES ];
            
            [self dismissModalViewControllerAnimated:YES];
		}else
        {
            [self dismissModalViewControllerAnimated:YES ];
        }
            
		
	}else
		
    /*
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
	 else */
		if (alertView.tag == 2 && buttonIndex == 0){
			//download latest version
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:
														@"http://www.hla.com.my/agencyportal/includes/DLrotate2.asp?file=iMP/iMP.plist"]];
			
		}
		else if (alertView.tag == 3){
			exit(0);
		}else
        if ( alertView.tag == 10 )
        {
            [txtAgentContactNo becomeFirstResponder ];
        }else
        if ( alertView.tag == 11 )
        {
            [txtAgentContactNo becomeFirstResponder];
        }else
        if ( alertView.tag == 12 )
        {
            [txtHomePostCode becomeFirstResponder];
            [myScrollView setContentOffset:CGPointMake(0, 130) animated:YES];
        }else
        if ( alertView.tag == 13 )
        {
            [txtAddr1 becomeFirstResponder];
            [myScrollView setContentOffset:CGPointMake(0, 130) animated:YES];
        }else
        if ( alertView.tag == 14 )
        {
            [txtEmail becomeFirstResponder];
            [myScrollView setContentOffset:CGPointMake(0, 230) animated:YES];
        }
        
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if (string.length == 0) {
		return YES;
	}
	
	if (textField == txtAddr1 || textField == txtAddr2 || textField == txtAddr3 ) {
		if ([textField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length > 31) {
			return NO;
		}
		else{
			return YES;
		}
	}
	else{
		return YES;
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
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Agent Code is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        [txtAgentCode becomeFirstResponder];
        return FALSE;
        
    }
    else {
        if (txtAgentCode.text.length != 8) {
            [self hideKeyboard];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:@"Invalid Agent Code length. Agent Code length should be exact 8 characters long"
														   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
			
            [txtAgentCode becomeFirstResponder];
            return FALSE;
        }
        
    }
    
    if ([txtAgentName.text isEqualToString:@""] || [txtAgentName.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length == 0 ) {
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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
            [self hideKeyboard];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Agent name is not valid" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtAgentName becomeFirstResponder];
            return false;
        }
    }
    
    if(![[txtAgentContactNo.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"" ]){
        if (txtAgentContactNo.text.length > 11) {
            [self hideKeyboard];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Contact number length must be less than 11 digits" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 10;
            [alert show];
            
            return false;
        }
        
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtAgentContactNo.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (!valid) {
            [self hideKeyboard];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Contact number must be numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 10;
            [alert show];
            
            return false;
        }
        
    }
    else {
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Agent's Contact No is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 11;
        [alert show];
        return false;
    }
    
    
    if(![[txtHomePostCode.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@"" ]){       
        BOOL valid;
        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtAgentContactNo.text];
        valid = [alphaNums isSupersetOfSet:inStringSet];
        if (!valid) {
            [self hideKeyboard];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Postcode must be numeric" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 12;
            [alert show];
            
            return false;
        }
        
    }
    else {
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Postcode is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 12;
        [alert show];
        return false;
    }
    
    if (![[txtLeaderCode.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        if (txtLeaderCode.text.length != 8) {
            [self hideKeyboard];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"Invalid Immediate Leader Code length. Immediate Leader Code length should be 8 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtLeaderCode becomeFirstResponder];
            return false;
        }
    }
    
    
    //new
//    if (![[txtICNo.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
//        if (txtICNo.text.length != 12) {
//            [self hideKeyboard];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                            message:@"Invalid IC No length. IC No length should be 12 characters long" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            [txtICNo becomeFirstResponder];
//            return false;
//        }
//        
//        BOOL valid;
//        NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
//        NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:txtICNo.text];
//        valid = [alphaNums isSupersetOfSet:inStringSet];
//        if (!valid) {
//            [self hideKeyboard];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                            message:@"Agent's IC No must be numeric" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            
//            [txtICNo becomeFirstResponder];
//            return false;
//        }
//    }
//    else {
//        [self hideKeyboard];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
//                                                        message:@"Agent's IC No is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        [txtICNo becomeFirstResponder];
//        return false;
//    }
    
    if (contDate.length == 0 || [self.txtContractDate.text isEqualToString:@""]) {
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Agent's Contract Date is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return false;
    }
    
    if ([[txtAddr1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Agent's Correspendence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 13;
        [alert show];
        
        return false;
    }
    //end
    
    if (![[txtEmail.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
        if( [self NSStringIsValidEmail:txtEmail.text] == FALSE ){
            [self hideKeyboard];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                            message:@"You have entered an invalid email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 14;
            [alert show];
            
            
            return FALSE;
        }
        
    }
    else {
        [self hideKeyboard];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                        message:@"Email is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 14;
        [alert show];
        
        return FALSE;
    }
    
    /*
	 if ([[txtAgencyPortalLogin.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
	 message:@"Agent Portal Login ID is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [alert show];
	 [txtAgencyPortalLogin becomeFirstResponder];
	 return false;
	 }
	 
	 if ([[txtAgencyPortalPwd.text stringByReplacingOccurrencesOfString:@" " withString:@"" ] isEqualToString:@""]) {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
	 message:@"Agent Portal Login Password is required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
	 [alert show];
	 [txtAgencyPortalPwd becomeFirstResponder];
	 return false;
	 }*/
	
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

- (IBAction)btnBack:(id)sender {
    [self dismissModalViewControllerAnimated:NO];
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
	NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20];
	
	AFXMLRequestOperation *operation =
	[AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
														success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
															XMLParser.delegate = self;
															[XMLParser setShouldProcessNamespaces:YES];
															[XMLParser parse];
															
														} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
															NSLog(@"error in calling web service");
															UIAlertView *success = [[UIAlertView alloc] initWithTitle:@" "
																											  message:@"Record Saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
															success.tag = 1;
															[success show];
														}];
	
	[operation start];
}

-(void) activateDevice{
    NSString *strURL = [NSString stringWithFormat:@"%@eSubmissionWS/eSubmissionXMLService.asmx/"
                        "ActivateDevice?Input1=%@&Input2=%@",
						[SIUtilities WSLogin], txtAgentCode.text, txtAgencyPortalPwd.text];
	
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
                                                            UIAlertView *success = [[UIAlertView alloc] initWithTitle:@" "
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
			UIAlertView *success = [[UIAlertView alloc] initWithTitle:@" "
															  message:@"Record Saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
			success.tag = 1;
			[success show];
			
			sqlite3_stmt *statement;
			if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
			{
				//NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"1\" WHERE "
				//"AgentLoginID=\"hla\" "];
                NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"1\" "];
				
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
            [self hideKeyboard];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
															message:[NSString stringWithFormat:@"Your Account is suspended. Please contact Hong Leong Assurance."]
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
			alert.tag = 3;
			[alert show];
			
			alert = Nil;
			
			sqlite3_stmt *statement;
			if (sqlite3_open([databasePath UTF8String ], &contactDB) == SQLITE_OK)
			{
				NSString *querySQL = [NSString stringWithFormat: @"UPDATE Agent_Profile set AgentStatus = \"0\" WHERE "
									  "AgentLoginID=\"hla\" "];
               /* NSString *querySQL = [NSString stringWithFormat: @"UPDATE User_Profile set AgentStatus = \"0\" WHERE "
									  "AgentLoginID=\"hla\" "];*/
				
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
            [self hideKeyboard];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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
            [self hideKeyboard];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
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
							  "AgentContractDate, AgentAddr1, AgentAddr2, AgentAddr3, AgentPortalLoginID, AgentPortalPassword, "
                              "AgentAddrPostcode, AgentContactNumber "
							  "FROM Agent_Profile WHERE IndexNo=1"];
        NSLog(querySQL);
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
                
                const char *addrPostcode = (const char*)sqlite3_column_text(statement, 16);
                AgentAddrPostcode = addrPostcode == NULL ? @"" : [[NSString alloc] initWithUTF8String:addrPostcode];
                
                const char *agentContactNumber = (const char*)sqlite3_column_text(statement, 17);
                AgentContactNumber = agentContactNumber == NULL ? @"" : [[NSString alloc] initWithUTF8String:agentContactNumber];
                
				StoreVarFirstTimeReg *storeVar = [StoreVarFirstTimeReg sharedInstance];
                
                storeVar.agentLogin = username;
                storeVar.agentCode = code;
                storeVar.agentName = name;
                storeVar.icNo = ICNo;
                storeVar.email = email;
                storeVar.address1 = Addr1;
                storeVar.address2 = Addr2;
                storeVar.address3 = Addr3;
                storeVar.leaderCode = leaderCode;
                storeVar.leaderName = leaderName;
                storeVar.contractDate = contDate;
                storeVar.postalCode = AgentAddrPostcode;
                storeVar.agentContactNumber = AgentContactNumber;
                
                /*
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
                */
                
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
            
            NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_Profile SET AgentLoginID = \"%@\", AgentCode= \"%@\", AgentName= \"%@\", "
								  "AgentContactNo= \"%@\", ImmediateLeaderCode= \"%@\", ImmediateLeaderName= \"%@\", "
								  "BusinessRegNumber = \"%@\", AgentEmail= \"%@\", AgentICNo=\"%@\", AgentContractDate=\"%@\", "
								  "AgentAddr1=\"%@\", AgentAddr2=\"%@\", AgentAddr3=\"%@\", AgentPortalLoginID = \"%@\", "
								  "AgentPortalPassword = \"%@\" , AgentContactNumber = \"%@\", AgentAddrPostcode = \"%@\", Channel=\"%@\" WHERE IndexNo=\"%d\"",
								  txtAgentId.text, txtAgentCode.text, txtAgentName.text, txtAgentContactNo.text, txtLeaderCode.text,
								  txtLeaderName.text,txtBixRegNo.text,txtEmail.text,txtICNo.text, contDate, txtAddr1.text,
								  txtAddr2.text, txtAddr3.text, txtAgencyPortalLogin.text, txtAgencyPortalPwd.text, txtAgentContactNo.text, txtHomePostCode.text, @"AGT", self.indexNo];
            
            
            const char *query_stmt = [querySQL UTF8String];
            
            //NSLog(@"%@",querySQL);
            
            if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    if(isFromFirstTime)
                    {
                        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@" "
                                                                          message:@"Your device has been registered to iM-Solutions. You will now be redirected to the login screen." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
                        success.tag = 1;
                        [success show];
                    }else
                    {
                        UIAlertView *success = [[UIAlertView alloc] initWithTitle:@" "
                                              message:@"Records updated." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
                        [success show];
                    }
                    
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
    [self setAddr1:nil];
    [self setTxtAgentId:nil];
    [self setTxtContractDate:nil];
    [super viewDidUnload];
}


@end
