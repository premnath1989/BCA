//
//  ProspectViewController.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 9/30/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

//test 1
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ProspectProfile.h"
#import "OccupationList.h"
#import "SIDate.h"
#import "IDTypeViewController.h"
#import "TitleViewController.h"
#import "GroupClass.h"
#import "Nationality.h"
#import "Race.h"
#import "MaritalStatus.h"
#import "Religion.h"
#import "Country.h"
#import "Country2.h"
#import "EditProspect.h"


@class DataTable,DBController;
@protocol ProspectViewControllerDelegate
- (void)FinishInsert;
@end

@interface ProspectViewController : UIViewController<IDTypeDelegate,SIDateDelegate,IDTypeDelegate, OccupationListDelegate,TitleDelegate,GroupDelegate, UITextFieldDelegate,UITextInputDelegate, UITextViewDelegate,NatinalityDelegate,RaceDelegate,MaritalStatusDelegate,ReligionDelegate,CountryDelegate,EditProspectDelegate, Country2Delegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    OccupationList *_OccupationList;
    SIDate *_SIDate;
    GroupClass *_GroupList;
    TitleViewController *_TitlePicker;
    Race *_raceList;
    MaritalStatus *_MaritalStatusList;
    Nationality *_nationalityList;
    Nationality *_nationalityList2;
    UIPopoverController *_OccupationListPopover;
    UIPopoverController *_ContactTypePopover;
    UIPopoverController *_SIDatePopover;
    UIPopoverController *_GroupPopover;
    UIPopoverController *_TitlePickerPopover;
    UIPopoverController *_ReligionListPopover;
    UIPopoverController *_RaceListPopover;
    UIPopoverController *_MaritalStatusPopover;
    UIPopoverController *_CountryListPopover;
	UIPopoverController *_Country2ListPopover;
  //  UIPopoverController *_CountryListPopover_Office;
    UIPopoverController *_nationalityPopover;
    UIPopoverController *_nationalityPopover2;
    id<ProspectViewControllerDelegate> _delegate;
    EditProspect *_EditProspect;
    UIAlertView *rrr;
    UIAlertView *errormsg;
    BOOL checked;
    BOOL checked2;
    BOOL isHomeCountry;
    BOOL isOffCountry;
	BOOL isBirthCountry;
    BOOL companyCase;
}

@property (strong, nonatomic) ProspectProfile* prospectprofile;

@property (strong, nonatomic) DBController* db;

@property (strong, nonatomic) DataTable * tableDB;
@property (strong, nonatomic) DataTable * tableCheckSameRecord;

@property (nonatomic, retain) EditProspect *EditProspect;
@property (nonatomic, strong) id<ProspectViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong) TitleViewController *TitlePicker;
@property (strong, nonatomic) IBOutlet UIButton *btnTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnOtherIdType;

@property (nonatomic, strong) Race *raceList;
@property (nonatomic, strong) Country *CountryList;
@property (nonatomic, strong) Country2 *Country2List;
@property (nonatomic, strong) MaritalStatus *MaritalStatusList;
@property (nonatomic, strong) Religion *ReligionList;
@property (nonatomic, strong) UIPopoverController *ReligionListPopover;
@property (nonatomic, strong) UIPopoverController *CountryListPopover;
@property (nonatomic, strong) UIPopoverController *Country2ListPopover;
//@property (nonatomic, strong) UIPopoverController *CountryListPopover_Office;
@property (nonatomic, strong) UIPopoverController *raceListPopover;
@property (nonatomic, strong) UIPopoverController *MaritalStatusPopover;
@property (nonatomic, strong) UIPopoverController *TitlePickerPopover;
@property (nonatomic, strong) IDTypeViewController *IDTypePicker;
@property (nonatomic, strong) UIPopoverController *IDTypePickerPopover;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, retain) OccupationList *OccupationList;
@property (nonatomic, retain) UIPopoverController *OccupationListPopover;
@property (nonatomic, strong) GroupClass *GroupList;
@property (nonatomic, strong) UIPopoverController *GroupPopover;
@property (nonatomic,strong) Nationality *nationalityList;
@property (nonatomic,strong) Nationality *nationalityList2;
@property (nonatomic, strong) UIPopoverController *nationalityPopover;
@property (nonatomic, strong) UIPopoverController *nationalityPopover2;

@property (strong, nonatomic) ProspectProfile* pp;

