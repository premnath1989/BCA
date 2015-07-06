//
//  SpouseViewController.m
//  iMobile Planner
//
//  Created by Meng Cheong on 7/8/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "SpouseViewController.h"
#import "ColorHexCode.h"

@interface SpouseViewController ()

@end

@implementation SpouseViewController

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
    ColorHexCode *CustomColor = [[ColorHexCode alloc]init ];
    self.navigationController.navigationBar.tintColor = [CustomColor colorWithHexString:@"A9BCF5"];
    
    CGRect frame = CGRectMake(0, 0, 400, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"TreBuchet MS" size:20];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [CustomColor colorWithHexString:@"234A7D"];
    label.text = @"Partner/Spouse";
    self.navigationItem.titleView = label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)doDone:(id)sender {
	[self dismissViewControllerAnimated:TRUE completion:nil];
}

- (IBAction)MailingAddressChanged:(id)sender {
	if (self.mailingAddress.selectedSegmentIndex == 0) {
        _mailAddressPostcode.text = @"";
        
        _mailAddressTown.enabled = false;
        _mailAddressTown.placeholder = @"Auto Populate from Postcode";
        
        _mailAddressCountry.text = @"MALAYSIA";
        _mailingAddressCountrySelector.hidden = true;
		
    }
    else{
        _mailAddressPostcode.text = @"";
        
        _mailAddressTown.enabled = true;
        _mailAddressTown.placeholder = @"Town";
        
        _mailAddressCountry.text = @"";
        _mailingAddressCountrySelector.hidden = false;
        
    }
}

- (IBAction)doCancel:(id)sender {
	[self dismissViewControllerAnimated:TRUE completion:Nil];
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

-(void)selectedNationality:(NSString *)selectedNationality {
    [_nationality setText:selectedNationality];
    
    if (_NationalityTypePickerPopover) {
        [_NationalityTypePickerPopover dismissPopoverAnimated:YES];
        _NationalityTypePickerPopover = nil;
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

-(void)selectedTitleType:(NSString *)selectedTitleType{
    [_PersonalDetailsTitle setText:selectedTitleType];
    
    if (_TitleTypePickerPopover) {
        [_TitleTypePickerPopover dismissPopoverAnimated:YES];
        _TitleTypePickerPopover = nil;
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

-(void)selectedOtherIDType:(NSString *)selectedOtherIDType{
    [_otherIDType setText:selectedOtherIDType];
    
    if (_OtherIDTypePickerPopover) {
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


- (void)viewDidUnload {
	[self setBtn1:nil];
	[self setMailAddress1:nil];
	[self setMailAddress2:nil];
	[self setMailAddress3:nil];
	[self setMailAddressPostcode:nil];
	[self setMailAddressCountry:nil];
	[self setMailAddressTown:nil];
	[self setNationality:nil];
	[self setOtherIDType:nil];
	[self setPersonalDetailsTitle:nil];
	[self setRace:nil];
	[self setMailingAddress:nil];
	[self setMailingAddressCountrySelector:nil];
	[self setMailingAddressCountrySelector:nil];
	[super viewDidUnload];
}
@end
