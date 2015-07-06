//
//  Nominees.h
//  iMobile Planner
//
//  Created by shawal sapuan on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleViewController.h"
#import "IDTypeViewController.h"
#import "SIDate.h"
#import "Relationship.h"
#import "CountryPopoverViewController.h"
#import "Country.h"
#import "Nationality.h"
#import "OccupationList.h"

#import <sqlite3.h>

//@protocol NomineesDelegate <NSObject>
//-(void)updateTotalSharePct:(NSString *)sharePctInsert;
//@end

@protocol NomineesDelegate <NSObject>
-(void)updateTotalSharePct:(NSString *)sharePctInsert;
@end


@interface Nominees : UITableViewController<UITextFieldDelegate, UIPopoverControllerDelegate, TitleDelegate, IDTypeDelegate, SIDateDelegate, RelationshipDelegate, CountryPopoverViewControllerDelegate,NatinalityDelegate,OccupationListDelegate, UIGestureRecognizerDelegate,CountryDelegate> {
	//BOOL isSameAddress;
	BOOL isForeignAddress;
    BOOL isCRForeignAddress;
    Nationality *_nationalityList;
    OccupationList *_OccupationList;
	//db for postcode
	NSString *databasePath;
    sqlite3 *contactDB;
    
    UIPopoverController *_OccupationListPopover;
    UIPopoverController *_nationalityPopover;
	//
}

@property (nonatomic, strong) id <NomineesDelegate> delegate;

@property (nonatomic, strong) TitleViewController *TitlePicker;
@property (nonatomic, strong) UIPopoverController *TitlePickerPopover;
@property (nonatomic, strong) IDTypeViewController *IDTypeVC;
@property (nonatomic, retain) UIPopoverController *IDTypePopover;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, strong) Relationship *RelationshipVC;
@property (nonatomic, retain) UIPopoverController *RelationshipPopover;
@property (nonatomic, strong) CountryPopoverViewController *CountryVC;
@property (nonatomic, strong) UIPopoverController *CountryPopover;
@property (nonatomic, strong) Country *CountryList;
@property (nonatomic, strong) UIPopoverController *CountryListPopover;
@property (nonatomic,strong) Nationality *nationalityList;
@property (nonatomic, strong) UIPopoverController *OccupationListPopover;
@property (nonatomic, retain) UIPopoverController *nationalityPopover;

@property (strong, nonatomic) IBOutlet UIButton *btnNationPO;
@property (strong, nonatomic) IBOutlet UILabel *lblforNationality;
@property (strong, nonatomic) IBOutlet UIButton *btnOccupationPO;


@property (strong, nonatomic) IBOutlet UILabel *totalShareLbl;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;//Title is required
@property (strong, nonatomic) IBOutlet UITextField *nameTF;//Name is required---Invalid name format. Same alphabet cannot be repeated more than three times.
@property (strong, nonatomic) IBOutlet UITextField *icNoTF;//Either New IC No. or Other ID is required.--- New IC must be 12 digits characters.--- [[New IC month must be between 1 and 12--- New IC day must be between 1 and 31--- (Date doesn't have __ days!)]]
@property (strong, nonatomic) IBOutlet UITextField *otherIDTypeLbl2;
@property (strong, nonatomic) IBOutlet UILabel *otherIDTypeLbl;
@property (strong, nonatomic) IBOutlet UITextField *otherIDTF;//Other ID is required.
@property (strong, nonatomic) IBOutlet UILabel *dobLbl;//Date of Birth is required.--- [[Invalid New IC No. against DOB.]]
@property (strong, nonatomic) IBOutlet UISegmentedControl *sexSC;//Sex is required.---[[New IC No. entered does not match with Sex.]] 
@property (strong, nonatomic) IBOutlet UITextField *sharePercentageTF;//Percentage of Share is required.--- Percentage of Share must be greater than zero.--- Total Percentage of Share exceeded 100%.
@property (strong, nonatomic) IBOutlet UILabel *relationshipLbl;//Relationship with Policy Owner is required.

