//
//  MainNomineesTrusteesVC.m
//  iMobile Planner
//
//  Created by Juliana on 8/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "MainNomineesTrusteesVC.h"
#import "textFields.h"
#import "DataClass.h"
#import "FMDatabase.h"
//#import "Utility.h"
#import "NomineesTrustees.h"



@interface MainNomineesTrusteesVC ()
{
    DataClass *obj;
	BOOL employerMandatory;
}
@end



@implementation MainNomineesTrusteesVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	obj = [DataClass getInstance];
	nominees = [self.storyboard instantiateViewControllerWithIdentifier:@"Nominees"];
	nominees.view.frame = CGRectMake(0, 0, self.mainView.frame.size.width, self.mainView.frame.size.height);
	[self addChildViewController:nominees];
	[self.mainView addSubview:nominees.view];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
	tap.cancelsTouchesInView = NO;
	tap.numberOfTapsRequired = 1;
	tap.delegate = self;
	[self.view addGestureRecognizer:tap];
    


    //databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];

    
}

-(void)hideKeyboard{
    
	Class UIKeyboardImpl = NSClassFromString(@"UIKeyboardImpl");
	id activeInstance = [UIKeyboardImpl performSelector:@selector(activeInstance)];
	[activeInstance performSelector:@selector(dismissKeyboard)];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UITextField class]] ||
        [touch.view isKindOfClass:[UIButton class]])
    {
        return NO;
    }
    return YES;
}
- (void)show1stNominee {
	NSLog(@"name nm 11111: %@" ,[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Trustees"] objectForKey:@"Nominee1_name"]);
	
	if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_gender"] isEqualToString:@"male"]) {
		nominees.sexSC.selectedSegmentIndex = 0;
	}
	else if ([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_gender"] isEqualToString:@"female"]) {
		nominees.sexSC.selectedSegmentIndex = 1;
	}
	nominees.sharePercentageTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"];
	//nominees.titleLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_title"];
    nominees.TitleCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_title"];
	nominees.nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"];
	nominees.icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"];
	//nominees.otherIDTypeLbl2.text =
	nominees.IDTypeCodeSelected = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"];
	nominees.otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"];
	nominees.dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_dob"];
	nominees.relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"];
	
	nominees.add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add1TF"];
	nominees.add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add2TF"];
	nominees.add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add3TF"];
	nominees.postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_postcodeTF"];
	nominees.townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_townTF"];
	nominees.stateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"]];
	nominees.StateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
	nominees.countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_countryTF"];

    nominees.nationalityLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nationalityTF"];
    
    
    
    nominees.nameOfEmployerTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_nameOfEmployerTF"];
    nominees.occupationLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_occupationTF"];
    nominees.exactDuty.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_exactDutiesTF"];
    nominees.CRadd1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd1TF"];
	nominees.CRadd2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd2TF"];
	nominees.CRadd3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRadd3TF"];
	nominees.CRpostcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRpostcodeTF"];
	nominees.CRtownTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRtownTF"];
	nominees.CRstateLbl.text = [self getStateDesc:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRstateTF"]];
	nominees.CRStateCode = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRstateTF"];
	nominees.CRcountryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_CRcountryTF"];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
	[self setMainView:nil];
	[super viewDidUnload];
}

- (IBAction)selectDone:(id)sender {
    //	[self dismissModalViewControllerAnimated:YES];
	
    //	[_delegate updateTotalSharePct:nominees.sharePercentageTF.text];
	
    [self hideKeyboard];
	[nominees editingDidEndPostcode:nil];
    
	if ([textFields trimWhiteSpaces:nominees.occupationLbl.text].length != 0) {
		[self CheckOccuCat:nominees.occupationLbl.text];
	}
	
	
    //check if duplicate nominee
    int no = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] intValue];
    
    // get Identification code
	NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath2 = [paths2 objectAtIndex:0];
    NSString *path2 = [docsPath2 stringByAppendingPathComponent:@"hladb.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:path2];
    [db open];
    NSString *otherIDTypeCode;
    FMResultSet *results_getID = [db executeQuery:@"select * from eProposal_Identification where IdentityDesc = ?", nominees.otherIDTypeLbl2.text];
    while ([results_getID next]) {
        otherIDTypeCode = [results_getID stringForColumn:@"IdentityCode"];
    }
    if (no == 1) {
        if (![_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's Name cannot be the same as 2nd Nominee's Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's New IC No. cannot be the same as 2nd Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's Other ID cannot be the same as 2nd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
            
        }
        
        if (![_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's Name cannot be the same as 3rd Nominee's Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's New IC No. cannot be the same as 3rd Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's Other ID cannot be the same as 3rd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
        if (![_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's Name cannot be the same as 4th Nominee's Name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's New IC No. cannot be the same as 4th Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"1st Nominee's Other ID cannot be the same as 4th Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
    }
    else if (no == 2) {
        if (![_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's Name cannot be the same as 1st Nominee's name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's New IC No. cannot be the same as 1st Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"]]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's Other ID cannot be the same as 1st Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
        if (![_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's Name cannot be the same as 3rd Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's New IC No. cannot be the same as 3rd Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's Other ID cannot be the same as 3rd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
        if (![_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's Name cannot be the same as 4th Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's New IC No. cannot be the same as 4th Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"2nd Nominee's Other ID cannot be the same as 4th Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
    }
    else if (no == 3) {
        if (![_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's Name cannot be the same as 1st Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's New IC No. cannot be the same as 1st Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"]]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's Other ID cannot be the same as 1st Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
        if (![_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's Name cannot be the same as 2nd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's New IC No. cannot be the same as 2nd Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's Other ID cannot be the same as 2nd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
        if (![_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's Name cannot be the same as 4th Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's New IC No. cannot be the same as 4th Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"3rd Nominee's Other ID cannot be the same as 4th Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
    }
    else if (no == 4) {
        if (![_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's Name cannot be the same as 1st Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's New IC No. cannot be the same as 1st Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"]]) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's Other ID cannot be the same as 1st Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
        if (![_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's Name cannot be the same as 2nd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's New IC No. cannot be the same as 2nd Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's Other ID cannot be the same as 2nd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
        
        if (![_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"]) {
            if ([[nominees.nameTF.text lowercaseString] isEqualToString:[[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_name"] lowercaseString]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's Name cannot be the same as 3rd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([nominees.icNoTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_ic"]] && nominees.icNoTF.text.length != 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's New IC No. cannot be the same as 3rd Nominee's New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                return;
            }
            else if ([otherIDTypeCode isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherIDType"]] && [nominees.otherIDTF.text isEqualToString:[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_otherID"]]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"4th Nominee's Other ID cannot be the same as 3rd Nominee's Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                alert.tag = 400;
                return;
            }
        }
    }
    
    // if there is trustee added, need to check trust policy
	NSLog(@"%@, %@", _Trustee1Lbl.text, _Trustee2Lbl.text);
    if (![_Trustee1Lbl.text isEqualToString:@"Add Trustee (1)"] || ![_Trustee2Lbl.text isEqualToString:@"Add Trustee (2)"]) {
        bool trust = [self validateTrust:no];
        if (!trust) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Appointment of Trustee is not allowed for non-trust policy." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            alert = Nil;
            return;
        }
    }
    
	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *myNumber = [f numberFromString:nominees.sharePercentageTF.text];
	
	NSNumberFormatter * f2 = [[NSNumberFormatter alloc] init];
	[f2 setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *myNumber2 = [f2 numberFromString:@"100"];
	
    
    bool isMale = FALSE;
	NSString *strDOB;
	
	
	NSLog(@"nominees.icNoTF.text %@ nominees.otherIDTF.text %@", nominees.icNoTF.text, nominees.otherIDTF.text);
	NSString *strDate;
	NSString *strMonth;
	NSString *strYear;
	NSString *febStatus = nil;
	
	NSDate *d;
	NSDate *d2;
	
	
	
    if (nominees.icNoTF.text.length != 0 && nominees.icNoTF.text.length == 12) {
        NSString *last = [nominees.icNoTF.text substringFromIndex:[nominees.icNoTF.text length] -1];
        NSCharacterSet *oddSet = [NSCharacterSet characterSetWithCharactersInString:@"13579"];
        
        if ([last rangeOfCharacterFromSet:oddSet].location != NSNotFound) {
            isMale = TRUE;
        } else {
            isMale = FALSE;
        }
		
		//get the DOB value from ic entered
        strDate = [nominees.icNoTF.text substringWithRange:NSMakeRange(4, 2)];
        strMonth = [nominees.icNoTF.text substringWithRange:NSMakeRange(2, 2)];
        strYear = [nominees.icNoTF.text substringWithRange:NSMakeRange(0, 2)];
        
        //get value for year whether 20XX or 19XX
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        
        NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
        NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
        if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
            strYear = [NSString stringWithFormat:@"19%@",strYear];
        }
        else {
            strYear = [NSString stringWithFormat:@"20%@",strYear];
        }
        
        strDOB = [NSString stringWithFormat:@"%@/%@/%@",strDate,strMonth,strYear];
		
		
        //		//CHECK DAY / MONTH / YEAR START
        //		//get the DOB value from ic entered
        //		NSString *strDate = [nominees.icNoTF.text substringWithRange:NSMakeRange(4, 2)];
        //		NSString *strMonth = [nominees.icNoTF.text substringWithRange:NSMakeRange(2, 2)];
        //		NSString *strYear = [nominees.icNoTF.text substringWithRange:NSMakeRange(0, 2)];
        //
        //		//get value for year whether 20XX or 19XX
        //		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //		[dateFormatter setDateFormat:@"yyyy"];
        //
        //		NSString *currentYear = [dateFormatter stringFromDate:[NSDate date]];
        //		NSString *strCurrentYear = [currentYear substringWithRange:NSMakeRange(2, 2)];
        //
        //		if ([strYear intValue] > [strCurrentYear intValue] && !([strYear intValue] < 30)) {
        //			strYear = [NSString stringWithFormat:@"19%@",strYear];
        //		}
        //		else {
        //			strYear = [NSString stringWithFormat:@"20%@",strYear];
        //		}
		
		NSString *strDOB2 = [NSString stringWithFormat:@"%@-%@-%@",strYear,strMonth,strDate];
		
		//determine day of february
		
		float devideYear = [strYear floatValue]/4;
		int devideYear2 = devideYear;
		float minus = devideYear - devideYear2;
		if (minus > 0) {
			febStatus = @"Normal";
		}
		else {
			febStatus = @"Jump";
		}
		
		//compare year is valid or not
		[dateFormatter setDateFormat:@"yyyy-MM-dd"];
		d = [NSDate date];
		d2 = [dateFormatter dateFromString:strDOB2];
    }
    
    //prem//
	
	[self hideKeyboard];
	
	if ((nominees.titleLbl.text.length == 0) || ([nominees.titleLbl.text isEqualToString:@"- SELECT -"])){
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Title is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//alert.tag = 100;
		[alert show];
        

	}
    
	else if ([textFields trimWhiteSpaces:nominees.nameTF.text].length == 0) {
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[nominees.nameTF becomeFirstResponder];
		alert.tag = 200;
		[alert show];
	}
	else if ([textFields validateString:nominees.nameTF.text])
	{
		//[nominees.nameTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 200;
		[alert show];
	}
	else if ([textFields validateString3:nominees.nameTF.text])
	{
		//[nominees.nameTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A-Z, space, apostrophe ('), alias (@), slash (/), dash (-), bracket(()) or dot (.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 200;
		[alert show];
	}
	else if ( (nominees.icNoTF.text.length == 0 || [nominees.icNoTF.text isEqualToString:@"New IC No"]) && !(nominees.otherIDTypeLbl2.text.length > 0 && ([nominees.otherIDTypeLbl2.text isEqualToString:@"- SELECT -"] || (!(nominees.otherIDTypeLbl2.text.length == 0)))		)) {
		
        //[nominees.icNoTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either New IC No. or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 300;
		[alert show];
	}
	else if ((nominees.icNoTF.text.length > 0) && (nominees.otherIDTF.text.length > 0) && ([nominees.icNoTF.text isEqualToString:nominees.otherIDTF.text])) {
		
        //[nominees.icNoTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID cannot be same as New IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 300;
		[alert show];
	}
	else if (nominees.icNoTF.text.length != 0 && nominees.icNoTF.text.length < 12) {
        //[nominees.icNoTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"New IC must be 12 digits characters." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 300;
		[alert show];
	}
    
    
	//else if ([textFields trimWhiteSpaces:nominees.icNoTF.text].length != 0 && [textFields trimWhiteSpaces:nominees.icNoTF.text].length == 12) {
    else if ([textFields trimWhiteSpaces:nominees.icNoTF.text].length != 0 && [d compare:d2] == NSOrderedAscending) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag = 300;
        [alert show];
        
        return;
    }
    else if ([textFields trimWhiteSpaces:nominees.icNoTF.text].length != 0 && ([strMonth intValue] > 12 || [strMonth intValue] < 1)) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC month must be between 1 and 12." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag = 300;
        [alert show];
        
        return;
    }
    else if([textFields trimWhiteSpaces:nominees.icNoTF.text].length != 0 && ([strDate intValue] < 1 || [strDate intValue] > 31))
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC day must be between 1 and 31." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag = 300;
        [alert show];
        
        return;
        
    }
    else if ([textFields trimWhiteSpaces:nominees.icNoTF.text].length != 0 && (([strMonth isEqualToString:@"01"] || [strMonth isEqualToString:@"03"] || [strMonth isEqualToString:@"05"] || [strMonth isEqualToString:@"07"] || [strMonth isEqualToString:@"08"] || [strMonth isEqualToString:@"10"] || [strMonth isEqualToString:@"12"]) && [strDate intValue] > 31)) {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag = 300;
        [alert show];
        
        return;
    }
    
    else if ([textFields trimWhiteSpaces:nominees.icNoTF.text].length != 0 && (([strMonth isEqualToString:@"04"] || [strMonth isEqualToString:@"06"] || [strMonth isEqualToString:@"09"] || [strMonth isEqualToString:@"11"]) && [strDate intValue] > 30)) {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No not valid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag = 300;
        [alert show];
        
        return;
    }
    else if ([textFields trimWhiteSpaces:nominees.icNoTF.text].length != 0 && (([febStatus isEqualToString:@"Normal"] && [strDate intValue] > 28 && [strMonth isEqualToString:@"02"]) || ([febStatus isEqualToString:@"Jump"] && [strDate intValue] > 29 && [strMonth isEqualToString:@"02"]))) {
        
        
        NSString *msg = [NSString stringWithFormat:@"February of %@ doesn’t have 29 days",strYear] ;
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        alert.tag = 300;
        [alert show];
        
        return;
    }
	
	else if ((![nominees.otherIDTypeLbl2.text isEqualToString:@"- SELECT -"]) && nominees.otherIDTypeLbl2.text.length > 0 && [textFields trimWhiteSpaces:nominees.otherIDTF.text].length == 0) {
        // NSLog(@"nominees.otherIDTypeLbl2.text: %@", nominees.otherIDTypeLbl2.text);
        // NSLog(@"nominees.otherIDTypeLbl2.text: %d, %d, %d", ![nominees.otherIDTypeLbl2.text isEqualToString:@"- Select -"], nominees.otherIDTypeLbl2.text.length > 0, ![nominees.otherIDTypeLbl2.text isEqualToString:@"- Select -"] && ![nominees.otherIDTypeLbl2.text isEqual:[NSNull null]]);
        //[nominees.otherIDTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 400;
		[alert show];
	}
	else if ((nominees.icNoTF.text == NULL || [nominees.icNoTF.text isEqualToString:@""]) && ([nominees.otherIDTypeLbl2.text isEqualToString:@"- SELECT -"]) && (nominees.otherIDTF.text.length == 0)) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either New IC No. or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//alert.tag = 500;
		[alert show];
	}
	else if ([nominees.otherIDTypeLbl2.text isEqualToString:@"- SELECT -"] && nominees.otherIDTF.text.length > 0 ) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Other ID Type is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//alert.tag = 500;
		[alert show];
	}
	else if ((![nominees.otherIDTypeLbl2.text isEqualToString:@"- SELECT -"]) && nominees.otherIDTypeLbl2.text.length > 0 && ([textFields validateOtherID:nominees.otherIDTF.text])) {
        //[nominees.otherIDTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid Other ID." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 400;
		[alert show];
		
	}
	else if (nominees.dobLbl.text.length == 0) {
        
        //[nominees.dobLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//alert.tag = 600;
		[alert show];
	}
    //	else if (strDOB && (![nominees.dobLbl.text isEqualToString:strDOB])) {
    //		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Invalid New IC No. against DOB." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		[alert show];
    //		alert.tag = 300;
    //		[alert show];
    //	}
	else if (nominees.sexSC.selectedSegmentIndex == -1) {
        
        //[nominees.sexSC becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Gender is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//alert.tag = 700;
		[alert show];
	}
    //	else if (((isMale && nominees.sexSC.selectedSegmentIndex == 1) || (!isMale && nominees.sexSC.selectedSegmentIndex == 0)) && nominees.icNoTF.text.length != 0) {
    //		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"New IC No. entered does not match with sex." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //		alert.tag = 300;
    //		[alert show];
    //	}
    
    
    else if (([nominees.nationalityLbl.text length] == 0)||[nominees.nationalityLbl.text isEqualToString:@"- SELECT -"]) {
        
        [nominees.nationalityLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1100;
		[alert show];
	}
	else if (nominees.icNoTF.text.length == 12 && ![nominees.nationalityLbl.text isEqualToString:@"MALAYSIAN"]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality didn’t match with IC No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1100;
		[alert show];
		
    }
    else if (([nominees.otherIDTypeLbl2.text isEqualToString:@"ARMY IDENTIFICATION NUMBER"] || [nominees.otherIDTypeLbl2.text  isEqualToString:@"BIRTH CERTIFICATE"] || [nominees.otherIDTypeLbl2.text  isEqualToString:@"OLD IDENTIFICATION NO"] || [nominees.otherIDTypeLbl2.text  isEqualToString:@"POLICE IDENTIFICATION NUMBER"]) && ![nominees.nationalityLbl.text isEqualToString:@"MALAYSIAN"]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1100;
		[alert show];
       
    }
    else if (([nominees.otherIDTypeLbl2.text isEqualToString:@"FOREIGNER BIRTH CERTIFICATE"] || [nominees.otherIDTypeLbl2.text  isEqualToString:@"FOREIGNER IDENTIFICATION NUMBER"] || [nominees.otherIDTypeLbl2.text  isEqualToString:@"PERMANENT RESIDENT"]) && [nominees.nationalityLbl.text isEqualToString:@"MALAYSIAN"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1100;
		[alert show];
        
    }
    
        
     else if ([nominees.otherIDTypeLbl2.text isEqualToString:@"SINGAPORE IDENTIFICATION NUMBER"] && ![nominees.nationalityLbl.text isEqualToString:@"SINGAPOREAN"]) {
         UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nationality didn’t match with Other ID No." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         alert.tag = 1100;
         [alert show];
         
     }
	
	 else if ([nominees.occupationLbl.text length] == 0) {
		 
		 [nominees.occupationLbl becomeFirstResponder];
		 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Occupation is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		 alert.tag = 1300;
		 [alert show];
	 }
	
	 else if (([nominees.occupationLbl.text length] == 0)||[nominees.occupationLbl.text isEqualToString:@"- SELECT -"]) {
		 
		 // [nominees.nationalityLbl becomeFirstResponder];
		 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Occupation is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		 alert.tag = 1300;
		 [alert show];
	 }
    
    else if (employerMandatory && [nominees.nameOfEmployerTF.text length] == 0 && [textFields trimWhiteSpaces:nominees.nameOfEmployerTF.text].length == 0)
    {
        
       // [nominees.relationshipLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Name of Employer is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1200;
		[alert show];
	}
//    else if (([textFields trimWhiteSpaces:nominees.nameOfEmployerTF.text].length == 0) && (![nominees.occupationLbl.text isEqualToString:@"HOUSEWIFE"] || ![nominees.occupationLbl.text isEqualToString:@"STUDENT"] || ![nominees.occupationLbl.text isEqualToString:@"JUVENILE"] || ![nominees.occupationLbl.text isEqualToString:@"RETIRED"] || ![nominees.occupationLbl.text isEqualToString:@"UNEMPLOYED"] || ![nominees.occupationLbl.text isEqualToString:@"TEMPORARILY UNEMPLOYED"]) )
//    {
//        
//        //[nominees.relationshipLbl becomeFirstResponder];
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Name of Employer is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1200;
//		[alert show];
//	}
    else if ([textFields trimWhiteSpaces:nominees.nameOfEmployerTF.text].length != 0 && [textFields validateString:nominees.nameOfEmployerTF.text])
	{
		//[nominees.nameTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1200;
		[alert show];
	}
    
    else if ([textFields trimWhiteSpaces:nominees.nameOfEmployerTF.text].length != 0  && [textFields validateOtherID:nominees.nameOfEmployerTF.text])
	{
		//[nominees.nameTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Invalid name format. Input must be alphabet A-Z, space, apostrophe ('), alias (@), slash (/), dash (-), bracket(()) or dot (.)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1200;
		[alert show];
	}
   
    else if (employerMandatory && [nominees.exactDuty.text length] == 0 && [textFields trimWhiteSpaces:nominees.exactDuty.text].length == 0)
    {
        
        //[nominees.exactDuty becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Exact Nature of Work is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1400;
		[alert show];
        
	}
//    else if ([textFields trimWhiteSpaces:nominees.exactDuty.text].length == 0) {
//        //[nominees.exactDuty becomeFirstResponder];
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Exact Nature of Work is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 1400;
//		[alert show];
//	}
    
    
	else if (nominees.sharePercentageTF.text.length == 0) {
        
       // [nominees.sharePercentageTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Percentage of Share is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
		alert.tag = 500;
		[alert show];
	}
	else if ([nominees.sharePercentageTF.text isEqualToString:@"0"]) {
        
       // [nominees.sharePercentageTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Percentage of Share must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 500;
		[alert show];
	}
	else if ([nominees.sharePercentageTF.text intValue] > 100) {
        
       // [nominees.sharePercentageTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Percentage of Share cannot be greater than 100." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 500;
		[alert show];
	}
	else if(/*[myNumber compare:myNumber2] == NSOrderedDescending*/ [myNumber intValue] > 100)
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1000;
		[alert show];
	}
	else if ([nominees.relationshipLbl.text length] == 0) {
        
       // [nominees.relationshipLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Relationship with Policy Owner is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1100;
		[alert show];
	}
    
	else if ([nominees.relationshipLbl.text isEqualToString:@"SELF"]) {
        
        //[nominees.relationshipLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Relationship cannot be SELF" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1100;
		[alert show];
	}
   
	//address validation
    
    else if ((!nominees.fa && [textFields trimWhiteSpaces:nominees.add1TF.text].length == 0 && nominees.isSameAddress == false) && (!nominees.CRfa && [textFields trimWhiteSpaces:nominees.CRadd1TF.text].length == 0) && [textFields trimWhiteSpaces:nominees.postcodeTF.text].length != 0 )
	{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 600;
		[alert show];
    }
    
    else if ((!nominees.fa && [textFields trimWhiteSpaces:nominees.add1TF.text].length == 0 && nominees.isSameAddress == false) && (!nominees.CRfa && [textFields trimWhiteSpaces:nominees.CRadd1TF.text].length == 0) && [textFields trimWhiteSpaces:nominees.CRpostcodeTF.text].length != 0 )
	{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 600;
		[alert show];
    }

	
	else if ((!nominees.fa && [textFields trimWhiteSpaces:nominees.add1TF.text].length == 0 && nominees.isSameAddress == false) && (!nominees.CRfa && [textFields trimWhiteSpaces:nominees.CRadd1TF.text].length == 0)&& [textFields trimWhiteSpaces:nominees.postcodeTF.text].length == 0 )
	{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either Residential Address or Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 600;
		[alert show];
    }
    
    else if ((!nominees.fa && [textFields trimWhiteSpaces:nominees.add1TF.text].length == 0 && nominees.isSameAddress == false) && (!nominees.CRfa && [textFields trimWhiteSpaces:nominees.CRadd1TF.text].length == 0)&& [textFields trimWhiteSpaces:nominees.CRpostcodeTF.text].length == 0 )
	{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Either Residential Address or Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 600;
		[alert show];
    }

	
    
    
//    else if ([textFields trimWhiteSpaces:_eAppPersonalDataVC.CRaddressTF.text].length == 0 && [textFields trimWhiteSpaces:_eAppPersonalDataVC.addressTF.text].length == 0 && !_eAppPersonalDataVC.fa && !_eAppPersonalDataVC.CRfa && [textFields trimWhiteSpaces:_eAppPersonalDataVC.postcodeTF.text].length != 0 ) {
//        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@" Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        alert.tag = 9001;
//        [alert show];
//        return FALSE;
//    }


    
	else if ((nominees.fa || nominees.postcodeTF.text.length != 0) && [textFields trimWhiteSpaces:nominees.add1TF.text].length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 600;
		[alert show];
	}
	
//	else if (!nominees.sa && [textFields trimWhiteSpaces:nominees.add1TF.text].length == 0 && nominees.isSameAddress == false) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		alert.tag = 600;
//		[alert show];
//	}
	else if (!nominees.fa && nominees.postcodeTF.text.length == 0 && [textFields trimWhiteSpaces:nominees.add1TF.text].length != 0) {
        
        //[nominees.postcodeTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Postcode for Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 700;
		[alert show];
	}
	else if (nominees.fa && (nominees.countryLbl.text.length == 0 || [nominees.countryLbl.text isEqualToString:@"- SELECT -"]) && [textFields trimWhiteSpaces:nominees.add1TF.text].length != 0) {
        
        //[nominees.countryLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Country for Residential Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 800;
		[alert show];
	}
	else if (!nominees.fa && [nominees.stateLbl.text isEqualToString:@"State"] && [textFields trimWhiteSpaces:nominees.add1TF.text].length != 0 && nominees.postcodeTF.text.length != 0) {
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Postcode for Residential Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 700;
		[alert show];
        
	}
    
    ////
	else if ((nominees.CRfa || nominees.CRpostcodeTF.text.length != 0) && [textFields trimWhiteSpaces:nominees.CRadd1TF.text].length == 0) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 601;
		[alert show];
	}

	else if (!nominees.CRfa && nominees.CRpostcodeTF.text.length == 0 && [textFields trimWhiteSpaces:nominees.CRadd1TF.text].length != 0) {
        
        //[nominees.postcodeTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Postcode for Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 701;
		[alert show];
	}
	else if (nominees.CRfa && [textFields trimWhiteSpaces:nominees.CRadd1TF.text].length != 0 && (nominees.CRcountryLbl.text.length == 0 || [nominees.CRcountryLbl.text isEqualToString:@"- SELECT -"])) {
    
        //[nominees.countryLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Country for Correspondence Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 801;
		[alert show];
	}
	else if (!nominees.sa && !nominees.fa && [nominees.CRstateLbl.text isEqualToString:@"State"] && [textFields trimWhiteSpaces:nominees.CRadd1TF.text].length != 0 && nominees.CRpostcodeTF.text.length != 0) {
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Postcode for Correspondence Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];	
		alert.tag = 901;
		[alert show];
        
	}
    ////
    
    else {
        // Check if i/c no is the same as policy owner
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
        FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
        [db open];
		
		NSString *poStatus;
		NSString *haveChildren;
		NSString *poRelationship;
        NSString *valid_msg;
        int *alert_response;
		
        FMResultSet *results = [db executeQuery:@"select LAName, LANewICNo, LAOtherIDType, LAOtherID, LAMaritalStatus, LARelationship, HaveChildren from eProposal_LA_Details where eProposalNo = ? AND POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y"];
        bool valid = TRUE;
		bool validName = true;
        while ([results next]) {
			NSString *name = [results objectForColumnName:@"LAName"];
            NSString *icNo = [results objectForColumnName:@"LANewICNo"];
            NSString *otherIDType = [results objectForColumnName:@"LAOtherIDType"];
            NSString *otherID = [results objectForColumnName:@"LAOtherID"];
            NSString *otherID_selected;
            
			poStatus = [results stringForColumn:@"LAMaritalStatus"];
			haveChildren = [results stringForColumn:@"HaveChildren"];
			poRelationship = [results stringForColumn:@"LARelationship"];
            
            // to get OtherID Type Code for comparison
            
            FMResultSet *resultsOtherID = [db executeQuery:@"select * from eProposal_Identification where IdentityDesc = ?",nominees.otherIDTypeLbl2.text];
            while ([resultsOtherID next]) {
                otherID_selected = [resultsOtherID stringForColumn:@"IdentityCode"];
            }
            
            
			NSLog(@"icnotf %@, icno %@", nominees.icNoTF.text, icNo);
            if ((nominees.icNoTF.text.length != 0 && [nominees.icNoTF.text isEqualToString:icNo])){
				valid = FALSE;
                valid_msg = @"Nominee's New IC No cannot be same as Policy Owner.";
                alert_response = 300;
			}
            //			else if ((nominees.otherIDTypeLbl2.text.length > 0) && (![nominees.otherIDTypeLbl2.text isEqualToString:@"- SELECT -"]) && [otherID_selected isEqualToString:otherIDType] && [nominees.otherIDTF.text isEqualToString:otherID]) {
            
			else if ((nominees.otherIDTypeLbl2.text.length > 0) && (![nominees.otherIDTypeLbl2.text isEqualToString:@"- SELECT -"]) && [otherID_selected isEqualToString:otherIDType] && [nominees.otherIDTF.text isEqualToString:otherID]) {
                valid = FALSE;
                valid_msg = @"Nominee's Other ID No cannot be same as Policy Owner";
                alert_response = 400;
            }
			else {
				valid = TRUE;
			}
			if (([textFields trimWhiteSpaces:nominees.nameTF.text].length != 0 && [nominees.nameTF.text caseInsensitiveCompare:name] == NSOrderedSame)){
				validName = FALSE;
			}
			else
				validName = TRUE;
        }
        [results close];
        [db close];
		
        NSLog(@"valid %d", valid);
        if (!valid) {
            //            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Policy Owner cannot be nominated as nominee." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:valid_msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = alert_response;
            [alert show];
            alert = nil;
        }
		else if (!validName){
			UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Nominee's name cannot be same as Policy Owner" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 200;
            [alert show];
            alert = nil;
		}
        else {
            //KY-save the record and dismiss
            NSString *gender;
            if(nominees.sexSC.selectedSegmentIndex == 0)
                gender = @"male";
            else if(nominees.sexSC.selectedSegmentIndex == 1)
                gender = @"female";
            
            if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"1"])
            {
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee1_share"];
                int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"] intValue];
                int share2 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"] intValue];
                int share3 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"] intValue];
                int share4 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"] intValue];
                //int share4 = [nominees.sharePercentageTF.text intValue];
                int total = share1 + share2 +share3 +share4;
                
                
                // if(total <= 100)
                // {
                
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee1_share"];
                //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.titleLbl.text forKey:@"Nominee1_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.TitleCodeSelected forKey:@"Nominee1_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameTF.text forKey:@"Nominee1_name"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.icNoTF.text forKey:@"Nominee1_ic"];
                //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTypeLbl2.text forKey:@"Nominee1_otherIDType"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.IDTypeCodeSelected forKey:@"Nominee1_otherIDType"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTF.text forKey:@"Nominee1_otherID"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.dobLbl.text forKey:@"Nominee1_dob"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:gender forKey:@"Nominee1_gender"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"Nominee1_relatioship"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nationalityLbl.text forKey:@"Nominee1_nationality"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.occupationLbl.text forKey:@"Nominee1_Occupation"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.exactDuty.text forKey:@"Nominee1_ExactDuties"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameOfEmployerTF.text forKey:@"Nominee1_nameofemployer"];
                
                
                
                
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nationalityLbl.text forKey:@"Nominee1_nationalityTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameOfEmployerTF.text forKey:@"Nominee1_nameOfEmployerTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.occupationLbl.text forKey:@"Nominee1_occupationTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.exactDuty.text forKey:@"Nominee1_exactDutiesTF"];
                
                if(nominees.btnSameAddress.tag == 1) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee1_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee1_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee1_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee1_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee1_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee1_townTF"];
                    //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee1_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee1_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee1_countryTF"];
                    
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee1_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee1_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee1_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee1_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee1_CRtownTF"];
                    //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee1_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee1_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee1_CRcountryTF"];
                }
                else if(nominees.btnForeignAddress.tag == 1)
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee1_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee1_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee1_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee1_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee1_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee1_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee1_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee1_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee1_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee1_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee1_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee1_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee1_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee1_CRcountryTF"];
                    
                }
                else
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"new" forKey:@"Nominee1_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee1_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee1_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee1_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee1_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee1_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee1_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee1_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"new" forKey:@"Nominee1_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee1_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee1_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee1_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee1_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee1_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee1_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee1_CRcountryTF"];
                    
                }
                
                
                
                
                //KY - Update the share value at NomineesTrustees VC
                
                NSString* str_share = [NSString stringWithFormat:@"%i", total];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
                
                // NSLog(@"MainNomineesTrusteesVC.h - TOTAL SHARE - %@",[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] );
                
                
                [_delegate updateTotalSharePct:str_share];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNominees" object:self];
                
                //[self dismissModalViewControllerAnimated:YES];
                
                //save for NMTrustStatus and NMChildAlive
                if ([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) {
                    if ([haveChildren isEqualToString:@"Y"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee1_ChildAlive"];
                    }
                    else if ([haveChildren isEqualToString:@"N"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee1_ChildAlive"];
                    }
                }
                else if ([poStatus isEqualToString:@"MARRIED"]) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee1_ChildAlive"];
                }
                else if ([poStatus isEqualToString:@"SINGLE"]){
                    if ([nominees.relationshipLbl.text isEqualToString:@"SON"] || [nominees.relationshipLbl.text isEqualToString:@"DAUGHTER"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee1_ChildAlive"];
                    }
                    else
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee1_ChildAlive"];
                }
                else
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_ChildAlive"];
                
                if (([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) && ([nominees.relationshipLbl.text isEqualToString:@"SON"] || [nominees.relationshipLbl.text isEqualToString:@"DAUGHTER"])) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee1_TrustStatus"];
                }
                else if (([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) && ([nominees.relationshipLbl.text isEqualToString:@"FATHER"] || [nominees.relationshipLbl.text isEqualToString:@"MOTHER"])) {
                    if ([haveChildren isEqualToString:@"Y"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee1_TrustStatus"];
                    }
                    else if ([haveChildren isEqualToString:@"N"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee1_TrustStatus"];
                    }
                }
                else
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee1_TrustStatus"];
                //}
				
				
                if(total > 100)
                {
					UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
					
                    //[alert setTag:1001];
                    [alert show];
                    alert = Nil;
					
					
					NSString* str_share = [NSString stringWithFormat:@"%i", total];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
					[_delegate updateTotalSharePct:str_share];
                    
                }
            }
            
            if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"2"])
            {
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee2_share"];
                int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"] intValue];
                int share2 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"] intValue];
                int share3 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"] intValue];
                int share4 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"] intValue];
                //  int share4 = [nominees.sharePercentageTF.text intValue];
                int total = share1 + share2 +share3 +share4;
                
                // if(total <= 100)
                //{
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee2_share"];
                
                //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.titleLbl.text forKey:@"Nominee2_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.TitleCodeSelected forKey:@"Nominee2_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameTF.text forKey:@"Nominee2_name"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.icNoTF.text forKey:@"Nominee2_ic"];
                //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTypeLbl2.text forKey:@"Nominee2_otherIDType"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.IDTypeCodeSelected forKey:@"Nominee2_otherIDType"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTF.text forKey:@"Nominee2_otherID"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.dobLbl.text forKey:@"Nominee2_dob"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:gender forKey:@"Nominee2_gender"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"Nominee2_relatioship"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nationalityLbl.text forKey:@"Nominee2_nationality"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.occupationLbl.text forKey:@"Nominee2_Occupation"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.exactDuty.text forKey:@"Nominee2_ExactDuties"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameOfEmployerTF.text forKey:@"Nominee2_nameofemployer"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nationalityLbl.text forKey:@"Nominee2_nationalityTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameOfEmployerTF.text forKey:@"Nominee2_nameOfEmployerTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.occupationLbl.text forKey:@"Nominee2_occupationTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.exactDuty.text forKey:@"Nominee2_exactDutiesTF"];
                
                
                
                
                if(nominees.btnSameAddress.tag == 1) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee2_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee2_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee2_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee2_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee2_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee2_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee2_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee2_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee2_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee2_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee2_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee2_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee2_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee2_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee2_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee2_CRcountryTF"];
                }
                else if(nominees.btnForeignAddress.tag == 1)
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee2_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee2_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee2_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee2_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee2_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee2_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee2_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee2_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee2_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee2_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee2_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee2_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee2_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee2_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee2_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee2_CRcountryTF"];
                    
                }
                else
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"new" forKey:@"Nominee2_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee2_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee2_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee2_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee2_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee2_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee2_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee2_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"new" forKey:@"Nominee2_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee2_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee2_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee2_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee2_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee2_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee2_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee2_CRcountryTF"];
                    
                }
                
                
                //KY - Update the share value at NomineesTrustees VC
                NSString* str_share = [NSString stringWithFormat:@"%i", total];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"TotalShare"];
                
                [_delegate updateTotalSharePct:str_share];
                
                //save for NMTrustStatus and NMChildAlive
                if ([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) {
                    if ([haveChildren isEqualToString:@"Y"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee2_ChildAlive"];
                    }
                    else if ([haveChildren isEqualToString:@"N"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee2_ChildAlive"];
                    }
                }
                else if ([poStatus isEqualToString:@"MARRIED"]) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee2_ChildAlive"];
                }
                else if ([poStatus isEqualToString:@"SINGLE"]){
                    if ([nominees.relationshipLbl.text isEqualToString:@"SON"] || [nominees.relationshipLbl.text isEqualToString:@"DAUGHTER"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee2_ChildAlive"];
                    }
                    else
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee2_ChildAlive"];
                }
                else
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_ChildAlive"];
                if (([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) && ([nominees.relationshipLbl.text isEqualToString:@"SON"] || [nominees.relationshipLbl.text isEqualToString:@"DAUGHTER"])) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee2_TrustStatus"];
                }
                else if (([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) && ([nominees.relationshipLbl.text isEqualToString:@"FATHER"] || [nominees.relationshipLbl.text isEqualToString:@"MOTHER"])) {
                    if ([haveChildren isEqualToString:@"Y"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee2_TrustStatus"];
                    }
                    else if ([haveChildren isEqualToString:@"N"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee2_TrustStatus"];
                    }
                }
                else
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee2_TrustStatus"];
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNominees" object:self];
                
                //[self dismissModalViewControllerAnimated:YES];
                
                
                //}
                if (total > 100)
                    
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    //[alert setTag:1001];
                    [alert show];
                    alert = Nil;
					
					
					NSString* str_share = [NSString stringWithFormat:@"%i", total];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
					[_delegate updateTotalSharePct:str_share];
					
                }
                
                
                
            }
			
            if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"3"])
            {
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee3_share"];
                int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"] intValue];
                int share2 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"] intValue];
                int share3 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"] intValue];
                int share4 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"] intValue];
                //  int share4 = [nominees.sharePercentageTF.text intValue];
                int total = share1 + share2 +share3 +share4;
                
                
                
                // if(total <= 100)
                // {
                
                
                //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.titleLbl.text forKey:@"Nominee3_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.TitleCodeSelected forKey:@"Nominee3_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameTF.text forKey:@"Nominee3_name"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.icNoTF.text forKey:@"Nominee3_ic"];
                //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTypeLbl2.text forKey:@"Nominee3_otherIDType"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.IDTypeCodeSelected forKey:@"Nominee3_otherIDType"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTF.text forKey:@"Nominee3_otherID"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.dobLbl.text forKey:@"Nominee3_dob"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:gender forKey:@"Nominee3_gender"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee3_share"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"Nominee3_relatioship"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nationalityLbl.text forKey:@"Nominee3_nationality"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.occupationLbl.text forKey:@"Nominee3_Occupation"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.exactDuty.text forKey:@"Nominee3_ExactDuties"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameOfEmployerTF.text forKey:@"Nominee3_nameofemployer"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nationalityLbl.text forKey:@"Nominee3_nationalityTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameOfEmployerTF.text forKey:@"Nominee3_nameOfEmployerTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.occupationLbl.text forKey:@"Nominee3_occupationTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.exactDuty.text forKey:@"Nominee3_exactDutiesTF"];
                
                if(nominees.btnSameAddress.tag == 1){
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee3_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee3_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee3_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee3_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee3_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee3_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee3_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee3_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee3_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee3_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee3_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee3_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee3_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee3_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee3_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee3_CRcountryTF"];
                }
                else if(nominees.btnForeignAddress.tag == 1)
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee3_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee3_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee3_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee3_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee3_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee3_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee3_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee3_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee3_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee3_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee3_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee3_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee3_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee3_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee3_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee3_CRcountryTF"];
                    
                }
                else
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"new" forKey:@"Nominee3_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee3_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee3_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee3_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee3_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee3_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee3_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee3_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"new" forKey:@"Nominee3_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee3_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee3_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee3_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee3_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee3_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee3_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee3_CRcountryTF"];
                }
                
                //KY - Update the share value at NomineesTrustees VC
                NSString* str_share = [NSString stringWithFormat:@"%i", total];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"TotalShare"];
                
                [_delegate updateTotalSharePct:str_share];
                
                //save for NMTrustStatus and NMChildAlive
                if ([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) {
                    if ([haveChildren isEqualToString:@"Y"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee3_ChildAlive"];
                    }
                    else if ([haveChildren isEqualToString:@"N"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee3_ChildAlive"];
                    }
                }
                else if ([poStatus isEqualToString:@"MARRIED"]) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee3_ChildAlive"];
                }
                else if ([poStatus isEqualToString:@"SINGLE"]){
                    if ([nominees.relationshipLbl.text isEqualToString:@"SON"] || [nominees.relationshipLbl.text isEqualToString:@"DAUGHTER"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee3_ChildAlive"];
                    }
                    else
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee3_ChildAlive"];
                }
                else
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_ChildAlive"];
                
                if (([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) && ([nominees.relationshipLbl.text isEqualToString:@"SON"] || [nominees.relationshipLbl.text isEqualToString:@"DAUGHTER"])) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee3_TrustStatus"];
                }
                else if (([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) && ([nominees.relationshipLbl.text isEqualToString:@"FATHER"] || [nominees.relationshipLbl.text isEqualToString:@"MOTHER"])) {
                    if ([haveChildren isEqualToString:@"Y"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee3_TrustStatus"];
                    }
                    else if ([haveChildren isEqualToString:@"N"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee3_TrustStatus"];
                    }
                }
                else
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee3_TrustStatus"];
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNominees" object:self];
                
                //[self dismissModalViewControllerAnimated:YES];
                
                //}
                if (total > 100)
                    
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
					
                    //[alert setTag:1001];
                    [alert show];
                    alert = Nil;
					
					
					NSString* str_share = [NSString stringWithFormat:@"%i", total];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
					[_delegate updateTotalSharePct:str_share];
                }
            }
			
            if([[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"WhichNominees"] isEqualToString:@"4"])
            {
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee4_share"];
                int share1 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_share"] intValue];
                int share2 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_share"] intValue];
                int share3 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_share"] intValue];
                int share4 = [[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_share"] intValue];
                //int share4 = [nominees.sharePercentageTF.text intValue];
                int total = share1 + share2 +share3 +share4;
                
                
                
                //if(total <= 100)
                //{
                
                
                //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.titleLbl.text forKey:@"Nominee4_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.TitleCodeSelected forKey:@"Nominee4_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameTF.text forKey:@"Nominee4_name"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.icNoTF.text forKey:@"Nominee4_ic"];
                //[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTypeLbl2.text forKey:@"Nominee4_otherIDType"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.IDTypeCodeSelected forKey:@"Nominee4_otherIDType"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTF.text forKey:@"Nominee4_otherID"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.dobLbl.text forKey:@"Nominee4_dob"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:gender forKey:@"Nominee4_gender"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee4_share"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"Nominee4_relatioship"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nationalityLbl.text forKey:@"Nominee4_nationality"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.occupationLbl.text forKey:@"Nominee4_Occupation"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.exactDuty.text forKey:@"Nominee4_ExactDuties"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameOfEmployerTF.text forKey:@"Nominee4_nameofemployer"];
                
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nationalityLbl.text forKey:@"Nominee4_nationalityTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameOfEmployerTF.text forKey:@"Nominee4_nameOfEmployerTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.occupationLbl.text forKey:@"Nominee4_occupationTF"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.exactDuty.text forKey:@"Nominee4_exactDutiesTF"];
                
                if(nominees.btnSameAddress.tag == 1) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee4_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee4_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee4_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee4_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee4_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee4_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee4_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee4_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee4_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee4_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee4_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee4_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee4_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee4_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee4_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee4_CRcountryTF"];
                }
                else if(nominees.btnForeignAddress.tag == 1)
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee4_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee4_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee4_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee4_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee4_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee4_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee4_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee4_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee4_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee4_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee4_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee4_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee4_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee4_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee4_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee4_CRcountryTF"];
                    
                }
                else
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"new" forKey:@"Nominee4_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee4_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee4_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee4_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee4_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee4_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee4_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee4_countryTF"];
                    
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"new" forKey:@"Nominee4_CRAddress"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd1TF.text forKey:@"Nominee4_CRadd1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd2TF.text forKey:@"Nominee4_CRadd2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRadd3TF.text forKey:@"Nominee4_CRadd3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRpostcodeTF.text forKey:@"Nominee4_CRpostcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRtownTF.text forKey:@"Nominee4_CRtownTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRstateLbl.text forKey:@"Nominee4_CRstateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.CRcountryLbl.text forKey:@"Nominee4_CRcountryTF"];
                }
                
                
                NSString* str_share = [NSString stringWithFormat:@"%i", total];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"TotalShare"];
                
                [_delegate updateTotalSharePct:str_share];
                
                //save for NMTrustStatus and NMChildAlive
                if ([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) {
                    if ([haveChildren isEqualToString:@"Y"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee4_ChildAlive"];
                    }
                    else if ([haveChildren isEqualToString:@"N"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee4_ChildAlive"];
                    }
                }
                else if ([poStatus isEqualToString:@"MARRIED"]) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee4_ChildAlive"];
                }
                else if ([poStatus isEqualToString:@"SINGLE"]){
                    if ([nominees.relationshipLbl.text isEqualToString:@"SON"] || [nominees.relationshipLbl.text isEqualToString:@"DAUGHTER"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee4_ChildAlive"];
                    }
                    else
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee4_ChildAlive"];
                }
                else
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_ChildAlive"];
                
                if (([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) && ([nominees.relationshipLbl.text isEqualToString:@"SON"] || [nominees.relationshipLbl.text isEqualToString:@"DAUGHTER"])) {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee4_TrustStatus"];
                }
                else if (([poStatus isEqualToString:@"DIVORCED"] || [poStatus isEqualToString:@"WIDOW"] || [poStatus isEqualToString:@"WIDOWER"]) && ([nominees.relationshipLbl.text isEqualToString:@"FATHER"] || [nominees.relationshipLbl.text isEqualToString:@"MOTHER"])) {
                    if ([haveChildren isEqualToString:@"Y"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"Y" forKey:@"Nominee4_TrustStatus"];
                    }
                    else if ([haveChildren isEqualToString:@"N"]) {
                        [[obj.eAppData objectForKey:@"SecD"] setValue:@"N" forKey:@"Nominee4_TrustStatus"];
                    }
                }
                else
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"" forKey:@"Nominee4_TrustStatus"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNominees" object:self];
                
                //[self dismissModalViewControllerAnimated:YES];
                
                //}
                if(total > 100)
                    
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@" " message:@"Total Percentage of Share exceeded 100%." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
					
                    //[alert setTag:1001];
                    [alert show];
                    alert = Nil;
					
					
					NSString* str_share = [NSString stringWithFormat:@"%i", total];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
					[_delegate updateTotalSharePct:str_share];
                }
            }
            
            [self dismissViewControllerAnimated:YES completion:Nil];
        }
 	}
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"1" forKey:@"EAPPSave"]; //When done, it's still not save into database, alert user to save. 
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 200) {
        [nominees.nameTF becomeFirstResponder];
    }
    else if (alertView.tag == 300) {
        [nominees.icNoTF becomeFirstResponder];
    }
	else if (alertView.tag == 400) {
        [nominees.otherIDTF becomeFirstResponder];
    }
    
    else if (alertView.tag == 1400) {
        [nominees.exactDuty becomeFirstResponder];
    }
	else if (alertView.tag == 500) {
        [nominees.sharePercentageTF becomeFirstResponder];
    }
	else if (alertView.tag == 600) {
        [nominees.add1TF becomeFirstResponder];
    }
	else if (alertView.tag == 700) {
        [nominees.postcodeTF becomeFirstResponder];
    }
    else if (alertView.tag == 800) {
        [nominees.countryLbl becomeFirstResponder];
    }
	else if (alertView.tag == 900) {
        [nominees.stateLbl becomeFirstResponder];
    }

    
    else if (alertView.tag == 601) {
        [nominees.CRadd1TF becomeFirstResponder];
    }
    else if (alertView.tag == 701) {
        [nominees.CRpostcodeTF becomeFirstResponder];
    }
    else if (alertView.tag == 801) {
        [nominees.CRcountryLbl becomeFirstResponder];
    }
	else if (alertView.tag == 901) {
        [nominees.CRstateLbl becomeFirstResponder];
    }


}



- (IBAction)selectCancel:(id)sender {
	[[obj.eAppData objectForKey:@"EAPP"] setValue:@"0" forKey:@"EAPPSave"]; //no change be made, cancel save prompt
	[self dismissModalViewControllerAnimated:YES];
}


- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (BOOL) validateTrust: (int) current {
    NSArray *childrens = [[NSArray alloc] initWithObjects:@"DAUGHTER", @"SON",nil];
    NSArray *parents = [[NSArray alloc] initWithObjects:@"FATHER", @"MOTHER",nil];
    NSArray *childrensNSpouse = [[NSArray alloc] initWithObjects:@"HUSBAND", @"WIFE", @"DAUGHTER", @"SON", nil];
    NSArray *status = [[NSArray alloc] initWithObjects:@"DIVORCED", @"WIDOW", @"WIDOWER",nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"hladb.sqlite"];
    
    NSString *poStatus;
    NSString *haveChildren;
	NSString *poRelationship;
    
    NSString *relationship1;
    NSString *relationship2;
    NSString *relationship3;
    NSString *relationship4;
    
    FMDatabase *database = [FMDatabase databaseWithPath:path];
    [database open];
    
    FMResultSet *resultsStatus = [database executeQuery:@"select LAMaritalStatus, LARelationship, HaveChildren from eProposal_LA_Details where eProposalNo = ? and POFlag = ?", [[obj.eAppData objectForKey:@"EAPP"] objectForKey:@"eProposalNo"], @"Y", Nil];
    NSLog(@"%@", [database lastErrorMessage]);
    while ([resultsStatus next]) {
        poStatus = [resultsStatus stringForColumn:@"LAMaritalStatus"];
        haveChildren = [resultsStatus stringForColumn:@"HaveChildren"];
		poRelationship = [resultsStatus stringForColumn:@"LARelationship"];
    }
    
    [database close];
    
    // get nominees relationship with PO
    if (![_Nominee1Lbl.text isEqualToString:@"Add Nominee (1)"] || current == 1) {
        relationship1 = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"];
        if (current == 1) {
            relationship1 = nominees.relationshipLbl.text;
        }
    }
    if (![_Nominee2Lbl.text isEqualToString:@"Add Nominee (2)"] || current == 2) {
        relationship2 = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee2_relatioship"];
        if (current == 2) {
            relationship2 = nominees.relationshipLbl.text;
        }
    }
    if (![_Nominee3Lbl.text isEqualToString:@"Add Nominee (3)"] || current == 3) {
        relationship3 = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee3_relatioship"];
        if (current == 3) {
            relationship3 = nominees.relationshipLbl.text;
        }
    }
    if (![_Nominee4Lbl.text isEqualToString:@"Add Nominee (4)"] || current == 4) {
        relationship4 = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee4_relatioship"];
        if (current == 4) {
            relationship4 = nominees.relationshipLbl.text;
        }
    }
    
    poStatus = [textFields trimWhiteSpaces:poStatus];
    if ([status containsObject:poStatus]) {
        if (haveChildren && [haveChildren isEqualToString:@"Y"]) {
            if (relationship1) {
                if ([childrens containsObject:relationship1]) {
                    return TRUE;
                }
            }
            if (relationship2) {
                if ([childrens containsObject:relationship2]) {
                    return TRUE;
                }
            }
            if (relationship3) {
                if ([childrens containsObject:relationship3]) {
                    return TRUE;
                }
            }
            if (relationship4) {
                if ([childrens containsObject:relationship4]) {
                    return TRUE;
                }
            }
        }
        else {
            if (relationship1) {
                if ([parents containsObject:relationship1]) {
                    return TRUE;
                }
            }
            if (relationship2) {
                if ([parents containsObject:relationship2]) {
                    return TRUE;
                }
            }
            if (relationship3) {
                if ([parents containsObject:relationship3]) {
                    return TRUE;
                }
            }
            if (relationship4) {
                if ([parents containsObject:relationship4]) {
                    return TRUE;
                }
            }
        }
        return FALSE;
    }
    else if ([poStatus isEqualToString:@"SINGLE"]) {
        if (relationship1) {
            if ([parents containsObject:relationship1]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship1]) {
				return TRUE;
			}
        }
        if (relationship2) {
            if ([parents containsObject:relationship2]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship2]) {
				return TRUE;
			}
        }
        if (relationship3) {
            if ([parents containsObject:relationship3]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship3]) {
				return TRUE;
			}
        }
        if (relationship4) {
            if ([parents containsObject:relationship4]) {
                return TRUE;
            }
			if ([childrens containsObject:relationship4]) {
				return TRUE;
			}
        }
        return FALSE;
	}
    else if ([poStatus isEqualToString:@"MARRIED"]) {
        if (relationship1) {
            if ([childrensNSpouse containsObject:relationship1]) {
                return TRUE;
            }
        }
        if (relationship2) {
            if ([childrensNSpouse containsObject:relationship2]) {
                return TRUE;
            }
        }
        if (relationship3) {
            if ([childrensNSpouse containsObject:relationship3]) {
                return TRUE;
            }
        }
        if (relationship4) {
            if ([childrensNSpouse containsObject:relationship4]) {
                return TRUE;
            }
        }
        return FALSE;
    }
    return FALSE;
}

- (BOOL) validateRelationChange {
	
	//int gotTrustee = 0;
	//int gotOtherNominee = 0;
	
	
	//1-get new relationship in nominee
	
    // check if trusstee exist and other relationship nominee
	
	//1- check if there are trustee
	//2 check other nominee with trust alow
	//3 - prompt error
	//4 - delete trustee
	
	
	//	if (![_Trustee1Lbl.text isEqualToString:@"Add Trustee (1)"] || ![_Trustee2Lbl.text isEqualToString:@"Add Trustee (2)"]) {
	//        bool trust = [self validateTrust:no];
	//        if (!trust) {
	//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Appointment of Trustee is not allowed for non-trust policy." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//            [alert show];
	//            alert = Nil;
	//            return;
	//        }
	//    }
	
	return TRUE;
}


//For NM Title
-(NSString*) getTitleDesc : (NSString*)Title
{
    NSString *desc;
    Title = [Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleDesc FROM eProposal_Title WHERE TitleCode = ?", Title];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"TitleDesc"];
    }
	
    [result close];
    [db close];
    
	if (count == 0) {
		if (Title.length > 0) {
			if ([Title isEqualToString:@"- SELECT -"] || [Title isEqualToString:@"- Select -"]) {
				desc = @"";
			}
			else {
				desc = Title;
				[self getTitleCode:Title];
			}		}
	}
    return desc;
}
-(void) getTitleCode : (NSString*)Title
{
    NSString *code;
	Title = [Title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT TitleCode FROM eProposal_Title WHERE TitleDesc = ?", Title];
    
    while ([result next]) {
        code =[result objectForColumnName:@"TitleCode"];
    }
	
    [result close];
    [db close];
	
	nominees.TitleCodeSelected = code;
	
}

-(NSString*) getStateDesc : (NSString*)state
{
    NSString *desc;
	state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT StateDesc FROM eProposal_state WHERE stateCode = ?", state];
    
    NSInteger *count = 0;
    while ([result next]) {
		count = count + 1;
        desc =[result objectForColumnName:@"stateDesc"];
    }
	
    [result close];
    [db close];
    
	if (count == 0) {
		if (state.length > 0) {
			if ([state isEqualToString:@"State"]){
				desc = @"";
			}
			else {
				desc = state;
				[self getStateCode:state];
			}
		}
	}
    return desc;
}

-(void) getStateCode : (NSString*)state
{
    NSString *code;
	state = [state stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    FMResultSet *result = [db executeQuery:@"SELECT stateCode FROM eProposal_state WHERE StateDesc = ?", state];
    
    while ([result next]) {
        code =[result objectForColumnName:@"StateDesc"];
    }
	
    [result close];
    [db close];
	
	nominees.StateCode = code;
	
}

-(void) CheckOccuCat : (NSString*) occCode {
	
	NSString *code = @"";
	NSString *cat = @"";
	occCode = [occCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]; //occpDesc
	
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	databasePath = [documentsDirectory stringByAppendingPathComponent:@"hladb.sqlite"];
	
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
	
	FMResultSet *result2 = [db executeQuery:@"select OccpCode from Adm_Occp where OccpDesc = ?", occCode, nil];
	
	while ([result2 next]) {
		code = [result2 stringForColumn:@"OccpCode"];
	}
	
    FMResultSet *result = [db executeQuery:@"select a.OccpCatCode, b.OccpCode from Adm_OccpCat a inner join Adm_OccpCat_Occp b on a.OccpCatCode = b.OccpCatCode where b.OccpCode = ?", code];
    
    while ([result next]) {
        cat = [result stringForColumn:@"OccpCatCode"];
        NSLog(@"cat: %@", cat);
		cat = [cat stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
    }
	
	if ([cat isEqualToString:@"HSEWIFE"] || [cat isEqualToString:@"JUV"] || [cat isEqualToString:@"RET"] || [cat isEqualToString:@"STU"] || [cat isEqualToString:@"UNEMP"]) {
		employerMandatory = FALSE;
	}
	else
		employerMandatory = TRUE;
	
    [result close];
    [db close];

	
}

@end
