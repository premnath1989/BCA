//
//  FirstTimeViewController.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "FirstTimeViewController.h"
#import "UserProfile.h"
#import "SecurityQuestion.h"
#import <QuartzCore/QuartzCore.h>

@interface FirstTimeViewController ()

@end

@implementation FirstTimeViewController
@synthesize userID;
@synthesize myScrollView;
@synthesize outletSave;
@synthesize txtOldPassword;
@synthesize txtNewPassword;
@synthesize txtConfirmPassword;
@synthesize btnCancel, popOverConroller, questOneCode, questTwoCode,questThreeCode;
@synthesize PasswordTipPopover = _PasswordTipPopover;
@synthesize PasswordTips = _PasswordTips;
@synthesize lblPasswordTips;
@synthesize outletTips;

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
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
	NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];

    UITapGestureRecognizer *gestureQTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ShowPasswordTips:)];
    gestureQTwo.numberOfTapsRequired = 1;
    [lblPasswordTips addGestureRecognizer:gestureQTwo];
    lblPasswordTips.hidden = TRUE;
    
    outletSave.hidden = TRUE;
    
    outletTips.backgroundColor = [UIColor clearColor];
    [outletTips setOpaque:NO ];
    [outletTips setBackgroundImage:[UIImage imageNamed:@"f-spot-question-mark.png"] 
                          forState:UIControlStateNormal];
    
    
}

- (void)viewDidUnload
{
    [self setTxtOldPassword:nil];
    [self setTxtNewPassword:nil];
    [self setTxtConfirmPassword:nil];
    [self setBtnCancel:nil];
    [self setMyScrollView:nil];
    [self setOutletSave:nil];
    [self setLblPasswordTips:nil];
    [self setOutletTips:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

- (IBAction)ActionCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}

- (IBAction)btnSave:(id)sender {
    BOOL valid;
    
    if ([txtOldPassword.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length <= 0 ) {
        
        valid = FALSE;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Old password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    else { 
        if ([txtNewPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
            valid = FALSE;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            if ([txtConfirmPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
                valid = FALSE;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Confirm password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else {
                valid = TRUE;
                 
            }
        }
    }
    
    
    if(valid == TRUE) {
        
        if (txtNewPassword.text.length < 6) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                            message:@"Password must be at least 6 characters long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        else {
            if (txtNewPassword.text.length > 20) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                                message:@"New Password cannot be more than 20 characters long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                txtNewPassword.text = @"";
                txtConfirmPassword.text = @"";
                [alert show];
                [txtNewPassword becomeFirstResponder];
            }
            else {
                if ([txtNewPassword.text isEqualToString:txtConfirmPassword.text]) {
                    
                    if ([txtOldPassword.text isEqualToString:@"password"]) {
                        //[self saveData];
                        [self saveChangePwdData];
                    }
                    else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                                        message:@"Old password doest not match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                    
                    
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New Password did not match with the confirmed password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
            }
        }
    }
}

-(void) saveChangePwdData{
    /*
    btnNext.hidden = false;
    outletSave.hidden = true;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" 
                                                    message:@"New Password saved! Click Next to continue" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
     */
    
    UserProfile *UserProfilePage = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfile"];
    UserProfilePage.indexNo = userID;
    UserProfilePage.idRequest = @"hla";
    UserProfilePage.FirstTimeLogin = 1;
    UserProfilePage.ChangePwdPassword = txtNewPassword.text;
    UserProfilePage.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentModalViewController:UserProfilePage animated:YES];
    
    
}

- (void) saveData
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET AgentPassword= \"%@\" ,FirstLogin = 0 WHERE IndexNo=\"%d\"",txtNewPassword.text,self.userID];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                //lblStatus.text = @"Data updated! Please Click Next.";
                outletSave.hidden = true;
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" 
                                        message:@"New Password saved! Click Next to continue" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            } else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                                message:@"New Password not saved." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
                
                //lblStatus.text = @"Update failed!.";
                
            }
            sqlite3_finalize(statement);
        }
        
        
        /*
        NSString *query2 = [NSString stringWithFormat:@"UPDATE Agent_Profile SET AgentCode= \"%@\", AgentName= \"%@\" ,AgentContactNo= \"%@\",ImmediateLeaderCode= \"%@\","
                            "ImmediateLeaderName= \"%@\",BusinessRegNumber= \"%@\",AgentEmail= \"%@\" WHERE IndexNo = \"%d\"",
                            txtAgentCode.text,txtAgentName.text,txtAgentContactNo.text,txtLeaderCode.text,txtLeaderName.text,txtRegistrationNo.text,txtEmail.text,self.userID];
        
        const char *result = [query2 UTF8String];
        if (sqlite3_prepare_v2(contactDB, result, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"AgentProfile Update!");
                lblStatus.text = @"Data updated! Please relogin.";
                
            } else {
                NSLog(@"AgentProfile Failed!");
                lblStatus.text = @"Update failed!.";
            }
            sqlite3_finalize(statement);
        }
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO SecurityQuestion_Input (SecurityQuestionCode, SecurityQuestionAns) SELECT \"%@\", \"%@\" UNION ALL SELECT \"%@\", \"%@\" UNION ALL SELECT \"%@\", \"%@\"",
                               questOneCode,txtAnswer1.text,questTwoCode,txtAnswer2.text,questThreeCode,txtAnswer3.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        if(sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"save question success!");
            } else {
                NSLog(@"Failed save question");
            }
            sqlite3_finalize(statement);
        }
         */
        
        sqlite3_close(contactDB);
    }

}
/*
- (void)selectQuestOne:(id)sender
{
    if(![popOverConroller isPopoverVisible]){
        
        selectOne = YES;
		SecurityQuesTbViewController *popView = [[SecurityQuesTbViewController alloc] init];
		popOverConroller = [[UIPopoverController alloc] initWithContentViewController:popView];
        popView.delegate = self;
        
		
		[popOverConroller setPopoverContentSize:CGSizeMake(530.0f, 400.0f)];
        [popOverConroller presentPopoverFromRect:CGRectMake(0, 0, 550, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
    else{
		[popOverConroller dismissPopoverAnimated:YES];
        selectOne = NO;
	}
}

- (void)selectQuestTwo:(id)sender
{
    if(![popOverConroller isPopoverVisible]){
        
        selectTwo = YES;
		SecurityQuesTbViewController *popView = [[SecurityQuesTbViewController alloc] init];
		popOverConroller = [[UIPopoverController alloc] initWithContentViewController:popView];
        popView.delegate = self;
        
		
		[popOverConroller setPopoverContentSize:CGSizeMake(530.0f, 400.0f)];
        [popOverConroller presentPopoverFromRect:CGRectMake(0, 0, 550, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
    else{
		[popOverConroller dismissPopoverAnimated:YES];
        selectTwo = NO;
	}
}

- (void)selectQuestThree:(id)sender
{
    if(![popOverConroller isPopoverVisible]){
        
        selectThree = YES;
		SecurityQuesTbViewController *popView = [[SecurityQuesTbViewController alloc] init];
		popOverConroller = [[UIPopoverController alloc] initWithContentViewController:popView];
        popView.delegate = self;
        
		[popOverConroller setPopoverContentSize:CGSizeMake(530.0f, 400.0f)];
        [popOverConroller presentPopoverFromRect:CGRectMake(0, 0, 550, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
    else{
		[popOverConroller dismissPopoverAnimated:YES];
        selectThree = NO;
	}
}
*/

