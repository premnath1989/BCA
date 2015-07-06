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
#import <sqlite3.h>

#import "FMDatabase.h"
#import "FMResultSet.h"

@interface eAppPersonalDetails : UITableViewController <IDTypeDelegate, SIDateDelegate,TitleDelegate,RelationshipDelegate, CountryPopoverViewControllerDelegate, UITextFieldDelegate> {
    IDTypeViewController *_IDTypeVC;
    SIDate *_SIDate;
    TitleViewController *_TitlePicker;
    Relationship *_RelationshipVC;
    UIPopoverController *_IDTypePopover;
    UIPopoverController *_SIDatePopover;
    UIPopoverController *_TitlePickerPopover;
    UIPopoverController *_RelationshipPopover;
    BOOL checked;
	BOOL isPart2Checked;
	BOOL isSameAddress;
	BOOL isForeignAddress;
	//db for postcode
	NSString *databasePath;
    sqlite3 *contactDB;
	//
	FMResultSet *results;
	NSString *nameLA1;
	NSString *nameLA2;
	NSString *namePayor;
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

//outlet

@property (strong, nonatomic) IBOutlet UILabel *titleLbl;//Title is required.
@property (strong, nonatomic) IBOutlet UILabel *OtherIDLbl;
@property (strong, nonatomic) IBOutlet UILabel *DOBLbl;//Date of Birth is required.--- [[Invalid date format.--- Invalid New IC No. against DOB.]]
@property (strong, nonatomic) IBOutlet UILabel *RelationshipLbl;//Relationship is required.
@property (strong, nonatomic) IBOutlet UIButton *checkAddress;
@property (strong, nonatomic) IBOutlet UIButton *checkForeign;
@property (strong, nonatomic) IBOutlet UITextField *fullNameTF;//Name is required.
@property (strong, nonatomic) IBOutlet UITextField *sTelNoTF;//Either one Contact No. is required.
@property (strong, nonatomic) IBOutlet UITextField *telNoTF;
@property (strong, nonatomic) IBOutlet UITextField *icNoTF;//Either New IC No. or Other ID is required.
@property (strong, nonatomic) IBOutlet UITextField *sMobileTF;
@property (strong, nonatomic) IBOutlet UITextField *mobileTF;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *otherIDTF;//Other ID is required.
@property (strong, nonatomic) IBOutlet UITextField *addressTF;//Address is required.
@property (strong, nonatomic) IBOutlet UITextField *address2TF;
@property (strong, nonatomic) IBOutlet UITextField *address3TF;
@property (strong, nonatomic) IBOutlet UILabel *stateLbl;
@property (strong, nonatomic) IBOutlet UILabel *countryLbl;

@property (strong, nonatomic) IBOutlet UITextField *postcodeTF;//Postcode is required.(if not Foreign Add)---Invalid Post Code.
@property (strong, nonatomic) IBOutlet UITextField *townTF;

@property (strong, nonatomic) IBOutlet UIButton *btnPart2;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sexSC;//Sex is required.--- [[New IC No. entered does not match with Sex.]]
@property (strong, nonatomic) IBOutlet UIButton *btnTitlePO;
@property (strong, nonatomic) IBOutlet UIButton *btnDOBPO;
@property (strong, nonatomic) IBOutlet UIButton *btnOtherIDTypePO;
@property (strong, nonatomic) IBOutlet UIButton *btnRelationshipPO;
@property (strong, nonatomic) IBOutlet UIButton *btnCountryPO;

@property (strong, nonatomic) IBOutlet UIButton *btnSameAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnForeignAddress;

@property (assign, nonatomic) BOOL fa;
@property (assign, nonatomic) BOOL sa;
@property (assign, nonatomic) BOOL p2;
@property (strong, nonatomic) IBOutlet UILabel *firstLALbl;
@property (strong, nonatomic) IBOutlet UILabel *secondLALbl;
@property (strong, nonatomic) IBOutlet UILabel *payorLbl;

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
- (IBAction)actionForCountryPO:(id)sender;
- (IBAction)editingDidEndPostcode:(id)sender;

@property (strong, nonatomic) IBOutlet UITableViewCell *la1cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *la2cell;
@property (strong, nonatomic) IBOutlet UITableViewCell *payorcell;
@property (strong, nonatomic) IBOutlet UIButton *L1Button;
@property (strong, nonatomic) IBOutlet UIButton *L2Button;
@property (strong, nonatomic) IBOutlet UIButton *PYButton;

@end
