//
//  SubDetails.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/11/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleViewController.h"
#import "Relationship.h"
#import "SIDate.h"
#import "IDTypeViewController.h"
#import "OccupationList.h"
#import "Nationality.h"
#import "Race.h"
#import "MaritalStatus.h"
#import "Country.h"


@protocol SubDetailsDelegate <NSObject>
-(void)updatePOLabel:(NSString *)potype;
@end


@interface SubDetails : UITableViewController<TitleDelegate,RelationshipDelegate,SIDateDelegate, IDTypeDelegate,OccupationListDelegate,NatinalityDelegate,RaceDelegate,MaritalStatusDelegate,UIAlertViewDelegate,UITextFieldDelegate,CountryDelegate, UIGestureRecognizerDelegate>

{
    BOOL isMoifiedData;
    BOOL isFirstTime;
    TitleViewController *_TitlePicker;
    IDTypeViewController *_IDTypeVC;
    SIDate *_SIDate;
    Relationship *_RelationshipVC;
    OccupationList *_OccupationList;
    Race *_raceList;
    MaritalStatus *_MaritalStatusList;
    Nationality *_nationalityList;

    UIPopoverController *_TitlePickerPopover;
    UIPopoverController *_IDTypePopover;
    UIPopoverController *_SIDatePopover;
    UIPopoverController *_RelationshipPopover;
    
    UIPopoverController *_OccupationListPopover;
    UIPopoverController *_RaceListPopover;
    UIPopoverController *_MaritalStatusPopover;
    UIPopoverController *_nationalityPopover;
    
    BOOL isPart2Checked;
    
    BOOL iscorrespondenceResidenceChecked;
    BOOL iscorrespondenceOfficeChecked;
    
    BOOL isResidenceForiegnAddChecked;
    BOOL isOfficeForiegnAddChecked;
	
	BOOL isResidencePOBOXChecked;
	BOOL isOfficePOBOXChecked;
	BOOL isMalPOBOXchecked;
	
    NSString *databasePath;
    sqlite3 *contactDB;
    
     id <SubDetailsDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;

@property (nonatomic, strong) TitleViewController *TitlePicker;
@property (nonatomic, strong) IDTypeViewController *IDTypeVC;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, strong) Relationship *RelationshipVC;

@property (nonatomic, strong) MaritalStatus *MaritalStatusList;
@property (nonatomic, retain) OccupationList *OccupationList;
@property (nonatomic,strong) Nationality *nationalityList;
@property (nonatomic, strong) Race *raceList;
@property (nonatomic, strong) Country *CountryList;
@property (nonatomic, strong) UIPopoverController *CountryListPopover;


@property (nonatomic, strong) UIPopoverController *TitlePickerPopover;
@property (nonatomic, retain) UIPopoverController *IDTypePopover;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, retain) UIPopoverController *RelationshipPopover;
@property (nonatomic, strong) UIPopoverController *OccupationListPopover;
@property (nonatomic, retain) UIPopoverController *RaceListPopover;
@property (nonatomic, retain) UIPopoverController *MaritalStatusPopover;
@property (nonatomic, retain) UIPopoverController *nationalityPopover;


@property (strong, nonatomic) IBOutlet UILabel *titleLbl;//Title
@property (strong, nonatomic) IBOutlet UISegmentedControl *policyOwnerType;
@property (strong, nonatomic) IBOutlet UILabel *DOBLbl;//Date of Birth
@property (strong, nonatomic) IBOutlet UITextField *nameLbl;// Full Name
@property (strong, nonatomic) IBOutlet UILabel *raceLbl;//Race
@property (strong, nonatomic) IBOutlet UITextField *nricLbl;//New IC
@property (strong, nonatomic) IBOutlet UILabel *nationalityLbl;//Nationality
@property (strong, nonatomic) IBOutlet UILabel *OtherTypeIDLbl; // Other ID Type
@property (nonatomic, copy) NSString *IDTypeCodeSelected; //other ID Type code
@property (nonatomic, copy) NSString *TitleCodeSelected; //Title code

