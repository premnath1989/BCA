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
#import "CardTypePopoverVCDC.h"
#import "Relationship.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

@interface PolicyDetails : UITableViewController <SIDateDelegate,IDTypeDelegate, FirstPaymentDelegate, RecurPaymentDelegate, PersonTypePopoverDelegate, IssuingBankDelegate, CardTypeDelegate,CardTypePopoverVCDC, RelationshipDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate> {
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
	NSString *WOPAmount;
	
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
    
    NSMutableArray *tempRSAAnnualy;
    NSMutableArray *tempRSASemi;
    NSMutableArray *tempRSAQuarterly;
    NSMutableArray *tempRSAMonthly;
	
	NSMutableArray *tempGST_Annual;
    NSMutableArray *tempGST_Semi;
    NSMutableArray *tempGST_Quarter;
    NSMutableArray *tempGST_Month;
	
	
	
	NSMutableArray *riderData;
    
    NSString *WhatBAnktype;
    NSString *WhatAccountType;
    
    
    NSString *ButtonState;
	int riderCount;
	
	int select;
}


@property (nonatomic, retain) NSString *ButtonState, *WhatBAnktype, *WhatAccountType;
@property (nonatomic, retain) NSString  *TickMArkValue;

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
@property (nonatomic, strong) CardTypePopoverVCDC *CardTypeVCDC;
@property (nonatomic, retain) UIPopoverController *CardTypePopoverDC;
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
@property (strong, nonatomic) IBOutlet UILabel *lblSubmitSpecial;
@property (strong, nonatomic) IBOutlet UIButton *btnPremDeposit;
@property (strong, nonatomic) IBOutlet UIButton *btnFuturePrem;
@property (strong, nonatomic) IBOutlet UIButton *btnTopUp;
@property (strong, nonatomic) IBOutlet UISegmentedControl *paymentModeSC;
@property (strong, nonatomic) IBOutlet UILabel *basicPlanLbl;
@property (strong, nonatomic) IBOutlet UILabel *termLbl;
@property (weak, nonatomic) IBOutlet UILabel *TotalNetPayable;
@property (strong, nonatomic) IBOutlet UILabel *sumAssuredLbl;
@property (weak, nonatomic) IBOutlet UILabel *TotalGSTAmmount;
@property (strong, nonatomic) IBOutlet UILabel *basicPremLbl;
@property (strong, nonatomic) IBOutlet UILabel *totalPremLbl;
@property (strong, nonatomic) IBOutlet UILabel *basicUnitAccLbl;
@property (strong, nonatomic) IBOutlet UILabel *riderUnitAccLbl;

@property (strong, nonatomic) IBOutlet UILabel *basicUnitLbl;
@property (strong, nonatomic) IBOutlet UILabel *riderUnitLbl;
@property (strong, nonatomic) IBOutlet UILabel *basicUnitCommToLbl;
@property (strong, nonatomic) IBOutlet UILabel *riderUnitCommToLbl;
@property (strong, nonatomic) IBOutlet UILabel *basicUnitCommFromLbl;
@property (strong, nonatomic) IBOutlet UILabel *riderUnitCommFromLbl;

@property (strong, nonatomic) IBOutlet UITableView *basicPlanRiderTblV;

@property (strong, nonatomic) IBOutlet UILabel *firstTimePaymentLbl;
@property (strong, nonatomic) IBOutlet UILabel *alertFirstPaymentLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnFirstPaymentPO;
@property (strong, nonatomic) IBOutlet UISegmentedControl *deductSC;
@property (strong, nonatomic) IBOutlet UILabel *recurPaymentLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnRecurPaymentPO;

//For EPP
@property (strong, nonatomic) IBOutlet UILabel *EPPLbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *EPPSC;