@property (strong, nonatomic) IBOutlet UIButton *outletGroup;
@property (weak, nonatomic) IBOutlet UIButton *outletTitle;
@property (weak, nonatomic) IBOutlet UIButton *outletRace;
@property (weak, nonatomic) IBOutlet UIButton *outletMaritalStatus;
@property (weak, nonatomic) IBOutlet UIButton *outletReligion;
@property (weak, nonatomic) IBOutlet UIButton *outletNationality;
@property (weak, nonatomic) IBOutlet UITextField *txtFullName;
@property (weak, nonatomic) IBOutlet UIButton *outletDOB;
@property (strong, nonatomic) IBOutlet UITextField *txtDOB;
@property (strong, nonatomic) IBOutlet UIButton *OtherIDType;
@property (strong, nonatomic) IBOutlet UITextField *txtOtherIDType;
@property (strong, nonatomic) IBOutlet UITextField *txtIDType;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeAddr1;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeAddr2;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeAddr3;
@property (weak, nonatomic) IBOutlet UITextField *txtHomePostCode;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeTown;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeState;
@property (weak, nonatomic) IBOutlet UITextField *txtHomeCountry;
@property (weak, nonatomic) IBOutlet UITextView *txtRemark;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segGender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segSmoker;
@property (weak, nonatomic) IBOutlet UIButton *outletOccup;
@property (strong, nonatomic) IBOutlet UITextView *txtExactDuties;
@property (strong, nonatomic) IBOutlet UITextField *txtAnnIncome;
@property (strong, nonatomic) IBOutlet UITextField *txtBussinessType;
@property (weak, nonatomic) IBOutlet UILabel *lblOfficeAddr;
@property (weak, nonatomic) IBOutlet UILabel *lblPostCode;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeAddr1;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeAddr2;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeAddr3;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficePostcode;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeTown;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeState;
@property (weak, nonatomic) IBOutlet UITextField *txtOfficeCountry;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefix1;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefix2;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefix3;
@property (weak, nonatomic) IBOutlet UITextField *txtPrefix4;
@property (weak, nonatomic) IBOutlet UITextField *txtContact1;
@property (weak, nonatomic) IBOutlet UITextField *txtContact2;
@property (weak, nonatomic) IBOutlet UITextField *txtContact3;
@property (weak, nonatomic) IBOutlet UITextField *txtContact4;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtClass;
@property (strong, nonatomic) IBOutlet UIButton *btnForeignHome;
@property (strong, nonatomic) IBOutlet UIButton *btnForeignOffice;
@property (strong, nonatomic) IBOutlet UIButton *btnOfficeCountry;
@property (strong, nonatomic) IBOutlet UIButton *btnHomeCountry;

@property (weak, nonatomic) IBOutlet UITextField *txtRigNO;
@property (weak, nonatomic) IBOutlet UITextField *txtRigDate;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segRigPerson;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segRigExempted;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segIsGrouping;
@property (weak, nonatomic) IBOutlet UIButton *btnAddGroup;
@property (weak, nonatomic) IBOutlet UIButton *btnViewGroup;
@property (strong, nonatomic) NSUserDefaults *UDGroup;

@property (weak, nonatomic) IBOutlet UIButton *btnRegDate;
- (IBAction)ActionforregistrationDte:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnRegistnDate;
@property (weak, nonatomic) IBOutlet UIButton *outletRigDate;
- (IBAction)ActionforRigdate:(id)sender;

- (IBAction)ActionforRegistrationDate:(id)sender;
- (IBAction)ActionIsGrouping:(id)sender;
- (IBAction)ViewGroup:(id)sender;
- (IBAction)addNewGroup:(id)sender;
- (IBAction)actionForRegistrationDate:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnregDare;

- (IBAction)ActionforRegDate:(id)sender;

- (IBAction)actionHomeCountry:(id)sender;
- (IBAction)actionNationality:(id)sender;
- (IBAction)actionRace:(id)sender;
- (IBAction)actionMaritalStatus:(id)sender;
- (IBAction)actionReligion:(id)sender;

- (IBAction)actionOfficeCountry:(id)sender;
- (IBAction)btnGroup:(id)sender;
- (IBAction)btnTitle:(id)sender;
- (IBAction)btnDOB:(id)sender;
- (IBAction)btnOtherIDType:(id)sender;
- (IBAction)ActionGender:(id)sender;
- (IBAction)ActionSmoker:(id)sender;
- (IBAction)btnOccup:(id)sender;
- (IBAction)isForeign:(id)sender;
- (IBAction)ActionRigperson:(id)sender;
- (IBAction)ActionExempted:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCoutryOfBirth;
- (IBAction)actionCountryOfBirth:(id)sender;

@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *DOB;
@property (nonatomic, copy) NSString *OccpCatCode;
@property (nonatomic, copy) NSString *OccupCodeSelected;
@property (nonatomic, copy) NSString *IDTypeCodeSelected;
@property (nonatomic, copy) NSString *TitleCodeSelected;
@property (nonatomic, copy) NSString *SelectedStateCode;
@property (nonatomic, copy) NSString *SelectedOfficeStateCode;
@property (strong, nonatomic) NSArray* ContactType;
@property (nonatomic, copy) NSString *ContactTypeTracker;
@property (nonatomic, copy) NSString *ClientSmoker;
@property (nonatomic, copy) NSString *GSTRigperson;
@property (nonatomic, copy) NSString *GSTRigExempted;

-(void)keyboardDidShow:(NSNotificationCenter *)notification;
-(void)keyboardDidHide:(NSNotificationCenter *)notification;

@end
