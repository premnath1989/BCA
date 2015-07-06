//
//  Trustees.h
//  iMobile Planner
//
//  Created by Erza on 7/4/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleViewController.h"
#import "IDTypeViewController.h"
#import "SIDate.h"
#import "CountryPopoverViewController.h"
#import <sqlite3.h>
#import "Relationship.h"


@interface Trustees : UITableViewController<UITextFieldDelegate, UIPopoverControllerDelegate, TitleDelegate, IDTypeDelegate, SIDateDelegate, CountryPopoverViewControllerDelegate, UIAlertViewDelegate, RelationshipDelegate> {
	BOOL isSameAsPO;
	BOOL isForeignAddress;
	NSString *databasePath;
    sqlite3 *contactDB;
}

//- (IBAction)doneBtn:(id)sender;
//outlet
@property (strong, nonatomic) IBOutlet UIButton *btnPO;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnTitlePO;
@property (strong, nonatomic) IBOutlet UITextField *nameTF;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sexSC;
@property (strong, nonatomic) IBOutlet UILabel *dobLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnDOBPO;
@property (strong, nonatomic) IBOutlet UITextField *icNoTF;
@property (strong, nonatomic) IBOutlet UILabel *otherIDTypeLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnOtherIDTypePO;
@property (strong, nonatomic) IBOutlet UITextField *otherIDTF;
@property (strong, nonatomic) IBOutlet UIButton *btnForeignAddress;
@property (strong, nonatomic) IBOutlet UITextField *add1TF;
@property (strong, nonatomic) IBOutlet UITextField *add2TF;
@property (strong, nonatomic) IBOutlet UITextField *add3TF;
@property (strong, nonatomic) IBOutlet UITextField *postcodeTF;
@property (strong, nonatomic) IBOutlet UITextField *townTF;
@property (strong, nonatomic) IBOutlet UILabel *stateLbl;
@property (strong, nonatomic) IBOutlet UILabel *countryLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnCountryPO;

@property (nonatomic, strong) TitleViewController *TitlePicker;
@property (nonatomic, strong) UIPopoverController *TitlePickerPopover;
@property (nonatomic, strong) IDTypeViewController *IDTypeVC;
@property (nonatomic, retain) UIPopoverController *IDTypePopover;
@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, strong) CountryPopoverViewController *CountryVC;
@property (nonatomic, strong) UIPopoverController *CountryPopover;
@property (nonatomic, strong) Relationship *RelationshipVC;
@property (nonatomic, retain) UIPopoverController *RelationshipPopover;
@property (assign, nonatomic) BOOL fa;
@property (assign, nonatomic) BOOL po;
@property (assign, nonatomic) NSInteger dobDay;
@property (assign, nonatomic) NSInteger dobMonth;
@property (assign, nonatomic) NSInteger dobYear;
@property (strong, nonatomic) NSString *hhh;
@property (strong, nonatomic) IBOutlet UITableViewCell *deleteCell;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UILabel *relationshipLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnRelationship;


//action
- (IBAction)actionForSameAsPO:(id)sender;
- (IBAction)actionForTitle:(id)sender;
- (IBAction)actionForDOB:(id)sender;
- (IBAction)actionForOtherIDType:(id)sender;
- (IBAction)actionForForeignAdd:(id)sender;
- (IBAction)editingDidEndPostcode:(id)sender;
- (IBAction)actionForCountry:(id)sender;
- (IBAction)actionForDeleteTrustee:(id)sender;
- (IBAction)actionForRelationship:(id)sender;


@end
