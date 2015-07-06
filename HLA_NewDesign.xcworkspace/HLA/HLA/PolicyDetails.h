//
//  PolicyDetails.h
//  iMobile Planner
//
//  Created by shawal sapuan on 6/25/13.
//  Copyright (c) 2013 InfoConnect Sdn Bhd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDate.h"
#import "IDTypeViewController.h"
#import <sqlite3.h>
#import "FirstPaymentPopoverVC.h"
#import "RecurPaymentPopoverVC.h"
#import "PersonTypePopoverVC.h"
#import "IssuingBankPopoverVC.h"
#import "CardTypePopoverVC.h"
#import "Relationship.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface PolicyDetails : UITableViewController <SIDateDelegate,IDTypeDelegate, FirstPaymentDelegate, RecurPaymentDelegate, PersonTypePopoverDelegate, IssuingBankDelegate, CardTypeDelegate, RelationshipDelegate, UITextFieldDelegate> {
    SIDate *_SIDate;
    UIPopoverController *_SIDatePopover;
	BOOL isLevelFace;
	BOOL isFacePlus;
	BOOL isVeryDynamic;
	BOOL isModDynamic;
	BOOL isDynamic;
	BOOL isBalanced;
	BOOL isLIEN;
	BOOL isPremDeposit;
	BOOL isFuturePrem;
	BOOL isTopUp;
	//db
	NSString *databasePath;
    sqlite3 *contactDB;
	const char *dbpath;
	sqlite3_stmt *statement;
	//
	FMResultSet *results2;
	NSString *type;
	NSString *name;
	NSString *term;
	NSString *sumAssured;
	
	NSString *modalPremiumAnnually;
	NSString *modalPremiumSemiAnnually;
	NSString *modalPremiumQuarterly;
	NSString *modalPremiumMonthly;
	
	
	NSMutableArray *tempRPersonType;
	NSMutableArray *tempRName;
	NSMutableArray *tempRTerm;
	NSMutableArray *tempRSumAssured;
    NSMutableArray *tempRModalPremium;
	
	NSMutableArray *tempRMPAnnually;
	NSMutableArray *tempRMPSemiAnnually;
	NSMutableArray *tempRMPQuarterly;
	NSMutableArray *tempRMPMonthly;
	
	NSMutableArray *riderData;
	int riderCount;
	
	int select;
}


@property (nonatomic, retain) SIDate *SIDate;
@property (nonatomic, retain) UIPopoverController *SIDatePopover;
@property (nonatomic, strong) IDTypeViewController *IDTypeVC;
@property (nonatomic, retain) UIPopoverController *IDTypePopover;
@property (nonatomic, strong) FirstPaymentPopoverVC *FirstPaymentVC;
@property (nonatomic, retain) UIPopoverController *FirstPaymentPopover;
@property (nonatomic, strong) RecurPaymentPopoverVC *RecurPaymentVC;
@property (nonatomic, retain) UIPopoverController *RecurPaymentPopover;
@property (nonatomic, strong) PersonTypePopoverVC *PersonTypeVC;
@property (nonatomic, retain) UIPopoverController *PersonTypePopover;
@property (nonatomic, strong) IssuingBankPopoverVC *IssuingBankVC;
@property (nonatomic, retain) UIPopoverController *IssuingBankPopover;
@property (nonatomic, strong) CardTypePopoverVC *CardTypeVC;
@property (nonatomic, retain) UIPopoverController *CardTypePopover;
@property (nonatomic, strong) Relationship *RelationshipVC;
@property (nonatomic, retain) UIPopoverController *RelationshipPopover;

//outlet
@property (weak, nonatomic) IBOutlet UILabel *DOBLbl;
@property (strong, nonatomic) IBOutlet UILabel *OtherIDLbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *part3;
@property (strong, nonatomic) IBOutlet UIButton *btnLevelFace;
@property (strong, nonatomic) IBOutlet UIButton *btnFacePlus;
@property (strong, nonatomic) IBOutlet UIButton *btnVeryDyn;
@property (strong, nonatomic) IBOutlet UIButton *btnModDyn;
@property (strong, nonatomic) IBOutlet UIButton *btnDyn;
@property (strong, nonatomic) IBOutlet UIButton *btnBalanced;
@property (strong, nonatomic) IBOutlet UIButton *btnLIEN;
@property (strong, nonatomic) IBOutlet UIButton *btnPremDeposit;
@property (strong, nonatomic) IBOutlet UIButton *btnFuturePrem;
@property (strong, nonatomic) IBOutlet UIButton *btnTopUp;
@property (strong, nonatomic) IBOutlet UISegmentedControl *paymentModeSC;
@property (strong, nonatomic) IBOutlet UILabel *basicPlanLbl;
@property (strong, nonatomic) IBOutlet UILabel *termLbl;
@property (strong, nonatomic) IBOutlet UILabel *sumAssuredLbl;
@property (strong, nonatomic) IBOutlet UILabel *basicPremLbl;
@property (strong, nonatomic) IBOutlet UILabel *totalPremLbl;
@property (strong, nonatomic) IBOutlet UILabel *basicUnitAccLbl;
@property (strong, nonatomic) IBOutlet UILabel *riderUnitAccLbl;
@property (strong, nonatomic) IBOutlet UITableView *basicPlanRiderTblV;

