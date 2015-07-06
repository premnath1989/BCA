//
//  ChangePassword.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/28/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ChangePassword.h"
#import "Login.h"
#import "setting.h"
#import "AppDelegate.h"

@interface ChangePassword ()

@end

@implementation ChangePassword
@synthesize txtOldPwd;
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
  
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
       
    AppDelegate *zzz= (AppDelegate*)[[UIApplication sharedApplication] delegate ];
    
    self.userID = zzz.indexNo;
    [self validateExistingPwd];
    outletSave.hidden = YES;
    lblMsg.hidden = TRUE;
    outletTips.hidden = TRUE;
    UITapGestureRecognizer *gestureQOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DisplayTips)];
    gestureQOne.numberOfTapsRequired = 1;
    
    [lblTips addGestureRecognizer:gestureQOne ];
    lblTips.userInteractionEnabled = YES;
    
}

- (void)viewDidUnload
{
    [self setTxtOldPwd:nil];
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

-(void)validatePassword
{
    if ([txtOldPwd.text isEqualToString:passwordDB]){
        
        [self saveChanges];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Password did not match! Please enter correct old password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtOldPwd becomeFirstResponder];
        txtOldPwd.text = @"";
        txtNewPwd.text = @"";
        txtConfirmPwd.text = @"";
        
    }
}

-(void)saveChanges
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"UPDATE User_Profile SET AgentPassword= \"%@\" WHERE IndexNo=\"%d\"",txtNewPwd.text,self.userID];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                txtOldPwd.text = @"";
                txtNewPwd.text = @"";
                txtConfirmPwd.text = @"";
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Password save!\n You need to re-login." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert setTag:01];
                [alert show];
                
            } else {
                lblMsg.text = @"Failed to update!";
                lblMsg.textColor = [UIColor redColor];
                
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}



- (IBAction)btnChange:(id)sender {
    bool valid;
    
   /* 
    if (txtOldPwd.text.length <= 0 || txtNewPwd.text.length <= 0 || txtConfirmPwd.text.length <= 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill up all field!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    } 
     */
    if ([txtOldPwd.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length <= 0 ) {
        
        valid = FALSE;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Old password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtOldPwd becomeFirstResponder];
        
    }
    else { 
        if ([txtNewPwd.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
            valid = FALSE;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtNewPwd becomeFirstResponder];
        }
        else {
            if ([txtConfirmPwd.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
                valid = FALSE;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Confirm password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtConfirmPwd becomeFirstResponder];
                
            }
            else {
                valid = TRUE;
                
            }
        }
    }
        
    if(valid == TRUE) {
        
        if (txtNewPwd.text.length < 6 || txtNewPwd.text.length > 20 ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                            message:@"New Password must be at least 6 characters long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtNewPwd becomeFirstResponder];
            
        }
        else {
            if ([txtNewPwd.text isEqualToString:txtConfirmPwd.text]) {
                [self validatePassword]; 
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New Password did not match with confirmed password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                txtOldPwd.text = @"";
                txtNewPwd.text = @"";
                txtConfirmPwd.text = @"";
            }   
            
        }
        
        
    }
     
}

- (IBAction)btnCancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnDone:(id)sender {
    bool valid;
    
    /* 
     if (txtOldPwd.text.length <= 0 || txtNewPwd.text.length <= 0 || txtConfirmPwd.text.length <= 0) {
     
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill up all field!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     
     } 
     */
    if ([txtOldPwd.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length <= 0 ) {
        
        valid = FALSE;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Old password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtOldPwd becomeFirstResponder];
        
    }
    else { 
        if ([txtNewPwd.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
            valid = FALSE;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            [txtNewPwd becomeFirstResponder];
        }
        else {
            if ([txtConfirmPwd.text stringByReplacingOccurrencesOfString:@" " withString:@""  ].length <= 0) {
                valid = FALSE;
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Confirm password is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [txtConfirmPwd becomeFirstResponder];
                
            }
            else {
                valid = TRUE;
                
            }
        }
    }
    
    if(valid == TRUE) {
        
        if (txtNewPwd.text.length < 6 ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                            message:@"New Password must be at least 6 characters long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            txtNewPwd.text = @"";
            txtConfirmPwd.text = @"";
            [alert show];
            [txtNewPwd becomeFirstResponder];
            
        }
        else {
            if (txtNewPwd.text.length > 20) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                                message:@"New Password cannot be more than 20 characters long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                txtNewPwd.text = @"";
                txtConfirmPwd.text = @"";
                [alert show];
                [txtNewPwd becomeFirstResponder];
            }
            else {
                if ([txtNewPwd.text isEqualToString:txtConfirmPwd.text]) {
                    [self validatePassword]; 
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"New Password did not match with confirmed password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    txtOldPwd.text = @"";
                    txtNewPwd.text = @"";
                    txtConfirmPwd.text = @"";
                }
            }
            
               
            
        }
        
        
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 01) {     
        if (buttonIndex == 0) {
            
            Login *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
            [self presentViewController:loginView animated:YES completion:nil];
        }
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
    
    if (_PasswordTips == Nil) {
        self.PasswordTips = [self.storyboard instantiateViewControllerWithIdentifier:@"Tip"];
        _PasswordTips.delegate = self;
        self.PasswordTipPopover = [[UIPopoverController alloc] initWithContentViewController:_PasswordTips];
        
    }
    [self.PasswordTipPopover setPopoverContentSize:CGSizeMake(950, 350)];
    [self.PasswordTipPopover presentPopoverFromRect:[lblTips frame]  inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)CloseWindow{
    //NSLog(@"received");
    [self.PasswordTipPopover dismissPopoverAnimated:YES];
}
 
@end
