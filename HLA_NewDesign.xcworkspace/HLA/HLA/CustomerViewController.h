//
//  CustomerViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 7/5/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import "TitlePopoverViewController.h"
#import "OtherIDPopoverViewController.h"
#import "RacePopoverViewController.h"
#import "NationalityPopoverViewController.h"
#import "CountryPopoverViewController.h"

@class CustomerViewController;

@protocol CustomerViewControllerDelegate<NSObject>
- (void)addedCustomerDisplay:(NSString*)type;
@end

@interface CustomerViewController : UITableViewController<TitlePopoverViewControllerDelegate,OtherIDPopoverViewControllerDelegate, RacePopoverViewControllerDelegate, NationalityPopoverViewControllerDelegate, CountryPopoverViewControllerDelegate>


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

@property (nonatomic, weak) id <CustomerViewControllerDelegate> delegate;

- (IBAction)CustomerViewClose:(id)sender;
- (IBAction)doCancel:(id)sender;


//popover labels

@property (weak, nonatomic) IBOutlet UILabel *PersonalDetailsTitle;
- (IBAction)doPersonalDetailsTitle:(id)sender;

- (IBAction)doOtherIDType:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *otherIDType;


@property (weak, nonatomic) IBOutlet UILabel *race;
- (IBAction)doRace:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *nationality;
- (IBAction)doNation:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btn1;
- (IBAction)clickBtn1:(id)sender;

//mailing address items and actions
- (IBAction)MailingAddressChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mailingAddress;
@property (weak, nonatomic) IBOutlet UITextField *mailAddress1;
@property (weak, nonatomic) IBOutlet UITextField *mailAddress2;
@property (weak, nonatomic) IBOutlet UITextField *mailAddress3;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressPostcode;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressTown;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressCountry;
@property (weak, nonatomic) IBOutlet UIButton *mailingAddressCountrySelector;
- (IBAction)doCountry:(id)sender;



@property (weak, nonatomic) IBOutlet UILabel *prospectTitle;
@property (weak, nonatomic) IBOutlet UITextField *prospectName;
@property (weak, nonatomic) IBOutlet UITextField *IDTypeNo;
@property (weak, nonatomic) IBOutlet UITextField *OtherIDTypeNo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *religion;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *smoker;
@property (weak, nonatomic) IBOutlet UITextField *DOB;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maritalStatus;

@property (weak, nonatomic) IBOutlet UITextField *PostCode;
@property (weak, nonatomic) IBOutlet UITextField *Town;


@property (weak, nonatomic) IBOutlet UIButton *mailingAddressForeign;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddress1;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddress2;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddress3;




@property (weak, nonatomic) IBOutlet UITextField *mailingAddressState;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddressCountry;


@property (weak, nonatomic) IBOutlet UIButton *permanentAddressForeign;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddress1;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddress2;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddress3;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddressPostCode;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddressTown;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddressState;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddressCountry;


@property (weak, nonatomic) IBOutlet UITextField *ResidenceTelExt;
@property (weak, nonatomic) IBOutlet UITextField *ResidenceTel;
@property (weak, nonatomic) IBOutlet UITextField *OfficeTelExt;
@property (weak, nonatomic) IBOutlet UITextField *OfficeTel;
//fix for bug 2646 start
@property (strong, nonatomic) IBOutlet UITextField *MobileTelExt;
@property (strong, nonatomic) IBOutlet UITextField *MobileTel;
//fix for bug 2646 end
@property (weak, nonatomic) IBOutlet UITextField *FaxExt;
@property (weak, nonatomic) IBOutlet UITextField *Fax;
@property (weak, nonatomic) IBOutlet UITextField *Email;



@property (weak, nonatomic) IBOutlet UIButton *titlePickerBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherIDTypePickerBtn;
@property (weak, nonatomic) IBOutlet UIButton *racePickerBtn;
@property (weak, nonatomic) IBOutlet UIButton *nationalityPickerBtn;
@property (weak, nonatomic) IBOutlet UIButton *mailingCountryPickerBtn;
@property (weak, nonatomic) IBOutlet UIButton *permanentCountryPickerBtn;




@end
