//
//  SpouseViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/8/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "TitlePopoverViewController.h"
#import "OtherIDPopoverViewController.h"
#import "RacePopoverViewController.h"
#import "NationalityPopoverViewController.h"
#import "CountryPopoverViewController.h"

@interface SpouseViewController : UITableViewController<TitlePopoverViewControllerDelegate,OtherIDPopoverViewControllerDelegate, RacePopoverViewControllerDelegate, NationalityPopoverViewControllerDelegate, CountryPopoverViewControllerDelegate>

@property (nonatomic, strong) TitlePopoverViewController *TitleTypePicker;
@property (nonatomic, strong) UIPopoverController *TitleTypePickerPopover;

@property (nonatomic, strong) OtherIDPopoverViewController *OtherIDTypePicker;
@property (nonatomic, strong) UIPopoverController *OtherIDTypePickerPopover;

@property (nonatomic, strong) RacePopoverViewController *RaceTypePicker;
@property (nonatomic, strong) UIPopoverController *RaceTypePickerPopover;

@property (nonatomic, strong) NationalityPopoverViewController *NationalityTypePicker;
@property (nonatomic, strong) UIPopoverController *NationalityTypePickerPopover;

@property (nonatomic, strong) CountryPopoverViewController *CountryTypePicker;
@property (nonatomic, strong) UIPopoverController *CountryTypePickerPopover;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UITextField *mailAddress1;
@property (weak, nonatomic) IBOutlet UITextField *mailAddress2;
@property (weak, nonatomic) IBOutlet UITextField *mailAddress3;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressPostcode;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressCountry;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressTown;
@property (weak, nonatomic) IBOutlet UILabel *nationality;
@property (weak, nonatomic) IBOutlet UILabel *otherIDType;
@property (weak, nonatomic) IBOutlet UILabel *PersonalDetailsTitle;
@property (weak, nonatomic) IBOutlet UILabel *race;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mailingAddress;
//@property (weak, nonatomic) IBOutlet UIImageView *mailingAddressCountrySelector;
@property (weak, nonatomic) IBOutlet UIButton *mailingAddressCountrySelector;


- (IBAction)clickBtn1:(id)sender;
- (IBAction)doDone:(id)sender;
- (IBAction)MailingAddressChanged:(id)sender;
- (IBAction)doCancel:(id)sender;
- (IBAction)doNation:(id)sender;
- (IBAction)doPersonalDetailsTitle:(id)sender;
- (IBAction)doOtherIDType:(id)sender;
- (IBAction)doRace:(id)sender;
- (IBAction)doCountry:(id)sender;

@end