@property (strong, nonatomic) IBOutlet UITextField *otherIDLbl; // Other ID 
@property (strong, nonatomic) IBOutlet UISegmentedControl *segReligion; // Religion
@property (strong, nonatomic) IBOutlet UILabel *OccupationLbl; // Occupation
@property (strong, nonatomic) IBOutlet UILabel *relationshipLbl; // Relatioship

@property (strong, nonatomic) IBOutlet UILabel *LARPOLbl; // Life Assured’s Relationship with Policy Owner

@property (strong, nonatomic) IBOutlet UILabel *PORLALbl; // Policy Owner’s Relationship with Life Assured

@property (strong, nonatomic) IBOutlet UILabel *martialStatusLbl; // Martial status
@property (strong, nonatomic) IBOutlet UIButton *checkPolicyOwner;
@property (strong, nonatomic) IBOutlet UITextField *employerLbl; // EmployerName
@property (strong, nonatomic) IBOutlet UITextField *businessLbl; // Type of Business
@property (retain, nonatomic) IBOutlet UITextView *exaxtDutiesLbl;
@property (strong, nonatomic) IBOutlet UIButton *ClearExaxtDuties;
@property (strong, nonatomic) IBOutlet UITextField *yearlyIncomeLbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segGender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segSmoker;
@property (strong, nonatomic) IBOutlet UILabel *txtNRIC;


//Correspondence Address
@property (strong, nonatomic) IBOutlet UILabel *LblCorrespondenceAdd;
@property (strong, nonatomic) IBOutlet UILabel *LblResidence;
@property (strong, nonatomic) IBOutlet UILabel *LblOffice;
@property (strong, nonatomic) IBOutlet UIButton *BtnResidence;
@property (strong, nonatomic) IBOutlet UIButton *BtnOffice;


//Residence Address
@property (strong, nonatomic) IBOutlet UILabel *LblResidenceAdd;
@property (strong, nonatomic) IBOutlet UILabel *LblForeignAdd;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segOwnership;
@property (strong, nonatomic) IBOutlet UILabel *LblOwnership;
@property (strong, nonatomic) IBOutlet UILabel *LblAddress1;
@property (strong, nonatomic) IBOutlet UILabel *LblPostcode1;
@property (strong, nonatomic) IBOutlet UILabel *LblTown1;
@property (strong, nonatomic) IBOutlet UILabel *LblState1;
@property (strong, nonatomic) IBOutlet UILabel *LblCountry1;

@property (strong, nonatomic) IBOutlet UITextField *txtPostcode1;
@property (strong, nonatomic) IBOutlet UITextField *txtState1;
@property (strong, nonatomic) IBOutlet UITextField *txtCountry1;
@property (strong, nonatomic) IBOutlet UITextField *txtTown1;

@property (strong, nonatomic) IBOutlet UITextField *txtAdd1;
@property (strong, nonatomic) IBOutlet UITextField *txtAdd12;
@property (strong, nonatomic) IBOutlet UITextField *txtAdd13;
@property (strong, nonatomic) IBOutlet UIButton *BtnResidenceForeignAdd;
 

//Office Address
@property (strong, nonatomic) IBOutlet UILabel *LblOfficeAdd2;
@property (strong, nonatomic) IBOutlet UILabel *LblForeignAdd2;
@property (strong, nonatomic) IBOutlet UILabel *LblAddress2;
@property (strong, nonatomic) IBOutlet UILabel *LblPostcode2;
@property (strong, nonatomic) IBOutlet UILabel *LblState2;
@property (strong, nonatomic) IBOutlet UILabel *LblTown2;
@property (strong, nonatomic) IBOutlet UILabel *LblCountry2;


