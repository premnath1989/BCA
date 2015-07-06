//
//  ChangePassword.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ChangePasswordReg.h"
#import "Login.h"
#import "setting.h"
#import "AppDelegate.h"
#import "SettingSecurityQuestion.h"

@interface ChangePasswordReg ()

@end

@implementation ChangePasswordReg
@synthesize txtNewPwd;
@synthesize txtConfirmPwd;
@synthesize outletSave, outletTips;
@synthesize lblMsg, lblTips;
@synthesize passwordDB;
@synthesize userID;
@synthesize PasswordTipPopover = _PasswordTipPopover;
@synthesize PasswordTips = _PasswordTips;

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
    NSLog(@"Receive userID:%d",self.userID);
    
    userID = 1; //because there will be only a possible of maximum 1 user
    storeVar = [StoreVarFirstTimeReg sharedInstance];
	
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
	
    /*
	 AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
	 
	 self.userID = zzz.indexNo;
	 [self validateExistingPwd];
	 */
    outletSave.hidden = YES;
    lblMsg.hidden = TRUE;
    outletTips.hidden = TRUE;
    UITapGestureRecognizer *gestureQOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DisplayTips)];
    gestureQOne.numberOfTapsRequired = 1;
    
    [lblTips addGestureRecognizer:gestureQOne ];
    lblTips.userInteractionEnabled = YES;
    
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
								   initWithTarget:self
								   action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tap];
}

-(void)hideKeyboard{
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
}

- (IBAction)btnBack:(id)sender {
    
    [self dismissModalViewControllerAnimated:NO];
    
}

- (void)viewDidUnload
{
    [self setTxtNewPwd:nil];
    [self setTxtConfirmPwd:nil];
    [self setOutletSave:nil];
    [self setLblMsg:nil];
    [self setOutletTips:nil];
    [self setLblTips:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (interfaceOrientation==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        return YES;
    
    return NO;
}



/*
 -(void)validateExistingPwd
 {
 const char *dbpath = [databasePath UTF8String];
 sqlite3_stmt *statement;
 
 if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
 {
 NSString *querySQL = [NSString stringWithFormat:@"SELECT AgentPassword FROM User_Profile WHERE IndexNO=\"%d\"",self.userID];
 
 NSLog(@"%@", querySQL);
 const char *query_stmt = [querySQL UTF8String];
 if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
 {
 if (sqlite3_step(statement) == SQLITE_ROW)
 {
 passwordDB = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
 
 } else {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
 [alert show];
 
 }
 sqlite3_finalize(statement);
 }
 sqlite3_close(contactDB);
 }
 }*/

-(void)validatePassword
{
    [self saveChanges];
	
}

-(void)saveChanges
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        //NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET AgentLoginId= \"%@\", AgentPassword= \"%@\" WHERE IndexNo=\"%d\"", storeVar.agentLogin, txtNewPwd.text, self.userID];
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE Agent_Profile SET AgentLoginId= \"%@\", AgentPassword= \"%@\" WHERE IndexNo=\"%d\"", storeVar.agentLogin, txtNewPwd.text, self.userID];
        
        const char *query_stmt = [querySQL UTF8String];
        
        NSLog(@"querySQL = %@",querySQL);
        NSLog(@"sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) = %d", sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL));
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                txtNewPwd.text = @"";
                txtConfirmPwd.text = @"";
                /*
				 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Password save!\n Please continue to setup the necessary Security Questions." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
				 [alert setTag:01];
				 [alert show];*/
                
                SettingSecurityQuestion *SecurityQuesView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingSecurityQuestion"];
                SecurityQuesView.modalPresentationStyle = UIModalPresentationPageSheet;
                SecurityQuesView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                SecurityQuesView.hideCloseButton = true;
                [self presentModalViewController:SecurityQuesView animated:YES];
                SecurityQuesView.view.superview.frame = CGRectMake(150, 50, 700, 748);
                
            } else {
                lblMsg.text = @"Failed to update!";
                lblMsg.textColor = [UIColor redColor];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}


- (BOOL) isPasswordLegal:(NSString*) password
{
    NSCharacterSet *lowerCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    
    NSCharacterSet *upperCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLKMNOPQRSTUVWXYZ"];
    
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
	
    
    BOOL lower = [password rangeOfCharacterFromSet:lowerCaseChars].location != NSNotFound;
    BOOL upper = [password rangeOfCharacterFromSet:upperCaseChars].location != NSNotFound;
    BOOL numb = [password rangeOfCharacterFromSet:numbers].location != NSNotFound;
    
    if ( lower && upper && numb )
    {
        NSLog(@"ok this password is ok");
        return true;
    }else
    {
        NSLog(@"this password not ok");
        return false;
    }
}

