//
//  ForgotPwd.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/29/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ForgotPwd.h"
#import "ColorHexCode.h"
#import "Login.h"

@interface ForgotPwd ()

@end

@implementation ForgotPwd
@synthesize lblStatusOne;
@synthesize lblStatusTwo;
@synthesize lblSelectQues;
@synthesize txtAnswer, LoginID;
@synthesize questCode,questDesc, answer, password, popOverConroller, txtQues1, txtQues2, txtQues3, txtAnswer1, txtAnswer2, txtAnswer3 ;

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
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    UITapGestureRecognizer *gestureQOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectQuestion:)];
    gestureQOne.numberOfTapsRequired = 1;
    [lblSelectQues addGestureRecognizer:gestureQOne];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self loadExisting];
    txtQues1.enabled = FALSE;
    txtQues2.enabled = FALSE;
    txtQues3.enabled = FALSE;
    
    ColorHexCode *CustomColor = [[ColorHexCode alloc] init ];
    txtQues1.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtQues1 setTextColor:[UIColor grayColor]];
    
    txtQues2.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtQues2 setTextColor:[UIColor grayColor]];
    
    txtQues3.backgroundColor = [CustomColor colorWithHexString:@"EEEEEE"];
    [txtQues3 setTextColor:[UIColor grayColor]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tap.cancelsTouchesInView = NO;
    tap.numberOfTapsRequired = 1;
    
    [self.view addGestureRecognizer:tap];
}

-(void)hideKeyboard{
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
}
- (void)viewDidUnload
{
    [self setLblSelectQues:nil];
    [self setTxtAnswer:nil];
    [self setLblStatusOne:nil];
    [self setLblStatusTwo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}



- (IBAction)btnRetrieve:(id)sender {
    
    if( txtAnswer1.text.length <= 0 || txtAnswer2.text.length <= 0 || txtAnswer3.text.length <= 0 )
    {
        [self getEmptyAnsPos];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please answer all questions to retrieve your password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1002;
        [alert show];
    }else
    {
        if( [txtAnswer1.text isEqualToString:dbAnswer1] && [txtAnswer2.text isEqualToString:dbAnswer2] && [txtAnswer3.text isEqualToString:dbAnswer3] )
        {
            [self retrievePassword];
            
            NSString *MsgToDisplay = [[NSString alloc] initWithFormat:@"Your password is %@",password ];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:MsgToDisplay delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1001;
            [alert show];
        }
        else
        {
            [self getWrongAnsPosition];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Answers to the questions aren't match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag = 1002;
            [alert show];
            
        }
    }
}


-(void) getWrongAnsPosition
{
    if( ![txtAnswer1.text isEqualToString:dbAnswer1] )
    {
        toAnsPos = 0;
    }else
    if( ![txtAnswer2.text isEqualToString:dbAnswer2] )
    {
        toAnsPos = 1;
    }else
    if( ![txtAnswer3.text isEqualToString:dbAnswer3] )
    {
        toAnsPos = 2;
    }
}

-(void) getEmptyAnsPos
{
    if( txtAnswer1.text.length <= 0 )
    {
        toAnsPos = 0;
    }else
    if( txtAnswer2.text.length <= 0 )
    {
        toAnsPos = 1;
    }else
    if( txtAnswer3.text.length <= 0 )
    {
        toAnsPos = 2;
    }
}

-(void)retrievePwd:(RetreivePwdTbViewController *)inController didSelectQuest:(NSString *)code desc:(NSString *)desc ans:(NSString *)ans
{
    questCode = [[NSString alloc] initWithFormat:@"%@",code];
    questDesc = [[NSString alloc] initWithFormat:@"%@",desc];
    answer = [[NSString alloc] initWithFormat:@"%@",ans];
    
    lblSelectQues.text = [[NSString alloc] initWithFormat:@"%@",questDesc];
    [popOverConroller dismissPopoverAnimated:YES];
}

- (IBAction)btnCancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void) retrievePassword
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT AgentPassword from Agent_Profile WHERE agentLoginID = \"%@\"", LoginID];
        //NSString *querySQL = [NSString stringWithFormat:@"SELECT AgentPassword from User_Profile WHERE agentLoginID = \"%@\"", LoginID];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                password = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
            } else {
                NSLog(@"Error retreive!");
            }
            sqlite3_finalize(statement);
        }
        
        NSString *sqlUpdate = [NSString stringWithFormat:@"UPDATE Agent_Profile SET ForgetPassword = 1"];
//        NSString *sqlUpdate = [NSString stringWithFormat:@"UPDATE User_Profile SET ForgetPassword = 1"];
        const char *sqlUpdate_stmt = [sqlUpdate UTF8String];
        if (sqlite3_prepare_v2(contactDB, sqlUpdate_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_DONE)
            {
                NSLog(@"UserProfile Update!");
                
            } else {
                NSLog(@"UserProfile Failed!");
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(contactDB);
    }
}

-(void) loadExisting{
    
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"select SecurityQuestionDesc, securityquestionans, A.securityQuestionCode from "
                              "securityQuestion_input as A, securityQuestion as B where A.securityQuestionCode = B.securityQuestionCode "];
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) == SQLITE_OK){
            
            int a = 1;
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSString *space = @" ";
                
                if ( a == 1) {
                    txtQues1.text = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    dbAnswer1 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                }
                else if (a == 2) {
                    txtQues2.text = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    dbAnswer2 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                }
                else if (a == 3) {
                    txtQues3.text = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                    dbAnswer3 = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                }
                
                a = a + 1;
            }
            sqlite3_finalize(statement);
        }
		
        sqlite3_close(contactDB);
    }
	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	
    if (alertView.tag==1001) {
        Login *LoginPage = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
        LoginPage.modalPresentationStyle = UIModalPresentationFullScreen;
        LoginPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:LoginPage animated:YES ];
        
        [self dismissModalViewControllerAnimated:YES];
    }else
    if (alertView.tag==1002) {
        if(toAnsPos == 0)
        {
            [txtAnswer1 becomeFirstResponder];
        }else
        if(toAnsPos == 1)
        {
            [txtAnswer2 becomeFirstResponder];
        }else
        if(toAnsPos == 2)
        {
            [txtAnswer3 becomeFirstResponder];
        }
    }
}

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popOverConroller = nil;
}

@end
