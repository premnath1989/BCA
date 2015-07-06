//
//  CustomerClientProfile.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/29/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomerClientProfile.h"
#import "CustomerViewController.h"
#import "DataClass.h"
#import "FMDatabase.h"
#import "textFields.h"

@interface CustomerClientProfile () {
	DataClass *obj;
}

@end

@implementation CustomerClientProfile
@synthesize CustomerVC = _CustomerVC;

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
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"mengcheong_Storyboard" bundle:nil];
    
    self.CustomerVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
    [self addChildViewController:self.CustomerVC];
    [self.contentView addSubview:self.CustomerVC.view];
    [self.contentView setBackgroundColor:self.CustomerVC.view.backgroundColor];
	
	obj = [DataClass getInstance];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDoneBtn:nil];
    [self setCustomerTitle:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}
- (IBAction)doDone:(id)sender {
    [_CustomerVC resignFirstResponder];
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    if ([textFields trimWhiteSpaces:_CustomerVC.mailingAddress1.text].length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Mailing Address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1001;
        [alert show];
        alert = nil;
        return;
    }
    if (_CustomerVC.PostCode.text.length == 0 && !_CustomerVC.foreignAddress) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Mailing Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1002;
        [alert show];
        alert = nil;
        return;
    }
    else if (_CustomerVC.PostCode.text.length != 0 && !_CustomerVC.foreignAddress) {
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        [db open];
        FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", _CustomerVC.PostCode.text];
        bool valid = FALSE;
        while ([result next]) {
            valid = TRUE;
        }
        [db close];
        if (!valid || _CustomerVC.PostCode.text.length != 5) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Mailing Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1002;
            [alert show];
            alert = nil;
            return;
        }
    }
    if (_CustomerVC.mailingAddressCountry.text.length == 0 || [_CustomerVC.mailingAddressCountry.text isEqualToString:@"- SELECT -"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Mailing Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
	
	NSString *eApp = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"isEAPP"];
	//NSLog(@"test %@", eApp);
	
	if (eApp) {
		if ([textFields trimWhiteSpaces:_CustomerVC.permanentAddress1.text].length == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Permanent Address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1012;
			[alert show];
			alert = nil;
			return;
		}
		
		
		
		if (!_CustomerVC.permanentForeignAddress){
			
			if (_CustomerVC.permanentAddressPostCode.text.length == 0) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Permanent Address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				alert.tag = 1013;
				[alert show];
				alert = nil;
				return;
			}
			else if (_CustomerVC.permanentAddressPostCode.text.length > 0) {
				NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
				NSString *docsDir = [dirPaths objectAtIndex:0];
				NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
				FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
				[db open];
				FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", _CustomerVC.permanentAddressPostCode.text];
				bool valid = FALSE;
				while ([result next]) {
					valid = TRUE;
				}
				[db close];
				if (!valid || _CustomerVC.permanentAddressPostCode.text.length != 5) {
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Permanent Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
					alert.tag = 1013;
					[alert show];
					alert = nil;
					return;
				}
			}
		}
		
		if (_CustomerVC.permanentAddressCountry.text.length == 0 || [_CustomerVC.permanentAddressCountry.text isEqualToString:@"- SELECT -"]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Permanent Address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			alert = nil;
			return;
		}
	}
	
	
	
	
	if ([eApp isEqualToString:@"Y"]){
		
		if (_CustomerVC.ResidenceTel.text.length == 0 && _CustomerVC.ResidenceTelExt.text.length == 0 && _CustomerVC.OfficeTel.text.length == 0 && _CustomerVC.OfficeTelExt.text.length == 0 && _CustomerVC.MobileTel.text.length == 0 && _CustomerVC.MobileTelExt.text.length == 0 && _CustomerVC.Fax.text.length == 0  && _CustomerVC.FaxExt.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please enter at least one of the contact numbers (Residential, Office, Mobile or Fax)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1004;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.ResidenceTel.text.length > 0 && _CustomerVC.ResidenceTelExt.text.length == 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for residential number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1004;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.ResidenceTel.text.length < 6 && _CustomerVC.ResidenceTelExt.text.length > 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residential number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1003;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.OfficeTel.text.length > 0 && _CustomerVC.OfficeTelExt.text.length == 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for office number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1006;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.OfficeTel.text.length < 6 && _CustomerVC.OfficeTelExt.text.length > 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1005;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.MobileTel.text.length > 0 && _CustomerVC.MobileTelExt.text.length == 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for mobile number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1008;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.MobileTel.text.length < 6 && _CustomerVC.MobileTelExt.text.length > 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Mobile number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1007;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.Fax.text.length > 0  && _CustomerVC.FaxExt.text.length == 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for fax number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1010;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.Fax.text.length < 6 && _CustomerVC.FaxExt.text.length > 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fax number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1009;
			[alert show];
			alert = nil;
			return;
		}
		else if (_CustomerVC.Email.text.length != 0 && ![textFields validateEmail:[textFields trimWhiteSpaces:_CustomerVC.Email.text]]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"You have entered an invalid email. Please key in the correct email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1011;
			[alert show];
			alert = nil;
			return;
		}
		
	}
    // Saving customer data into dataclass
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.prospectTitle.text forKey:@"CustomerTitle"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.prospectName.text forKey:@"CustomerName"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.IDTypeNo.text forKey:@"CustomerNRIC"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.otherIDType.text forKey:@"CustomerOtherIDType"];
	
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.OtherIDTypeNo.text forKey:@"CustomerOtherID"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.race.text forKey:@"CustomerRace"];
    
    if (_CustomerVC.religion.selectedSegmentIndex == 0) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"MUSLIM" forKey:@"CustomerReligion"];
    }
    else if (_CustomerVC.religion.selectedSegmentIndex == 1) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"NON-MUSLIM" forKey:@"CustomerReligion"];
    }
    else {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"- SELECT -" forKey:@"CustomerReligion"];
    }
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.nationality.text forKey:@"CustomerNationality"];
    
    if (_CustomerVC.gender.selectedSegmentIndex == 0) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"MALE" forKey:@"CustomerSex"];
    }
    else if (_CustomerVC.gender.selectedSegmentIndex == 1) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"FEMALE" forKey:@"CustomerSex"];
    }
    else {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"(null)" forKey:@"CustomerSex"];
    }
    
    if (_CustomerVC.smoker.selectedSegmentIndex == 0) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"Y" forKey:@"CustomerSmoker"];
    }
    else if (_CustomerVC.smoker.selectedSegmentIndex == 1) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"N" forKey:@"CustomerSmoker"];
    }
    else {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"(null)" forKey:@"CustomerSmoker"];
    }
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.DOB.text forKey:@"CustomerDOB"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.age.text forKey:@"CustomerAge"];
    
    if (_CustomerVC.maritalStatus.selectedSegmentIndex == 0) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"DIVORCED" forKey:@"CustomerMaritalStatus"];
    }
    else if (_CustomerVC.maritalStatus.selectedSegmentIndex == 1) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"MARRIED" forKey:@"CustomerMaritalStatus"];
    }
    else if (_CustomerVC.maritalStatus.selectedSegmentIndex == 2) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"SINGLE" forKey:@"CustomerMaritalStatus"];
    }
    else if (_CustomerVC.maritalStatus.selectedSegmentIndex == 3) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"WIDOW" forKey:@"CustomerMaritalStatus"];
    }
    else if (_CustomerVC.maritalStatus.selectedSegmentIndex == 4) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"WIDOWER" forKey:@"CustomerMaritalStatus"];
    }
    else {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"- SELECT -" forKey:@"CustomerMaritalStatus"];
    }
    
    if (_CustomerVC.foreignAddress) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerMailingAddressForeign"];
    }
    else if (!_CustomerVC.foreignAddress) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerMailingAddressForeign"];
    }
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.mailingAddress1.text forKey:@"CustomerMailingAddress1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.mailingAddress2.text forKey:@"CustomerMailingAddress2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.mailingAddress3.text forKey:@"CustomerMailingAddress3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.PostCode.text forKey:@"CustomerMailingPostcode"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.Town.text forKey:@"CustomerMailingAddressTown"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.mailingAddressState.text forKey:@"CustomerMailingAddressState"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.mailingAddressCountry.text forKey:@"CustomerMailingAddressCountry"];
    
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.permanentAddress1.text forKey:@"CustomerPermanentAddress1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.permanentAddress2.text forKey:@"CustomerPermanentAddress2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.permanentAddress3.text forKey:@"CustomerPermanentAddress3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.permanentAddressPostCode.text forKey:@"CustomerPermanentPostcode"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.permanentAddressTown.text forKey:@"CustomerPermanentAddressTown"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.permanentAddressState.text forKey:@"CustomerPermanentAddressState"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.permanentAddressCountry.text forKey:@"CustomerPermanentAddressCountry"];
    
    //NSLog(@"Country: %@", [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"]);
    
    if (_CustomerVC.permanentForeignAddress) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"CustomerPermanentAddressForeign"];
    }
    else if (!_CustomerVC.permanentForeignAddress) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"CustomerPermanentAddressForeign"];
    }
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.ResidenceTelExt.text forKey:@"ResidenceTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.ResidenceTel.text forKey:@"ResidenceTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.OfficeTelExt.text forKey:@"OfficeTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.OfficeTel.text forKey:@"OfficeTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.MobileTelExt.text forKey:@"MobileTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.MobileTel.text forKey:@"MobileTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.FaxExt.text forKey:@"FaxTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.Fax.text forKey:@"FaxTel"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:_CustomerVC.Email.text forKey:@"Email"];
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
	
	/*if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"1"]){
        [_CustomerVC.mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    }
    else{
        [_CustomerVC.mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    }
    _CustomerVC.mailingAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"];
    _CustomerVC.mailingAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"];
    _CustomerVC.mailingAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"];
    _CustomerVC.PostCode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"];
    _CustomerVC.Town.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"];
    _CustomerVC.mailingAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"];
    _CustomerVC.mailingAddressCountry.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"];*/
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
        [_CustomerVC.mailingAddress1 becomeFirstResponder];
    }
    else if (alertView.tag == 1002) {
        [_CustomerVC.PostCode becomeFirstResponder];
    }
	else if (alertView.tag == 1003) {
        [_CustomerVC.ResidenceTel becomeFirstResponder];
    }
	else if (alertView.tag == 1004) {
        [_CustomerVC.ResidenceTelExt becomeFirstResponder];
    }
	else if (alertView.tag == 1005) {
        [_CustomerVC.OfficeTel becomeFirstResponder];
    }
	else if (alertView.tag == 1006) {
        [_CustomerVC.OfficeTelExt becomeFirstResponder];
    }
	else if (alertView.tag == 1007) {
        [_CustomerVC.MobileTel becomeFirstResponder];
    }
	else if (alertView.tag == 1008) {
        [_CustomerVC.MobileTelExt becomeFirstResponder];
    }
	else if (alertView.tag == 1009) {
        [_CustomerVC.Fax becomeFirstResponder];
    }
	else if (alertView.tag == 1010) {
        [_CustomerVC.FaxExt becomeFirstResponder];
    }
	else if (alertView.tag == 1011) {
        [_CustomerVC.Email becomeFirstResponder];
    }
	else if (alertView.tag == 1012) {
        [_CustomerVC.permanentAddress1 becomeFirstResponder];
    }
	else if (alertView.tag == 1013) {
        [_CustomerVC.permanentAddressPostCode becomeFirstResponder];
    }
	
}

- (IBAction)doCancel:(id)sender {
    [self dismissModalViewControllerAnimated:TRUE];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}
@end
