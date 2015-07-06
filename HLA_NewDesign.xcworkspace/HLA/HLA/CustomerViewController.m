//
//  CustomerViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "CustomerViewController.h"
#import "ColorHexCode.h"
#import "DataClass.h"

@interface CustomerViewController (){
    DataClass *obj;
}

@end

@implementation CustomerViewController

@synthesize btn1;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //UIColor *tintColor = [UIColor colorWithRed:195/255.0f green:212/255.0f blue:255/255.0f alpha:1];
    //[self.navigationController.navigationBar setTintColor:tintColor];
    /*
	ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Customer";
    self.navigationItem.titleView = label;
     */
    obj=[DataClass getInstance];
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerReadOnly"] isEqualToString:@"1"]){
        _prospectTitle.enabled = FALSE;
        _prospectName.enabled = FALSE;
        _IDTypeNo.enabled = FALSE;
        _otherIDType.enabled = FALSE;
        _OtherIDTypeNo.enabled = FALSE;
        _race.enabled = FALSE;
        _religion.enabled = FALSE;
        _nationality.enabled = FALSE;
        _gender.enabled = FALSE;
        _smoker.enabled = FALSE;
        _DOB.enabled = FALSE;
        _age.enabled = FALSE;
        _maritalStatus.enabled = FALSE;
//        _mailingAddressForeign.enabled = FALSE;
//        _mailingAddress1.enabled = FALSE;
//        _mailingAddress2.enabled = FALSE;
//        _mailingAddress3.enabled = FALSE;
//        _PostCode.enabled = FALSE;
//        _Town.enabled = FALSE;
//        _mailingAddressState.enabled = FALSE;
//        _mailingAddressCountry.enabled = FALSE;
        
        _titlePickerBtn.hidden = TRUE;
        _otherIDTypePickerBtn.hidden = TRUE;
        _racePickerBtn.hidden = TRUE;
        _nationalityPickerBtn.hidden = TRUE;
