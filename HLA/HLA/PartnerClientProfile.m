//
//  PartnerClientProfile.m
//  iMobile Planner
//
//  Created by Meng Cheong on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "PartnerClientProfile.h"
#import "PartnerViewController.h"
#import "DataClass.h"
#import "FMDatabase.h"
#import "textFields.h"

@interface PartnerClientProfile () {
    DataClass *obj;
}

@end

@implementation PartnerClientProfile

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
    
    self.PartnerVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"PartnerViewController"];
    [self.contentView setBackgroundColor:self.PartnerVC.view.backgroundColor];
    [self addChildViewController:self.PartnerVC];
    [self.contentView addSubview:self.PartnerVC.view];

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
    [self setPartnerTitle:nil];
    [self setContentView:nil];
    [super viewDidUnload];
}
- (IBAction)doDone:(id)sender {
    
    if ([textFields trimWhiteSpaces:_PartnerVC.mailingAddress1.text].length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Mailing Address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1001;
        [alert show];
        alert = nil;
        return;
    }
    
    if (_PartnerVC.mailingAddressPostcode.text.length == 0 && !_PartnerVC.foreignAddress) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Mailing Address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1002;
        [alert show];
        alert = nil;
        return;
    }
    else if (_PartnerVC.mailingAddressPostcode.text.length != 0 && !_PartnerVC.foreignAddress) {
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        [db open];
        FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", _PartnerVC.mailingAddressPostcode.text];
        bool valid = FALSE;
        while ([result next]) {
            valid = TRUE;
        }
        [db close];
        if (!valid || _PartnerVC.mailingAddressPostcode.text.length != 5) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Mailing Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1002;
            [alert show];
            alert = nil;
            return;
        }
    }
    
    if (_PartnerVC.mailingAddressCountry.text.length == 0 || [_PartnerVC.mailingAddressCountry.text isEqualToString:@"- SELECT -"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Mailing Address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }

	NSString *eApp = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"isEAPP"];
	
	eApp = _PartnerVC.isEAPP;
	NSLog(@"test %@", eApp);
	
    if (eApp) {
    if ([textFields trimWhiteSpaces:_PartnerVC.permanentAddress1.text].length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Permanent Address is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1012;
        [alert show];
        alert = nil;
        return;
    }
    

		
		if (!_PartnerVC.permanentForeignAddress){
		
    if (_PartnerVC.permanentAddressPostcode.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Permanent Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag = 1013;
        [alert show];
        alert = nil;
        return;
    }
    else if (_PartnerVC.permanentAddressPostcode.text.length > 0) {
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsDir = [dirPaths objectAtIndex:0];
        NSString *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"hladb.sqlite"]];
        FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
        [db open];
        FMResultSet *result = [db executeQuery:@"SELECT Town, Statedesc, b.Statecode FROM adm_postcode as A, eproposal_state as B where trim(a.Statecode) = b.statecode and Postcode = ?", _PartnerVC.permanentAddressPostcode.text];
        bool valid = FALSE;
        while ([result next]) {
            valid = TRUE;
        }
        [db close];
        if (!valid || _PartnerVC.permanentAddressPostcode.text.length != 5) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Postcode for Permanent Address is invalid." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = 1013;
            [alert show];
            alert = nil;
            return;
        }
	}
    }
    
    if (_PartnerVC.permanentAddressCountry.text.length == 0 || [_PartnerVC.permanentAddressCountry.text isEqualToString:@"- SELECT -"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Country for Permanent Address is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
        return;
    }
	}