@property (strong, nonatomic) IBOutlet UITextField *txtPostcode2;
@property (strong, nonatomic) IBOutlet UITextField *txtState2;
@property (strong, nonatomic) IBOutlet UITextField *txtCountry2;
@property (strong, nonatomic) IBOutlet UITextField *txtTown2;

@property (strong, nonatomic) IBOutlet UITextField *txtAdd2;
@property (strong, nonatomic) IBOutlet UITextField *txtAdd22;
@property (strong, nonatomic) IBOutlet UITextField *txtAdd23;

@property (strong, nonatomic) IBOutlet UIButton *BtnOfficeForeignAdd;




//Contact Tel No
@property (strong, nonatomic) IBOutlet UILabel *LblContactTitle3;
@property (strong, nonatomic) IBOutlet UILabel *LblResidence3;
@property (strong, nonatomic) IBOutlet UILabel *LblOffice3;
@property (strong, nonatomic) IBOutlet UILabel *LblEmail3;
@property (strong, nonatomic) IBOutlet UILabel *LblMobile3;
@property (strong, nonatomic) IBOutlet UILabel *LblFax3;

@property (strong, nonatomic) IBOutlet UITextField *txtResidence1;
@property (strong, nonatomic) IBOutlet UITextField *txtResidence2;

@property (strong, nonatomic) IBOutlet UITextField *txtOffice1;
@property (strong, nonatomic) IBOutlet UITextField *txtOffice2;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtMobile1;
@property (strong, nonatomic) IBOutlet UITextField *txtMobile2;
@property (strong, nonatomic) IBOutlet UITextField *txtFax1;
@property (strong, nonatomic) IBOutlet UITextField *txtFax2;

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtIC;
@property (strong, nonatomic) IBOutlet UILabel *policyLifecycleLabel;
@property (strong, nonatomic) IBOutlet UILabel *Me;
@property (strong, nonatomic) IBOutlet UILabel *asTheParent;
@property (strong, nonatomic) IBOutlet UILabel *NRIC;


@property (strong, nonatomic) NSMutableDictionary *LADetails;
@property (strong, nonatomic) IBOutlet UIButton *residenceCountryBtn;
@property (strong, nonatomic) IBOutlet UIButton *officeCountryBtn;
@property (strong, nonatomic) IBOutlet UIButton *btnRelationship;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segHaveChildren;


//P.O.Box 
@property (weak, nonatomic) IBOutlet UIButton *btnMalPOB;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegResidencePOB;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegOfficePOB;

- (IBAction)ActionCheckMalPOB:(id)sender;
- (IBAction)ActionResidencePOB:(id)sender;
- (IBAction)ActionOfficePOB:(id)sender;


- (IBAction)ActionResidenceCountry:(id)sender;
- (IBAction)ActionOfficeCountry:(id)sender;

- (IBAction)ActionTitle:(id)sender;
- (IBAction)ActionOtherID:(id)sender;
- (IBAction)ActionDOB:(id)sender;
- (IBAction)ActionRelationship:(id)sender;
- (IBAction)ActionRace:(id)sender;
- (IBAction)ActionNationality:(id)sender;
- (IBAction)ActionMartialStatus:(id)sender;
- (IBAction)ActionOccupation:(id)sender;
- (IBAction)ActionCheckPolicyOwner:(id)sender;

- (IBAction)ActionOwnership:(id)sender;
- (IBAction)ActionHaveChildren:(id)sender;

- (IBAction)ActionCheckCorrespondenceResidence:(id)sender;
- (IBAction)ActionCheckCorrespondenceOffice:(id)sender;

- (IBAction)ActionCheckResidenceAddress:(id)sender;
- (IBAction)ActionCheckOfficeAddress:(id)sender;
- (IBAction)editingDidEndPostcode:(id)sender;
- (IBAction)editingDidEndPostcode2:(id)sender;
- (void)btnDone:(id)sender;
- (void)doDelete;
- (IBAction)postChanged:(id)sender;

-(IBAction)CleatAllinDutied:(id)sender;
@end