//        _mailingCountryPickerBtn.hidden = TRUE;
        _permanentCountryPickerBtn.hidden = TRUE;
    }
	
	//fix for bug 2494 start
    NSString *titleTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	if ([titleTrim isEqualToString:@"- Select -"]) {
		_prospectTitle.text = @"";
	}
	else {
		_prospectTitle.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerTitle"];
	}
	
    _prospectName.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerName"];
    _IDTypeNo.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNRIC"];
    _otherIDType.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherIDType"];
    _OtherIDTypeNo.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerOtherID"];
	
	NSString *raceTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerRace"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	if ([raceTrim isEqualToString:@"- Select -"]) {
		_race.text = @"";
	}
	else {
		_race.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerRace"];
	}
	
	NSString *relTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerReligion"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([relTrim isEqualToString:@"NON-MUSLIM"]){
        [_religion setSelectedSegmentIndex:1];
    }
    else if ([relTrim isEqualToString:@"- Select -"]){
        [_religion setSelectedSegmentIndex:-1];
    }
	else{
		[_religion setSelectedSegmentIndex:0];
	}
	
	NSString *nationTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNationality"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	if ([nationTrim isEqualToString:@"- Select -"]) {
		_nationality.text = @"";
	}
	else {
		_nationality.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerNationality"];
	}
	
	NSString *sexTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSex"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([sexTrim isEqualToString:@"MALE"]){
        [_gender setSelectedSegmentIndex:0];
    }
    else if ([sexTrim isEqualToString:@"(null)"]){
        [_gender setSelectedSegmentIndex:-1];
    }
	else {
		[_gender setSelectedSegmentIndex:1];
	}
	
	NSString *smokerTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerSmoker"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([smokerTrim isEqualToString:@"Y"]){
        [_smoker setSelectedSegmentIndex:0];
    }
    else if ([smokerTrim isEqualToString:@"(null)"]){
        [_smoker setSelectedSegmentIndex:-1];
    }
	else{
		[_smoker setSelectedSegmentIndex:0];
	}
	
	NSString *dobTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"] stringByReplacingOccurrencesOfString:@" " withString:@""];
	if ([dobTrim isEqualToString:@"-Select-"]) {
		_DOB.text = @"";
	}
	else {
		_DOB.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerDOB"];
	}
	
	NSString *statusTrim = [[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMaritalStatus"] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([statusTrim isEqualToString:@"DIVORCED"]){
        [_maritalStatus setSelectedSegmentIndex:0];
    }
    else if ([statusTrim isEqualToString:@"MARRIED"]){
        [_maritalStatus setSelectedSegmentIndex:1];
    }
    else if ([statusTrim isEqualToString:@"SINGLE"]){
        [_maritalStatus setSelectedSegmentIndex:2];
    }
    else if ([statusTrim isEqualToString:@"WIDOW"]){
        [_maritalStatus setSelectedSegmentIndex:3];
    }
    else if ([statusTrim isEqualToString:@"WIDOWER"]){
        [_maritalStatus setSelectedSegmentIndex:4];
    }
	else if ([statusTrim isEqualToString:@"- Select -"]){
        [_maritalStatus setSelectedSegmentIndex:-1];
    }
	
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressForeign"] isEqualToString:@"1"]){
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    }
    else{
        [_mailingAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];        
    }
    _mailingAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress1"];
    _mailingAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress2"];
    _mailingAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddress3"];
    _PostCode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingPostcode"];
    _Town.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressTown"];
    _mailingAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressState"];
    _mailingAddressCountry.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerMailingAddressCountry"];
    
    
    if ([[[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressForeign"] isEqualToString:@"0"]){
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
    }
    else{
        [_permanentAddressForeign setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
    }
	//fix for bug 2494 end
	
    _permanentAddress1.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress1"];
    _permanentAddress2.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress2"];
    _permanentAddress3.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddress3"];
    _permanentAddressPostCode.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentPostcode"];
    _permanentAddressTown.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressTown"];
    _permanentAddressState.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressState"];
    _permanentAddressCountry.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"CustomerPermanentAddressCountry"];
    
    _ResidenceTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTelExt"];
    _ResidenceTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"ResidenceTel"];
    
    _OfficeTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTelExt"];
    _OfficeTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"OfficeTel"];
    
	//fix for bug 2646 start
	_MobileTelExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTelExt"];
	_MobileTel.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"MobileTel"];
	//fix for bug 2646 end
	
    _FaxExt.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTelExt"];
    _Fax.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"FaxTel"];
    
    _Email.text = [[obj.CFFData objectForKey:@"SecC"] objectForKey:@"Email"];
    
    NSDateFormatter *fmtDate = [[NSDateFormatter alloc] init];
    [fmtDate setDateFormat:@"dd/mm/yyyy"];
    NSDate *startDate = [fmtDate dateFromString:_DOB.text];
    NSString *textDate = [NSString stringWithFormat:@"%@",[fmtDate stringFromDate:[NSDate date]]];
    NSDate *endDate = [fmtDate dateFromString:textDate];
    
    NSDateComponents* components = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:startDate
                                       toDate:endDate
                                       options:0];
    
    _age.text = [NSString stringWithFormat:@"%d",[components year]];
    
    fmtDate = Nil;
    components = Nil;

    
    //_mailingAddressForeign

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)CustomerViewClose:(id)sender {
    //NSLog(@"call delegate");
    //[self.delegate addedCustomerDisplay:@"Display"];
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

- (IBAction)doCancel:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:Nil];
}

