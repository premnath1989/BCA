//
//  eAppPersonalDetails.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/3/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDTypeViewController.h"
#import "SIDate.h"
#import "TitleViewController.h"
#import "Relationship.h"
#import "CountryPopoverViewController.h"
#import "Country.h"
#import <sqlite3.h>
#import "OccupationList.h"
#import "FMDatabase.h"
#import "Nationality.h"
#import "FMResultSet.h"

@interface eAppPersonalDetails : UITableViewController <IDTypeDelegate, SIDateDelegate,TitleDelegate,OccupationListDelegate,RelationshipDelegate, CountryPopoverViewControllerDelegate,NatinalityDelegate, UITextFieldDelegate, CountryDelegate> {
    IDTypeViewController *_IDTypeVC;
    SIDate *_SIDate;
    TitleViewController *_TitlePicker;
    Relationship *_RelationshipVC;
    Nationality *_nationalityList;
    
    UIPopoverController *_IDTypePopover;
    UIPopoverController *_SIDatePopover;
    UIPopoverController *_TitlePickerPopover;
    UIPopoverController *_RelationshipPopover;
    UIPopoverController *_OccupationListPopover;
    UIPopoverController *_nationalityPopover;

	
    BOOL checked;
	BOOL isPart2Checked;
	BOOL isSameAddress;
	BOOL isForeignAddress;
	BOOL isCRForeignAddress;
    OccupationList *_OccupationList;
	//db for postcode
	NSString *databasePath;
    sqlite3 *contactDB;
	//
	FMResultSet *results;
    FMResultSet *results2;
	NSString *nameLA1;
	NSString *nameLA2;
	NSString *namePayor;
	NSString *namePO;
	NSString *PRelationship;
	int ageForPart2;
}

@property (nonatomic, strong) IDTypeViewController *IDTypeVC;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, strong) TitleViewController *TitlePicker;
@property (nonatomic, strong) Relationship *RelationshipVC;
@property (nonatomic, strong) CountryPopoverViewController *CountryVC;
@property (nonatomic, strong) UIPopoverController *TitlePickerPopover;
@property (nonatomic, retain) UIPopoverController *IDTypePopover;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, retain) UIPopoverController *RelationshipPopover;
@property (nonatomic, strong) UIPopoverController *CountryPopover;
@property (strong, nonatomic) NSMutableDictionary *LADetails;
@property (nonatomic,strong) Nationality *nationalityList;

//outlet

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;//Title is required.
@property (strong, nonatomic) IBOutlet UILabel *OtherIDLbl;
@property (strong, nonatomic) IBOutlet UILabel *DOBLbl;//Date of Birth is required.--- [[Invalid date format.--- Invalid New IC No. against DOB.]]
@property (strong, nonatomic) IBOutlet UILabel *RelationshipLbl;//Relationship is required.
@property (strong, nonatomic) IBOutlet UIButton *checkAddress;
@property (strong, nonatomic) IBOutlet UIButton *checkForeign;

@property (strong, nonatomic) IBOutlet UIButton *checkCRAddress;
@property (strong, nonatomic) IBOutlet UIButton *checkCRForeign;

@property (strong, nonatomic) IBOutlet UITextField *fullNameTF;//Name is required.
@property (strong, nonatomic) IBOutlet UITextField *sTelNoTF;//Either one Contact No. is required.
@property (strong, nonatomic) IBOutlet UITextField *telNoTF;
@property (strong, nonatomic) IBOutlet UITextField *telPhoneNoPrefixTF;

@property (strong, nonatomic) IBOutlet UITextField *icNoTF;//Either New IC No. or Other ID is required.
@property (strong, nonatomic) IBOutlet UITextField *sMobileTF;
@property (strong, nonatomic) IBOutlet UITextField *mobileTF;
@property (strong, nonatomic) IBOutlet UITextField *mobilePrefixTF;

@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *otherIDTF;//Other ID is required.
@property (strong, nonatomic) IBOutlet UITextField *addressTF;//Address is required.
@property (strong, nonatomic) IBOutlet UITextField *address2TF;
@property (strong, nonatomic) IBOutlet UITextField *address3TF;
@property (strong, nonatomic) IBOutlet UILabel *stateLbl;
@property (strong, nonatomic) IBOutlet UILabel *countryLbl;
@property (strong, nonatomic) IBOutlet UITextField *postcodeTF;//Postcode is required.(if not Foreign Add)---Invalid Post Code.
@property (strong, nonatomic) IBOutlet UITextField *townTF;


@property (strong, nonatomic) IBOutlet UITextField *CRaddressTF;//Address is required.
@property (strong, nonatomic) IBOutlet UITextField *CRaddress2TF;
@property (strong, nonatomic) IBOutlet UITextField *CRaddress3TF;
@property (strong, nonatomic) IBOutlet UILabel *CRstateLbl;
@property (strong, nonatomic) IBOutlet UILabel *CRcountryLbl;
@property (strong, nonatomic) IBOutlet UITextField *CRpostcodeTF;//Postcode is required.(if not Foreign Add)---Invalid Post Code.
@property (strong, nonatomic) IBOutlet UITextField *CRtownTF;

@property (strong, nonatomic) IBOutlet UITextField *btnNationality; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *NationalityLbl; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UITextField *nameOfEmployerTF; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UITextField *btnOccupation; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UITextField *exactNatureOfWorkTF; //New fields to support new proposal form