@property (strong, nonatomic) IBOutlet UILabel *firstTimePaymentLbl;
@property (strong, nonatomic) IBOutlet UILabel *alertFirstPaymentLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnFirstPaymentPO;
@property (strong, nonatomic) IBOutlet UISegmentedControl *deductSC;
@property (strong, nonatomic) IBOutlet UILabel *recurPaymentLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnRecurPaymentPO;
@property (strong, nonatomic) IBOutlet UILabel *personTypeLbl;//Person Type is required.
@property (strong, nonatomic) IBOutlet UIButton *btnPersonTypePO;
@property (strong, nonatomic) IBOutlet UILabel *bankLbl;//Issuing Bank is required.
@property (strong, nonatomic) IBOutlet UIButton *btnBankPO;
@property (strong, nonatomic) IBOutlet UILabel *cardTypeLbl;//Card Type is required.
@property (strong, nonatomic) IBOutlet UIButton *btnCardTypePO;
@property (strong, nonatomic) IBOutlet UITextField *accNoTF;//Card No. is required.--- [[Card No. didn't match with card type.]]
@property (strong, nonatomic) IBOutlet UITextField *expiryDateTF;//Card Expired Date is required.--- [[Month must be between 1 and 12--- Invalid Month format.--- Year must greater than current year. (for year)--- Credit Card has expired, please use other credit card. (for month or date expired)--- Invalid Year format.]]
@property (strong, nonatomic) IBOutlet UITextField *expiryDateYearTF;
@property (strong, nonatomic) IBOutlet UITextField *memberNameTF;//Name is required.--- Invalid name format. Same alphabet cannot be repeated more than three times.
@property (strong, nonatomic) IBOutlet UISegmentedControl *memberSexSC;//Sex is required.
@property (strong, nonatomic) IBOutlet UILabel *memberDOBLbl;//Date of Birth is required.
@property (strong, nonatomic) IBOutlet UIButton *btnMemberDOBPO;
@property (strong, nonatomic) IBOutlet UITextField *memberIC;//Either New IC No. or Other ID is required.--- [[New IC month must be between 1 and 12--- New IC day must be between 1 and 31--- (Date doesn't have __ days!)]]
@property (strong, nonatomic) IBOutlet UILabel *memberOtherIDTypeLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnMemberOtherIDType;
@property (strong, nonatomic) IBOutlet UITextField *memberOtherIDTF;//Other ID is required.
@property (strong, nonatomic) IBOutlet UITextField *memberContactNoTF;//Contact No. is required.
@property (strong, nonatomic) IBOutlet UILabel *memberRelationshipLbl;//Relationship is required.
@property (strong, nonatomic) IBOutlet UIButton *btnMemberRelationshipPO;
@property (strong, nonatomic) IBOutlet UISegmentedControl *paidUpOptionSC;
@property (strong, nonatomic) IBOutlet UILabel *paidUpTermLbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sumAssuredSC;
@property (strong, nonatomic) IBOutlet UILabel *revisedAmountLbl;
@property (strong, nonatomic) IBOutlet UITextField *agentCodeTF;
@property (strong, nonatomic) IBOutlet UITextField *agentContactNoTF;
@property (strong, nonatomic) IBOutlet UITextField *agentNameTF;
@property (strong, nonatomic) IBOutlet UITableView *fundAllocTblV;
@property (strong, nonatomic) IBOutlet UITableView *LIENTblV;
@property (strong, nonatomic) IBOutlet UILabel *srvTaxLbl;
@property (strong, nonatomic) IBOutlet UILabel *totalPremTaxLbl;

@property (assign, nonatomic) BOOL op;
@property (assign, nonatomic) BOOL ccsi;
@property (strong, nonatomic) IBOutlet UILabel *investmentPeriodLbl;

- (IBAction)actionForFirstPaymentPO:(id)sender;
- (IBAction)actionForRecurPaymentPO:(id)sender;
- (IBAction)actionForPersonTypePO:(id)sender;
- (IBAction)actionForBankPO:(id)sender;
- (IBAction)actionForCardTypePO:(id)sender;
- (IBAction)actionForMemberRelationshipPO:(id)sender;
- (IBAction)editingDidEndIC:(id)sender;
- (IBAction)actionForModePayment:(id)sender;

- (IBAction)ActionDOB:(id)sender;
- (IBAction)ActionOtherID:(id)sender;
- (IBAction)ActionPart3:(id)sender;
- (IBAction)actionForDeathTPD:(id)sender;
- (IBAction)actionForInvestStrategy:(id)sender;
- (IBAction)actionForLIEN:(id)sender;
- (IBAction)actionForExcessPrem:(id)sender;
//Please submit Fully Paid Up form if your selected Fully/Reduce Paid Up is 'Yes'
@end