- (IBAction)MailingAddressChanged:(id)sender {
    if (self.mailingAddress.selectedSegmentIndex == 0) {
        //_mailAddressPostcode.text = @"";
        
        //_mailAddressTown.enabled = false;
        //_mailAddressTown.placeholder = @"Auto Populate from Postcode";
        
        //_mailAddressCountry.text = @"MALAYSIA";
        //_mailingAddressCountrySelector.hidden = true;
    
    }
    else{
        //_mailAddressPostcode.text = @"";
        
        //_mailAddressTown.enabled = true;
        //_mailAddressTown.placeholder = @"Town";
        
        //_mailAddressCountry.text = @"";
        //_mailingAddressCountrySelector.hidden = false;
        
    }
    /*
    if (self.mailingAddress.selectedSegmentIndex == 0) {
        _mailAddress1.text = @"43, Jalan Rejang 3";
        _mailAddress1.enabled = FALSE;
        _mailAddress1.borderStyle = UITextBorderStyleNone;
        
        _mailAddress2.text = @"Setapak Jaya";
        _mailAddress2.enabled = FALSE;
        _mailAddress2.borderStyle = UITextBorderStyleNone;
        
        _mailAddress3.text = @"Kuala Lumpur";
        _mailAddress3.enabled = FALSE;
        _mailAddress3.borderStyle = UITextBorderStyleNone;
        
        _mailAddressPostcode.text = @"53300";
        _mailAddressPostcode.enabled = FALSE;
        _mailAddressPostcode.borderStyle = UITextBorderStyleNone;
        _mailAddressPostcode.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        _mailAddressTown.text = @"KUALA LUMPUR";
        _mailAddressTown.enabled = FALSE;
        _mailAddressTown.borderStyle = UITextBorderStyleNone;
        _mailAddressTown.textColor = [UIColor scrollViewTexturedBackgroundColor];
        
        _mailAddressCountry.text = @"MALAYSIA";
        _mailAddressCountry.enabled = FALSE;
        _mailAddressCountry.borderStyle = UITextBorderStyleNone;
        _mailAddressCountry.textColor = [UIColor scrollViewTexturedBackgroundColor];
    
    } else {
        _mailAddress1.text = @"";
        _mailAddress1.enabled = TRUE;
        _mailAddress1.borderStyle = UITextBorderStyleLine;
        
        _mailAddress2.text = @"";
        _mailAddress2.enabled = TRUE;
        _mailAddress2.borderStyle = UITextBorderStyleLine;
        
        _mailAddress3.text = @"";
        _mailAddress3.enabled = TRUE;
        _mailAddress3.borderStyle = UITextBorderStyleLine;
        
        _mailAddressPostcode.text = @"";
        _mailAddressPostcode.enabled = TRUE;
        _mailAddressPostcode.borderStyle = UITextBorderStyleLine;
        _mailAddressPostcode.textColor = [UIColor blackColor];
        
        _mailAddressTown.text = @"";
        _mailAddressTown.enabled = TRUE;
        _mailAddressTown.borderStyle = UITextBorderStyleLine;
        _mailAddressTown.textColor = [UIColor blackColor];
        
        _mailAddressCountry.text = @"";
        //_mailAddressCountry.enabled = TRUE;
        //_mailAddressCountry.borderStyle = UITextBorderStyleLine;
        _mailAddressCountry.textColor = [UIColor blackColor];
    }
     */
    
}
- (void)viewDidUnload {
    [self setMailAddress1:nil];
    [self setMailAddress2:nil];
    [self setMailAddress3:nil];
    [self setMailAddressPostcode:nil];
    [self setMailAddressTown:nil];
    [self setMailAddressPostcode:nil];
    [self setMailAddressTown:nil];
    [self setMailAddressCountry:nil];
    [self setMailingAddress:nil];
    [self setMailingAddressCountrySelector:nil];
    [self setPersonalDetailsTitle:nil];
    [self setOtherIDType:nil];
    [self setRace:nil];
    [self setNationality:nil];
    [self setBtn1:nil];
    [self setMailingAddressCountrySelector:nil];
    [self setProspectTitle:nil];
    [self setProspectName:nil];
    //[self setIDTYpeNo:nil];
    [self setIDTypeNo:nil];
    [self setOtherIDTypeNo:nil];
    [self setReligion:nil];
    [self setGender:nil];
    [self setSmoker:nil];
    [self setDOB:nil];
    [self setAge:nil];
    [self setMaritalStatus:nil];
    [self setMailingAddressForeign:nil];
    [self setMailingAddress1:nil];
    [self setMailingAddress2:nil];
    [self setMailingAddress3:nil];
    [self setMailingAddressState:nil];
    [self setMailingAddressCountry:nil];
    [self setPermanentAddressForeign:nil];
    [self setPermanentAddress1:nil];
    [self setPermanentAddress2:nil];
    [self setPermanentAddress3:nil];
    [self setPermanentAddressPostCode:nil];
    [self setPermanentAddressTown:nil];
    [self setPermanentAddressState:nil];
    [self setPermanentAddressCountry:nil];
    [self setResidenceTelExt:nil];
    [self setResidenceTel:nil];
    [self setOfficeTelExt:nil];
    [self setOfficeTel:nil];
    [self setFaxExt:nil];
    [self setFax:nil];
    [self setEmail:nil];
    [self setPostCode:nil];
    [self setTown:nil];
    [self setTitlePickerBtn:nil];
    [self setOtherIDTypePickerBtn:nil];
    [self setRacePickerBtn:nil];
    [self setNationalityPickerBtn:nil];
    [self setMailingCountryPickerBtn:nil];
    [self setPermanentCountryPickerBtn:nil];
    [self setMobileTelExt:nil];
    [self setMobileTel:nil];
    [super viewDidUnload];
}