-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 0, 1024, 748-352);
    self.myScrollView.contentSize = CGSizeMake(1024, 748);
    
    CGRect textFieldRect = [activeField frame];
    textFieldRect.origin.y += 10;
    [self.myScrollView scrollRectToVisible:textFieldRect animated:YES];
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
    self.myScrollView.frame = CGRectMake(0, 0, 1024, 748);
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    activeField = textField;
    return YES;
}

- (IBAction)btnNext:(id)sender {
    BOOL valid;
    
    if ([txtOldPassword.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length <= 0 ) {
        
        valid = FALSE;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Old password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    else { 
        if ([txtNewPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
            valid = FALSE;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            if ([txtConfirmPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
                valid = FALSE;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Confirm password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else {
                valid = TRUE;
                
            }
        }
    }
    
    
    if(valid == TRUE) {
        
        if (txtNewPassword.text.length < 6 || txtNewPassword.text.length > 20 ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                            message:@"Password must be at least 6 characters long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        else {
            if ([txtNewPassword.text isEqualToString:txtConfirmPassword.text]) {
                
                if ([txtOldPassword.text isEqualToString:@"password"]) {
                    //[self saveData];
                    [self saveChangePwdData];
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                                    message:@"Old password doest not match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New Password did not match with the confirmed password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }
    }
}

-(void)ShowPasswordTips:(id)sender {
    self.PasswordTips = [self.storyboard instantiateViewControllerWithIdentifier:@"Tip"];
    self.PasswordTipPopover = [[UIPopoverController alloc] initWithContentViewController:_PasswordTips];
    [self.PasswordTipPopover setPopoverContentSize:CGSizeMake(950, 350)];    
    [self.PasswordTipPopover presentPopoverFromRect:[sender frame ]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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

-(void)CloseWindow{
    //NSLog(@"received");
    [self.PasswordTipPopover dismissPopoverAnimated:YES];
}


@end