//credit card - recurring payment
@property (strong, nonatomic) IBOutlet UIButton *btnSameAsFT;
@property (strong, nonatomic) IBOutlet UILabel *personTypeLbl;//Person Type 
@property (strong, nonatomic) IBOutlet UIButton *btnPersonTypePO;
@property (strong, nonatomic) IBOutlet UILabel *bankLbl;//Issuing Bank 
@property (strong, nonatomic) IBOutlet UIButton *btnBankPO;
@property (strong, nonatomic) IBOutlet UILabel *cardTypeLbl;//Card Type 
@property (strong, nonatomic) IBOutlet UIButton *btnCardTypePO;
@property (strong, nonatomic) IBOutlet UITextField *accNoTF;//Card No. 
@property (strong, nonatomic) IBOutlet UITextField *expiryDateTF;
@property (strong, nonatomic) IBOutlet UITextField *expiryDateYearTF;
@property (strong, nonatomic) IBOutlet UITextField *memberNameTF;//Name 
@property (strong, nonatomic) IBOutlet UISegmentedControl *memberSexSC;//Sex 
@property (strong, nonatomic) IBOutlet UILabel *memberDOBLbl;//Date of Birth 
@property (strong, nonatomic) IBOutlet UIButton *btnMemberDOBPO;
@property (strong, nonatomic) IBOutlet UITextField *memberIC;//New IC No. 
@property (strong, nonatomic) IBOutlet UILabel *memberOtherIDTypeLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnMemberOtherIDType;
@property (strong, nonatomic) IBOutlet UITextField *memberOtherIDTF;//Other ID is required.
@property (strong, nonatomic) IBOutlet UITextField *memberContactNoTF;//Contact No. is required.
@property (strong, nonatomic) IBOutlet UITextField *memberContactNoPrefixCF;
@property (strong, nonatomic) IBOutlet UILabel *memberRelationshipLbl;//Relationship is required.
@property (strong, nonatomic) IBOutlet UIButton *btnMemberRelationshipPO;


//First time Payment (credit Card)
@property (strong, nonatomic) IBOutlet UILabel *FTpersonTypeLbl;
@property (strong, nonatomic) IBOutlet UIButton *FTbtnPersonTypePO;
@property (strong, nonatomic) IBOutlet UILabel *FTbankLbl;
@property (strong, nonatomic) IBOutlet UIButton *FTbtnBankPO;
@property (strong, nonatomic) IBOutlet UILabel *FTcardTypeLbl;
@property (strong, nonatomic) IBOutlet UIButton *FTbtnCardTypePO;
@property (strong, nonatomic) IBOutlet UITextField *FTaccNoTF;
@property (strong, nonatomic) IBOutlet UITextField *FTexpiryDateTF;
@property (strong, nonatomic) IBOutlet UITextField *FTexpiryDateYearTF;
@property (strong, nonatomic) IBOutlet UITextField *FTmemberNameTF;
@property (strong, nonatomic) IBOutlet UISegmentedControl *FTmemberSexSC;
@property (strong, nonatomic) IBOutlet UILabel *FTmemberDOBLbl;
@property (strong, nonatomic) IBOutlet UIButton *FTbtnMemberDOBPO;
@property (strong, nonatomic) IBOutlet UITextField *FTmemberIC;
@property (strong, nonatomic) IBOutlet UILabel *FTmemberOtherIDTypeLbl;
@property (strong, nonatomic) IBOutlet UIButton *FTbtnMemberOtherIDType;
@property (strong, nonatomic) IBOutlet UITextField *FTmemberOtherIDTF;
@property (strong, nonatomic) IBOutlet UITextField *FTmemberContactNoTF;
@property (strong, nonatomic) IBOutlet UITextField *FTmemberContactNoPrefixCF;
@property (strong, nonatomic) IBOutlet UILabel *FTmemberRelationshipLbl;
@property (strong, nonatomic) IBOutlet UIButton *FTbtnMemberRelationshipPO;
@property (nonatomic, copy) NSString *FTIDTypeCodeSelected;

//##


@property (strong, nonatomic) IBOutlet UISegmentedControl *paidUpOptionSC;
@property (strong, nonatomic) IBOutlet UILabel *paidUpTermLbl;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sumAssuredSC;
@property (strong, nonatomic) IBOutlet UILabel *revisedAmountLbl;
@property (strong, nonatomic) IBOutlet UITextField *agentCodeTF;
@property (strong, nonatomic) IBOutlet UITextField *agentContactNoTF;
@property (strong, nonatomic) IBOutlet UITextField *agentContactNoPrefixTF;

