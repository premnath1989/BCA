//
//  PartnerViewController.h
//  iMobile Planner
//
//  Created by Meng Cheong on 8/30/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitlePopoverViewController.h"
#import "OtherIDPopoverViewController.h"
#import "RacePopoverViewController.h"
#import "NationalityPopoverViewController.h"
#import "CountryPopoverViewController.h"

@class PartnerViewController;

@protocol PartnerViewControllerDelegate<NSObject>
- (void)addedPartnerDisplay:(NSString*)type;
@end

@interface PartnerViewController : UITableViewController<TitlePopoverViewControllerDelegate,OtherIDPopoverViewControllerDelegate, RacePopoverViewControllerDelegate, NationalityPopoverViewControllerDelegate, CountryPopoverViewControllerDelegate>

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

@property (nonatomic, weak) id <PartnerViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *age;

@property (weak, nonatomic) IBOutlet UILabel *PartnerTitle;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *IDTypeNo;
@property (weak, nonatomic) IBOutlet UILabel *otherIDType;
@property (weak, nonatomic) IBOutlet UITextField *otherIDTypeNo;
@property (weak, nonatomic) IBOutlet UILabel *race;
@property (weak, nonatomic) IBOutlet UISegmentedControl *religion;
@property (weak, nonatomic) IBOutlet UILabel *nationality;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *smoker;
@property (weak, nonatomic) IBOutlet UITextField *DOB;
//@property (weak, nonatomic) IBOutlet UITableViewCell *age;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maritalStatus;


@property (weak, nonatomic) IBOutlet UIButton *mailingAddressForeign;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddress1;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddress2;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddress3;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddressPostcode;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddressTown;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddressState;
@property (weak, nonatomic) IBOutlet UITextField *mailingAddressCountry;


@property (weak, nonatomic) IBOutlet UIButton *permanentAddressForeign;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddress1;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddress2;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddress3;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddressPostcode;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddressTown;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddressState;
@property (weak, nonatomic) IBOutlet UITextField *permanentAddressCountry;

@property (weak, nonatomic) IBOutlet UITextField *residenceTelExt;
@property (weak, nonatomic) IBOutlet UITextField *residenceTel;
@property (weak, nonatomic) IBOutlet UITextField *officeTelExt;
@property (weak, nonatomic) IBOutlet UITextField *officeTel;
@property (strong, nonatomic) IBOutlet UITextField *mobileTelExt;
@property (strong, nonatomic) IBOutlet UITextField *mobileTel;
@property (weak, nonatomic) IBOutlet UITextField *faxExt;
@property (weak, nonatomic) IBOutlet UITextField *fax;
@property (weak, nonatomic) IBOutlet UITextField *email;


@property (weak, nonatomic) IBOutlet UIButton *titlePickerBtn;
- (IBAction)doTitle:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *otherIDTypePickerBtn;
- (IBAction)doOtherIDType:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *nationalityPickerBtn;
@property (weak, nonatomic) IBOutlet UIButton *doNationality;

@property (weak, nonatomic) IBOutlet UIButton *racePickerBtn;
- (IBAction)doRace:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *mailingAddressCountryPickerBtn;
- (IBAction)doMailingAddressCountry:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *permanentAddressCountryPickerBtn;

@property (weak, nonatomic) IBOutlet UIButton *doPermanentAddressCountry;





















@end