//	NSString *eApp = [[obj.CFFData objectForKey:@"CFF"] objectForKey:@"isEAPP"];
//
//	eApp = _PartnerVC.isEAPP;
//	NSLog(@"test %@", eApp);
	
	if ([eApp isEqualToString:@"Y"]){
		if (_PartnerVC.residenceTelExt.text.length == 0 && _PartnerVC.residenceTel.text.length == 0 && _PartnerVC.officeTelExt.text.length == 0 && _PartnerVC.officeTel.text.length == 0 && _PartnerVC.mobileTel.text.length == 0 && _PartnerVC.mobileTelExt.text.length == 0 && _PartnerVC.fax.text.length == 0 && _PartnerVC.faxExt.text.length == 0) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Please enter at least one of the contact numbers (Residential, Office, Mobile or Fax)." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1004;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.residenceTel.text.length > 0 && _PartnerVC.residenceTelExt.text.length == 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for residential number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1004;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.residenceTel.text.length < 6 && _PartnerVC.residenceTelExt.text.length > 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Residential number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1003;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.officeTel.text.length > 0 && _PartnerVC.officeTelExt.text.length == 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for office number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1006;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.officeTel.text.length < 6 && _PartnerVC.officeTelExt.text.length > 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Office number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1005;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.mobileTel.text.length > 0 && _PartnerVC.mobileTelExt.text.length == 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for mobile number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1008;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.mobileTel.text.length < 6 && _PartnerVC.mobileTelExt.text.length > 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Mobile number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1007;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.fax.text.length > 0 && _PartnerVC.faxExt.text.length == 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Prefix for fax number is required." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1010;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.fax.text.length < 6 && _PartnerVC.faxExt.text.length > 0){
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Fax number’s length must be at least 6 digits or more." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1009;
			[alert show];
			alert = nil;
			return;
		}
		else if (_PartnerVC.email.text.length != 0 && ![textFields validateEmail:[textFields trimWhiteSpaces:_PartnerVC.email.text]]) {
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"You have entered an invalid email. Please key in the correct email." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			alert.tag = 1011;
			[alert show];
			alert = nil;
			return;
		}
		
	}
    
    obj = [DataClass getInstance];
    if (self.PartnerVC.foreignAddress) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerMailingAddressForeign"];
    }
    else if (!self.PartnerVC.foreignAddress) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerMailingAddressForeign"];
    }
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mailingAddress1.text forKey:@"PartnerMailingAddress1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mailingAddress2.text forKey:@"PartnerMailingAddress2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mailingAddress3.text forKey:@"PartnerMailingAddress3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mailingAddressPostcode.text forKey:@"PartnerMailingPostcode"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mailingAddressTown.text forKey:@"PartnerMailingAddressTown"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mailingAddressState.text forKey:@"PartnerMailingAddressState"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mailingAddressCountry.text forKey:@"PartnerMailingAddressCountry"];
    
    obj = [DataClass getInstance];
    if (self.PartnerVC.permanentForeignAddress) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"1" forKey:@"PartnerPermanentAddressForeign"];
    }
    else if (!self.PartnerVC.permanentForeignAddress) {
        [[obj.CFFData objectForKey:@"SecC"] setValue:@"0" forKey:@"PartnerPermanentAddressForeign"];
    }
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.permanentAddress1.text forKey:@"PartnerPermanentAddress1"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.permanentAddress2.text forKey:@"PartnerPermanentAddress2"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.permanentAddress3.text forKey:@"PartnerPermanentAddress3"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.permanentAddressPostcode.text forKey:@"PartnerPermanentPostcode"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.permanentAddressTown.text forKey:@"PartnerPermanentAddressTown"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.permanentAddressState.text forKey:@"PartnerPermanentAddressState"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.permanentAddressCountry.text forKey:@"PartnerPermanentAddressCountry"];
	
	[[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.residenceTelExt.text forKey:@"PartnerResidenceTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.residenceTel.text forKey:@"PartnerResidenceTel"];
	
	[[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.officeTelExt.text forKey:@"PartnerOfficeTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.officeTel.text forKey:@"PartnerOfficeTel"];
	
	[[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mobileTelExt.text forKey:@"PartnerMobileTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.mobileTel.text forKey:@"PartnerMobileTel"];
	
	[[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.faxExt.text forKey:@"PartnerFaxTelExt"];
    [[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.fax.text forKey:@"PartnerFaxTel"];
	
	[[obj.CFFData objectForKey:@"SecC"] setValue:self.PartnerVC.email.text forKey:@"PartnerEmail"];
	
    [self.delegate partnerUpdate];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1001) {
        [_PartnerVC.mailingAddress1 becomeFirstResponder];
    }
    else if (alertView.tag == 1002) {
        [_PartnerVC.mailingAddressPostcode becomeFirstResponder];
    }
	else if (alertView.tag == 1003) {
        [_PartnerVC.residenceTel becomeFirstResponder];
    }
	else if (alertView.tag == 1004) {
        [_PartnerVC.residenceTelExt becomeFirstResponder];
    }
	else if (alertView.tag == 1005) {
        [_PartnerVC.officeTel becomeFirstResponder];
    }
	else if (alertView.tag == 1006) {
        [_PartnerVC.officeTelExt becomeFirstResponder];
    }
	else if (alertView.tag == 1007) {
        [_PartnerVC.mobileTel becomeFirstResponder];
    }
	else if (alertView.tag == 1008) {
        [_PartnerVC.mobileTelExt becomeFirstResponder];
    }
	else if (alertView.tag == 1009) {
        [_PartnerVC.fax becomeFirstResponder];
    }
	else if (alertView.tag == 1010) {
        [_PartnerVC.faxExt becomeFirstResponder];
    }
	else if (alertView.tag == 1011) {
        [_PartnerVC.email becomeFirstResponder];
    }
	else if (alertView.tag == 1012){
		[_PartnerVC.permanentAddress1 becomeFirstResponder];
	}
	else if (alertView.tag == 1013){
		[_PartnerVC.permanentAddressPostcode becomeFirstResponder];
	}

}

- (IBAction)doDelete:(id)sender {
    [[obj.CFFData objectForKey:@"CFF"] setValue:@"1" forKey:@"CFFSave"];
    [self.delegate partnerDelete];
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
