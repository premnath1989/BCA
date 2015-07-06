//
//  SettingSecurityQuestion.m
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 11/21/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SettingSecurityQuestion.h"

@interface SettingSecurityQuestion ()

@end

@implementation SettingSecurityQuestion
@synthesize btnClose,questOneCode;
@synthesize outletQues1,questTwoCode;
@synthesize outletQues3,questThreeCode;
@synthesize outletQues2;
@synthesize txtAnswer1;
@synthesize txtAnswer2;
@synthesize txtAnswer3;
@synthesize ScrollView;
@synthesize popOverConroller;

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
	// Do any additional setup after loading the view.
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
    
    outletQues1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    outletQues2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    outletQues3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg10.jpg"]];
    
}

- (void)viewDidUnload
{
    [self setBtnClose:nil];
    [self setScrollView:nil];
    [self setOutletQues1:nil];
    [self setOutletQues3:nil];
    [self setTxtAnswer1:nil];
    [self setTxtAnswer2:nil];
    [self setTxtAnswer3:nil];
    [self setOutletQues2:nil];
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
        [self loadExisting];
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




-(void)keyboardDidShow:(NSNotificationCenter *)notification
{
  self.ScrollView.frame = CGRectMake(0, 0, 700, 748-352);
  self.ScrollView.contentSize = CGSizeMake(700, 500);
  
  CGRect textFieldRect = [activeField frame];
  textFieldRect.origin.y += 10;
  [self.ScrollView scrollRectToVisible:self.view.frame animated:YES];
  
}

-(void)keyboardDidHide:(NSNotificationCenter *)notification
{
  self.ScrollView.frame = CGRectMake(0, 0, 700, 700);
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
                    [outletQues1 setTitle:[space stringByAppendingString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]] forState:UIControlStateNormal];
                    txtAnswer1.text = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    questOneCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                }
                else if (a == 2) {
                    [outletQues2 setTitle:[space stringByAppendingString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]] forState:UIControlStateNormal];
                    txtAnswer2.text = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    questTwoCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                }
                else if (a == 3) {
                    [outletQues3 setTitle:[space stringByAppendingString:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)]] forState:UIControlStateNormal];
                    txtAnswer3.text = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                    questThreeCode = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                }
                
                a = a + 1;
            } 
            sqlite3_finalize(statement);       
        }
            
        sqlite3_close(contactDB);
    }
        
}

-(void)securityQuest:(SecurityQuesTbViewController *)inController didSelectQuest:(NSString *)code desc:(NSString *)desc{
    NSString *space = @" ";
    
    if (selectOne) {
        questOneCode = [[NSString alloc] initWithFormat:@"%@",code];
        [outletQues1 setTitle:[space stringByAppendingString: [[NSString alloc] initWithFormat:@"%@",desc]] forState:UIControlStateNormal ];
    }
    else if (selectTwo) {
        questTwoCode = [[NSString alloc] initWithFormat:@"%@",code];
        [outletQues2 setTitle:[space stringByAppendingString:[[NSString alloc] initWithFormat:@"%@",desc]] forState:UIControlStateNormal ];
    }
    else if (selectThree) {
        questThreeCode = [[NSString alloc] initWithFormat:@"%@",code];
        [outletQues3 setTitle:[space stringByAppendingString:[[NSString alloc] initWithFormat:@"%@",desc]] forState:UIControlStateNormal ];
    }
    [popOverConroller dismissPopoverAnimated:YES];
    
    selectOne = NO;
    selectTwo = NO;
    selectThree = NO;
    
}