@property (strong, nonatomic) IBOutlet UITextView *nameOfEmployerTF;
@property (strong, nonatomic) IBOutlet UITextView *exactDuty;
@property (strong, nonatomic) IBOutlet UITextField *nationalityLbl;
@property (strong, nonatomic) IBOutlet UITextField *occupationLbl;


@property (strong, nonatomic) IBOutlet UIButton *btnSameAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnForeignAddress;
@property (strong, nonatomic) IBOutlet UITextField *add1TF;//Address is required.
@property (strong, nonatomic) IBOutlet UITextField *add2TF;
@property (strong, nonatomic) IBOutlet UITextField *add3TF;
@property (strong, nonatomic) IBOutlet UITextField *postcodeTF;//Postcode is required (only if not foreign add)--- Invalid Postcode.
@property (strong, nonatomic) IBOutlet UITextField *townTF;
@property (strong, nonatomic) IBOutlet UILabel *stateLbl;
@property (strong, nonatomic) IBOutlet UILabel *countryLbl;//if foreign add then Country is required.
@property (strong, nonatomic) IBOutlet UIButton *btnCountryPO;
@property (strong, nonatomic) IBOutlet UIButton *btnRelationshipPO;
@property (strong, nonatomic) IBOutlet UIButton *btnDOBPO;
@property (strong, nonatomic) IBOutlet UIButton *btnOtherIDTypePO;
@property (strong, nonatomic) IBOutlet UIButton *btnTitlePO;
@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellDelete;
@property (assign, nonatomic) BOOL fa;
@property (assign, nonatomic) BOOL sa;
@property (assign, nonatomic) BOOL isSameAddress;

@property (assign, nonatomic) BOOL CRfa;
@property (strong, nonatomic) IBOutlet UIButton *btnCRForeignAddress;
@property (strong, nonatomic) IBOutlet UITextField *CRadd1TF;
@property (strong, nonatomic) IBOutlet UITextField *CRadd2TF;
@property (strong, nonatomic) IBOutlet UITextField *CRadd3TF;
@property (strong, nonatomic) IBOutlet UITextField *CRpostcodeTF;
@property (strong, nonatomic) IBOutlet UITextField *CRtownTF;
@property (strong, nonatomic) IBOutlet UILabel *CRstateLbl;
@property (strong, nonatomic) IBOutlet UILabel *CRcountryLbl;
@property (strong, nonatomic) IBOutlet UIButton *CRbtnCountryPO;
@property (nonatomic, retain) OccupationList *OccupationList;


@property (nonatomic, copy) NSString *IDTypeCodeSelected;
@property (nonatomic, copy) NSString *TitleCodeSelected;
@property (nonatomic, copy) NSString *StateCode;
@property (nonatomic, copy) NSString *CRStateCode;
@property (assign, nonatomic) BOOL isResidential;

- (IBAction)donePressed:(id)sender;
- (IBAction)actionForCountry:(id)sender;
- (IBAction)actionForForeignAdd:(id)sender;
- (IBAction)actionForCRCountry:(id)sender;
- (IBAction)actionForCRForeignAdd:(id)sender;
- (IBAction)actionForSameAdd:(id)sender;
- (IBAction)actionForRelationship:(id)sender;
- (IBAction)actionForDOB:(id)sender;
- (IBAction)actionForOtherIDType:(id)sender;
- (IBAction)actionForTitle:(id)sender;
- (IBAction)editingDidEndPostcode:(id)sender;
- (IBAction)editingDidEndShare:(id)sender;
- (IBAction)deleteNominee:(id)sender;
- (IBAction)ActionOccupation:(id)sender;
- (IBAction)ActionNationality:(id)sender;
- (IBAction)editingDidEndCRPostcode:(id)sender;

//@property (nonatomic, strong) id <NomineesDelegate> delegate;

@end
