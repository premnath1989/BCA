//
//  EditProspect.h
//  HLA Ipad
//
//  Created by Md. Nazmus Saadat on 10/1/12.
//  Copyright (c) 2012 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProspectProfile.h"
#import <sqlite3.h>
#import "OccupationList.h"
#import "SIDate.h"
#import "IDTypeViewController.h"
#import "TitleViewController.h"
#import "GroupClass.h"
#import "Nationality.h"
#import "Country.h"
#import "Race.h"
#import "MaritalStatus.h"
#import "Religion.h"

@class DataTable,DBController;
@protocol EditProspectDelegate
- (void)FinishEdit;
@end

@interface EditProspect : UIViewController<OccupationListDelegate,IDTypeDelegate,SIDateDelegate,UITextViewDelegate,TitleDelegate,GroupDelegate,UITextFieldDelegate,NatinalityDelegate,CountryDelegate,RaceDelegate,ReligionDelegate,MaritalStatusDelegate>{
    NSString *databasePath;
    sqlite3 *contactDB;
    UITextField *activeField;
    GroupClass *_GroupList;
    TitleViewController *_TitlePicker;
    SIDate *_SIDate;
    OccupationList *_OccupationList;
    Nationality *_nationalityList;
    Nationality *_nationalityList2;
    UIPopoverController *_GroupPopover;
    UIPopoverController *_TitlePickerPopover;
    UIPopoverController *_SIDatePopover;
    UIPopoverController *_OccupationListPopover;
    UIPopoverController *_CountryListPopover;
    UIPopoverController *_nationalityPopover;
    UIPopoverController *_nationalityPopover2;
    UIPopoverController *_ReligionListPopover;
    UIPopoverController *_RaceListPopover;
    UIPopoverController *_MaritalStatusPopover;
    id<EditProspectDelegate> _delegate;
    UIAlertView *rrr;
    BOOL checked;
    BOOL checked2;
    BOOL isHomeCountry;
    BOOL isOffCountry;
    BOOL companyCase;
}

@property (strong, nonatomic) DBController* db;

@property (strong, nonatomic) DataTable * tableDB;

@property (nonatomic, strong) Race *raceList;
@property (nonatomic, strong) Country *CountryList;
@property (nonatomic, strong) MaritalStatus *MaritalStatusList;
@property (nonatomic, strong) Religion *ReligionList;
@property (nonatomic, strong) UIPopoverController *ReligionListPopover;
@property (nonatomic, strong) UIPopoverController *CountryListPopover;
@property (nonatomic, strong) UIPopoverController *raceListPopover;
@property (nonatomic, strong) UIPopoverController *MaritalStatusPopover;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong) id<EditProspectDelegate> delegate;
@property (strong, nonatomic) ProspectProfile* pp;
@property (nonatomic, strong) IDTypeViewController *IDTypePicker;
@property (nonatomic, strong) UIPopoverController *IDTypePickerPopover;
@property (nonatomic, retain) OccupationList *OccupationList;
@property (nonatomic, retain) UIPopoverController *OccupationListPopover;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, strong) TitleViewController *TitlePicker;
@property (nonatomic, strong) UIPopoverController *TitlePickerPopover;
@property (nonatomic, strong) GroupClass *GroupList;
@property (nonatomic, strong) UIPopoverController *GroupPopover;
@property (nonatomic,strong) Nationality *nationalityList;
@property (nonatomic, strong) UIPopoverController *nationalityPopover;
@property (nonatomic,strong) Nationality *nationalityList2;
@property (nonatomic, strong) UIPopoverController *nationalityPopover2;



@property (weak, nonatomic) IBOutlet UIButton *outletRace;
@property (weak, nonatomic) IBOutlet UIButton *outletMaritalStatus;
@property (weak, nonatomic) IBOutlet UIButton *outletReligion;
@property (weak, nonatomic) IBOutlet UIButton *outletNationality;
@property (strong, nonatomic) IBOutlet UIButton *outletGroup;
@property (strong, nonatomic) IBOutlet UIButton *outletTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtrFullName;
@property (weak, nonatomic) IBOutlet UIButton *outletDOB;
@property (strong, nonatomic) IBOutlet UITextField *txtDOB;
@property (strong, nonatomic) IBOutlet UITextField *txtIDType;
@property (strong, nonatomic) IBOutlet UIButton *OtherIDType;
@property (strong, nonatomic) IBOutlet UITextField *txtOtherIDType;
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
@property (weak, nonatomic) IBOutlet UITextField *txtOfficePostCode;
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
@property (weak, nonatomic) IBOutlet UIButton *outletDelete;
@property (strong, nonatomic) IBOutlet UITextField *txtClass;
@property (strong, nonatomic) IBOutlet UIButton *btnForeignHome;
@property (strong, nonatomic) IBOutlet UIButton *btnForeignOffice;
@property (strong, nonatomic) IBOutlet UIButton *btnOfficeCountry;
@property (strong, nonatomic) IBOutlet UIButton *btnHomeCountry;


- (IBAction)actionNationality:(id)sender;
- (IBAction)actionRace:(id)sender;
- (IBAction)actionMaritalStatus:(id)sender;
- (IBAction)actionReligion:(id)sender;
- (IBAction)ActionHomeCountry:(id)sender;
- (IBAction)addNewGroup:(id)sender;
- (IBAction)ActionOfficeCountry:(id)sender;
- (IBAction)isForeign:(id)sender;
- (IBAction)btnGroup:(id)sender;
- (IBAction)btnTitle:(id)sender;
- (IBAction)btnDOB:(id)sender;
- (IBAction)btnOtherIDType:(id)sender;
- (IBAction)ActionGender:(id)sender;
- (IBAction)ActionSmoker:(id)sender;
- (IBAction)btnOccup:(id)sender;
- (IBAction)btnDelete:(id)sender;

@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *DOB;
@property (nonatomic, copy) NSString *OccupCodeSelected;
@property (nonatomic, copy) NSString *SelectedStateCode;
@property (nonatomic, copy) NSString *SelectedOfficeStateCode;
@property (nonatomic, copy) NSString *strChanges;
@property (nonatomic, copy) NSString *ClientSmoker;

-(void)keyboardDidShow:(NSNotificationCenter *)notification;
-(void)keyboardDidHide:(NSNotificationCenter *)notification;

@end