@property (strong, nonatomic) IBOutlet UIButton *btnPart2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sexSC;//Sex is required.--- [[New IC No. entered does not match with Sex.]]
@property (strong, nonatomic) IBOutlet UIButton *btnTitlePO;
@property (strong, nonatomic) IBOutlet UIButton *btnDOBPO;
@property (strong, nonatomic) IBOutlet UIButton *btnOtherIDTypePO;
@property (strong, nonatomic) IBOutlet UIButton *btnRelationshipPO;
@property (strong, nonatomic) IBOutlet UIButton *btnCountryPO;
@property (strong, nonatomic) IBOutlet UIButton *btnOccupationPO;
@property (strong, nonatomic) IBOutlet UIButton *btnNationPO;
@property (strong, nonatomic) IBOutlet UIButton *btnCRCountryPO;
@property (strong, nonatomic) IBOutlet UIButton *btnSameAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnForeignAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnCRForeignAddress;

@property (assign, nonatomic) BOOL fa;
@property (assign, nonatomic) BOOL CRfa;
@property (assign, nonatomic) BOOL sa;
@property (assign, nonatomic) BOOL p2;
@property (strong, nonatomic) IBOutlet UILabel *firstLALbl;
@property (strong, nonatomic) IBOutlet UILabel *secondLALbl;
@property (strong, nonatomic) IBOutlet UILabel *payorLbl;
@property (strong, nonatomic) IBOutlet UILabel *POLbl;
//Basvi addeed lables
@property (strong, nonatomic) IBOutlet UILabel *lblforparticularsofCO;
@property (strong, nonatomic) IBOutlet UILabel *lblforCOmustattainage16andabove;
@property (strong, nonatomic) IBOutlet UILabel *lblforTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblforsex;
@property (strong, nonatomic) IBOutlet UILabel *lblforfullname;
@property (strong, nonatomic) IBOutlet UILabel *lblforTelno;
@property (strong, nonatomic) IBOutlet UILabel *lblforNewIcno;
@property (strong, nonatomic) IBOutlet UILabel *lblformobile;
@property (strong, nonatomic) IBOutlet UILabel *lblforOtherIdType;
@property (strong, nonatomic) IBOutlet UILabel *lblforEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblforOtherId;
@property (strong, nonatomic) IBOutlet UILabel *lblforDOB;
@property (strong, nonatomic) IBOutlet UILabel *lblforRelationshipwithLA;
@property (strong, nonatomic) IBOutlet UILabel *lblforSameaddressasPO;
@property (strong, nonatomic) IBOutlet UILabel *lblforForeignAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblforAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblforPostcode;
@property (strong, nonatomic) IBOutlet UILabel *lblforTown;
@property (strong, nonatomic) IBOutlet UILabel *lblforState;
@property (strong, nonatomic) IBOutlet UILabel *lblforCountry;

@property (strong, nonatomic) IBOutlet UILabel *lblforCRForeignAddress; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforCRAddress; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforCRPostcode; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforCRTown; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforCRState; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforCRCountry; //New fields to support new proposal form

@property (strong, nonatomic) IBOutlet UILabel *lblforResidenceAddressTitle; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforCorrespondenceAddressTitle; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforNationality; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblfornameOfEmployer; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforOccupation; //New fields to support new proposal form
@property (strong, nonatomic) IBOutlet UILabel *lblforExactDuty; //New fields to support new proposal form

@property (assign, nonatomic) BOOL isResidential;
@property (strong, nonatomic) IBOutlet UILabel *OccupationLbl;


- (IBAction)btnLA1:(id)sender;
- (IBAction)btnLA2:(id)sender;
- (IBAction)btnPayor:(id)sender;

- (IBAction)ActionTitle:(id)sender;
- (IBAction)ActionOtherID:(id)sender;
- (IBAction)ActionDOB:(id)sender;
- (IBAction)ActionRelationship:(id)sender;
- (IBAction)actionForPart2:(id)sender;
- (IBAction)actionForSameAdd:(id)sender;
- (IBAction)actionForForeignAdd:(id)sender;
- (IBAction)actionForCRForeignAdd:(id)sender;
- (IBAction)actionForCountryPO:(id)sender;
- (IBAction)actionForCRCountryPO:(id)sender;
- (IBAction)editingDidEndPostcode:(id)sender;
- (IBAction)editingDidEndCRPostcode:(id)sender;
- (IBAction):(id)sender;
- (IBAction)ActionOccupation:(id)sender;
- (IBAction)ActionNationality:(id)sender;

@property (strong, nonatomic) IBOutlet UITableViewCell *la1cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *la2cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *payorcell;
@property (strong, nonatomic) IBOutlet UIButton *L1Button;
@property (strong, nonatomic) IBOutlet UIButton *L2Button;
@property (strong, nonatomic) IBOutlet UIButton *PYButton;
@property (nonatomic, retain) OccupationList *OccupationList;


@property (nonatomic, copy) NSString *IDTypeCodeSelected;
@property (nonatomic, copy) NSString *TitleCodeSelected;
@property (nonatomic, strong) Country *CountryList;
@property (nonatomic, strong) UIPopoverController *CountryListPopover;
@property (nonatomic, strong) UIPopoverController *OccupationListPopover;
@property (nonatomic, retain) UIPopoverController *nationalityPopover;

// for validation
@property (strong, nonatomic) NSMutableArray *icAry;
@property (strong, nonatomic) NSMutableArray *otherIDAry;
@property (strong, nonatomic) NSMutableArray *otherIDTypeAry;
@property (strong, nonatomic) NSMutableArray *nameAry;

@end