@property (strong, nonatomic) IBOutlet UITextField *agentNameTF;
@property (strong, nonatomic) IBOutlet UITableView *fundAllocTblV;
@property (strong, nonatomic) IBOutlet UITableView *LIENTblV;
@property (strong, nonatomic) IBOutlet UILabel *srvTaxLbl;
@property (strong, nonatomic) IBOutlet UILabel *totalPremTaxLbl;

@property (assign, nonatomic) BOOL op;
@property (assign, nonatomic) BOOL ccsi;

@property (assign, nonatomic) BOOL FTop;
@property (assign, nonatomic) BOOL FTccsi;
@property (assign, nonatomic) BOOL isSameAsFT;
@property (assign, nonatomic) BOOL ChangeTick;

@property (assign, nonatomic) NSString *ChangeTickMAsterMenu;


@property (strong, nonatomic) IBOutlet UILabel *investmentPeriodLbl;

@property (strong, nonatomic)  UILabel *lbl;

@property (nonatomic, copy) NSString *IDTypeCodeSelected;



//policy bank details////
@property (strong, nonatomic) IBOutlet UIButton *TckbuttonPolicyBankDetails;
@property (strong, nonatomic) IBOutlet UILabel *DCBankName;
@property (strong, nonatomic) IBOutlet UILabel *DCAccountType;
@property (strong, nonatomic) IBOutlet UIButton *DCBankNameBtn;
@property (strong, nonatomic) IBOutlet UIButton *DCAccountTypeBtn;
@property (strong, nonatomic) IBOutlet UITextField *DCAccNo;

@property (strong, nonatomic) IBOutlet UITextField *PayeeType;
@property (strong, nonatomic) IBOutlet UITextField *DCNewIcNo;
@property (strong, nonatomic) IBOutlet UILabel *OtherIDTypeDc;
@property (strong, nonatomic) IBOutlet UITextField *OtherIDDC;
@property (strong, nonatomic) IBOutlet UITextField *emailDC;
@property (strong, nonatomic) IBOutlet UITextField *mobileNoPrefixDC;
@property (strong, nonatomic) IBOutlet UITextField *mobileNoDC;

- (IBAction)TckPolicyBankDetailsDC:(id)sender;
- (IBAction)ActionBankNameDC:(id)sender;
- (IBAction)ActionAccountTypeDC:(id)sender;
- (IBAction)ActionOtherIdDC:(id)sender;


////
- (IBAction)actionForFirstPaymentPO:(id)sender;
- (IBAction)actionForRecurPaymentPO:(id)sender;

- (IBAction)actionForPersonTypePO:(id)sender;
- (IBAction)actionForBankPO:(id)sender;
- (IBAction)actionForCardTypePO:(id)sender;
- (IBAction)actionForMemberRelationshipPO:(id)sender;
- (IBAction)ActionDOB:(id)sender;
- (IBAction)ActionOtherID:(id)sender;
- (IBAction)ActionForSameAsFT:(id)sender;

- (IBAction)actionForPersonTypePO_FT:(id)sender;
- (IBAction)actionForBankPO_FT:(id)sender;
- (IBAction)actionForCardTypePO_FT:(id)sender;
- (IBAction)ActionDOB_FT:(id)sender;
- (IBAction)ActionOtherID_FT:(id)sender;
- (IBAction)actionForMemberRelationshipPO_FT:(id)sender;

- (IBAction)editingDidEndIC:(id)sender;
- (IBAction)actionForModePayment:(id)sender;

- (IBAction)ActionPart3:(id)sender;
- (IBAction)actionForDeathTPD:(id)sender;
- (IBAction)actionForInvestStrategy:(id)sender;
- (IBAction)actionForLIEN:(id)sender;
- (IBAction)actionForExcessPrem:(id)sender;

- (IBAction)actionForICNo:(UITextField *)textField;



//Please submit Fully Paid Up form if your selected Fully/Reduce Paid Up is 'Yes'

@property (nonatomic, strong) UIPopoverController *paidUpPopover;
@end