-(void)selectedTitleType:(NSString *)selectedTitleType{
    [_PersonalDetailsTitle setText:selectedTitleType];
    
    if (_TitleTypePickerPopover) {
        [_TitleTypePickerPopover dismissPopoverAnimated:YES];
        _TitleTypePickerPopover = nil;
    }
}


- (IBAction)doPersonalDetailsTitle:(id)sender {
    if (_TitleTypePicker == nil) {
        _TitleTypePicker = [[TitlePopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _TitleTypePicker.delegate = self;
    }
    
    if (_TitleTypePickerPopover == nil) {
        
        _TitleTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_TitleTypePicker];
        [_TitleTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_TitleTypePickerPopover dismissPopoverAnimated:YES];
        _TitleTypePickerPopover = nil;
    }

}

-(void)selectedOtherIDType:(NSString *)selectedOtherIDType{
    [_otherIDType setText:selectedOtherIDType];
    
    if (_OtherIDTypePickerPopover) {
        [_OtherIDTypePickerPopover dismissPopoverAnimated:YES];
        _OtherIDTypePickerPopover = nil;
    }
}

- (IBAction)doOtherIDType:(id)sender {
    if (_OtherIDTypePicker == nil) {
        _OtherIDTypePicker = [[OtherIDPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _OtherIDTypePicker.delegate = self;
    }
    
    if (_OtherIDTypePickerPopover == nil) {
        
        _OtherIDTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_OtherIDTypePicker];
        [_OtherIDTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_OtherIDTypePickerPopover dismissPopoverAnimated:YES];
        _OtherIDTypePickerPopover = nil;
    }

}
- (IBAction)doRace:(id)sender {
    if (_RaceTypePicker == nil) {
        _RaceTypePicker = [[RacePopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _RaceTypePicker.delegate = self;
    }
    
    if (_RaceTypePickerPopover == nil) {
        
        _RaceTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_RaceTypePicker];
        [_RaceTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_RaceTypePickerPopover dismissPopoverAnimated:YES];
        _RaceTypePickerPopover = nil;
    }
}

-(void)selectedRace:(NSString *)selectedRace {
    [_race setText:selectedRace];
    
    if (_RaceTypePickerPopover) {
        [_RaceTypePickerPopover dismissPopoverAnimated:YES];
        _RaceTypePickerPopover = nil;
    }
}

-(void)selectedNationality:(NSString *)selectedNationality {
    [_nationality setText:selectedNationality];
    
    if (_NationalityTypePickerPopover) {
        [_NationalityTypePickerPopover dismissPopoverAnimated:YES];
        _NationalityTypePickerPopover = nil;
    }
}

- (IBAction)doNation:(id)sender {
    if (_NationalityTypePicker == nil) {
        _NationalityTypePicker = [[NationalityPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _NationalityTypePicker.delegate = self;
    }
    
    if (_NationalityTypePickerPopover == nil) {
        
        _NationalityTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_NationalityTypePicker];
        [_NationalityTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_NationalityTypePickerPopover dismissPopoverAnimated:YES];
        _NationalityTypePickerPopover = nil;
    }
}

- (IBAction)clickBtn1:(id)sender {
    btn1.selected = !btn1.selected;
	if (btn1.selected) {
		[btn1 setImage: [UIImage imageNamed:@"cb_glossy_on.png"] forState:UIControlStateNormal];
	}
	else {
		[btn1 setImage:[UIImage imageNamed:@"cb_glossy_off.png"] forState:UIControlStateNormal];
	}
}

- (IBAction)doCountry:(id)sender {
    if (_CountryTypePicker == nil) {
        _CountryTypePicker = [[CountryPopoverViewController alloc] initWithStyle:UITableViewStylePlain];
        _CountryTypePicker.delegate = self;
    }
    
    if (_CountryTypePickerPopover == nil) {
        
        _CountryTypePickerPopover = [[UIPopoverController alloc] initWithContentViewController:_CountryTypePicker];
        [_CountryTypePickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    } else {
        [_CountryTypePickerPopover dismissPopoverAnimated:YES];
        _CountryTypePickerPopover = nil;
    }
}

-(void)selectedCountry:(NSString *)selectedCountry {
    [_mailAddressCountry setText:selectedCountry];
    
    if (_CountryTypePickerPopover) {
        [_CountryTypePickerPopover dismissPopoverAnimated:YES];
        _CountryTypePickerPopover = nil;
    }
}

- (IBAction)PostCode:(id)sender {
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
