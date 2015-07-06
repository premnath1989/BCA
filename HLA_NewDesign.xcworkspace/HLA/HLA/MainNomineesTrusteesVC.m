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
//#import "Utility.h"

@interface MainNomineesTrusteesVC ()
{
    DataClass *obj;
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
	nominees.titleLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_title"];
	nominees.nameTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_name"];
	nominees.icNoTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_ic"];
	nominees.otherIDTypeLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherIDType"];
	nominees.otherIDTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_otherID"];
	nominees.dobLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_dob"];
	nominees.relationshipLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_relatioship"];
	
	nominees.add1TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add1TF"];
	nominees.add2TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add2TF"];
	nominees.add3TF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_add3TF"];
	nominees.postcodeTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_postcodeTF"];
	nominees.townTF.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_townTF"];
	nominees.stateLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_stateTF"];
	nominees.countryLbl.text = [[obj.eAppData objectForKey:@"SecD"] objectForKey:@"Nominee1_countryTF"];
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
	
	NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
	[f setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *myNumber = [f numberFromString:nominees.sharePercentageTF.text];
	
	NSNumberFormatter * f2 = [[NSNumberFormatter alloc] init];
	[f2 setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber *myNumber2 = [f2 numberFromString:@"100"];

	if ([nominees.titleLbl.text isEqualToString:@"Title"]) {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Title is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 100;
		[alert show];
	}
	else if (nominees.nameTF.text.length == 0) {
        
        [nominees.nameTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 200;
		[alert show];
	}
	else if ([textFields validateString:nominees.nameTF.text])
	{
        [nominees.nameTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Invalid name format. Same alphabet cannot be repeated more than three times." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 300;
		[alert show];
	}
	else if ( nominees.icNoTF.text.length == 0 || [nominees.icNoTF.text isEqualToString:@"New IC No"] || [nominees.otherIDTypeLbl.text isEqualToString:@"Other ID Type"]) {
		
        [nominees.icNoTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Either New IC No. or Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 400;
		[alert show];
	}
	else if (![nominees.otherIDTypeLbl.text isEqualToString:@"Other ID Type"] && nominees.otherIDTF.text.length == 0) {
		
        [nominees.otherIDTF becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Other ID is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 500;
		[alert show];
	}
	else if ([nominees.dobLbl.text isEqualToString:@"Date of Birth"]) {
        
        [nominees.dobLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Date of Birth is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 600;
		[alert show];
	}
	else if (nominees.sexSC.selectedSegmentIndex == -1) {
        
        [nominees.sexSC becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Sex is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 700;
		[alert show];
	}
	else if (nominees.sharePercentageTF.text.length == 0) {
        
         [nominees.sharePercentageTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Percentage of Share is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

		alert.tag = 800;
		[alert show];
	}
	else if ([nominees.sharePercentageTF.text isEqualToString:@"0"]) {
        
        [nominees.sharePercentageTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Percentage of Share must be greater than zero." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 900;
		[alert show];
	}
	else if([myNumber compare:myNumber2] == NSOrderedDescending)
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1000;
		[alert show];
	}
	else if ([nominees.relationshipLbl.text isEqualToString:@"Relationship with Policy Owner"]) {
        
        [nominees.relationshipLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Relationship with Policy Owner is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1100;
		[alert show];
	}
	else if (!nominees.sa && nominees.add1TF.text.length == 0 && nominees.isSameAddress == false) {
       
        [nominees.add1TF becomeFirstResponder];
    
        
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1200;
		[alert show];
	}
	else if (!nominees.sa && !nominees.fa && nominees.postcodeTF.text.length == 0 && nominees.isSameAddress == false) {
        
        [nominees.postcodeTF becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Postcode is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1300;
		[alert show];
	}
	else if (!nominees.sa && nominees.fa && [nominees.countryLbl.text isEqualToString:@"Country"] && nominees.isSameAddress == false) {
        
        [nominees.countryLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Country is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1400;
		[alert show];
	}
	else if (!nominees.sa && !nominees.fa && [nominees.stateLbl.text isEqualToString:@"State"] && nominees.isSameAddress == false) {
        
        [nominees.stateLbl becomeFirstResponder];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Invalid Postcode." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		alert.tag = 1500;
		[alert show];

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
            
            
            if(total <= 100)
            {
				
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee1_share"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.titleLbl.text forKey:@"Nominee1_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameTF.text forKey:@"Nominee1_name"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.icNoTF.text forKey:@"Nominee1_ic"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTypeLbl.text forKey:@"Nominee1_otherIDType"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTF.text forKey:@"Nominee1_otherID"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.dobLbl.text forKey:@"Nominee1_dob"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:gender forKey:@"Nominee1_gender"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"Nominee1_relatioship"];
                
				if(nominees.btnSameAddress.tag == 1)
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee1_Address"];
                else if(nominees.btnForeignAddress.tag == 1)
                {
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"foreign" forKey:@"Nominee1_Address"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add1TF.text forKey:@"Nominee1_add1TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add2TF.text forKey:@"Nominee1_add2TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.add3TF.text forKey:@"Nominee1_add3TF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.postcodeTF.text forKey:@"Nominee1_postcodeTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.townTF.text forKey:@"Nominee1_townTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.stateLbl.text forKey:@"Nominee1_stateTF"];
                    [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.countryLbl.text forKey:@"Nominee1_countryTF"];
                    
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
                }

                
                //KY - Update the share value at NomineesTrustees VC
                
                NSString* str_share = [NSString stringWithFormat:@"%i", total];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:str_share forKey:@"TotalShare"];
                
               // NSLog(@"MainNomineesTrusteesVC.h - TOTAL SHARE - %@",[[obj.eAppData objectForKey:@"SecD"] objectForKey:@"TotalShare"] );
                
                
                [_delegate updateTotalSharePct:str_share];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNominees" object:self];
                
                [self dismissModalViewControllerAnimated:YES];
				
            }
            else  if(total > 100)
            {
                NSLog(@"TOTAL - %i", total);
				UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
				
				[alert setTag:1001];
                [alert show];
				alert = Nil;
				
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
                        
            if(total <= 100)
            {
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee2_share"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.titleLbl.text forKey:@"Nominee2_title"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameTF.text forKey:@"Nominee2_name"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.icNoTF.text forKey:@"Nominee2_ic"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTypeLbl.text forKey:@"Nominee2_otherIDType"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTF.text forKey:@"Nominee2_otherID"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.dobLbl.text forKey:@"Nominee2_dob"];
                [[obj.eAppData objectForKey:@"SecD"] setValue:gender forKey:@"Nominee2_gender"];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"Nominee2_relatioship"];
				
				if(nominees.btnSameAddress.tag == 1)
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee2_Address"];
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
                }
				
                
                //KY - Update the share value at NomineesTrustees VC
                NSString* str_share = [NSString stringWithFormat:@"%i", total];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"TotalShare"];
                
                [_delegate updateTotalSharePct:str_share];
                
				
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNominees" object:self];
                
                [self dismissModalViewControllerAnimated:YES];
            }
            else
				
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                
                [alert setTag:1001];
                [alert show];
                alert = Nil;
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
            
          
            
            if(total <= 100)
            {
				
				
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.titleLbl.text forKey:@"Nominee3_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameTF.text forKey:@"Nominee3_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.icNoTF.text forKey:@"Nominee3_ic"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTypeLbl.text forKey:@"Nominee3_otherIDType"];
				
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTF.text forKey:@"Nominee3_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.dobLbl.text forKey:@"Nominee3_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:gender forKey:@"Nominee3_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee3_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"Nominee3_relatioship"];
				
				if(nominees.btnSameAddress.tag == 1)
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee3_Address"];
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
                }

                //KY - Update the share value at NomineesTrustees VC
                NSString* str_share = [NSString stringWithFormat:@"%i", total];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"TotalShare"];
                
                [_delegate updateTotalSharePct:str_share];
                
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNominees" object:self];
                
                [self dismissModalViewControllerAnimated:YES];
                
            }
            else
                
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                
                [alert setTag:1001];
                [alert show];
                alert = Nil;
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
            
            
            
            if(total <= 100)
            {
				
                
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.titleLbl.text forKey:@"Nominee4_title"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.nameTF.text forKey:@"Nominee4_name"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.icNoTF.text forKey:@"Nominee4_ic"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTypeLbl.text forKey:@"Nominee4_otherIDType"];
				
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.otherIDTF.text forKey:@"Nominee4_otherID"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.dobLbl.text forKey:@"Nominee4_dob"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:gender forKey:@"Nominee4_gender"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.sharePercentageTF.text forKey:@"Nominee4_share"];
				[[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"Nominee4_relatioship"];
				
				if(nominees.btnSameAddress.tag == 1)
                    [[obj.eAppData objectForKey:@"SecD"] setValue:@"same" forKey:@"Nominee4_Address"];
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
                }

                
                NSString* str_share = [NSString stringWithFormat:@"%i", total];
                
                [[obj.eAppData objectForKey:@"SecD"] setValue:nominees.relationshipLbl.text forKey:@"TotalShare"];
                
                [_delegate updateTotalSharePct:str_share];
                
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNominees" object:self];
                
                [self dismissModalViewControllerAnimated:YES];
                
            }
            else   if(total > 100)
                
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"iMobile Planner" message:@"Total Percentage of Share exceeded 100%." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                
                [alert setTag:1001];
                [alert show];
                alert = Nil;
            }
        }
        
	[self dismissModalViewControllerAnimated:YES];	
		
 	}
}

- (IBAction)selectCancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}


- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
