//
//  ForgotPwd.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/29/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "ForgotPwd.h"

@interface ForgotPwd ()

@end

@implementation ForgotPwd
@synthesize lblStatusOne;
@synthesize lblStatusTwo;
@synthesize lblSelectQues;
@synthesize txtAnswer, LoginID;
@synthesize questCode,questDesc, answer, password, popOverConroller ;

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
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    UITapGestureRecognizer *gestureQOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectQuestion:)];
    gestureQOne.numberOfTapsRequired = 1;
    [lblSelectQues addGestureRecognizer:gestureQOne];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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


- (void)selectQuestion:(id)sender
{
    if(![popOverConroller isPopoverVisible]){
        
		RetreivePwdTbViewController *popView = [[RetreivePwdTbViewController alloc] init];
		popOverConroller = [[UIPopoverController alloc] initWithContentViewController:popView];
        popView.delegate = self;
        
		[popOverConroller setPopoverContentSize:CGSizeMake(530.0f, 400.0f)];
        [popOverConroller presentPopoverFromRect:CGRectMake(0, 0, 550, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
    else{
		[popOverConroller dismissPopoverAnimated:YES];
	}
}


- (IBAction)btnRetrieve:(id)sender {
    
    if ([lblSelectQues.text isEqualToString:@"Select your question" ]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please select your security question" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        
        if (txtAnswer.text.length <= 0 ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the answer for your security question." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        
        }
        else {
        if ([txtAnswer.text isEqualToString:answer]) {
            
            [self retrievePassword];
          
            NSString *MsgToDisplay = [[NSString alloc] initWithFormat:@"Your password is %@",password ];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:MsgToDisplay delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            
            /*
            lblStatusOne.text = @"Success!";
            lblStatusOne.textColor = [UIColor blueColor];
            
            lblStatusTwo.text = [[NSString alloc] initWithFormat:@"Your password is %@",password];
            lblStatusTwo.textColor = [UIColor blueColor];
             */
        }
        else {
            /*
            lblStatusOne.text = @"Failed!";
            lblStatusOne.textColor = [UIColor redColor];
            
            lblStatusTwo.text = @"Please key in the correct answer for the question you have chose!";
            lblStatusTwo.textColor = [UIColor redColor];
             */
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please key in the correct answer for the question you have chose!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT AgentPassword from User_Profile WHERE agentLoginID = \"%@\"", LoginID];
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
        
        NSString *sqlUpdate = [NSString stringWithFormat:@"UPDATE User_Profile SET ForgetPassword = 1"];
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

-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.popOverConroller = nil;
}

@end