- (IBAction)btnCancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnDone:(id)sender {
    bool valid;
    bool passwordValid = [self isPasswordLegal:txtNewPwd.text];
    /*
     if (txtOldPwd.text.length <= 0 || txtNewPwd.text.length <= 0 || txtConfirmPwd.text.length <= 0) {
     
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please fill up all field!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     
     }
     */
	
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
	
	if ([txtNewPwd.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
		valid = FALSE;
        [self hideKeyboard];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 03;
		[alert show];
		
	}
	else {
		if ([txtConfirmPwd.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
			valid = FALSE;
            [self hideKeyboard];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Confirm password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 02;
			[alert show];
			//[txtConfirmPwd becomeFirstResponder];
			
		}
		else {
			valid = TRUE;
			
		}
	}
      
    if(valid == TRUE) {
        
        if(passwordValid)
        {
            if (txtNewPwd.text.length < 6 ) {
                [self hideKeyboard];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                message:@"New password should be between 6 to 20 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                txtNewPwd.text = @"";
                txtConfirmPwd.text = @"";
                alert.tag = 03;
                [alert show];
                //[txtNewPwd becomeFirstResponder];
                
            }
            else {
                if (txtNewPwd.text.length > 20) {
                    [self hideKeyboard];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" "
                                                                    message:@"New password should be between 6 to 20 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    txtNewPwd.text = @"";
                    txtConfirmPwd.text = @"";
                    alert.tag = 03;
                    [alert show];
                    //[txtNewPwd becomeFirstResponder];
                }
                else {
                    if ([txtNewPwd.text isEqualToString:txtConfirmPwd.text]) {
                        [self validatePassword];
                    }
                    else {
                        [self hideKeyboard];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New Password did not match with confirmed password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        txtNewPwd.text = @"";
                        txtConfirmPwd.text = @"";
                    }
                }
            }
        }else
        {
            [self hideKeyboard];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"The password must be in a combination of lowercase, uppercase and numbers." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 03;
            [alert show];
            txtNewPwd.text = @"";
            txtConfirmPwd.text = @"";
        }
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 01) {
        if (buttonIndex == 0) {
            
            /*Login *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
			 [self presentViewController:loginView animated:YES completion:nil];*/
            
            SettingSecurityQuestion *SecurityQuesView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingSecurityQuestion"];
            SecurityQuesView.modalPresentationStyle = UIModalPresentationPageSheet;
            SecurityQuesView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            SecurityQuesView.hideCloseButton = true;
            [self presentModalViewController:SecurityQuesView animated:YES];
            SecurityQuesView.view.superview.frame = CGRectMake(150, 50, 700, 748);
        }
    }else
        if (alertView.tag == 02)
        {
            [txtConfirmPwd becomeFirstResponder];
        }else
            if (alertView.tag == 03)
            {
                [txtNewPwd becomeFirstResponder];
            }
}
- (IBAction)btnTips:(id)sender {
    if (_PasswordTips == Nil) {
        self.PasswordTips = [self.storyboard instantiateViewControllerWithIdentifier:@"Tip"];
        _PasswordTips.delegate = self;
        self.PasswordTipPopover = [[UIPopoverController alloc] initWithContentViewController:_PasswordTips];
        
    }
    [self.PasswordTipPopover setPopoverContentSize:CGSizeMake(950, 350)];
    [self.PasswordTipPopover presentPopoverFromRect:[sender frame ]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(void)DisplayTips{
    
    [self.view endEditing:YES];
    
    if (_PasswordTips == Nil) {
        self.PasswordTips = [self.storyboard instantiateViewControllerWithIdentifier:@"Tip"];
        _PasswordTips.delegate = self;
        self.PasswordTipPopover = [[UIPopoverController alloc] initWithContentViewController:_PasswordTips];
        
    }
    [self.PasswordTipPopover setPopoverContentSize:CGSizeMake(1050, 330)];
    [self.PasswordTipPopover presentPopoverFromRect:[lblTips frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)CloseWindow{
    //NSLog(@"received");
    [self.PasswordTipPopover dismissPopoverAnimated:YES];
}


@end