- (IBAction)btnQues1:(id)sender {
    if(![popOverConroller isPopoverVisible]){
        
        selectOne = YES;
		SecurityQuesTbViewController *popView = [[SecurityQuesTbViewController alloc] init];
        if (popOverConroller == Nil) {
            popOverConroller = [[UIPopoverController alloc] initWithContentViewController:popView];
            popView.delegate = self;
            
        }
		
		[popOverConroller setPopoverContentSize:CGSizeMake(530.0f, 400.0f)];
        [popOverConroller presentPopoverFromRect:CGRectMake(0, 0, 550, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
    else{
		[popOverConroller dismissPopoverAnimated:YES];
        selectOne = NO;
	}
    
}

- (IBAction)btnQues2:(id)sender {
    if(![popOverConroller isPopoverVisible]){
        
        selectTwo = YES;
		SecurityQuesTbViewController *popView = [[SecurityQuesTbViewController alloc] init];
        if (popOverConroller == Nil) {
            popOverConroller = [[UIPopoverController alloc] initWithContentViewController:popView];
            popView.delegate = self;
            
        }
		
		[popOverConroller setPopoverContentSize:CGSizeMake(530.0f, 400.0f)];
        [popOverConroller presentPopoverFromRect:CGRectMake(0, 0, 550, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
    else{
		[popOverConroller dismissPopoverAnimated:YES];
        selectTwo = NO;
	}
}


- (IBAction)btnQues3:(id)sender {
    if(![popOverConroller isPopoverVisible]){
        
        selectThree = YES;
		SecurityQuesTbViewController *popView = [[SecurityQuesTbViewController alloc] init];
        if (popOverConroller == Nil) {
            popOverConroller = [[UIPopoverController alloc] initWithContentViewController:popView];
            popView.delegate = self;
            
        }
		
		[popOverConroller setPopoverContentSize:CGSizeMake(530.0f, 400.0f)];
        [popOverConroller presentPopoverFromRect:CGRectMake(0, 0, 550, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	}
    else{
		[popOverConroller dismissPopoverAnimated:YES];
        selectThree = NO;
	}
}


- (IBAction)ActionClose:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doSave:(id)sender {
    
    [self.view endEditing:TRUE];
    [self resignFirstResponder];
    
    Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
    id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
    [activeInstance performSelector:@selector(dismissKeyboard)];
    
    self.ScrollView.frame = CGRectMake(0, 0, 700, 748);
    
    if( [self validation] == TRUE ){
        [self DeleteOldData]; //delete old security question data first if any
        
        sqlite3_stmt *statement;
        
        if (sqlite3_open([databasePath UTF8String], &contactDB) == SQLITE_OK)
        {
            
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO SecurityQuestion_Input (SecurityQuestionCode, SecurityQuestionAns) " 
                                   " SELECT \"%@\", \"%@\" UNION ALL SELECT \"%@\", \"%@\" UNION ALL SELECT \"%@\", \"%@\"",
                                   questOneCode,txtAnswer1.text,questTwoCode,txtAnswer2.text,questThreeCode,txtAnswer3.text];
            
            if(sqlite3_prepare_v2(contactDB, [insertSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
                if (sqlite3_step(statement) == SQLITE_DONE)
                {   
                    /*
                     UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success"
                     message:@"Click Next to continue" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
                     [success show];
                     
                     if (FirstTimeLogin == 1) {
                     outletNext.hidden = false;
                     outletSave.hidden = TRUE;
                     }
                     */
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Security Question successfully updated!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert setTag:01];
                    [alert show];
                    
                } else {
                    NSLog(@"Failed save question");
                }
                sqlite3_finalize(statement);
            }
            
            sqlite3_close(contactDB);
        }
    }
}

-(void)DeleteOldData{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *DeleteSQL = [NSString stringWithFormat:
                               @"Delete from SecurityQuestion_Input"];
        if(sqlite3_prepare_v2(contactDB, [DeleteSQL UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            sqlite3_step(statement);
            sqlite3_finalize(statement);
            
        }
        
        sqlite3_close(contactDB);
    }
}

-(BOOL)validation{

    if ([outletQues1.titleLabel.text isEqualToString:outletQues2.titleLabel.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You cannot have 2 same security question !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return false;
    }
    
    if ([outletQues2.titleLabel.text isEqualToString:outletQues3.titleLabel.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You cannot have 2 same security question !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return false;
    }
    
    if ([outletQues3.titleLabel.text isEqualToString:outletQues1.titleLabel.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You cannot have 2 same security question !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return false;
    }

    if([txtAnswer1.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length < 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                            message:@"Please provide answer for question 1" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtAnswer1 becomeFirstResponder];
        return  FALSE;
    }

    if([txtAnswer2.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length < 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please provide answer for question 2" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtAnswer2 becomeFirstResponder];
        return  FALSE;
    }

    if([txtAnswer3.text stringByReplacingOccurrencesOfString:@" " withString:@"" ].length < 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Please provide answer for question 3" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [txtAnswer3 becomeFirstResponder];
        return  FALSE;
    }

    return TRUE;
}

@end
